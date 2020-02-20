package com.linkportal.docmanager;


import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.http.HttpServletRequest;
import org.springframework.web.multipart.MultipartFile;
import java.util.List;


public interface documentManager {	
	
	
	
	 //******** FOR THE GROUNDOPS  DOCUMENTS ********	
	  public List<DocumentEntity> showAllDocumentsFromFolder(HttpServletRequest req,String foldername); 
	  
	  public boolean addDocumentToFolder(HttpServletRequest req,MultipartFile file)throws IOException, SQLException;
	
	 
	
	
	   
	   //******** FOR THE DAILY SUMMARY REPORT ********
	   public void createDailySummaryReport_PDF(String airline , String Operation , String datop , String useremail);
	   
	   public void createDailySummaryReport_DOC(String airline , String Operation , String datop , String useremail);
	   
	
}
