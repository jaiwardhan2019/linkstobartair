package com.linkportal.reports.excel;

import java.awt.Font;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.IOException;
import java.io.OutputStream;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.Year;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Properties;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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

import com.google.common.base.Strings;
import com.linkportal.datamodel.flightDelayComment;
import com.linkportal.datamodel.flightDelayCommentRowmapper;
import com.linkportal.datamodel.flightSectorLogRowmapper;
import com.linkportal.datamodel.fligthSectorLog;
import com.linkportal.dbripostry.codusSageFuelInvoice;
import com.linkportal.dbripostry.codusSageFuelInvoiceRowmapper;
import com.linkportal.sql.GroundOpsSqlBuilder;
import com.linkportal.sql.linkPortalSqlBuilder;




@Repository
public class ReportMasterImp extends excelReportCommonUtil implements ReportMaster {

	
	private static final String MasterSqlForallFuelInvoice = "SELECT scheme.Codisplinvdm.item As Invoice_No,\r\n"
			+ "scheme.Codisplinvdm.date_1 As DATE1 , scheme.Codisplinvhm.batch as Batch,\r\n"
			+ "scheme.Codisplinvhm.analysis_codes2 as Financial_Year , scheme.Codisplinvhm.period ,\r\n"
			+ "scheme.Codisplinvhm.supplier as Supplier_Code, scheme.Codisplinvhm.name as Supplier_Name, \r\n"
			+ "scheme.Codisplinvhm.analysis_codes3 As Franchise, scheme.Codisplinvdm.nominal_code As Nominal_Code,\r\n"
			+ "scheme.Codisplinvdm.vat_code, scheme.Codisplinvdm.local_value AS Amount_From_Line_Item_Table,\r\n"
			+ "scheme.Codisplinvdm.analysis_1 AS IATA_CODE , scheme.Codisplinvdm.analysis_2 AS Ticket_No,\r\n"
			+ "scheme.Codisplinvdm.analysis_3 AS Flight_No, scheme.Codisplinvdm.analysis_4 AS Aircraft_Reg,\r\n"
			+ "scheme.Codisplinvdm.name_1 AS TYPE_FUEL_AIRPORT_FEE, scheme.Codisplinvdm.value_1\r\n"
			+ "FROM scheme.Codisplinvhm  JOIN scheme.Codisplinvdm  ON scheme.Codisplinvhm.item = scheme.Codisplinvdm.item \r\n"
			+ "and scheme.Codisplinvhm.supplier = scheme.Codisplinvdm.supplier\r\n"
			+ "where scheme.Codisplinvdm.nominal_code in ('R026-3-20-10-010','R026-3-20-10-005') ";
	
	
	private static final String CurrentYearLasttwoDigit = Year.now().toString().substring(2);
	

    @Autowired
    DataSource dataSourcesqlserver;
    
    @Autowired
    DataSource dataSourcesqlservercp;
    
	@Autowired
	DataSource datasourceaalive;
	
      
	JdbcTemplate jdbcTemplate;	
	JdbcTemplate jdbcTemplateCorp;	
	JdbcTemplate jdbcTemplateForInvoice;	
	
	
	
	@Value("${spring.operations.excel.reportsfileurl}") String filepath;	
	
	

    //---------- Logger Initializer------------------------------- 
	private final Logger logger = Logger.getLogger(ReportMasterImp.class);
	

	
	
	
	ReportMasterImp(DataSource dataSourcesqlserver,DataSource dataSourcesqlservercp,DataSource datasourceaalive){ 
		jdbcTemplate     = new JdbcTemplate(dataSourcesqlserver);
		jdbcTemplateCorp = new JdbcTemplate(dataSourcesqlservercp);
		jdbcTemplateForInvoice  = new JdbcTemplate(datasourceaalive);
	}

	
	
	
	//-------------- First Sheet Header and Column width -------------------------------------
	private static final String[] standardTitlesList = {"Flight Date", "Flight No.", "A/C Type", "A/C Reg.",
													"STD", "STA", "SCH DEP", "SCH ARR", 
													"ATD", "ATA", "ACT DEP", "ACT ARR",
													"AIRBORN", "TOT ON BOARD", "IATA Delay Code Groups",
													"Delay 1", "Delay 2", "Delay 3", "Delay 4", "Delay Time 1", "Delay Time 2", "Delay Time 3", "Delay Time 4", "Total Delay", 
													"ATA - ATD", "Delay Remarks",
													"Landing Time", "Fuel Used", "Dep Fuel", "Arr Fuel", "Fuel Uplift",
													"Captain ", "First Officer " };
	

	private static final short[] standardWidthsList = {3000, 2500, 3000, 2500,
												2000, 2000, 2500, 2500,
												2500, 2500, 2500, 2500, 
												2500, 2500, 8000,2500, 
												2500, 2500, 2500, 3500, 
												3500, 3500, 3500, 3500,
												3000, 8000,2500, 2500, 
												2500, 2500, 2500, 5000, 
												4000 };
	
	
	
	
	
		

	private static final String[] cancelledTitlesList = {"Flight Date", "Flight No.", "A/C Type", "A/C Reg.",
													"STD", "STA", "SCH DEP", "SCH ARR","ACT DEP", "ACT ARR",
													"Planned Pax", "ATA - ATD", " Remarks " };
	
	private static final short[] cancelledWidthsList = {3000, 2500, 3000, 2500,
													2000, 2000, 2500, 2500,
													2500, 2500,	2500, 2500, 12000
													};
	

	
	private static final String[] sortedByDelayCodesTitlesList = {"Flight Date", "Flight No.", "A/C Type", "A/C Reg.",
															"STD", "STA",  "SCH DEP", "SCH ARR",
															"ATD", "ATA", "ACT DEP", "ACT ARR", 
															"AB", "TOB", "Iata Delay Code Groups", 
															"Delay Code", "Delay Time", "Total Delay", "ATA - ATD", "Delay Remarks" };
	
	
	private static final short[]  sortedByDelayCodesWidthsList = {3000, 2500, 3000, 2500,
															2000, 2000, 2500, 2500,
															2500, 2500, 2500, 2500,
															2500, 3000, 10000,
															3000, 3000, 2800, 2500, 20000};
		
	
	
	
	
	
	
	
	public int Populate_Reliablity_Report_ExcelFormat(String airline, String airport, 
			  String startDate, String endDate,String tolerance,String delayCodeGroupCode, String useremail) throws Exception  {
		
	    
		 ClassLoader classLoader = this.getClass().getClassLoader();
		 File configFile         = new File(classLoader.getResource("delaycodegroup.properties").getFile());
		 FileReader reader       = new FileReader(configFile);
		 Properties p            = new Properties(); 
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
	    

	    // Create Header Label with the parameter Detail 	
	    row = sheet.createRow( rowNumber++ );
	    createCell_Header(style, row, 0,"Reliablity Report For the Flights  Between : "+startDate+" And : "+endDate );
	    row = sheet.createRow( rowNumber++ );
	    row = sheet.createRow( rowNumber++ );
	    if(delayCodeGroupCode.equalsIgnoreCase("ALL")) 
	    {
	    	 createCell_Header(style, row, 0,"Delay Code : ALL ");
	    }
	    else
	    {
	       createCell_Header(style, row, 0,"For delay Code : "+delayCodeGroupCode);
	    }
	    row = sheet.createRow( rowNumber++ );
	    row = sheet.createRow( rowNumber++ );
	    
		
		
		
		
		//------------ Creating Header of The Excel Sheet ---------------
		for (int c = 0; c < standardTitlesList.length; c++) {
			createCell_Header(style,row, c, standardTitlesList[c]);
			sheet.setColumnWidth( c, standardWidthsList[c] );
			
		}
		
		//------------- Here Writing Body of the Report -------------------
		row = sheet.createRow( rowNumber++ ) ;
        linkPortalSqlBuilder sqlb = new linkPortalSqlBuilder();
        String firstsheetsql=sqlb.builtExcelReliabilityReportSQL(airline.toUpperCase(), airport, startDate, endDate,delayCodeGroupCode);        
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
		createDelayFlightSheet(style,workbook,rowNumber,delayflightsql,p,startDate, endDate , null);
	    logger.info("Delay Flight List is Created :");
	    
	    
	    
	   
	    
	    //------ CREATE FOLDER FOR THE SPECIFIC USER 
	    File file = new File(filepath+useremail);
        if (!file.exists()) {
            if (file.mkdir()) {
                
                logger.info(filepath+useremail+" Directory  Created for the Report Files");
            } else {
                
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
private void createDelayFlightSheet(CellStyle style,HSSFWorkbook workbook, int rowNumber, String sqlForDelay,Properties p , String StartDate , String endDate,String delayCodeList)throws Exception {

	HSSFSheet sheet =  workbook.createSheet( "Report - All Delayed Flights");
	setPrintSetup(sheet);
	String delaycodegroup="";
	
	HSSFRow row = sheet.createRow(rowNumber++);
	
	
	   // Create Header Label with the parameter Detail 	
    row = sheet.createRow( rowNumber++ );
    createCell_Header(style, row, 0,"Delay Flight Report  Between : "+StartDate+" And : "+endDate );

    row = sheet.createRow( rowNumber++ );
    if(delayCodeList == null) {delayCodeList= " All ";}
    row = sheet.createRow( rowNumber++ );
	
	//------------ Creating Header of The Excel Sheet ---------------
	for (int c = 0; c < sortedByDelayCodesTitlesList.length; c++) {
		createCell_Header( style, row, c, sortedByDelayCodesTitlesList[c]);
		sheet.setColumnWidth( c, sortedByDelayCodesWidthsList[c] );
	}
	
	List<fligthSectorLog>  flightthird = jdbcTemplate.query(sqlForDelay,new flightSectorLogRowmapper());	
    
	
	
	  
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





	@Override
	public int Populate_Delay_Report_ExcelFormat(String airline, String airport, String fromdate , String todate ,String useremail)
			throws Exception {

		
		    String[] delayFlightReportTitlesList = {"Flight Date", "Flight No.","A/C Reg.",
				"STD", "STA", "ACT DEP", "ACT ARR","IATA Delay Code Groups","Delay Code1", "Total Delay",
				"Delay Remarks","Status","Action","Comment"};

		
		    short[] delayFlightReportTitlesWidthsList = {3000, 2500, 3000, 2000, 
				2000, 3000, 3000, 8500,2000, 2500, 2500, 2500,3000,10000};


		
		 ClassLoader classLoader = this.getClass().getClassLoader();
		 File configFile         = new File(classLoader.getResource("delaycodegroup.properties").getFile());
		 FileReader reader       = new FileReader(configFile);
		 Properties p            = new Properties(); 
		 p.load(reader);
	
		
		
		String delaycodegroup="";
	   	
		
	    logger.info("Delay Flight Report  Creation Started at:"+ new Date());	
        
		HSSFWorkbook workbook = new HSSFWorkbook();	
		HSSFRow row = null;
		int rowNumber = 0;
	
	
		
		// Create a new font and alter it.
	    HSSFFont font = workbook.createFont();
		font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
		font.setFontName("Arial");
	    //  Create Style sheet with the above font 	
		CellStyle style = workbook.createCellStyle();
		style.setFillBackgroundColor(IndexedColors.GREY_50_PERCENT.getIndex());
		style.setFillPattern(CellStyle.LESS_DOTS);
	    style.setFont(font);
		
 
	    
	    
	    //------------------ This Will Create Report Sheet for All Delay Flight  ---------------
	    linkPortalSqlBuilder sqlb5 = new linkPortalSqlBuilder(); 
	    String delayflightsql      = sqlb5.builtExcelReliabilityReportSQL_AllflightWithDelayCode(airline, airport, fromdate, todate);	
	    rowNumber = 0;                
	    
	    //System.out.println(delayflightsql);
	    
		createDelayFlightSheet(style,workbook,rowNumber,delayflightsql,p,fromdate,todate,null);
	    logger.info("Delay Flight List is Created :");
	    
	    
	    
    
	    
	    //------------------ This Will Create Report Sheet for All Flight Which is Cancel  ---------------
	    linkPortalSqlBuilder sqlb4 = new linkPortalSqlBuilder(); 
	    String cancleflightsql=sqlb4.builtExcelReliabilityReportSQL_AllCancel(airline, airport, fromdate , todate);	    
	    rowNumber=0;
	    createCancleFlightSheet(style,workbook,rowNumber,cancleflightsql,p);
	    logger.info("Cancle Flight List is Created :");
	   
	    
	    
	    //------ CREATE FOLDER FOR THE SPECIFIC USER 
	    File file = new File(filepath+useremail);
        if (!file.exists()) {
            if (file.mkdir()) {
                
                logger.info(filepath+useremail+" Directory  Created for the Report Files");
            } else {
                
                logger.error("Failed to create directory name :"+filepath+useremail+"# Please Check Folder permissions");
            }
        }
	    
	    
	    
	    
	    
		//--------------- Creating File And Writing into it ----------------------
		try (FileOutputStream outputStream = new FileOutputStream(filepath+useremail+"/delayFlightReport.xls")) {
		    workbook.write(outputStream);			    
		} catch (IOException ioe){logger.error(ioe);}
		
				logger.info("EXCEL Format Delay Flight Report Creation Finished at:"+ new Date());	
		
		
		return 0;
	}




    //  For the On Time Performance Report ......... 
	@Override
	public int Populate_On_Time_Performance_Report_ExcelFormat(String airline, String airport, String Startflightdate,
			String Endflightdate, String emailid , String delaycodegroup) throws Exception {
		
		
	    logger.info("On Time Performance Flight Report  Creation Started at:"+ new Date());	
        
		HSSFWorkbook workbook = new HSSFWorkbook();	
		HSSFRow row = null;
		int rowNumber = 0;
	
	
		
		// Create a new font and alter it.
	    HSSFFont font = workbook.createFont();
		font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
		font.setFontName("Arial");
	    //  Create Style sheet with the above font 	
		CellStyle style = workbook.createCellStyle();
		style.setFillBackgroundColor(IndexedColors.GREY_50_PERCENT.getIndex());
		style.setFillPattern(CellStyle.LESS_DOTS);
	    style.setFont(font);
		

	    //------------------ This Will Create Report Sheet for All OTP Flight  ---------------
	    GroundOpsSqlBuilder sqlb = new GroundOpsSqlBuilder(); 
	    String delayflightsql      = sqlb.builtOnTimePerformanceReportSql(airline, airport, Startflightdate,Endflightdate,delaycodegroup);	
	    rowNumber = 0;                
	    
	    //System.out.println(delayflightsql);
	    
	    createOntimePerformanceFlightSheet(style,workbook,rowNumber,delayflightsql,Startflightdate,Endflightdate,delaycodegroup);
	    logger.info("Delay Flight List is Created :");
	    
	    
	    //------ CREATE FOLDER FOR THE SPECIFIC USER 
	    File file = new File(filepath+emailid);
        if (!file.exists()) {
            if (file.mkdir()) {
                
                logger.info(filepath+emailid+" Directory  Created for the Report Files");
            } else {
                
                logger.error("Failed to create directory name :"+filepath+emailid+"# Please Check Folder permissions");
            }
        }
	    
	    
	    
        
    		//--------------- Creating File And Writing into it ----------------------
    		try (FileOutputStream outputStream = new FileOutputStream(filepath+emailid+"/onTimePerformanceFlightReport.xls")) {
    		    
    			workbook.write(outputStream);			    
    		    
    		} catch (IOException ioe){logger.error(ioe);}
    		
    		logger.info("EXCEL Format Ontime Flight Performance Report Creation Finished at:"+ new Date());	
    	
		
		return 0;
	}
	
	





	//----------------- This Will Create Sheet With OTP Report ------------------------------- 
	private void createOntimePerformanceFlightSheet(CellStyle style,HSSFWorkbook workbook, int rowNumber, String sqlForOtp , String StartDate , String endDate, String delayCodeList)throws Exception {

		HSSFSheet sheet =  workbook.createSheet( "OTP - Report");
		setPrintSetup(sheet);
		String delaycodelist="";
		String delayDesclist="";
		
		HSSFRow row = sheet.createRow(rowNumber++);
		
	    String[] otpFlightReportTitlesList = {"Flight Date", "Flight No.","AC Typ","Ac Reg ", "From", "To", "Delay Code","Duration",
	    		"Attributable Delay","Delay Description", " Note "};

	    short[] otpFlightReportTitlesWidthsList = {3000, 3000, 3000, 3000,3000, 3000, 3000, 3000,6000,10000,30000};

		
	    // Create Header Label with the parameter Detail 	
	    row = sheet.createRow( rowNumber++ );
	    createCell_Header(style, row, 0,"One Time Performance Between : "+StartDate+" And : "+endDate );

	    row = sheet.createRow( rowNumber++ );
	    if(delayCodeList.equalsIgnoreCase("ALL")) {delayCodeList= " All ";}	
	    createCell_Header(style, row, 0,"For delay Code : "+delayCodeList);
	    row = sheet.createRow( rowNumber++ );
	    row = sheet.createRow( rowNumber++ );
	    
		
		//------------ Creating Header of The Excel Sheet ---------------
		for (int c = 0; c < otpFlightReportTitlesList.length; c++) {
			createCell_Header( style, row, c, otpFlightReportTitlesList[c]);
			sheet.setColumnWidth( c, otpFlightReportTitlesWidthsList[c] );
		}
		
		List<fligthSectorLog>  flightthird = jdbcTemplate.query(sqlForOtp,new flightSectorLogRowmapper());
		List<flightDelayComment>  flightcomment = jdbcTemplateCorp.query("Select * from Gops_Flight_Delay_Comment_Master WHERE Flight_Date between '"+StartDate+"' and '"+endDate+"'  order by Entry_Date_Time desc ",new flightDelayCommentRowmapper());
		
		
		  
	    for(fligthSectorLog flt:flightthird){  
	    	
	    	row = sheet.createRow( rowNumber++ );
	     	createCell(row, 0, flt.getFlightDate());
	    	createCell(row, 1, flt.getFlightNo());
	    	createCell(row, 2, flt.getAircraftType());
	    	createCell(row, 3, flt.getAircraftReg());	
	     	createCell(row, 4, flt.getFrom());
	     	createCell(row, 5, flt.getTo());
	     	
	     	delaycodelist = flt.getDelayCode1(); 
	     	if(flt.getDelayCode2() != null) {delaycodelist = delaycodelist + ", "+flt.getDelayCode2();}
	     	if(flt.getDelayCode3() != null) {delaycodelist = delaycodelist + ", "+flt.getDelayCode3();}
	     	if(flt.getDelayCode4() != null) {delaycodelist = delaycodelist + ", "+flt.getDelayCode4();}	     	
	     	
	     	createCell(row, 6,delaycodelist);
	       	createCell(row, 7, flt.getTotalDelayTime());	       	
	       	
	       	
	       	delayDesclist = flt.getDelayCode1_desc();
	       	if(!Strings.isNullOrEmpty(flt.getDelayCode2_desc())) {delayDesclist = delayDesclist + ", "+flt.getDelayCode2_desc();}
	       	if(!Strings.isNullOrEmpty(flt.getDelayCode3_desc())) {delayDesclist = delayDesclist + ", "+flt.getDelayCode3_desc();}
	     	if(!Strings.isNullOrEmpty(flt.getDelayCode4_desc())) {delayDesclist = delayDesclist + ", "+flt.getDelayCode4_desc();}
	     	
	     	createCell(row, 8, getStobartAttributableDelayForThisFlightandDate(flt.getFlightNo(), flt.getFlightDate(),flightcomment)); 
	       	createCell(row, 9, delayDesclist);
	    	createCell(row, 10, flt.getFlightNoteRemarks_For_Excel());
	       	
	    	
	    }// ---------- End Of Loop 
		
	  
			
		
	}//------------ End Of Method 






	   /* This method will take Parameter as flightno and flightDate and FlightSectorList
	    * check for the flight and date   return StobartAttributableDelay  YES / NO 
	   */	  
	   private String getStobartAttributableDelayForThisFlightandDate(String flightNo, String flightDate,List<flightDelayComment> flightcomment) {
		       String StobartAttributableDelay=null;
			   for(flightDelayComment flightDComment : flightcomment) {
				   if(flightNo.equalsIgnoreCase(flightDComment.getFlightNumber()) && flightDate.equalsIgnoreCase(flightDComment.getFlightDate()))
				   {
					 StobartAttributableDelay = flightDComment.getStobartdelay();					 
				   }
				   
		       }		 
				   
		   return StobartAttributableDelay;
	   }











	    // For Fuel Invoice.. JAITODO
		@Override
		public int  populateFuelInvoiceFromCodusSage(String financialYear, String invBatch, String invoiceNo , String userEmail)
				throws Exception {
			
			System.out.println("Detail"+financialYear+invBatch+invoiceNo);
	        
			HSSFWorkbook workbook = new HSSFWorkbook();	
			HSSFRow row = null;
			int rowNumber = 0;
		
		
			
			// Create a new font and alter it.
		    HSSFFont font = workbook.createFont();
			font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
			font.setFontName("Arial");
		    //  Create Style sheet with the above font 	
			CellStyle style = workbook.createCellStyle();
			style.setFillBackgroundColor(IndexedColors.LIGHT_BLUE.getIndex());
			//style.setFillPattern(CellStyle.LESS_DOTS);
		    style.setFont(font);
			

		    //------------------ This Will Create Report Sheet for All OTP Flight  ---------------
		    
		    String sqlForInvoiceList      = MasterSqlForallFuelInvoice;	
		    
		    
			if (!Strings.isNullOrEmpty(invBatch)) {
				sqlForInvoiceList = sqlForInvoiceList + "and scheme.Codisplinvhm.batch like '%" + invBatch+"%'";
			}
			
			if (!Strings.isNullOrEmpty(invoiceNo)) {
				sqlForInvoiceList = sqlForInvoiceList + "and scheme.Codisplinvdm.item like '%"+ invoiceNo+ "%'";
			}

			if (!Strings.isNullOrEmpty(financialYear)) {
				sqlForInvoiceList = sqlForInvoiceList + "and scheme.Codisplinvhm.analysis_codes2 like '%"+financialYear+ "'";
			} 
			else 
			{
				sqlForInvoiceList = sqlForInvoiceList + "and scheme.Codisplinvhm.analysis_codes2 like '%"+CurrentYearLasttwoDigit+"'";

			}
		    
			
		    rowNumber = 0;                
		    
		    
		    //--- Create Sheet and Fill Data in there from database 
		    createFuelReportSheet(style,workbook,rowNumber,financialYear,invoiceNo,invBatch,sqlForInvoiceList);
		   
		    
			// --------------- Creating File And Save to Disk ----------------------
			try (FileOutputStream outputStream = new FileOutputStream(filepath +userEmail+"/fuelInvoiceReport.xls")) {

				workbook.write(outputStream);
				logger.info("Fuel Invoice is created on:" + new Date());

			} catch (IOException ioe) {logger.error(ioe);}
	    	
			return 1;

		}	   
			   
			   

		
		//----------------- This Will Create Sheet With OTP Report ------------------------------- 
		private void createFuelReportSheet(CellStyle style,HSSFWorkbook workbook, int rowNumber, String finYear , String inVoiceNo , String batchNo, String sqlForInvoiceList)throws Exception {

			HSSFSheet sheet =  workbook.createSheet( "Fuel - Report");
			setPrintSetup(sheet);
			String delaycodelist="";
			String delayDesclist="";
			
			HSSFRow row = sheet.createRow(rowNumber++);
			
		    String[] otpFlightReportTitlesList = {"Invoice No ", "DATE1","Batch","Financial_Year", "period", "Supplier_Name", "Franchise","Nominal Code",
		    		"VAT Code","Amount", " IATA Code " , "Ticket No" ,"Flight_No" ,"Aircraft_Reg" , "TYPE_FUEL_AIRPORT_FEE" , "value_1"};

		    short[] otpFlightReportTitlesWidthsList = {3000, 3000, 3000, 3000,3000, 12000, 3000, 3000,6000,10000,10000,3000,3000,3000,3000,5000};

			
		    // Create Header Label with the parameter Detail 	
		    row = sheet.createRow( rowNumber++ );
		    
		    createCell_Header(style, row, 0,"Invoice list of Year  : "+finYear);

		    row = sheet.createRow( rowNumber++ );
		    row = sheet.createRow( rowNumber++ );
		    
			
			//------------ Creating Header of The Excel Sheet ---------------
			for (int c = 0; c < otpFlightReportTitlesList.length; c++) {
				createCell_Header( style, row, c, otpFlightReportTitlesList[c]);
				sheet.setColumnWidth( c, otpFlightReportTitlesWidthsList[c] );
			}
			
			int rowCtr = 0;
			List<codusSageFuelInvoice> invoiceList = jdbcTemplateForInvoice.query(sqlForInvoiceList,new codusSageFuelInvoiceRowmapper());		
			  
		    for(codusSageFuelInvoice invObj:invoiceList){  
		    	
		    	row = sheet.createRow( rowNumber++ );
		    	createCell(row, 0, rowCtr++);
		     	createCell(row, 1, invObj.getInvoiceNo());
		     	createCell(row, 2, invObj.getInvoiceDate());
		     	createCell(row, 3, invObj.getInvoiceBatch());
		     	createCell(row, 4, invObj.getInvoiceFinYear());
		    	createCell(row, 5, invObj.getInvoiceFinYear());
		    	
		    }// ---------- End Of Loop 
			
		  
				
			
		}//------------ End Of Method 



			
	
	
	
}//------------ End Of Class ReportMasterImp  
