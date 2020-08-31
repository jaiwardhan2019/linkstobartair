package com.linkportal.docmanager;


import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.http.HttpServletRequest;
import org.springframework.web.multipart.MultipartFile;
import java.util.List;


public interface documentManager {	
	
	
	
	 //******** FOR THE GROUNDOPS  DOCUMENTS ********	
	  public List<DocumentEntity> showAllDocumentsFromFolder(HttpServletRequest req,String foldername);
	  
	  public List<DocumentEntity> searchDocumentsFromFolder(String documentname);
	  
	  public boolean addDocumentToFolder(HttpServletRequest req,MultipartFile file)throws IOException, SQLException;
  
	  public boolean removeDocumentFromFolder(int id)throws IOException, SQLException;
	  
	  public List<String> listFolder(String foldername);
	

	   
	   //******** FOR THE DAILY SUMMARY REPORT ********
	   public void createDailySummaryReport_PDF(String airline , String Operation , String datop , String useremail);
	   
	   public void createDailySummaryReport_DOC(String airline , String Operation , String datop , String useremail);
	   
	   
	  //******** For Fuel  XML File Conversion to the Excel ********	   
	   public boolean convertMultipleXmlfiletoExcelFile(HttpServletRequest filePath,MultipartFile file)throws IOException;

	   
	   
	
}
