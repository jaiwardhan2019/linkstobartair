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
	

	//-------THis Will be Called when link is clicked form the Header ----------------- 
	@RequestMapping(value = "/invoiceconversiontool",method = {RequestMethod.POST,RequestMethod.GET}, produces = { MimeTypeUtils.TEXT_PLAIN_VALUE })
	public ModelAndView invoiceConversionTool(HttpServletRequest req,ModelMap model) throws Exception{	
		model.addAttribute("emailid",req.getParameter("emailid"));
		model.addAttribute("password",req.getParameter("password"));
		model.put("profilelist",req.getSession().getAttribute("profilelist"));
		model.put("status", displayAllConvertedFile(req));
		logger.info("User id:"+req.getParameter("emailid")+" Called Invoice Conversion Tool");		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("miscellanous/convertinvoice");
		return modelAndView;	
	}//--------------- End Of Function -------------




	
	//-------THis Will be Called when Convert Invoice Button will be clicked ----------------- 
	@RequestMapping(value = "/convertXmltoExcelandDownload", method = { RequestMethod.POST, RequestMethod.GET }, produces = { MimeTypeUtils.TEXT_PLAIN_VALUE })
	public ModelAndView convert_Xml_Excel_Download(@RequestParam("cfile") MultipartFile[] files, HttpServletRequest req,
			ModelMap model) throws Exception, xmlToExcelInvoiceConversionException {		
		

		model.put("profilelist", req.getSession().getAttribute("profilelist"));
		model.addAttribute("emailid", req.getParameter("emailid"));
		model.addAttribute("password", req.getParameter("password"));

		if (docserv.convertXmltoExcelFormat(req, files)) {		
			model.put("status", displayAllConvertedFile(req));
		} else {
			model.put("status", "<ul><li><i class='fa fa-exclamation-triangle' aria-hidden='true'></i>&nbsp;&nbsp; Error !!! </li> <li> Please make sure file type is .XML </li> <li>Please make sure the XML File Belongs to the Relevant Supplier.</li></ul>");
		}	
	
		logger.info("User id:" + req.getParameter("emailid") + " File Updated to the Folder :" + req.getParameter("cat"));
		
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
											+ "<td width='40%' align='left'>&nbsp;&nbsp;<a href='"+req.getParameter("emailid")+"/"+filename+"/"+innerfileName+"'>"+innerfileName.substring(0,innerfileName.length()-3)+"xml</a>&nbsp;&nbsp;</td>"
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
