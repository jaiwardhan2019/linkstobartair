package com.linkportal.controller;

import java.io.IOException;

import java.io.PrintWriter;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.common.base.Strings;
import com.linkportal.airlinemanager.airDataManager;
import com.linkportal.airlinemanager.airLineEntity;


import com.linkportal.crewripostry.crewReport;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.linkportal.dbripostry.linkUsers;
import com.linkportal.docmanager.DocumentService;
import com.linkportal.fltreport.flightReports;
import com.linkportal.smsreportusers.smsConsumerEntity;
import com.linkportal.smsreportusers.smsConsumerService;




@Controller
public class groundOpsController2 {

	
	@Autowired
	linkUsers dbusr;
	

	@Autowired
	flightReports fltobj;


	@Autowired
	DocumentService  docserv;
	
	
	 @Autowired 
	 smsConsumerService smsSrvObj;

	 @Autowired
	 airDataManager airObj;


	  
	 @Autowired
	 crewReport crewInfo;
	
	
    //---------- Logger Initializer------------------------------- 
	private final Logger logger = Logger.getLogger(HomeController.class);
	

    //*********************** FLIGHT REPORT SECTION ***********************
	//-------THis Will be Called When MayFly  Report link is called from the Home Page ----------------- 
	@RequestMapping(value = "/wtstatement",method = {RequestMethod.POST,RequestMethod.GET}) 
	public String GroundOpsWeightstatement(HttpServletRequest req,ModelMap model) throws Exception{
		
		   //Formatting today date...
		   Date today                     = new Date();               
		   SimpleDateFormat formattedDate = new SimpleDateFormat("yyyy-MM-dd");
		   Calendar                     c = Calendar.getInstance();  
		   String todaydate               = formattedDate.format(c.getTime());
		   model.put("datop",todaydate);	        
   	       model.put("airlinecode",req.getParameter("airlinecode").toLowerCase());
 	       //model.addAttribute("airlinereg",req.getParameter("airlinereg").toLowerCase());
 	    
   	       
            model.put("airlinereg",fltobj.Populate_Operational_AirlineReg(req.getParameter("airlinereg"),req.getParameter("emailid")));		
	        model.put("airlinelist",fltobj.Populate_Operational_Airline(req.getParameter("airlinecode"),req.getParameter("emailid")));		
	        
	        if(!req.getParameter("airlinecode").equals("ALL")) {
	           model.put("gopsfilelist",docserv.getAllDocuments(req,"GOPS"));
	        }
	        
		        
	        if(req.getParameter("operation") != null){	      
	        	if(req.getParameter("operation").equals("remove")){	        		
	        		if(docserv.deleteDocumentById(Integer.parseInt(req.getParameter("docid")))){System.out.println("Document Removed");}
	        		model.put("gopsfilelist",docserv.getAllDocuments(req,"GOPS"));
	        	}
	        	
	        }
	        
 	     	model.put("profilelist",req.getSession().getAttribute("profilelist"));
			model.addAttribute("emailid",req.getParameter("emailid"));
			model.addAttribute("password",req.getParameter("password"));
			model.put("usertype",req.getParameter("usertype"));
			logger.info("User id:"+req.getParameter("emailid")+" Checked the Weight Statement..");
			return "groundoperation/weightstatement"; 
			
	}

	
	
	
	
	//-------THis Will be Called When MayFly  Report link is called from the Home Page ----------------- 
		@RequestMapping(value = "/addwtstatement",method = {RequestMethod.POST,RequestMethod.GET}) 
		public String addGroundOpsWeightstatement(@RequestParam("gfile") MultipartFile[] files,HttpServletRequest req,ModelMap model) throws Exception{
		
        
	   	       model.put("airlinecode",req.getParameter("airlinecode").toLowerCase());
	 	    
	   	       
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
				logger.info("User id:"+req.getParameter("emailid")+" Added Weight Statement.");
				return "groundoperation/weightstatement"; 
		}

	
	
	
	
	
	
	
	
	//****************** GROUND OPS SMS REPORT CONSUMER USER MANAGMENT ***********************************************
	//-------THis Will be Called When Refis User Links is called from Ground Ops  
	@RequestMapping(value = "/managesmscontacts",method = {RequestMethod.POST,RequestMethod.GET})
	public String manageSmsUserlist(HttpServletRequest req, ModelMap model) throws Exception {	
		    String operationStatus="";
		    String callingPage="groundoperation/smscontacts/manageSmscontacts";
			model.addAttribute("emailid",req.getParameter("emailid"));
			model.addAttribute("password",req.getParameter("password"));	
			model.put("profilelist",req.getSession().getAttribute("profilelist")); 
			model.put("usertype",req.getParameter("usertype"));	
			
			
			
			
			//--------- Start Remove Operation -------------------- 
			if(req.getParameter("operation") != null){	
				
				//--Add new user form --
				if(req.getParameter("operation").equals("addnew")) {callingPage="groundoperation/smscontacts/updateSmsUser";}
				
				//--Update User Form --
				if(req.getParameter("operation").equals("updateexisting")){					
					smsConsumerEntity smsUserObj = smsSrvObj.findSmsUser(req.getParameter("userinsubject"));					
					model.put("smsUserEntity",smsUserObj); 
					callingPage="groundoperation/smscontacts/updateSmsUser";
				}
				
	       			
				//-- Add / Update  User Detail to the Database  
				if(req.getParameter("operation").equals("save")) {	
					
					if(req.getParameter("userinsubject").length() > 0){
						smsSrvObj.updateSmsUser(req);
						operationStatus="User Updated";
					}
					else
					{
						smsSrvObj.addSmsUser(req);
						operationStatus="User Created";
					}
					
					callingPage="groundoperation/smscontacts/manageSmscontacts";
				}							
	
				
				//-- Remove User from the list
				if(req.getParameter("operation").equals("remove")) {					
					smsSrvObj.removeSmsUser(req.getParameter("userinsubject"));
					operationStatus="User Removed.";
				}
				model.put("operationStatus",operationStatus);
			}
		
			model.put("listSmsUser",smsSrvObj.listSmsUser());
		    
		return callingPage;
	
	}
	

	
	

	//****************** AIRLINE ACCOUNT DATA MANAGMENT ***********************************************
	@RequestMapping(value = "/manageairlinedata",method = {RequestMethod.POST,RequestMethod.GET})
	public String manageAirline(HttpServletRequest req, ModelMap model) throws Exception {	
		    String operationStatus="";
		    String callingPage="groundoperation/airline/manageAirline";
			model.addAttribute("emailid",req.getParameter("emailid"));
			model.addAttribute("password",req.getParameter("password"));	
			model.put("profilelist",req.getSession().getAttribute("profilelist")); 
			model.put("usertype",req.getParameter("usertype"));	
			
			
			
			
			//--------- Start Remove Operation -------------------- 
			if(req.getParameter("operation") != null){	
				
				//--Add new user form --
				if(req.getParameter("operation").equals("addnew")) {callingPage="groundoperation/airline/updateAirlineData";}
				
				
				//--Update Airline Form --
				if(req.getParameter("operation").equals("updateexisting")){					
					airLineEntity airData = airObj.findAirline(req.getParameter("userinsubject"));
					model.put("airlineEntity",airData); 
					callingPage="groundoperation/airline/updateAirlineData";
				}
				
	       			
				//-- Add / Update  User Detail to the Database  
				if(req.getParameter("operation").equals("save")) {	
					
					if(req.getParameter("userinsubject").length() > 0){
						if(airObj.updateAirline(req)) {operationStatus="Updated";}else {operationStatus="Not Updated !!";}						
					}
					else
					{
						airObj.addAirLine(req);
						operationStatus="Airline Created";
					}
					
					callingPage="groundoperation/airline/manageAirline";
				}							
	
				
				//-- Remove User from the list
				if(req.getParameter("operation").equals("remove")) {					
					airObj.removeAirLine(req.getParameter("userinsubject"));
					operationStatus="Airlin Removed.";
				}
				model.put("operationStatus",operationStatus);
			}
		
			model.put("listAirline",airObj.listAirLineData());
		    
		return callingPage;
	
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

	

	//****************** CREW BRIEFING MANAGMENT ***********************************************
	@RequestMapping(value = "/managecrewbriefing",method = {RequestMethod.POST,RequestMethod.GET})
	public String manageCrewbriefing(HttpServletRequest req, HttpServletResponse resp, ModelMap model) throws Exception {

		    String callingPage="groundoperation/crewbreafing/managecrewbreafing";
			model.addAttribute("emailid",req.getParameter("emailid"));
			model.addAttribute("password",req.getParameter("password"));	
			model.put("profilelist",req.getSession().getAttribute("profilelist")); 
			model.put("usertype",req.getParameter("usertype"));

			
			model.put("captionlist", crewInfo.showCrewCaptionFirstOfficer());
			model.put("tokenbalance", crewInfo.getTokenBalance());


		    //--------- Start Operation --------------------
			if(req.getParameter("operation") != null){


	

			} //  End of  if(req.getParameter("operation")



		return callingPage;
	}
	
	
	
	
	
	
	
	
	


} //---- END OF CONTROLLER CLASS ----------

	

