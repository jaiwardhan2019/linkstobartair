package com.linkportal.docmanager;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;

import javax.sql.DataSource;

import org.apache.log4j.Logger;
import org.apache.poi.xwpf.usermodel.XWPFDocument;
import org.apache.poi.xwpf.usermodel.XWPFTable;
import org.apache.poi.xwpf.usermodel.XWPFTableRow;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.pdf.PdfWriter;



@Repository
public class pdfWordReportBuilderImp implements pdfWordReportBuilder {

    @Autowired
    DataSource dataSourcesqlserver;
      
	JdbcTemplate jdbcTemplate;	

	@Value("${spring.operations.excel.reportsfileurl}") private String filepath;	
	
	

    //***---------------- LOGGER------------------------------ 
	private Logger logger = Logger.getLogger(pdfWordReportBuilderImp.class);
	

	
	pdfWordReportBuilderImp(DataSource dataSourcesqlserver){ 
		jdbcTemplate = new JdbcTemplate(dataSourcesqlserver);
	}




	
	
	//---- https://howtodoinjava.com/library/read-generate-pdf-java-itext/    
	@Override
	public void createDailySummaryReport_PDF(String airline, String Operation, String datop , String useremail) {
		
		  
	    //------ CREATE FOLDER FOR THE SPECIFIC USER 
	    File file = new File(filepath+useremail);
        if (!file.exists()) {
            if (file.mkdir()) {
                System.out.println("Directory is created!");
                logger.info(filepath+useremail+" Directory  Created for the Report Files");
            } else {
                System.out.println("Failed to create directory!");
                logger.error("Failed to create directory name :"+filepath+useremail+"# Please Check Folder permissions");
            }
        }
	    
		   
		 Document document = new Document();
	      try
	      {
	         PdfWriter writer = PdfWriter.getInstance(document, new FileOutputStream(filepath+useremail+"/HelloWorld.pdf"));
	         document.open();
	         document.add(new Paragraph("A Hello World PDF document."));
	         document.close();
	         writer.close();
	      } catch (DocumentException e)
	      {
	         e.printStackTrace();
	      } catch (FileNotFoundException e)
	      {
	         e.printStackTrace();
	      }
		
		
		
	}





    
	//-------- https://www.baeldung.com/java-microsoft-word-with-apache-poi
	//--------- https://www.daniweb.com/programming/software-development/threads/469522/adding-image-in-doc-file-using-apache-poi   
	@Override
	public void createDailySummaryReport_DOC(String airline, String Operation, String datop, String useremail){
	
		
		try {
			
		//Blank Document
	      XWPFDocument document = new XWPFDocument();
	        
	      //Write the Document in file system
	      FileOutputStream out;

		  out = new FileOutputStream(new File(filepath+useremail+"/HelloWorld.doc"));
	     //create table
	      XWPFTable table = document.createTable();
			
	      //create first row
	      XWPFTableRow tableRowOne = table.getRow(0);
	      tableRowOne.getCell(0).setText("col one, row one");
	      tableRowOne.addNewTableCell().setText("col two, row one");
	      tableRowOne.addNewTableCell().setText("col three, row one");
			
	      //create second row
	      XWPFTableRow tableRowTwo = table.createRow();
	      tableRowTwo.getCell(0).setText("col one, row two");
	      tableRowTwo.getCell(1).setText("col two, row two");
	      tableRowTwo.getCell(2).setText("col three, row two");
			
	      //create third row
	      XWPFTableRow tableRowThree = table.createRow();
	      tableRowThree.getCell(0).setText("col one, row three");
	      tableRowThree.getCell(1).setText("col two, row three");
	      tableRowThree.getCell(2).setText("col three, row three");
		
	      document.write(out);
	      out.close();
	      
		} catch (FileNotFoundException e) {e.printStackTrace();}
		  catch (IOException ee) {}
	    
		
		
		
		logger.info("create_table.docx written successully");
		
		
		
	}//  End of Function 



	
	
	
	
	
	
	

}//------- END OF Class -----------
