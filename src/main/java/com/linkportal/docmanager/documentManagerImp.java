package com.linkportal.docmanager;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.sql.Connection;

import javax.servlet.http.HttpServletRequest;
import javax.sql.DataSource;
import javax.xml.parsers.ParserConfigurationException;

import org.apache.log4j.Logger;
import org.apache.poi.xwpf.usermodel.XWPFDocument;
import org.apache.poi.xwpf.usermodel.XWPFTable;
import org.apache.poi.xwpf.usermodel.XWPFTableRow;
import org.apache.tomcat.jni.FileInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.support.rowset.SqlRowSet;
import org.springframework.stereotype.Repository;
import org.springframework.web.multipart.MultipartFile;
import org.xml.sax.SAXException;

import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.pdf.PdfWriter;
import com.linkportal.groundops.gopsAllapi;
import com.microsoft.sqlserver.jdbc.SQLServerException;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import org.apache.commons.io.FileUtils;

@Repository
public class documentManagerImp extends xmlFileConverterToExcel implements documentManager {

	@Autowired
	DocumentService  docserv;
	
	@Autowired
	DataSource dataSourcesqlservercp;

	JdbcTemplate jdbcTemplate;

	@Value("${spring.operations.excel.reportsfileurl}")
	private String filepath;
	@Value("${groundops.documentroot.folder}")
	private String groundopsRootFolder;
	
	
	@Value("${fuelinvoices.documentroot.folder}")
	private String fuelInvoiceRootFolder;
	
	
	

	// ***---------------- LOGGER------------------------------
	private Logger logger = Logger.getLogger(documentManagerImp.class);

	documentManagerImp(DataSource dataSourcesqlservercp) {
		jdbcTemplate = new JdbcTemplate(dataSourcesqlservercp);
	}

	@Override
	public List<DocumentEntity> showAllDocumentsFromFolder(HttpServletRequest req, String foldername) {

		String sqlListDocs = "  SELECT  doc_id , doc_name  , doc_description , doc_type , doc_path ,  doc_department "
				+ " , doc_category  , convert(varchar, cast(doc_added_date as date), 106) as doc_added_date "
				+ " , doc_addedby_name  from Gops_Document_Master  where len(doc_category) < 5 order by doc_id desc";

		if (req.getParameter("cat") != null) {
			// -- When calling from any other folder
			if (!req.getParameter("cat").toUpperCase().equals("HOME")) {
				sqlListDocs = " SELECT doc_id , doc_name  , doc_description , doc_type , doc_path ,  doc_department "
						+ "      , doc_category  , convert(varchar, cast(doc_added_date as date), 106) as doc_added_date "
						+ "      , doc_addedby_name  from Gops_Document_Master where doc_category='"
						+ req.getParameter("cat").toUpperCase() + "' and doc_department='" + foldername
						+ "' order by doc_id desc";
			}

		}

		// -- FOR Weighting Statement Documents
		if (foldername.contains("-")) {
			sqlListDocs = " SELECT doc_id , doc_name  , doc_description , doc_type , doc_path ,  doc_department "
					+ "      , doc_category  , convert(varchar, cast(doc_added_date as date), 106) as doc_added_date "
					+ "      , doc_addedby_name  from Gops_Document_Master where len(doc_category) < 5 order by doc_id desc";
		}

		// -- If calling from Business Updated
		if (req.getParameter("businessupdates") != null) {

			sqlListDocs = " SELECT doc_id , doc_name  , doc_description , doc_type , doc_path ,  doc_department "
					+ "      , doc_category  , convert(varchar, cast(doc_added_date as date), 106) as doc_added_date "
					+ "      , doc_addedby_name  from Gops_Document_Master where doc_category='"
					+ req.getParameter("news").toUpperCase()
					+ "' and doc_department='BUPDATES' order by doc_id desc";

			// -- When calling from any other folder
			if (req.getParameter("news").toUpperCase().equals("latest")) {
				sqlListDocs = " SELECT doc_id , doc_name  , doc_description , doc_type , doc_path ,  doc_department "
						+ "      , doc_category  , convert(varchar, cast(doc_added_date as date), 106) as doc_added_date "
						+ "      , doc_addedby_name  from Gops_Document_Master where doc_category='"
						+ req.getParameter("news").toUpperCase()
						+ "' and doc_department='BUPDATES' order by doc_id desc";
			}

			// -- When calling from any other folder
			if (req.getParameter("news").toUpperCase().equals("archive")) {
				sqlListDocs = " SELECT doc_id , doc_name  , doc_description , doc_type , doc_path ,  doc_department "
						+ "      , doc_category  , convert(varchar, cast(doc_added_date as date), 106) as doc_added_date "
						+ "      , doc_addedby_name  from Gops_Document_Master where doc_category='"
						+ req.getParameter("news").toUpperCase()
						+ "' and doc_department='BUPDATES' order by doc_id desc";
			}

		}

		//System.out.println("SQL here :"+sqlListDocs);

		List documentList = jdbcTemplate.query(sqlListDocs, new DocumentEntityRowmapper());
		return documentList;

	}

	@Override
	public List<DocumentEntity> searchDocumentsFromFolder(String documentname) {

		String qlListDocs = " SELECT doc_id , doc_name  , doc_description , doc_type , doc_path ,  doc_department "
				+ " , doc_category  , convert(varchar, cast(doc_added_date as date), 106) as doc_added_date "
				+ " , doc_addedby_name  from Gops_Document_Master  where doc_description like '%" + documentname
				+ "%' order by doc_added_date";
		List documentList = jdbcTemplate.query(qlListDocs, new DocumentEntityRowmapper());
		return documentList;
	}

	@Override
	public boolean addDocumentToFolder(HttpServletRequest req, MultipartFile file) throws IOException, SQLException {

		// CREATING MAIN FOLDER AND SUB FOLDER UNDER GROUND OPS ROOT FOLDER

		// --If weight Statement content is added
		File fileuploaddirectory = null;

		if (req.getParameter("cat").contains("-")) {
			fileuploaddirectory = new File(groundopsRootFolder + "/weightstatement/");
			if (!fileuploaddirectory.exists()) {
				fileuploaddirectory.mkdir();
			}
			fileuploaddirectory = new File(
					groundopsRootFolder + "/weightstatement/" + req.getParameter("cat").toUpperCase() + "/");
			if (!fileuploaddirectory.exists()) {
				fileuploaddirectory.mkdir();
			}
		}

		// --If Form Folder content is added
		if (req.getParameter("cat").contains("form")) {
			fileuploaddirectory = new File(groundopsRootFolder + "/forms/");
			if (!fileuploaddirectory.exists()) {
				fileuploaddirectory.mkdir();
			}
			fileuploaddirectory = new File(
					groundopsRootFolder + "/forms/" + req.getParameter("cat").toUpperCase() + "/");
			if (!fileuploaddirectory.exists()) {
				fileuploaddirectory.mkdir();
			}

		}

		// This Part of Code Will Create Only Folder like GCI / GCM / GCR if not exist
		// then create one
		if (req.getParameter("cat").toString().length() < 5) {
			File uploadDir = new File(groundopsRootFolder + req.getParameter("cat").toUpperCase() + "/");
			if (!uploadDir.exists()) {
				uploadDir.mkdir();
				logger.info(req.getParameter("cat").toUpperCase() + ":Folder is Created ");
			}
			fileuploaddirectory = new File(groundopsRootFolder + "/" + req.getParameter("cat").toUpperCase() + "/");
		}

		// This Part will Upload File to into the folder
		byte[] bytes = file.getBytes();
		Path path = Paths
				.get(fileuploaddirectory + "/" + file.getOriginalFilename().replaceAll("['\\\\/:*&?\"<>|]", ""));
		Files.write(path, bytes);

		// Get File related Info into varriable
		String filefullname = file.getOriginalFilename();
		String extension = "";
		int i = file.getOriginalFilename().lastIndexOf('.');
		if (i > 0) {
			extension = file.getOriginalFilename().substring(i + 1);
		}
		DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");
		LocalDateTime currentdateandtime = LocalDateTime.now();
		String addbyname = req.getParameter("emailid");

		try {

			// if file is exist then update time and added by email Otherwise Create new
			// Entry in the Table
			SqlRowSet result = jdbcTemplate
					.queryForRowSet("Select doc_name from Gops_Document_Master where doc_category='"
							+ req.getParameter("cat").toUpperCase() + "' and  doc_name='"
							+ file.getOriginalFilename().replaceAll("['\\\\/:*&?\"<>|]", "") + "'");
			if (result.next()) {
				jdbcTemplate.execute("Update Gops_Document_Master set doc_addedby_name='" + addbyname
						+ "' , doc_added_date='" + currentdateandtime.toString() + "' where doc_category='"
						+ req.getParameter("cat").toUpperCase() + "'  and  doc_name='"
						+ file.getOriginalFilename().replaceAll("['\\\\/:*&?\"<>|]", "") + "'");
			} else {

				java.sql.Connection con1 = dataSourcesqlservercp.getConnection();
				String SQL_ADD = " INSERT INTO  Gops_Document_Master (doc_name , doc_description , doc_type , doc_path , doc_department , doc_category ,doc_added_date , doc_addedby_name) "
						+ " values (?,?,?,?,?,?,?,?)";

				PreparedStatement pstm = con1.prepareStatement(SQL_ADD);

				pstm.setString(1, file.getOriginalFilename().replaceAll("['\\\\/:*&?\"<>|]", ""));
				pstm.setString(2, file.getOriginalFilename().replaceAll("['\\\\/:*&?\"<>|]", ""));
				pstm.setString(3, extension);
				pstm.setString(4, path.toString());
				pstm.setString(5, "GOPS");
				pstm.setString(6, req.getParameter("cat").toUpperCase());
				pstm.setString(7, currentdateandtime.toString());
				pstm.setString(8, addbyname);
				int rows = pstm.executeUpdate();
				pstm = null;
				con1.close();
				logger.info("Document Detail been Added in the database");

			}

		} catch (SQLServerException ex) {
			logger.error("While Adding Document Info to  DB :" + ex.toString());
			// Write Remove Document Code
			File ff = new File(path.toString());
			ff.delete();
			return false;
		}

		return true;

	}

	@Override
	public boolean removeDocumentFromFolder(int docId) throws IOException {

		try {

			// 1.Fetch File detail from table
			SqlRowSet result = jdbcTemplate.queryForRowSet(
					"Select doc_name , doc_path ,  doc_category from Gops_Document_Master where doc_id=" + docId);
			if (result.next()) {
				File ff = new File(result.getString("doc_path"));
				// 2 Once file is removed from folder remove entry from table
				if (ff.delete()) {
					jdbcTemplate.execute("delete from Gops_Document_Master where doc_id=" + docId);
				}
			}
			return true;

		} catch (Exception e) {
			logger.error("While Removing file :" + e.toString());
			return false;
		}
	}

	// --- Will Show All File in the folder
	@Override
	public List<String> listFolder(String foldername) {
		List<String> doclist = new ArrayList<String>();
		File directory = new File(groundopsRootFolder + foldername + "/");
		if (directory.isDirectory()) {
			String[] fileList = directory.list();
			for (String filename : fileList) {
				doclist.add(filename);
			}
			return doclist;
		} else {
			return null;
		}

	}

	// ---- https://howtodoinjava.com/library/read-generate-pdf-java-itext/
	@Override
	public void createDailySummaryReport_PDF(String airline, String Operation, String datop, String useremail) {

		// ------ CREATE FOLDER FOR THE SPECIFIC USER
		File file = new File(filepath + useremail);
		if (!file.exists()) {
			if (file.mkdir()) {

				logger.info(filepath + useremail + " Directory  Created for the Report Files");
			} else {
				logger.error("Failed to create directory name :" + filepath + useremail
						+ "# Please Check Folder permissions");
			}
		}

		Document document = new Document();
		try {
			PdfWriter writer = PdfWriter.getInstance(document,
					new FileOutputStream(filepath + useremail + "/HelloWorld.pdf"));
			document.open();
			document.add(new Paragraph("A Hello World PDF document."));
			document.close();
			writer.close();
		} catch (DocumentException e) {
			e.printStackTrace();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		}

	}

	// -------- https://www.baeldung.com/java-microsoft-word-with-apache-poi
	// ---------
	// https://www.daniweb.com/programming/software-development/threads/469522/adding-image-in-doc-file-using-apache-poi
	@Override
	public void createDailySummaryReport_DOC(String airline, String Operation, String datop, String useremail) {

		try {

			// Blank Document
			XWPFDocument document = new XWPFDocument();

			// Write the Document in file system
			FileOutputStream out;

			out = new FileOutputStream(new File(filepath + useremail + "/HelloWorld.doc"));
			// create table
			XWPFTable table = document.createTable();

			// create first row
			XWPFTableRow tableRowOne = table.getRow(0);
			tableRowOne.getCell(0).setText("col one, row one");
			tableRowOne.addNewTableCell().setText("col two, row one");
			tableRowOne.addNewTableCell().setText("col three, row one");

			// create second row
			XWPFTableRow tableRowTwo = table.createRow();
			tableRowTwo.getCell(0).setText("col one, row two");
			tableRowTwo.getCell(1).setText("col two, row two");
			tableRowTwo.getCell(2).setText("col three, row two");

			// create third row
			XWPFTableRow tableRowThree = table.createRow();
			tableRowThree.getCell(0).setText("col one, row three");
			tableRowThree.getCell(1).setText("col two, row three");
			tableRowThree.getCell(2).setText("col three, row three");

			document.write(out);
			out.close();

		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException ee) {
		}

		logger.info("create_table.docx written successully");

	}// End of Function

	
	
	
	
	@Value("${fuelinvoices.documentroot.folder}")
	String fuelInvoiceRootDirectory;
	@Override
	public boolean convertMultipleXmlfiletoExcelFile(HttpServletRequest req, MultipartFile[] files) throws IOException, ParserConfigurationException, SAXException {

		File fileuploaddirectory = new File(fuelInvoiceRootFolder);
		String supplierName=null;
		boolean convertAndUploadStatus=true;
	
		if (!fileuploaddirectory.exists()) {
			fileuploaddirectory.mkdir();
		}

		fileuploaddirectory = new File(fuelInvoiceRootFolder + "/" + req.getParameter("emailid") + "/");
		if (!fileuploaddirectory.exists()) {
			fileuploaddirectory.mkdir();
		}
		
		if (req.getParameter("supplier").equals("shell")) {
			supplierName="shell";
		}		
	
		if (req.getParameter("supplier").equals("wfs")) {
			supplierName="wfs";
		}		
	
	
		fileuploaddirectory = new File(fuelInvoiceRootFolder + "/" + req.getParameter("emailid") + "/" +supplierName+ "/");
		if (!fileuploaddirectory.exists()) {
			fileuploaddirectory.mkdir();
		}
		
		
		//--- Will clear all old existing file
		FileUtils.cleanDirectory(fileuploaddirectory);
		
		
		
		// --------- This Part of code Will Loop For Multiple File and Save on the local Folder
		Arrays.asList(files).stream().forEach(file -> {
		byte[] bytes;
		try {			
				bytes = file.getBytes();
				Path path = Paths.get(fuelInvoiceRootFolder + "/" + req.getParameter("emailid") + "/"+req.getParameter("supplier") + "/"+ file.getOriginalFilename().replaceAll("['\\\\/:*&?\"<>|]", ""));
				String fileNameExt=file.getOriginalFilename().substring(file.getOriginalFilename().length() - 3);
				if(fileNameExt.equalsIgnoreCase("xml")){ 
					Files.write(path, bytes);
			  		if(req.getParameter("supplier").equalsIgnoreCase("shell")){shellInvoiceParser(path);}
			  		if(req.getParameter("supplier").equalsIgnoreCase("wfs")){ worldFuelServiceInvoiceParser(path);}		
				}			
			} catch (IOException | ParserConfigurationException | SAXException e) {e.printStackTrace();}
		});
        //------- End Of loop ---------
			
	
		
		return convertAndUploadStatus;
	}

	

}// ------- END OF Class -----------
