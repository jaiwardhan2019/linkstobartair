package com.linkportal.controller;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;

import java.io.File;


import java.io.OutputStream;
import java.time.Year;
import java.util.Date;



import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.IOUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.ModelMap;
import org.springframework.util.MimeTypeUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.linkportal.datamodel.flightDelayComment;
import com.linkportal.dbripostry.codusSageFuelReport;
import com.linkportal.docmanager.DocumentService;
import com.linkportal.exception.xmlToExcelInvoiceConversionException;
import com.linkportal.groundops.gopsAllapi;
import com.linkportal.reports.excel.ReportMaster;
import com.linkportal.security.UserSecurityLdap;
import com.google.common.base.Strings;
import java.io.File;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.List;
import java.time.Year;
import java.time.Year;
@RestController
public class ajaxRestControllerFinance {


	@Autowired
	DocumentService  docserv;
	
	@Autowired
	codusSageFuelReport fuelInvObject;
	
	
	@Autowired
	ReportMaster excel;

	
	
	@Value("${spring.operations.excel.reportsfileurl}") String filepath;	
	



    //---------- Logger Initializer------------------------------- 
	private final Logger logger = Logger.getLogger(HomeController.class);
	

	//-------THis Will be Called when link is clicked form the Header ----------------- 
	@RequestMapping(value = "/invoiceconversiontool",method = {RequestMethod.POST,RequestMethod.GET}, produces = { MimeTypeUtils.TEXT_PLAIN_VALUE })
	public ModelAndView invoiceConversionTool(HttpServletRequest req,ModelMap model) throws Exception{	
		String[] userEmailId   =  req.getParameter("profilelist").toString().split("#");
	    model.addAttribute("profilelist",req.getParameter("profilelist"));	
		model.put("status", displayAllConvertedFile(req));
		logger.info("User id:"+userEmailId[0]+" Called Invoice Conversion Tool");		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("miscellanous/convertinvoice");
		return modelAndView;	
	}//--------------- End Of Function -------------


	

	//-------THis Will be Called when link is clicked form the Header ----------------- 
	@RequestMapping(value = "/populatefuelinvoice",method = {RequestMethod.POST,RequestMethod.GET}, produces = { MimeTypeUtils.TEXT_PLAIN_VALUE })
	public ModelAndView populatefuelinvoice(HttpServletRequest req,ModelMap model) throws Exception{	
		
		String[] userEmailId   =  req.getParameter("profilelist").toString().split("#");
	    model.addAttribute("profilelist",req.getParameter("profilelist"));	
	    
	    String CurrentYear = Year.now().toString();
	
	    String searchLabel="Details Of # ";
	    
	    //--- Built Label and all 
		if ((req.getParameter("batch") != null) && (req.getParameter("batch").length() > 0)) {
			model.put("batch", req.getParameter("batch"));
			searchLabel = searchLabel + " Batch no : <b>" + req.getParameter("batch")+"</b>";
		}
		if ((req.getParameter("invoiceno")) != null && (req.getParameter("invoiceno").length() > 0)) {
			model.put("invoiceno", req.getParameter("invoiceno"));
			searchLabel = searchLabel + " Invoice no : <b>" + req.getParameter("invoiceno")+"</b>";
		}
		if ((req.getParameter("financialyear") != null) && (req.getParameter("financialyear").length() > 0)) {
			model.put("financialyear", req.getParameter("financialyear"));
			searchLabel = searchLabel + " Financial Year : <b>20"+req.getParameter("financialyear")+"</b>";
		}

		if(searchLabel.length() <= 15) {searchLabel = searchLabel+"<b>"+CurrentYear+"</b>";} 	
		
		
	    //-- Service Cal Pull and Populate data from database 
	    model.put("searchlabel",searchLabel);
	    model.put("invoicelist",fuelInvObject.populateFuelInvoices(req));
	    
	    
	    
		logger.info("User id:"+userEmailId[0]+" Called Fuel Report");		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("miscellanous/fuelreportdownload");
		return modelAndView;	
	}//--------------- End Of Function -------------


	
	
	
	
    //https://34codefactory.medium.com/spring-boot-file-download-using-ajax-example-code-factory-95e33ab0934c
	// JAITODO
	
	// --------- THIS PART WILL DO DB UPDATE FROM THE AJAX
	@RequestMapping(value = "/downloadfuleinvoiceinexcelfile", method = { RequestMethod.POST, RequestMethod.GET })
	public void CreateExcelReport(ModelMap model, HttpServletRequest req, HttpServletResponse res)
			throws Exception {	

			logger.info(req.getParameter("emailid") + " : Have Started Downloading  Fuel Invoice Excel Report  on:" + new Date());
			excel.populateFuelInvoiceFromCodusSage(req.getParameter("financialyear"), req.getParameter("batch"), req.getParameter("invoiceno"),req.getParameter("emailid"));

	}

	
	

	//--- Download File on new browser 
	private void downLoadFile(HttpServletResponse response , ByteArrayOutputStream baos , String fileName) throws Exception {
		
		OutputStream out = null;
		//------- This Part will Download The File --------
		try {
			
			// Set the response message header to tell the browser that the current respo
			response.setContentType( "application/pdf");
			// Tell the browser that the current response data requires user intervention to save to the file, and what the file name is. If the file name has Chinese, it must be URL encoded. 
			System.out.println("Inside Download  Methid ");
		
			//response.setHeader( "Content-Disposition", "attachment;filename=" + fileName);    //<<-- For Download
			response.setHeader( "Content-Disposition", "inline;filename=" + fileName);       //<<-- For View   
			out = response.getOutputStream();			
			baos.writeTo(out);			
			out.flush();
			baos.close();
			
		} catch (Exception e) {logger.error(e); System.out.println(e.getMessage());} 
		    //finally{if(baos != null){ baos.close();}if(out != null){ out.close();}}//End of finally 
		

		
	}
	
	
	
	


	
	//-------THis Will be Called when Convert Invoice Button will be clicked ----------------- 
	@RequestMapping(value = "/convertXmltoExcelandDownload", method = { RequestMethod.POST, RequestMethod.GET }, produces = { MimeTypeUtils.TEXT_PLAIN_VALUE })
	public ModelAndView convert_Xml_Excel_Download(@RequestParam("cfile") MultipartFile[] files, HttpServletRequest req,
			ModelMap model) throws Exception {

		String[] userEmailId   =  req.getParameter("profilelist").toString().split("#");
	    model.addAttribute("profilelist",req.getParameter("profilelist"));	

		if (docserv.convertXmltoExcelFormat(req, files)) {		
			model.put("status", displayAllConvertedFile(req));
		} else {
			model.put("status", "<ul><li><i class='fa fa-exclamation-triangle' aria-hidden='true'></i>&nbsp;&nbsp; Error !!! </li> <li> Please make sure file type is .XML </li> <li>Please make sure the XML File Belongs to the Relevant Supplier.</li></ul>");
		}	
	
		logger.info("User id:" + userEmailId[0] + " File Updated to the Folder :" + req.getParameter("cat"));
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("miscellanous/convertinvoice");
		return modelAndView;
	}	
	
	
	
	
	//-------- This Method will display the Last Converted Invoices and their Link 
	@Value("${fuelinvoices.documentroot.folder}")
	String fuelInvoiceRootDirectory;	
	String displayAllConvertedFile(HttpServletRequest req) {
			String tableBody = "";
			String fileName  = null;
			File foldername = new File(fuelInvoiceRootDirectory + "/"+req.getParameter("emailid")+"/");
				if (foldername.isDirectory()) {
					String[] folderList = foldername.list();
					for (String filename : folderList) {
						if(new File(fuelInvoiceRootDirectory + "/"+req.getParameter("emailid")+"/"+filename).isDirectory()){
							tableBody = tableBody + "<tr align='left'><td colspan='2'><img src='"+filename.toLowerCase()+".jpg'>&nbsp;&nbsp;<b>"+filename.toUpperCase()+" &nbsp;Invoices # </b></td> </tr>";	
							String[] fileList = new File(fuelInvoiceRootDirectory + "/"+req.getParameter("emailid")+"/"+filename).list();
							for (String innerfileName : fileList) {								
								if(innerfileName.contains("xls")) {
									tableBody = tableBody + "<tr align='left'> "
											+ "<td width='40%' align='left'>&nbsp;&nbsp;<a href='"+req.getParameter("emailid")+"/"+filename+"/"+innerfileName.substring(0,innerfileName.length()-3)+"xml' target='_new'>"+innerfileName.substring(0,innerfileName.length()-3)+"xml</a>&nbsp;&nbsp;</td>"
											+ "<td width='60%' align='left'>&nbsp;<img src='xls.png'>&nbsp;<a href='"+req.getParameter("emailid")+"/"+filename+"/"+innerfileName.substring(0,innerfileName.length()-3)+"xls'>" +innerfileName.substring(0,innerfileName.length()-3)+"xls&nbsp;&nbsp;&nbsp;<i class='fa fa-download' aria-hidden='true'></i></a></td>"							
											+ "</tr>";								
								}
					
								
							} //  End of Inner For loop							
							
						}//  End of if 
						
						
						
						
					}//  End of outer For Loop
					
				}
				
				return tableBody;
				
				
			}// End of Method
			
	
	
	
}
