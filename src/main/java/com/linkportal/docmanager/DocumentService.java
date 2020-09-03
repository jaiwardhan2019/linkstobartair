package com.linkportal.docmanager;

import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Optional;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.fileupload.FileUpload;
import org.apache.maven.model.building.FileModelSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.google.common.base.Strings;
import com.linkportal.exception.xmlToExcelInvoiceConversionException;
import com.linkportal.exceptions.RecordNotFoundException;



@Service
public class DocumentService {
	
	@Autowired
	documentManager repository;
	
	
	public boolean addUploadFiletoDatabaseAndFolder(HttpServletRequest req,MultipartFile file) throws IOException, SQLException{
		   if(repository.addDocumentToFolder(req,file)) { return true; } else  { return false;}
	}
	
	
	public List<DocumentEntity> getAllDocuments(HttpServletRequest req, String department){		
		   List<DocumentEntity> result =  repository.showAllDocumentsFromFolder(req, department);
		   return result;
	}


	public boolean deleteDocumentById(int id) throws IOException, SQLException{	
		   return repository.removeDocumentFromFolder(id);
	} 
	

	public List<DocumentEntity> seachDocuments(String documentname){		
		   List<DocumentEntity> result =  repository.searchDocumentsFromFolder(documentname);
		   return result;
	}
		
	
	// -------- For the Fuel Invoice XML to EXCEL Conversion -------
	public boolean convertXmltoExcelFormat(HttpServletRequest req, MultipartFile[] files)throws IOException, SQLException, xmlToExcelInvoiceConversionException {
		
		// -- Validation of Supplier
		if (Strings.isNullOrEmpty(req.getParameter("supplier"))) {
			throw new xmlToExcelInvoiceConversionException("Could not find Supplier Detail.");
		}

		// -- Validation of Attached File
		Arrays.asList(files).stream().forEach(file -> {
			if (file.isEmpty()) {
				try {
					throw new xmlToExcelInvoiceConversionException("File Attachment is Missing.");
				} catch (xmlToExcelInvoiceConversionException e) {e.printStackTrace();}
			}
			
			if(!getFileExtension(file.getName()).equals("xml")) {
				try {
					throw new xmlToExcelInvoiceConversionException("File Type Should be XML.");
				} catch (xmlToExcelInvoiceConversionException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			
			
		});

		
		// -- File Conversion and Download
		if (repository.convertMultipleXmlfiletoExcelFile(req, files)) {	return true;} else {return false;}

		
	}
	
	
	public String getFileExtension(String fullName) {	   
	    String fileName = new File(fullName).getName();
	    int dotIndex = fileName.lastIndexOf('.');
	    return (dotIndex == -1) ? "" : fileName.substring(dotIndex + 1);
	}
	
}




