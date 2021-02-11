package com.linkportal.docmanager;


import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.http.HttpServletRequest;
import javax.xml.parsers.ParserConfigurationException;

import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.web.multipart.MultipartFile;
import org.xml.sax.SAXException;

import java.util.List;


public interface documentManager {	
	
	
	
	 //******** FOR THE GROUNDOPS  DOCUMENTS ********	
	 List<DocumentEntity> showAllDocumentsFromFolder(HttpServletRequest req, String foldername);
    
	 String showVoiceOfGuestImage(String foldername)throws EmptyResultDataAccessException;
	 
	 String showEmergencyResponsPlanDocument(String foldername)throws EmptyResultDataAccessException;
	  
	 List<DocumentEntity> searchDocumentsFromFolder(String documentname);
	  
	 boolean addDocumentToFolder(HttpServletRequest req, MultipartFile file)throws IOException, SQLException;
  
	 boolean removeDocumentFromFolder(int id)throws IOException, SQLException;
	  
	 List<String> listFolder(String foldername);
	 
	 
	 /****
	  * Transfer From local box to the flightops2 for the weight statement
	  * these files will be used by the crew website for the Weight Statement
	  * Note :  Passing null as a file will only empty folder content  
	 ****/
	 void transFileFromlocalHostToFlightOps(HttpServletRequest req, MultipartFile file);
	 
	 
	  


	   //******** FOR THE DAILY SUMMARY REPORT ********
	   void createDailySummaryReport_PDF(String airline, String Operation, String datop, String useremail);
	   
	   void createDailySummaryReport_DOC(String airline, String Operation, String datop, String useremail);
	   
	   
	  //******** For Fuel  XML File Conversion to the Excel ********	   
	  boolean convertMultipleXmlfiletoExcelFile(HttpServletRequest filePath, MultipartFile[] files)throws IOException, ParserConfigurationException, SAXException;
	   

}
