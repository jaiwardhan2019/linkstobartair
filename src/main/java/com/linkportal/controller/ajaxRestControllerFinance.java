package com.linkportal.controller;

import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;


import javax.servlet.http.HttpServletRequest;

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
import com.linkportal.docmanager.DocumentService;
import com.linkportal.exception.xmlToExcelInvoiceConversionException;
import com.linkportal.groundops.gopsAllapi;
import com.linkportal.security.UserSecurityLdap;
import com.google.common.base.Strings;



@RestController
public class ajaxRestControllerFinance {



	@Autowired
	DocumentService  docserv;
	
	

    //---------- Logger Initializer------------------------------- 
	private Logger logger = Logger.getLogger(HomeController.class);
	

	//-------THis Will be FOR Finance invoice conversion tool  ----------------- 
	@RequestMapping(value = "/invoiceconversiontool",method = {RequestMethod.POST,RequestMethod.GET}, produces = { MimeTypeUtils.TEXT_PLAIN_VALUE })
	public ModelAndView invoiceConversionTool(HttpServletRequest req,ModelMap model) throws Exception{	
		model.addAttribute("emailid",req.getParameter("emailid"));
		model.addAttribute("password",req.getParameter("password"));
		model.put("profilelist",req.getSession().getAttribute("profilelist"));
		model.put("status", displayLastConvertedFile(req));
		logger.info("User id:"+req.getParameter("emailid")+" Called Invoice Conversion Tool");		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("miscellanous/convertinvoice");
		return modelAndView;	
	}//--------------- End Of Function -------------




	

	@RequestMapping(value = "/convertXmltoExcelandDownload", method = { RequestMethod.POST, RequestMethod.GET }, produces = { MimeTypeUtils.TEXT_PLAIN_VALUE })
	public ModelAndView convert_Xml_Excel_Download(@RequestParam("cfile") MultipartFile[] files, HttpServletRequest req,
			ModelMap model) throws Exception, xmlToExcelInvoiceConversionException {		
		

		model.put("profilelist", req.getSession().getAttribute("profilelist"));
		model.addAttribute("emailid", req.getParameter("emailid"));
		model.addAttribute("password", req.getParameter("password"));

		if (docserv.convertXmltoExcelFormat(req, files)) {
			model.put("status", buildFileLinkTodownload(req,files) );
		} else {
			model.put("status", "Error while uploading !!! Please check log file.");
		}	
	
		logger.info("User id:" + req.getParameter("emailid") + " File Updated to the Folder :" + req.getParameter("cat"));
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("miscellanous/convertinvoice");
		return modelAndView;
	}	
	
	
	
	
	
	//------- Will Create List of file in a String to display for download --------------
	String buildFileLinkTodownload(HttpServletRequest req, MultipartFile[] files) {
	
		String tableBody = "";
		String fileName  = null;
		tableBody = tableBody + "<tr align='left'><td colspan='2'><img src='"+req.getParameter("supplier").toLowerCase()+".jpg'>&nbsp;&nbsp;<b>"+req.getParameter("supplier").toUpperCase()+" &nbsp;Invoices # </b></td> </tr>";		
		for (MultipartFile multipartFile : files) {
			
			//--Build the download link only for the XML File not for other file 
			if(multipartFile.getOriginalFilename().substring(multipartFile.getOriginalFilename().length() - 3).equalsIgnoreCase("xml")){
				fileName =  multipartFile.getOriginalFilename().toString().substring(0,multipartFile.getOriginalFilename().toString().length() - 3)+"xls";
				tableBody = tableBody + "<tr align='center'> "
						+ "<td width='40%'>&nbsp;&nbsp;&nbsp;<a href='"+req.getParameter("emailid")+"/"+req.getParameter("supplier")+"/"+multipartFile.getOriginalFilename()+"'>"+fileName.substring(0,fileName.length()-3)+"xml&nbsp;&nbsp;</a></td>"
						+ "<td width='60%'><img src='xls.png'>&nbsp;&nbsp;&nbsp;<a href='"+req.getParameter("emailid")+"/"+req.getParameter("supplier")+"/"+fileName+"'>" +fileName+ "&nbsp;&nbsp;<i class='fa fa-download' aria-hidden='true'></i></a></td>"							
						+ "</tr>";
			}
			
		}
		return tableBody;
	}
	
	
	
	
	
	//-------- This Method will display the Last Converted Invoices and their Link 
	@Value("${fuelinvoices.documentroot.folder}")
	String fuelInvoiceRootDirectory;
	
	String displayLastConvertedFile(HttpServletRequest req) {
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
								if(innerfileName.contains("xml")) {
									tableBody = tableBody + "<tr align='center'> "
											+ "<td width='40%'>&nbsp;&nbsp;&nbsp;<a href='"+req.getParameter("emailid")+"/"+filename+"/"+innerfileName+"'>"+innerfileName.substring(0,innerfileName.length()-3)+"xml</a>&nbsp;&nbsp;</td>"
											+ "<td width='60%'><img src='xls.png'>&nbsp;<a href='"+req.getParameter("emailid")+"/"+filename+"/"+innerfileName.substring(0,innerfileName.length()-3)+"xls'>" +innerfileName.substring(0,innerfileName.length()-3)+"xls&nbsp;&nbsp;&nbsp;<i class='fa fa-download' aria-hidden='true'></i></a></td>"							
											+ "</tr>";								
								}
					
								
							} //  End of Inner For loop							
							
						}//  End of if 
						
						
						
						
					}//  End of outer For Loop
					
				}
				
				return tableBody;
				
				
			}// End of Method
			
	
	
	
}
