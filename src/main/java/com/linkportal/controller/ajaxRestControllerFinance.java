package com.linkportal.controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Arrays;
import java.util.List;


import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
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
	
	
	

	// -------THis Will be Called When Add File will be Called from the GCI - GCM -
	// GCR edit Screen
	@RequestMapping(value = "/convertXmltoExcelandDownload", method = { RequestMethod.POST, RequestMethod.GET })
	public String convert_Xml_Excel_Download(@RequestParam("cfile") MultipartFile[] files, HttpServletRequest req,
			ModelMap model) throws Exception, xmlToExcelInvoiceConversionException {
		
		

		model.put("profilelist", req.getSession().getAttribute("profilelist"));
		model.addAttribute("emailid", req.getParameter("emailid"));
		model.addAttribute("password", req.getParameter("password"));

		
		
		
		
		/*
		 * / int status=0;
		 * 
		 * //*********WILL UPLOAD SINGLE FILE************************
		 * if(docserv.addUploadFiletoDatabaseAndFolder(req,file)) {
		 * model.put("status","Successfully Added"); } else {
		 * model.put("status","Error while uploading !!!");
		 * 
		 * }
		 * 
		 */

		// *********WILL UPLOAD MULTIPLE FILE************************

		if (docserv.convertXmltoExcelFormat(req, files)) {
			model.put("status", "Successfully Added");
		} else {
			model.put("status", "Error while uploading !!! Please check log file.");
		}	
	
		
		logger.info("User id:" + req.getParameter("emailid") + " File Updated to the Folder :" + req.getParameter("cat"));
		//return "miscellanous/convertinvoice";
		System.out.println("User id:" + req.getParameter("emailid") + " File Updated to the Folder :" + req.getParameter("cat"));
				
		return null;		
	}	
	
	

	
}
