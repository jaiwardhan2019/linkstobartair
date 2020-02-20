package com.linkportal.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
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
import com.linkportal.security.EncryptDecrypt;


@Controller
public class groundOpsController {

	
	@Autowired
	linkUsers dbusr;
	
	@Autowired
	gopsAllapi refisuser;
	
	@Autowired
	manageStobartContract contract;
	
	@Autowired
	EncryptDecrypt encdec;
	
	@Autowired
	flightReports flt;
	
	@Autowired
	piechart chart;
	
	
	@Autowired
	DocumentService  docserv;

	
	
    //---------- Logger Initializer------------------------------- 
	private Logger logger = Logger.getLogger(HomeController.class);
	
		


	//------- This Part Will be Called from the Login Page index.jsp 
	@RequestMapping(value = "/groundopsHomePage",method = {RequestMethod.POST,RequestMethod.GET}) 
	public String HomePage(HttpServletRequest req,ModelMap model) throws Exception{
	       
		  if(req.getParameter("emailid") == null) {return "index";}
		  model.addAttribute("emailid",req.getParameter("emailid"));
		  model.addAttribute("password",req.getParameter("password"));			
		  //model.put("profilelist", dbusr.getUser_Profile_List_From_DataBase(req.getParameter("emailid"))); //<<-- Populate Profile List with the map object 
		  model.put("profilelist",req.getSession().getAttribute("profilelist")); 
		  model.put("usertype",req.getParameter("usertype"));
		  return "groundoperation/groundopshome";
		  
	}//----------- End of Function 


	//------- This Part Will be Called from the Login Page index.jsp 
	@RequestMapping(value = "/groundopskeycontact",method = {RequestMethod.POST,RequestMethod.GET}) 
	public String GroundopsKeyContact(HttpServletRequest req,ModelMap model) throws Exception{
	       
		  if(req.getParameter("emailid") == null) {return "index";}
		  model.addAttribute("emailid",req.getParameter("emailid"));
		  model.addAttribute("password",req.getParameter("password"));			
		  //model.put("profilelist", dbusr.getUser_Profile_List_From_DataBase(req.getParameter("emailid"))); //<<-- Populate Profile List with the map object 
		  model.put("profilelist",req.getSession().getAttribute("profilelist")); 
		  model.put("usertype",req.getParameter("usertype"));
		  return "groundoperation/keycontacts";
		  
	}//----------- End of Function 


	
	
	
	
	
	

     //*********************** FLIGHT REPORT SECTION ***********************
	//-------THis Will be Called When MayFly  Report link is called from the Home Page ----------------- 
	@RequestMapping(value = "/flightreport",method = {RequestMethod.POST,RequestMethod.GET}) 
	public String GroundOpsflightreport(HttpServletRequest req,ModelMap model) throws Exception{
		
		   //Formatting today date...
		   Date today                     = new Date();               
		   SimpleDateFormat formattedDate = new SimpleDateFormat("yyyy-MM-dd");
		   Calendar                     c = Calendar.getInstance();  
		   String todaydate               = (String)(formattedDate.format(c.getTime()));
		   model.put("datop",todaydate);	        
		   if(req.getParameter("datop") != null) {
			   todaydate = req.getParameter("datop");
			   model.put("datop",req.getParameter("datop"));
		   }
		   
		 	   
		   model.put("airlinelist",flt.Populate_Operational_Airline(req.getParameter("airlinecode"), req.getParameter("emailid")));		
		   model.put("airportlist",flt.Populate_Operational_Airport(req.getParameter("airportcode"), req.getParameter("emailid")));
		   model.put("reportbody",flt.PopulateFlightReport(req.getParameter("airlinecode"), req.getParameter("airportcode"), req.getParameter("sortby"), todaydate,req.getParameter("flightno"),req.getParameter("emailid")));	
		   model.put("reportbody_cancle",flt.Populate_MayFly_Report_body(req.getParameter("airlinecode"),req.getParameter("airportcode"),req.getParameter("sortby"),todaydate,0,req.getParameter("emailid")));		
				   
		   
		  
	      //-------------- FOR GRAPH --------------------------------- 		     
	      String dataPoints =chart.createPieChart_For_Flight_Report(req.getParameter("airlinecode"), req.getParameter("airportcode"),req.getParameter("datop"),req.getParameter("emailid"));
	      model.addAttribute("dataPoints",dataPoints); 
	   	
		   
		   
		    model.addAttribute("airlinecode",req.getParameter("airlinecode").toLowerCase());
			model.put("profilelist",req.getSession().getAttribute("profilelist"));
			model.addAttribute("emailid",req.getParameter("emailid"));
			model.addAttribute("password",req.getParameter("password"));
			model.put("usertype",req.getParameter("usertype"));
			logger.info("User id:"+req.getParameter("emailid")+" Login to flight Report");
			return "groundoperation/reports/flightreports"; 
	}
	
		

	
	
	
	//****************** GROUND OPS DOCUMENT REPORT AND MANAGMENT ***********************************************
	//-------THis Will be Called When GCI GCM GCR called from Ground Ops  
	@RequestMapping(value = "/listdocuments",method = {RequestMethod.POST,RequestMethod.GET})
	public String groundopsdocumentlist(HttpServletRequest req, ModelMap model) throws Exception {	
		   
		   int status=0;

		   if(req.getParameter("cat").equals("gci")) {
			   model.put("foldername","Ground Crew Instructions");		
			   
		   }
		   
		   if(req.getParameter("cat").equals("gcm")) {
			   model.put("foldername","Ground Crew Memo");
		   }
		   
		   if(req.getParameter("cat").equals("gcr")) {
			   model.put("foldername","Ground Crew Reminder");
		   }

		   
		  //******* Pupulate List of File *******************
		   model.put("gopsfilelist",docserv.getAllDocuments(req,"GOPS"));
			 
		
		   
		   
		   
		   model.put("profilelist",req.getSession().getAttribute("profilelist"));
		   model.addAttribute("emailid",req.getParameter("emailid"));
		   model.addAttribute("password",req.getParameter("password"));
		   model.put("usertype",req.getParameter("usertype"));
			
		   
		   
		   
		   //-- This part will be called when Edit / View / Upload Event is called 
		   if(req.getParameter("operation") != null) {			   
			  //for view and edit mode 
			  if(req.getParameter("operation").equals("update")) {return "groundoperation/gcigcmgcr/updatefolderdocuments";}
			  if(req.getParameter("operation").equals("read"))   {return "groundoperation/gcigcmgcr/listalldocumentfromfolder";}
				
		   } // End of Operation Event.
		   
		   
		   
		   logger.info("User id:"+req.getParameter("emailid")+" Login to GCI - GCM - GCR Module");
		   return "groundoperation/gcigcmgcr/listalldocumentfromfolder";
	}		   


	
	
	//-------THis Will be Called When Add File will be Called from the GCI - GCM  - GCR  edit Screen  
	@RequestMapping(value = "/addfiletofolder",method = {RequestMethod.POST,RequestMethod.GET})
	public String addfiletofolde(@RequestParam("gfile") MultipartFile file,HttpServletRequest req, ModelMap model) throws Exception {	
		   
		   int status=0;

		   //*********WILL UPLOAD THE FILE************************
		   if(docserv.addUploadFiletoDatabaseAndFolder(req,file)) {			   
			   model.put("status","Successfully Added");	
		   }
		   else
		   {
			   model.put("status","Error while uploading !!!");
			   
		   }
		   
		   
		   //******* Pupulate List of File *******************
		   model.put("gopsfilelist",docserv.getAllDocuments(req,"GOPS"));
		   
		  
		   
		   
		   
		   if(req.getParameter("cat").equals("gci")) {
			   model.put("foldername","Ground Crew Instructions");			   
		   }
		   
		   if(req.getParameter("cat").equals("gcm")) {
			   model.put("foldername","Ground Crew Memo");
		   }
		   
		   if(req.getParameter("cat").equals("gcr")) {
			   model.put("foldername","Ground Crew Reminder");
		   }
		   
		   
		   model.put("profilelist",req.getSession().getAttribute("profilelist"));
		   model.addAttribute("emailid",req.getParameter("emailid"));
		   model.addAttribute("password",req.getParameter("password"));
		   model.put("usertype",req.getParameter("usertype"));
			
		   
	   
		   
		   logger.info("User id:"+req.getParameter("emailid")+" Login to GCI - GCM - GCR Module");
		   return "groundoperation/gcigcmgcr/updatefolderdocuments";
	}		   

		
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	//****************** GROUND OPS EXTERNAL USER MANAGMENT ***********************************************
	//-------THis Will be Called When Refis User Links is called from Ground Ops  
	@RequestMapping(value = "/managegopssuser",method = {RequestMethod.POST,RequestMethod.GET})
	public String groundopsuserlist(HttpServletRequest req, ModelMap model) throws Exception {	
		   int status=0;
			model.addAttribute("emailid",req.getParameter("emailid"));
			model.addAttribute("password",req.getParameter("password"));			
			//model.put("profilelist", dbusr.getUser_Profile_List_From_DataBase(req.getParameter("emailid")));
			model.put("profilelist",req.getSession().getAttribute("profilelist")); 
			model.put("usertype",req.getParameter("usertype"));	
			
			
			
			
			//--------- Start Remove Operation -------------------- 
			if(req.getParameter("operation") != null){	
				
				//-- View  Ground Ops User --
				if(req.getParameter("operation").equals("view")) {
					
					refisUsers userobject = refisuser.viewGopsUserDetail(req.getParameter("userinsubject").trim());					
					model.put("password",encdec.decrypt(userobject.getPassword()));
					model.put("gopsuserdetail", userobject );					
					model.put("listofairline", refisuser.getAllAirlineList(req.getParameter("userinsubject").trim()));
					model.put("listofstation", refisuser.getAllStationList(req.getParameter("userinsubject").trim()));
					return "groundoperation/users/viewUpdateRefisusers"; 
				}
				
				
				
				
				//-- Update Ground Ops User --
				if(req.getParameter("operation").equals("update")) {
			   	   if(refisuser.updateGopsUserDetail(req) == 1){
					  model.put("status","User Updated...");
				    }
			   	   else
			   	   {
			   		model.put("status","User Not Updated Please check log file.");
			   	   }
				   
			   	   refisUsers userobject = refisuser.viewGopsUserDetail(req.getParameter("userid").trim());					
				   model.put("password",encdec.decrypt(userobject.getPassword()));			   	   
				   
				   model.put("gopsuserdetail", userobject);
 				   model.put("listofairline", refisuser.getAllAirlineList(req.getParameter("userinsubject").trim()));
				   model.put("listofstation", refisuser.getAllStationList(req.getParameter("userinsubject").trim()));
				   return "groundoperation/users/viewUpdateRefisusers"; 
				}
				
				
				
				
				
				//-- Remove Ground Ops User --
				if(req.getParameter("operation").equals("remove")) {				  
				   status=refisuser.removeRefisUser_FromDb(req.getParameter("userinsubject"));
				   model.put("status","User id :(&nbsp;&nbsp;"+req.getParameter("userinsubject")+"&nbsp;&nbsp;) Removed Successfully..");	
				}
				
				
				
				
				//-- Add new User page
				if(req.getParameter("operation").equals("addnew")) {
				  System.out.println("Add new is selected ");
				  model.put("listofairline", refisuser.getAllAirlineList(req.getParameter("userinsubject").trim()));
				  model.put("listofstation", refisuser.getAllStationList(req.getParameter("userinsubject").trim()));
				  return "groundoperation/users/addNewRefisusers"; 
				}
				
				
				
				//-- Add new User Create /  Add new entry to datebase 
				if(req.getParameter("operation").equals("createuser")) {
					
				   int statusaddition = refisuser.addnewGopsUserDetail(req);
					
			   	   if(statusaddition == 1){
						  model.put("status","User Created Successfully ..");
					}
			   	   
				    if(statusaddition == 0){
				    	model.put("status","User Not Updated Please check log file.");
					}
				    
			   	    if(statusaddition == 2){
						 model.put("userid",req.getParameter("userid"));
						 model.put("description",req.getParameter("description"));
						 model.put("password",req.getParameter("userpassword"));
						 model.put("listofairline", refisuser.getAllAirlineList(req.getParameter("userinsubject").trim()));
						 model.put("listofstation", refisuser.getAllStationList(req.getParameter("userinsubject").trim()));						 
						 model.put("status","User Allready Exist please choose different name.");
						 return "groundoperation/users/addNewRefisusers"; 
					}
			   	   
	  		    
				
				}
				
				
				
					
				
			}//---------- End Of Account Removed Operation 
			
			
		    
			
			//---- USER SEARCH PART -------------------
		    if(req.getParameter("user") != null){		    			    	
		    	model.put("refisAccountlist", refisuser.searchRefisUser(req.getParameter("user")));		    	
		    }
		    else
		    {
		    	model.put("refisAccountlist", refisuser.showRefisUser());
		    }
			
		    
		    
		    
		return "groundoperation/users/manageRefisusers";
	}
	
	




} //---- END OF CONTROLLER CLASS ----------


   
	

