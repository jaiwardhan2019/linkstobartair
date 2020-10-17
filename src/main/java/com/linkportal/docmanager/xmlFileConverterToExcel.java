package com.linkportal.docmanager;

import java.io.*;
import java.util.*;
import java.nio.file.Path;

import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.ParserConfigurationException;

import org.w3c.dom.Document;
import org.w3c.dom.NodeList;
import org.w3c.dom.Node;
import org.w3c.dom.Element;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;
import org.xml.sax.SAXParseException;

import com.linkportal.controller.HomeController;

import java.io.*;


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
import org.springframework.web.multipart.MultipartFile;


abstract class xmlFileConverterToExcel {


    //---------- Logger Initializer------------------------------- 
	private final Logger logger = Logger.getLogger(HomeController.class);
	

	
	//-------------- Shell Invoice Sheet Header and Column width -------------------------------------
	private static final String[] shellInvoiceTitlesList = {"Account No", "Invoice No", "Invoice Date", "Due Date","Payment Term", 
													 "Total With VAT In Local Curr.","Created On"};
	private static final short[] shellInvoiceTitlesWdth = {5000, 5000, 5000, 5000, 5000, 6000, 5000};	
	
	private static final String[] shellInvoiceLineItemTitlesList = {"Item_Number", "Deliver Date", "Ticket No", "Aircraft Type","Aircraft Reg No", "Flight No",
															"Liters QTY","ITA CODE","Fuel Value","Net Value","Diffrential AMT","Airport Fee","Exchange Rate"};
	private static final short[] shellInvoiceLineItemTitlesWdth = {4000, 4000, 4000, 4000, 4000, 4000, 4000,4000,4000,4000,4000,4000,4000};
	

	//-------------- World Fuel Invoice Sheet Header and Column width -------------------------------------
	private static final String[] wfsInvoiceTitlesList = {"Account No", "Invoice No", "Invoice Date", "Due Date","Payment Term","Invo .Currency",
													     "Total With VAT","Created On"};
	private static final short[] wfsInvoiceTitlesWdth = {5000, 5000, 5000, 5000, 5000, 5000, 6000, 5000};	
	
	private static final String[] wfsInvoiceLineItemTitlesList = {"Item_Number", "Deliver Date", "Ticket No", "Aircraft Type","Aircraft Reg No", "Flight No",
															"Liters QTY","ITA CODE","Fuel Value","Net Value","Exchange Rate"};
	private static final short[] wfsInvoiceLineItemTitlesWdth = {4000, 4000, 4000, 4000, 4000, 4000, 4000,4000,4000,4000,4000};
	

		
	
	void shellInvoiceParser(Path fileWithPath) throws ParserConfigurationException, SAXException, IOException {
		
		// --- This part of code will Load the XML file name  and load into parser---------
		File inputFile = new File(fileWithPath.toString());
		DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
		DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
		Document doc = dBuilder.parse(inputFile);
		doc.getDocumentElement().normalize();

		
		logger.info("Shell Invoice Conversion from XML to  EXCEL Creation Started at:"+ new Date());	
        
		HSSFWorkbook workbook = new HSSFWorkbook();	
		HSSFRow row = null;
		int rowNumber = 0;
	
		
		HSSFSheet sheet =  workbook.createSheet( "Shell Invoice" );
		setPrintSetup(sheet);
		
		row = sheet.createRow(rowNumber++);
		row =sheet.getRow(0);
		
		
		
		// Create a new font and alter it.
	    HSSFFont font = workbook.createFont();
		font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
		font.setFontName("Arial");
	    // Create Style sheet with the above font 	
		CellStyle style = workbook.createCellStyle();
		style.setFillBackgroundColor(IndexedColors.GREY_50_PERCENT.getIndex());
		style.setFillPattern(CellStyle.LESS_DOTS);
	    style.setFont(font);
		
	    // ------------ Creating Header  ---------------
	    for (int c = 0; c < shellInvoiceTitlesList.length; c++) {
	    	createCell_Header(style, row, c, shellInvoiceTitlesList[c]);
	    	sheet.setColumnWidth(c, shellInvoiceTitlesWdth[c]);
	    }

	    

        //-----------  This Part of code will print Invoice Header Content -----------
        NodeList summaryh = doc.getElementsByTagName("InvoiceHeader");     
        row = sheet.createRow((short)1);
        row.setHeight((short)350);
        
        for(int temph = 0; temph < summaryh.getLength(); temph++){	        	 
       	Node nNodeh = summaryh.item(temph);	           	            
           if (nNodeh.getNodeType() == Node.ELEMENT_NODE) {
              Element eElementh = (Element)nNodeh;
                row.createCell(0).setCellValue(eElementh.getElementsByTagName("CustomerEntityID").item(0).getTextContent());
	            row.createCell(1).setCellValue(eElementh.getElementsByTagName("InvoiceNumber").item(0).getTextContent());
	            row.createCell(2).setCellValue(eElementh.getElementsByTagName("InvoiceIssueDate").item(0).getTextContent());
	            row.createCell(3).setCellValue(eElementh.getElementsByTagName("InvoiceIssueDate").item(0).getTextContent());
	            row.createCell(4).setCellValue(eElementh.getElementsByTagName("InvoicePaymentTermsDescription").item(0).getTextContent());
	            row.createCell(5).setCellValue(eElementh.getElementsByTagName("InvoiceTotalAmountLocal").item(0).getTextContent());
	            row.createCell(6).setCellValue(eElementh.getElementsByTagName("InvoiceIssueDate").item(0).getTextContent());
	           
           }//--- End of If -------------------
           
        }// -------------------End of for loop 

	    
	    
        HSSFRow row1 = sheet.createRow((short)3);
        row1.createCell(0).setCellValue("__________________________________________________________________________________________(:LINE ITEM:)______________________________________________________________________________________________________");
       
        HSSFRow lineItemHeader = sheet.createRow((short)5);
        lineItemHeader.setHeight((short)300);
		// Create a new font and alter it.
	    HSSFFont fontLineItem = workbook.createFont();
	    fontLineItem.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
	    fontLineItem.setFontName("Arial");
		
	    // Create Style sheet with the above font 	
		CellStyle styleLineItem = workbook.createCellStyle();		
		styleLineItem.setFont(fontLineItem);    
		
	    for (int c = 0; c < shellInvoiceLineItemTitlesList.length; c++) {
	    	createCell_Header(styleLineItem, lineItemHeader, c, shellInvoiceLineItemTitlesList[c]);
	    	sheet.setColumnWidth(c, shellInvoiceLineItemTitlesWdth[c]);
	    }

       
        try{
	         
	         int rowcounter=6;         
	         
	         //-----------  This Part of code will print lineItem of Invoice -----------
	         NodeList lineitem = doc.getElementsByTagName("InvoiceLine");	 
	         for(int temp = 0; temp < lineitem.getLength(); temp++){
	        	 HSSFRow row3 = sheet.createRow((short)rowcounter);
	        	 Node nNode = lineitem.item(temp);		           	            
	             if (nNode.getNodeType() == Node.ELEMENT_NODE) {
	            	 try {
			               Element eElement = (Element) nNode;
			               row3.createCell(0).setCellValue(eElement.getElementsByTagName("ItemNumber").item(0).getTextContent());
			               row3.createCell(1).setCellValue(eElement.getElementsByTagName("ItemReferenceLocalDate").item(0).getTextContent().substring(0,10));
			               row3.createCell(2).setCellValue(eElement.getElementsByTagName("ItemDeliveryReferenceValue").item(1).getTextContent());
			               row3.createCell(3).setCellValue(eElement.getElementsByTagName("ItemDeliveryReferenceValue").item(3).getTextContent());	               
			               row3.createCell(4).setCellValue(addChar(eElement.getElementsByTagName("ItemDeliveryReferenceValue").item(2).getTextContent(),'-',2));
			               row3.createCell(5).setCellValue(eElement.getElementsByTagName("ItemDeliveryReferenceValue").item(0).getTextContent());	               
			               row3.createCell(6).setCellValue(Double.parseDouble(eElement.getElementsByTagName("ItemQuantityQty").item(0).getTextContent()));	               
			               row3.createCell(7).setCellValue(eElement.getElementsByTagName("ItemDeliveryLocation").item(0).getTextContent());	               
			               row3.createCell(8).setCellValue(eElement.getElementsByTagName("SubItemInvoiceAmount").item(0).getTextContent());
			               row3.createCell(9).setCellValue(eElement.getElementsByTagName("ItemInvoiceAmount").item(0).getTextContent());
			               row3.createCell(10).setCellValue(eElement.getElementsByTagName("SubItemInvoiceAmount").item(1).getTextContent());	              
			               row3.createCell(11).setCellValue(eElement.getElementsByTagName("SubItemInvoiceAmount").item(2).getTextContent());	               
			               row3.createCell(12).setCellValue(Double.parseDouble(eElement.getElementsByTagName("ExchangeRate").item(1).getTextContent()));
		              
	            }catch(NullPointerException ee){logger.error("Error on line Item No : "+temp+":=>"+ee.toString());} 
	               
	               
	            }//--- End of If -------------------
	            rowcounter++;
	         }// -------------------End of for loop for line item printing 
	     
	        }catch(Exception eee){logger.error(eee.toString());} 
        
        

       
		//--------------- Creating File And Writing into it ----------------------
		try (FileOutputStream outputStream = new FileOutputStream(fileWithPath.toString().substring(0,fileWithPath.toString().length() - 3)+"xls")) {
		    workbook.write(outputStream);			    
		} catch (IOException ioe){logger.error(ioe);}
	
		logger.info("Shell Invoice Conversion  Finished at:"+ new Date());	
	
	}
	
	
	
	
	
	void worldFuelServiceInvoiceParser(Path fileWithPath) throws ParserConfigurationException, SAXException, IOException {
		
		// --- This part of code will Load the XML file name  and load into parser---------
		File inputFile = new File(fileWithPath.toString());
		DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
		DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
		Document doc = dBuilder.parse(inputFile);
		doc.getDocumentElement().normalize();
		
		logger.info("EXCEL Format Of Shell Invoice Creation Started at:"+ new Date());	
        
		HSSFWorkbook workbook = new HSSFWorkbook();	
		HSSFRow row = null;
		int rowNumber = 0;
	
		
		HSSFSheet sheet =  workbook.createSheet( "World Fuel Invoice" );
		setPrintSetup(sheet);
		
		row = sheet.createRow(rowNumber++);
		row =sheet.getRow(0);
		
		
		
		// Create a new font and alter it.
	    HSSFFont font = workbook.createFont();
		font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
		font.setFontName("Arial");
	    // Create Style sheet with the above font 	
		CellStyle style = workbook.createCellStyle();
		style.setFillBackgroundColor(IndexedColors.GREY_50_PERCENT.getIndex());
		style.setFillPattern(CellStyle.LESS_DOTS);
	    style.setFont(font);
		
	    // ------------ Creating Header  ---------------
	    for (int c = 0; c < wfsInvoiceTitlesList.length; c++) {
	    	createCell_Header(style, row, c, wfsInvoiceTitlesList[c]);
	    	sheet.setColumnWidth(c, wfsInvoiceTitlesWdth[c]);
	    }

	    

        //-----------  This Part of code will print Invoice Header Content -----------
        NodeList summaryh = doc.getElementsByTagName("InvoiceHeader");     
        row = sheet.createRow((short)1);
        row.setHeight((short)350);
        
        for(int temph = 0; temph < summaryh.getLength(); temph++){	        	 
       	Node nNodeh = summaryh.item(temph);	           	            
           if (nNodeh.getNodeType() == Node.ELEMENT_NODE) {
              Element eElementh = (Element)nNodeh;
                row.createCell(0).setCellValue(eElementh.getElementsByTagName("CustomerEntityID").item(0).getTextContent());
	            row.createCell(1).setCellValue(eElementh.getElementsByTagName("InvoiceNumber").item(0).getTextContent());
	            row.createCell(2).setCellValue(eElementh.getElementsByTagName("InvoiceIssueDate").item(0).getTextContent());
	            row.createCell(3).setCellValue(eElementh.getElementsByTagName("InvoiceIssueDate").item(0).getTextContent());
	            row.createCell(4).setCellValue(eElementh.getElementsByTagName("InvoicePaymentTermsType").item(0).getTextContent());
	            row.createCell(5).setCellValue(eElementh.getElementsByTagName("InvoiceCurrencyCodeLocal").item(0).getTextContent());
	            row.createCell(6).setCellValue(eElementh.getElementsByTagName("InvoiceTotalAmount").item(0).getTextContent());
	            row.createCell(7).setCellValue(eElementh.getElementsByTagName("InvoiceIssueDate").item(0).getTextContent());
	           
           }//--- End of If -------------------
           
        }// -------------------End of for loop 

	    
	    
        HSSFRow row1 = sheet.createRow((short)3);
        row1.createCell(0).setCellValue("__________________________________________________________________________________________(:LINE ITEM:)______________________________________________________________________________________________________");
       
        HSSFRow lineItemHeader = sheet.createRow((short)5);
        lineItemHeader.setHeight((short)300);
		// Create a new font and alter it.
	    HSSFFont fontLineItem = workbook.createFont();
	    fontLineItem.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
	    fontLineItem.setFontName("Arial");
		
	    // Create Style sheet with the above font 	
		CellStyle styleLineItem = workbook.createCellStyle();		
		styleLineItem.setFont(fontLineItem);    
		
	    for (int c = 0; c < shellInvoiceLineItemTitlesList.length; c++) {
	    	createCell_Header(styleLineItem, lineItemHeader, c, shellInvoiceLineItemTitlesList[c]);
	    	sheet.setColumnWidth(c, shellInvoiceLineItemTitlesWdth[c]);
	    }

       
        try{
	         
	         int rowcounter=6;   //  Start from 6th line on the excel sheet      
	         
	         //-----------  This Part of code will print lineItem of Invoice -----------
	         NodeList lineitem = doc.getElementsByTagName("InvoiceLine");	 
	         for(int temp = 0; temp < lineitem.getLength(); temp++){
	        	 HSSFRow row3 = sheet.createRow((short)rowcounter);
	        	 Node nNode = lineitem.item(temp);		           	            
	             if (nNode.getNodeType() == Node.ELEMENT_NODE) {
	            	 try {
			               Element eElement = (Element) nNode;
			               row3.createCell(0).setCellValue(eElement.getElementsByTagName("ItemNumber").item(0).getTextContent());
			               row3.createCell(1).setCellValue(eElement.getElementsByTagName("ItemReferenceLocalDate").item(0).getTextContent().substring(0,10));
			               row3.createCell(2).setCellValue(eElement.getElementsByTagName("ItemDeliveryReferenceValue").item(0).getTextContent());
			               row3.createCell(3).setCellValue(eElement.getElementsByTagName("ItemDeliveryReferenceValue").item(3).getTextContent());			               
			               row3.createCell(4).setCellValue(addChar(eElement.getElementsByTagName("ItemDeliveryReferenceValue").item(1).getTextContent(),'-',2));			               
			               row3.createCell(5).setCellValue(eElement.getElementsByTagName("ItemDeliveryReferenceValue").item(2).getTextContent());
			               row3.createCell(6).setCellValue(Double.parseDouble(eElement.getElementsByTagName("ItemQuantityQty").item(0).getTextContent()));
			               row3.createCell(7).setCellValue(eElement.getElementsByTagName("ItemDeliveryLocation").item(0).getTextContent());
			               row3.createCell(8).setCellValue(eElement.getElementsByTagName("SubItemPricingAmount").item(0).getTextContent());
			               row3.createCell(9).setCellValue(eElement.getElementsByTagName("ItemInvoiceAmount").item(0).getTextContent());
			               // Differential Ammount need to be added 
			               //row3.createCell(11).setCellValue(eElement.getElementsByTagName("SubItemPricingAmount").item(0).getTextContent());
			               row3.createCell(12).setCellValue(eElement.getElementsByTagName("ExchangeRate").item(0).getTextContent());
			               
			               
	          }catch(NullPointerException ee){logger.error("Error on line Item No : "+temp+":=>"+ee.toString());} 
	               
	               
	            }//--- End of If -------------------
	            rowcounter++;
	         }// -------------------End of for loop for line item printing 
	     
	        }catch(Exception eee){logger.error(eee.toString());} 
        
        

       
		//--------------- Creating File And Writing into it ----------------------
		try (FileOutputStream outputStream = new FileOutputStream(fileWithPath.toString().substring(0,fileWithPath.toString().length() - 3)+"xls")) {
		    workbook.write(outputStream);			    
		} catch (IOException ioe){logger.error(ioe);}
	
		logger.info("World Fuels Invoice Conversion  Finished at:"+ new Date());	
		

	}

	
	
	
	
	
	
	
	
	
	
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


	public String addChar(String str, char ch, int position) {
	    StringBuilder sb = new StringBuilder(str);
	    sb.insert(position, ch);
	    return sb.toString();
	}

	
	
}
