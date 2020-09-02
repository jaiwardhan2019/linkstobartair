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
	
	
	
	
	
	
	String buildFileLinkTodownload(HttpServletRequest req, MultipartFile[] files) {
	
		String HrefLink  = req.getParameter("supplier");
		String tableBody = "";
		String fileName  = null;
		tableBody = tableBody + "<tr align='left'><td colspan='2'><b>"+req.getParameter("supplier").toUpperCase()+" &nbsp;Invoices # </b></td> </tr>";		
		for (MultipartFile multipartFile : files) {
			fileName =  multipartFile.getOriginalFilename().toString().substring(0,multipartFile.getOriginalFilename().toString().length() - 3)+"xls";
			tableBody = tableBody + "<tr align='center'> "
					+ "<td width='40%'>&nbsp;&nbsp;&nbsp;"+fileName.substring(0,fileName.length()-3)+"xml&nbsp;&nbsp;</td>"
					+ "<td width='60%'><img src='xls.png'>&nbsp;&nbsp;&nbsp;<a href='"+req.getContextPath()+"/"+req.getParameter("emailid")+"/"+req.getParameter("supplier")+"/"+fileName+"'>" +fileName+ "&nbsp;&nbsp;<i class='fa fa-download' aria-hidden='true'></i></a></td>"
							
					+ "</tr>";
		}
		return tableBody;
	}
	
	
	
	
}
