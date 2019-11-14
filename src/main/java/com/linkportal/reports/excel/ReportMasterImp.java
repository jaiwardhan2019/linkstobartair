package com.linkportal.reports.excel;

import java.awt.Font;
import java.io.File;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.ParseException;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.Properties;

import javax.sql.DataSource;

import org.apache.log4j.Logger;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFPrintSetup;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.linkportal.datamodel.flightSectorLogRowmapper;
import com.linkportal.datamodel.fligthSectorLog;
import com.linkportal.sql.linkPortalSqlBuilder;




@Repository
public class ReportMasterImp implements ReportMaster {


    @Autowired
    DataSource dataSourcesqlserver;
    

    
      
	JdbcTemplate jdbcTemplate;	
	
	
	@Value("${spring.operations.excel.reportsfileurl}") String filepath;	
	
	

    //---------- Logger Initializer------------------------------- 
	private Logger logger = Logger.getLogger(ReportMasterImp.class);
	

	
	
	
	ReportMasterImp(DataSource dataSourcesqlserver){ 
		jdbcTemplate = new JdbcTemplate(dataSourcesqlserver);
	}

	
	
	//-------------- First Sheet Header and Column width -------------------------------------
	private static String[] standardTitlesList = {"Flight Date", "Flight No.", "A/C Type", "A/C Reg.",
													"STD", "STA", "SCH DEP", "SCH ARR", 
													"ATD", "ATA", "ACT DEP", "ACT ARR",
													"AIRBORN", "TOT ON BOARD", "IATA Delay Code Groups",
													"Delay 1", "Delay 2", "Delay 3", "Delay 4", "Delay Time 1", "Delay Time 2", "Delay Time 3", "Delay Time 4", "Total Delay", 
													"ATA - ATD", "Delay Remarks",
													"Landing Time", "Fuel Used", "Dep Fuel", "Arr Fuel", "Fuel Uplift",
													"Captain ", "First Officer " };
	
	
	private static short[] standardWidthsList = {3000, 2500, 3000, 2500, 
												2000, 2000, 2500, 2500,
												2500, 2500, 2500, 2500, 
												2500, 2500, 8000,2500, 
												2500, 2500, 2500, 3500, 
												3500, 3500, 3500, 3500,
												3000, 8000,2500, 2500, 
												2500, 2500, 2500, 5000, 
												4000 };
	
	
	
	

	private static String[] cancelledTitlesList = {"Flight Date", "Flight No.", "A/C Type", "A/C Reg.", 
													"STD", "STA", "SCH DEP", "SCH ARR","ACT DEP", "ACT ARR",
													"Planned Pax", "ATA - ATD", " Remarks " };
	
	private static short[] cancelledWidthsList = {3000, 2500, 3000, 2500, 
													2000, 2000, 2500, 2500,
													2500, 2500,	2500, 2500, 12000
													};
	

	
	private static String[] sortedByDelayCodesTitlesList = {"Flight Date", "Flight No.", "A/C Type", "A/C Reg.", 
															"STD", "STA",  "SCH DEP", "SCH ARR",
															"ATD", "ATA", "ACT DEP", "ACT ARR", 
															"AB", "TOB", "Iata Delay Code Groups",
															"Delay Code", "Delay Time", "Total Delay", "ATA - ATD", "Delay Remarks" };
	
	
	private static short[]  sortedByDelayCodesWidthsList = {3000, 2500, 3000, 2500,
															2000, 2000, 2500, 2500,
															2500, 2500, 2500, 2500,
															2500, 3000, 10000,
															3000, 3000, 2500, 2500, 20000};
		
	
	
	
	
	
	
	
	public int Populate_Reliablity_Report_ExcelFormat(String airline, String airport, 
			  String startDate, String endDate,String tolerance,String delayCodeGroupCode, String useremail) throws Exception  {
		
	    
		 ClassLoader classLoader = this.getClass().getClassLoader();
		 File configFile=new File(classLoader.getResource("delaycodegroup.properties").getFile());
		 FileReader reader=new FileReader(configFile);
		 Properties p=new Properties(); 
		 p.load(reader);
	
		
		
		String delaycodegroup="";
	   	
		
	    logger.info("EXCEL Format Reliablity Report Creation Started at:"+ new Date());	
        
		HSSFWorkbook workbook = new HSSFWorkbook();	
		HSSFRow row = null;
		int rowNumber = 0;
	
		
		HSSFSheet sheet =  workbook.createSheet( "Reliability-Revenue All Flights" );
		setPrintSetup(sheet);
		
		row = sheet.createRow(rowNumber++);
		row=sheet.getRow(0);
		
		
		
		// Create a new font and alter it.
	    HSSFFont font = workbook.createFont();
		font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
		font.setFontName("Arial");
	    //  Create Style sheet with the above font 	
		CellStyle style = workbook.createCellStyle();
		style.setFillBackgroundColor(IndexedColors.GREY_50_PERCENT.getIndex());
		style.setFillPattern(CellStyle.LESS_DOTS);
	    style.setFont(font);
		
		
		
		
		
		//------------ Creating Header of The Excel Sheet ---------------
		for (int c = 0; c < standardTitlesList.length; c++) {
			createCell_Header(style,row, c, standardTitlesList[c]);
			sheet.setColumnWidth( c, standardWidthsList[c] );
			
		}
		
		//------------- Here Writing Body of the Report -------------------
		row = sheet.createRow( rowNumber++ ) ;
        linkPortalSqlBuilder sqlb = new linkPortalSqlBuilder();
	    String firstsheetsql=sqlb.builtExcelReliabilityReportSQL(airline.toUpperCase(), airport, startDate, endDate);
	    List<fligthSectorLog>  flightsec = jdbcTemplate.query(firstsheetsql,new flightSectorLogRowmapper());	
		    
	   
	  
	   
	    
	    for(fligthSectorLog flt:flightsec){  
	    	
	     	createCell(row, 0, flt.getFlightDatop());
	    	createCell(row, 1, flt.getFlightNo());
	    	createCell(row, 2, flt.getAircraftType());
	    	createCell(row, 3, flt.getAircraftReg());
	    	createCell(row, 4, flt.getStd());
	    	createCell(row, 5, flt.getSta());
	    	createCell(row, 6, flt.getEtd());
	    	createCell(row, 7, flt.getEta());
	    	createCell(row, 8, flt.getAtd());
	    	createCell(row, 9, flt.getAta());
	    	createCell(row, 10, flt.getFrom());
	    	createCell(row, 11, flt.getTo());
	    	createCell(row, 12, flt.getAirborn());
	    	createCell(row, 13, flt.getTotalOnBoard());
			createCell(row, 14, flt.IATA_DelCodeGroup());
	    	createCell(row, 15, flt.getDelayCode1());
	    	createCell(row, 16, flt.getDelayCode2());
	    	createCell(row, 17, flt.getDelayCode3());
	    	createCell(row, 18, flt.getDelayCode4());
	    	createCell(row, 19, flt.getDelayCode1_time());
	    	createCell(row, 20, flt.getDelayCode2_time());
	    	createCell(row, 21, flt.getDelayCode3_time());
	    	createCell(row, 22, flt.getDelayCode4_time());
		    createCell(row, 23, flt.getTotalDelayTime());
			createCell(row, 24, flt.getAtaAtd());
			createCell(row, 25,flt.getFlightNoteRemarks_For_Excel());
	    	createCell(row, 26,flt.getTouchdown());
	    	createCell(row, 27,flt.getFuelburn());
	    	createCell(row, 28,flt.getFuelAtthetimeofdep());
	    	createCell(row, 29,flt.getFuelAtthetimeofarr());	    	
	    	createCell(row, 30,flt.getFuelUplift());	    	
	    	createCell(row, 31,flt.getFlightCaption());
	    	createCell(row, 32,flt.getFlightFirstOfficer());
	    	
	    	row = sheet.createRow( rowNumber++ );
	    	
	    } ///  End of for loop and creation of First Sheet 
	    
	   
	
    
		
	
	    
	    
	    //------------------ This Will Create Report Sheet for All Flight Which is delay over 15 Minutes ---------------
	    linkPortalSqlBuilder sqlb1 = new linkPortalSqlBuilder(); 
	    String secondsheetsql=sqlb1.builtExcelReliabilityReportSQL_AsPerDelay(airline, airport, startDate, endDate,15);
	    rowNumber=0;
	    createDelaySheet(style,workbook,15,rowNumber,secondsheetsql,p);
	    logger.info("15 Minutes Delay Report Created :");
	    
	    
	    
	    //------------------ This Will Create Report Sheet for All Flight Which is delay over 30 Minutes ---------------
	    linkPortalSqlBuilder sqlb2 = new linkPortalSqlBuilder(); 
	    String thirdsheetsql=sqlb2.builtExcelReliabilityReportSQL_AsPerDelay(airline, airport, startDate, endDate,30);
	    rowNumber=0;
	    createDelaySheet(style,workbook,30,rowNumber,thirdsheetsql,p);
	    logger.info("30 Minutes Delay Report Created :");
	    
	    
	    
	    //------------------ This Will Create Report Sheet for All Flight Which is delay over 60 Minutes ---------------
	    linkPortalSqlBuilder sqlb3 = new linkPortalSqlBuilder(); 
	    String fourthsheetsql=sqlb3.builtExcelReliabilityReportSQL_AsPerDelay(airline, airport, startDate, endDate,60);
	    rowNumber=0;
	    createDelaySheet(style,workbook,60,rowNumber,fourthsheetsql,p);
	    logger.info("60 Minutes Delay Report Created :");
	    
	    
	    
	    //------------------ This Will Create Report Sheet for All Flight Which is Cancel  ---------------
	    linkPortalSqlBuilder sqlb4 = new linkPortalSqlBuilder(); 
	    String cancleflightsql=sqlb4.builtExcelReliabilityReportSQL_AllCancel(airline, airport, startDate, endDate);	    
	    rowNumber=0;
	    createCancleFlightSheet(style,workbook,rowNumber,cancleflightsql,p);
	    logger.info("Cancle Flight List is Created :");
	    
	   
	    
	    
	    
	    
	    //------------------ This Will Create Report Sheet for All Delay Flight  ---------------
	    linkPortalSqlBuilder sqlb5 = new linkPortalSqlBuilder(); 
	    String delayflightsql=sqlb5.builtExcelReliabilityReportSQL_AllflightWithDelayCode(airline, airport, startDate, endDate);	    
	    rowNumber=0;
		createDelayFlightSheet(style,workbook,rowNumber,delayflightsql,p);
	    logger.info("Delay Flight List is Created :");
	    
	    
	    
	   
	    
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
	    
	    
	    
	    
	    
		//--------------- Creating File And Writing into it ----------------------
		try (FileOutputStream outputStream = new FileOutputStream(filepath+useremail+"/viewExcelReliabilityReportFlights.xls")) {
		    workbook.write(outputStream);			    
		} catch (IOException ioe){logger.error(ioe);}
		
		
		logger.info("EXCEL Format Reliablity Report Creation Finished at:"+ new Date());	
		
		return 0;
	} //------------------------ End of Function Populate_Reliablity_Report_ExcelFormat  
	
	
	
	
	
	
	
	private void createDelaySheet(CellStyle style,HSSFWorkbook workbook, int delayminutes, int rowNumber, String sql,Properties p )throws Exception{
	
		HSSFSheet sheet =  workbook.createSheet( "Report Delayed >= "+delayminutes);
		setPrintSetup(sheet);
		String delaycodegroup="";
		
		HSSFRow row = sheet.createRow(rowNumber++);
		
		//------------ Creating Header of The Excel Sheet ---------------
		for (int c = 0; c < standardTitlesList.length; c++) {
			createCell_Header(style,row, c, standardTitlesList[c]);
			sheet.setColumnWidth( c, standardWidthsList[c] );
		}
		
		List<fligthSectorLog>  flightsecone = jdbcTemplate.query(sql,new flightSectorLogRowmapper());	
	    
		
		  
	    for(fligthSectorLog flt:flightsecone){  
	    	
	    	row = sheet.createRow( rowNumber++ );
	     	createCell(row, 0, flt.getFlightDatop());
	    	createCell(row, 1, flt.getFlightNo());
	    	createCell(row, 2, flt.getAircraftType());
	    	createCell(row, 3, flt.getAircraftReg());
	    	createCell(row, 4, flt.getStd());
	    	createCell(row, 5, flt.getSta());
	    	createCell(row, 6, flt.getEtd());
	    	createCell(row, 7, flt.getEta());
	    	createCell(row, 8, flt.getAtd());
	    	createCell(row, 9, flt.getAta());
	    	createCell(row, 10, flt.getFrom());
	    	createCell(row, 11, flt.getTo());
	    	createCell(row, 12, flt.getAirborn());
	    	createCell(row, 13, flt.getTotalOnBoard());
		 	createCell(row, 14, flt.IATA_DelCodeGroup());
	    	createCell(row, 15, flt.getDelayCode1());
	    	createCell(row, 16, flt.getDelayCode2());
	    	createCell(row, 17, flt.getDelayCode3());
	    	createCell(row, 18, flt.getDelayCode4());
	    	createCell(row, 19, flt.getDelayCode1_time());
	    	createCell(row, 20, flt.getDelayCode2_time());
	    	createCell(row, 21, flt.getDelayCode3_time());
	    	createCell(row, 22, flt.getDelayCode4_time());
		    createCell(row, 23, flt.getTotalDelayTime());
			createCell(row, 24, flt.getAtaAtd());
		 	createCell(row, 25, flt.getFlightNoteRemarks_For_Excel());
	    	createCell(row, 26,flt.getTouchdown());	    	
	    	createCell(row, 27,flt.getFuelburn());
	    	createCell(row, 28,flt.getFuelAtthetimeofdep());
	    	createCell(row, 29,flt.getFuelAtthetimeofarr());	    	
	    	createCell(row, 30,flt.getFuelUplift());
	    	createCell(row, 31,flt.getFlightCaption());
	    	createCell(row, 32,flt.getFlightFirstOfficer());
	    	
	    	
	    	
	    	
	    	
	    }// ---------- End Of Loop 
	    
			
		
}//------------ End Of createDelaySheet 

   
	
	
	
private void createCancleFlightSheet(CellStyle style,HSSFWorkbook workbook, int rowNumber, String sql,Properties p )throws Exception{
	
		HSSFSheet sheet =  workbook.createSheet( "Report - Cancelled Flights");
		setPrintSetup(sheet);
		String delaycodegroup;
		
		HSSFRow row = sheet.createRow(rowNumber++);
		
		//------------ Creating Header of The Excel Sheet ---------------
		for (int c = 0; c < cancelledTitlesList.length; c++) {
			createCell_Header(style,row, c, cancelledTitlesList[c]);
			sheet.setColumnWidth( c, cancelledWidthsList[c] );
		}
		
		List<fligthSectorLog>  flightthird = jdbcTemplate.query(sql,new flightSectorLogRowmapper());	
	  	  
	    for(fligthSectorLog flt:flightthird){  
	    	
	    	row = sheet.createRow( rowNumber++ );
	     	createCell(row, 0, flt.getFlightDatop());
	    	createCell(row, 1, flt.getFlightNo());
	    	createCell(row, 2, flt.getAircraftType());
	    	createCell(row, 3, ("CANX_"+flt.getAircraftType()));	    	
	    	createCell(row, 4, flt.getStd());
	    	createCell(row, 5, flt.getSta());	    	
	    	createCell(row, 6, flt.getEtd());
	    	createCell(row, 7, flt.getEta());
	     	createCell(row, 8, flt.getFrom());
	    	createCell(row, 9, flt.getTo());
	    	createCell(row, 10, flt.getNoOfSeats());
	    	createCell(row, 11, flt.getAtaAtd());	    	
	    	createCell(row, 12,flt.getFlightnote());
	    	
	    	
	    }// ---------- End Of Loop 
		
	
			
		
}//------------ End Of createCancleFlightSheet

   






//----------------- This Will Create Sheet With the Delay Code only ------------------------------- 
private void createDelayFlightSheet(CellStyle style,HSSFWorkbook workbook, int rowNumber, String sql,Properties p )throws Exception,IOException, ParseException{

	HSSFSheet sheet =  workbook.createSheet( "Report - All Delayed Flights");
	setPrintSetup(sheet);
	String delaycodegroup="";
	
	HSSFRow row = sheet.createRow(rowNumber++);
	
	//------------ Creating Header of The Excel Sheet ---------------
	for (int c = 0; c < sortedByDelayCodesTitlesList.length; c++) {
		createCell_Header( style, row, c, sortedByDelayCodesTitlesList[c]);
		sheet.setColumnWidth( c, sortedByDelayCodesWidthsList[c] );
	}
	
	List<fligthSectorLog>  flightthird = jdbcTemplate.query(sql,new flightSectorLogRowmapper());	
    
	
	
	  
    for(fligthSectorLog flt:flightthird){  
    	
    	row = sheet.createRow( rowNumber++ );
     	createCell(row, 0, flt.getFlightDatop());
    	createCell(row, 1, flt.getFlightNo());
    	createCell(row, 2, flt.getAircraftType());
    	createCell(row, 3, flt.getAircraftReg());	    	
    	createCell(row, 4, flt.getStd());
    	createCell(row, 5, flt.getSta());	    	
    	createCell(row, 6, flt.getEtd());
    	createCell(row, 7, flt.getEta());
    	
     	createCell(row, 8, flt.getFrom());
    	createCell(row, 9, flt.getTo());
    	
    	createCell(row, 10, flt.getAtd());
    	createCell(row, 11, flt.getAta());
    	
    	createCell(row, 12, flt.getAirborn());
    	createCell(row, 13, flt.getTouchdown());
    	createCell(row, 14, flt.IATA_DelCodeGroup());
    	createCell(row, 15, flt.getDelayCode1());
     	createCell(row, 16, flt.getDelayCode1_time());
     	createCell(row, 17, flt.getTotalDelayTime());
     	createCell(row, 18, flt.getAtaMinusAtd().trim());
      	createCell(row, 19, flt.getFlightNoteRemarks_For_Excel());
     	  
    	
    	
    }// ---------- End Of Loop 
	

		
	
}//------------ End Of createCancleFlightSheet





	
		
	
	
	
	
	
	
	
	/**
	 * Creates a cell
	 * Design Cell
	 * https://poi.apache.org/components/spreadsheet/quick-guide.html#FillsAndFrills
	 */
	protected HSSFCell createCell_Header(CellStyle style,HSSFRow row,  int column, String value ) {
		
			  HSSFCell cell  = row.createCell( column );
		      cell.setCellValue( value );
		      cell.setCellStyle(style);
		      return cell;
	}
	

	
	
	
	protected HSSFCell createCell(HSSFRow row,  int column, String value ) {
		
		  HSSFCell cell  = row.createCell( column );
	      cell.setCellValue( value );
	      
	      return cell;
}
	
	
	
	
	protected HSSFCell createCell( HSSFRow row,  int column, Long value ) {
		
		HSSFCell cell  = row.createCell( column );
		cell.setCellValue( value ) ;
		return cell;
	}
	
	protected HSSFCell createCell( HSSFRow row,  int column, Integer value ) {
		
		HSSFCell cell  = row.createCell( column );
		cell.setCellValue( value ) ;
		return cell;
	}
	
	
	

	protected void setPrintSetup(HSSFSheet sheet) {
		HSSFPrintSetup ps = sheet.getPrintSetup();
		ps.setFitWidth((short)1);   //1 page by blank pages wide.
		ps.setFitHeight((short)0);
		sheet.setAutobreaks(true);   
		ps.setLandscape(true);		//set landscape
		
	}
	
	


	
	
	
	
	
}//------------ End Of Class ReportMasterImp  
