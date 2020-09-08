package com.linkportal.docmanager;

import java.io.File;
import java.io.IOException;
import java.nio.file.Path;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Iterator;
import java.util.List;
import java.util.Optional;

import javax.servlet.http.HttpServletRequest;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUpload;
import org.apache.commons.fileupload.disk.DiskFileItem;
import org.apache.maven.model.building.FileModelSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;

import com.google.common.base.Strings;
import com.linkportal.exception.xmlToExcelInvoiceConversionException;
import com.linkportal.exceptions.RecordNotFoundException;
import com.linkportal.docmanager.xmlFileConverterToExcel;

@Service
public class DocumentService {

	@Autowired
	documentManager repository;

	public boolean addUploadFiletoDatabaseAndFolder(HttpServletRequest req, MultipartFile file)
			throws IOException, SQLException {
		if (repository.addDocumentToFolder(req, file)) {
			return true;
		} else {
			return false;
		}
	}

	public List<DocumentEntity> getAllDocuments(HttpServletRequest req, String department) {
		List<DocumentEntity> result = repository.showAllDocumentsFromFolder(req, department);
		return result;
	}

	public boolean deleteDocumentById(int id) throws IOException, SQLException {
		return repository.removeDocumentFromFolder(id);
	}

	public List<DocumentEntity> seachDocuments(String documentname) {
		List<DocumentEntity> result = repository.searchDocumentsFromFolder(documentname);
		return result;
	}

	// -------- For the Fuel Invoice XML to EXCEL Conversion -------
	public boolean convertXmltoExcelFormat(HttpServletRequest req, MultipartFile[] files) throws IOException,
			SQLException, xmlToExcelInvoiceConversionException, ParserConfigurationException, SAXException {

		boolean methodStatus = false;

		// --- Validation of all Input
		if (validateFormEntity(req, files)) {
			methodStatus = repository.convertMultipleXmlfiletoExcelFile(req, files);
		}

		return methodStatus;

	}

	boolean validateFormEntity(HttpServletRequest req, MultipartFile[] files)
			throws xmlToExcelInvoiceConversionException, ParserConfigurationException, SAXException, IOException {

		boolean methodStatus = true;
		// -- Validation of Supplier
		if (Strings.isNullOrEmpty(req.getParameter("supplier"))) {
			return false;
		}

		// -- Validation of Attached File if it is .XML or not
		for (MultipartFile filContent : files) {
			// -- Validate File Extention and Content Empty
			if (getFileExtension(filContent.getOriginalFilename()).equalsIgnoreCase("xml") && (!filContent.isEmpty())) {
				methodStatus = true;
				// -- Validate Invoice Belongs to Their Supplier
				if (req.getParameter("supplier").equalsIgnoreCase("shell")) {
					methodStatus = isSupplierReleventFile(filContent, "SHELL");
				}
				if (req.getParameter("supplier").equalsIgnoreCase("wfs")) {
					methodStatus = isSupplierReleventFile(filContent, "WORLD");
				}

			} // End of outer if

		} // End of For

		return methodStatus;
	}

	
	
	String getFileExtension(String fullName) {
		String fileName = new File(fullName).getName();
		int dotIndex = fileName.lastIndexOf('.');
		return (dotIndex == -1) ? "" : fileName.substring(dotIndex + 1);
	}

	
	
	
	boolean isSupplierReleventFile(MultipartFile fileWithPath, String supplierName)
			throws ParserConfigurationException, SAXException, IOException {

		// --- This part of code will Load the XML file name and load into
		// parser---------
		File inputFile = getTempFile(fileWithPath);
		DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
		DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
		Document doc = dBuilder.parse(inputFile);
		doc.getDocumentElement().normalize();

		// ----------- This Part of code will print Invoice Header Content -----------
		NodeList summaryh = doc.getElementsByTagName("InvoiceHeader");

		boolean findSupplierStatus = false;

		for (int temph = 0; temph < summaryh.getLength(); temph++) {
			Node nNodeh = summaryh.item(temph);
			if (nNodeh.getNodeType() == Node.ELEMENT_NODE) {
				Element eElementh = (Element) nNodeh;
				if (eElementh.getElementsByTagName("IssuingEntityName").item(0).getTextContent()
						.contains(supplierName)) {
					findSupplierStatus = true;
				}
			} // --- End of If -------------------
		} // -------------------End of for loop

		return findSupplierStatus;
	}

	public File getTempFile(MultipartFile multipartFile) throws IOException {
		CommonsMultipartFile commonsMultipartFile = (CommonsMultipartFile) multipartFile;
		FileItem fileItem = commonsMultipartFile.getFileItem();
		DiskFileItem diskFileItem = (DiskFileItem) fileItem;
		String absPath = diskFileItem.getStoreLocation().getAbsolutePath();

		File file = new File(absPath);

		// trick to implicitly save on disk small files (<10240 bytes by default)
		if (!file.exists()) {
			file.createNewFile();
			multipartFile.transferTo(file);
		}

		return file;
	}
}
