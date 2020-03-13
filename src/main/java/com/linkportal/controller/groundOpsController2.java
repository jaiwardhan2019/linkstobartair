package com.linkportal.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.file.FileVisitResult;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.SimpleFileVisitor;
import java.nio.file.attribute.BasicFileAttributes;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;


import com.linkportal.contractmanager.manageStobartContract;
import com.linkportal.dbripostry.linkUsers;
import com.linkportal.docmanager.DocumentService;
import com.linkportal.fltreport.flightReports;
import com.linkportal.graphreport.piechart;
import com.linkportal.groundops.gopsAllapi;
import com.linkportal.groundops.refisUsers;
import com.linkportal.reports.excel.ReportMaster;
import com.linkportal.security.EncryptDecrypt;


@Controller
public class groundOpsController2 {

	
	@Autowired
	linkUsers dbusr;
	

	@Autowired
	flightReports fltobj;


	@Autowired
	DocumentService  docserv;

	
    //---------- Logger Initializer------------------------------- 
	private Logger logger = Logger.getLogger(HomeController.class);
	

    //*********************** FLIGHT REPORT SECTION ***********************
	//-------THis Will be Called When MayFly  Report link is called from the Home Page ----------------- 
	@RequestMapping(value = "/wtstatement",method = {RequestMethod.POST,RequestMethod.GET}) 
	public String GroundOpsWeightstatement(HttpServletRequest req,ModelMap model) throws Exception{
		
		   //Formatting today date...
		   Date today                     = new Date();               
		   SimpleDateFormat formattedDate = new SimpleDateFormat("yyyy-MM-dd");
		   Calendar                     c = Calendar.getInstance();  
		   String todaydate               = (String)(formattedDate.format(c.getTime()));
		   model.put("datop",todaydate);	        
   	       model.put("airlinecode",req.getParameter("airlinecode").toLowerCase());
 	       //model.addAttribute("airlinereg",req.getParameter("airlinereg").toLowerCase());
 	    
   	       
            model.put("airlinereg",fltobj.Populate_Operational_AirlineReg(req.getParameter("airlinereg"),req.getParameter("emailid")));		
	        model.put("airlinelist",fltobj.Populate_Operational_Airline(req.getParameter("airlinecode"),req.getParameter("emailid")));		
	        
	        if(!req.getParameter("airlinecode").equals("ALL")) {
	           model.put("gopsfilelist",docserv.getAllDocuments(req,"GOPS"));
	        }
	        
		        
	        if(req.getParameter("operation") != null){
	        	if(req.getParameter("operation").equals("view")){System.out.println("Write view code");}
	        	if(req.getParameter("operation").equals("update")){System.out.println("Write Update code");}
	        	if(req.getParameter("operation").equals("remove")){	        		
	        		if(docserv.deleteDocumentById(Integer.parseInt(req.getParameter("docid")))){System.out.println("Document Removed");}
	        		model.put("gopsfilelist",docserv.getAllDocuments(req,"GOPS"));
	        	}
	        	
	        }
	        
 	     	model.put("profilelist",req.getSession().getAttribute("profilelist"));
			model.addAttribute("emailid",req.getParameter("emailid"));
			model.addAttribute("password",req.getParameter("password"));
			model.put("usertype",req.getParameter("usertype"));
			logger.info("User id:"+req.getParameter("emailid")+" Login to flightreports Report");
			return "groundoperation/weightstatement"; 
			
	}

	
	
	//-------THis Will be Called When MayFly  Report link is called from the Home Page ----------------- 
		@RequestMapping(value = "/addwtstatement",method = {RequestMethod.POST,RequestMethod.GET}) 
		public String addGroundOpsWeightstatement(@RequestParam("gfile") MultipartFile[] files,HttpServletRequest req,ModelMap model) throws Exception{
		
        
	   	       model.put("airlinecode",req.getParameter("airlinecode").toLowerCase());
	 	       //model.addAttribute("airlinereg",req.getParameter("airlinereg").toLowerCase());
	 	    
	   	       
	            model.put("airlinereg",fltobj.Populate_Operational_AirlineReg(req.getParameter("airlinereg"),req.getParameter("emailid")));		
		        model.put("airlinelist",fltobj.Populate_Operational_Airline(req.getParameter("airlinecode"),req.getParameter("emailid")));		
		   	
               		
	       		 int status=0;
	    		 Arrays.asList(files).stream().forEach(file ->{
	    		 try{
	    			 if(docserv.addUploadFiletoDatabaseAndFolder(req,file)) { model.put("status","Successfully Added"); }else{ model.put("status","Error while uploading !!!");}
	    	       }catch (IOException | SQLException e) {e.printStackTrace();logger.error("While Uploading file :"+e.toString());}
	    		
	    		 });
    		 
	    		//******* Pupulate List of File *******************
	  		    model.put("gopsfilelist",docserv.getAllDocuments(req,"GOPS"));
	  		
	  	     	model.put("profilelist",req.getSession().getAttribute("profilelist"));
				model.addAttribute("emailid",req.getParameter("emailid"));
				model.addAttribute("password",req.getParameter("password"));
				model.put("usertype",req.getParameter("usertype"));
				return "groundoperation/weightstatement"; 
		}

	
	
	
	
	
	
	
	
	//****************** GROUND OPS SMS REPORT CONSUMER USER MANAGMENT ***********************************************
	//-------THis Will be Called When Refis User Links is called from Ground Ops  
	@RequestMapping(value = "/smsusermanager",method = {RequestMethod.POST,RequestMethod.GET})
	public String manageSmsUserlist(HttpServletRequest req, ModelMap model) throws Exception {	
		   int status=0;
			model.addAttribute("emailid",req.getParameter("emailid"));
			model.addAttribute("password",req.getParameter("password"));	
			model.put("profilelist",req.getSession().getAttribute("profilelist")); 
			model.put("usertype",req.getParameter("usertype"));	
			
			
			
			
			//--------- Start Remove Operation -------------------- 
			if(req.getParameter("operation") != null){	
				
				//-- View  Ground Ops User --
				if(req.getParameter("operation").equals("view")) {
					
				}
				
				//-- View  Ground Ops User --
				if(req.getParameter("operation").equals("add")) {
					
				}
							
	
				//-- View  Ground Ops User --
				if(req.getParameter("operation").equals("remove")) {
					
				}
										
				
			}	    
		    
		return "groundoperation/users/manageRefisusers";
	
	}
	



} //---- END OF CONTROLLER CLASS ----------

	

