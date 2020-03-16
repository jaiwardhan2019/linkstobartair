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
import java.util.List;
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
import com.linkportal.datamodel.fligthSectorLog;
import com.linkportal.dbripostry.linkUsers;
import com.linkportal.docmanager.DocumentService;
import com.linkportal.fltreport.flightReports;
import com.linkportal.graphreport.piechart;
import com.linkportal.groundops.gopsAllapi;
import com.linkportal.groundops.refisUsers;
import com.linkportal.reports.excel.ReportMaster;
import com.linkportal.security.EncryptDecrypt;


@Controller
public class groundOpsController1 {

	
	@Autowired
	linkUsers dbusr;
	
	@Autowired
	gopsAllapi refisuser;
	
	
	@Autowired
	EncryptDecrypt encdec;
	
	@Autowired
	flightReports flt;
	
	@Autowired
	piechart chart;
	
	
	@Autowired
	DocumentService  docserv;

	
	@Autowired
	gopsAllapi  gopsobj; 

	@Autowired
	ReportMaster excel;


	@Value("${spring.operations.excel.reportsfileurl}") String filepath;
	
    //---------- Logger Initializer------------------------------- 
	private Logger logger = Logger.getLogger(HomeController.class);
	
	


	//------- This Part Will be Called from the Login Page index.jsp 
	@RequestMapping(value = "/groundopsHomePage",method = {RequestMethod.POST,RequestMethod.GET}) 
	public String HomePage(HttpServletRequest req,ModelMap model) throws Exception{
	       
		  if(req.getParameter("emailid") == null) {return "index";}
		  model.addAttribute("emailid",req.getParameter("emailid"));
		  model.addAttribute("password",req.getParameter("password"));			
		  //model.put("profilelist", dbusr.getUser_Profile_List_From_DataBase(req.getParameter("emailid"))); //<<-- Populate Profile List with the map object 
		  
		//--- Show today Punctuality Status    
		  model.put("DailyPunctStatistics",gopsobj.getPuncStaticforGroundOpsHomePage());
		  
		  //--- List top 10 document 
		  model.put("gopsfilelist",docserv.getAllDocuments(req,"home"));	
		  
		  
		  
		  
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
			logger.info("User id:"+req.getParameter("emailid")+" Login to flightreports Report");
			return "groundoperation/reports/flightreports"; 
	}



	//-------THis Will be Called When Reliablity Flight  Report  link is called from the Home Page ----------------- 
	@RequestMapping(value = "/reliablityflightreport",method = {RequestMethod.POST,RequestMethod.GET}) 
	public String GroundOpsReliablityflightreport(HttpServletRequest req,ModelMap model) throws Exception{
		
		   //Formatting today date...
		   Date today                     = new Date();               
		   SimpleDateFormat formattedDate = new SimpleDateFormat("yyyy-MM-dd");
		   Calendar                     c = Calendar.getInstance();  
		   String fromdate               = (String)(formattedDate.format(c.getTime()));
		   String todate                 = fromdate;
				   
		   model.put("startdate",fromdate);
		   model.put("enddate",todate);	
		   if(req.getParameter("startdate") != null) {	
			   fromdate  = req.getParameter("startdate");
			   todate    = req.getParameter("enddate");
			   model.put("startdate",req.getParameter("startdate"));			   
			   model.put("enddate",req.getParameter("enddate"));
		   }
		   
		   model.put("tolerance",req.getParameter("tolerance"));		 	   
		   model.put("airlinelist",flt.Populate_Operational_Airline(req.getParameter("airlinecode"), req.getParameter("emailid")));		
		   model.put("airportlist",flt.Populate_Operational_Airport(req.getParameter("airportcode"), req.getParameter("emailid")));
		   
		   
		 //--------- FOR GENERAL FLIGHTS---------------------------- 
		   model.put("reportbody",flt.Populate_Reliablity_Report_body(req.getParameter("airlinecode"),
		         req.getParameter("airportcode"),fromdate,todate,
		         req.getParameter("tolerance"),req.getParameter("delayCodeGroupCode")));
	
		   //--------- FOR CANCLE FLIGHTS--------------------- 
		   model.put("reportbody_C",flt.Populate_Reliablity_Report_body_Cancle_Flights(req.getParameter("airlinecode"),
			         req.getParameter("airportcode"),fromdate,todate,req.getParameter("tolerance")));
		   
		   
		   
		    model.addAttribute("airlinecode",req.getParameter("airlinecode").toLowerCase());
			model.put("profilelist",req.getSession().getAttribute("profilelist"));
			model.addAttribute("emailid",req.getParameter("emailid"));
			model.addAttribute("password",req.getParameter("password"));
			model.put("usertype",req.getParameter("usertype"));
			logger.info("User id:"+req.getParameter("emailid")+" Login to reliablity flight Report");
			return "groundoperation/reports/reliablity";
			
			
	}
	
	
	
	
	
	//--------- THIS PART WILL DO DB UPDATE FROM THE AJAX  
	@RequestMapping(value = "/CreateExcelReliabilityReport",method = {RequestMethod.POST,RequestMethod.GET}) 
	public void CreateExcelReliabilityReport(ModelMap model,HttpServletRequest req,HttpServletResponse res) throws Exception{

		   String filename="";
		   
		   if(req.getParameter("delay").equals("no")){
				   excel.Populate_Reliablity_Report_ExcelFormat(req.getParameter("airlinecode"),
						req.getParameter("airportcode"),req.getParameter("startdate"),req.getParameter("enddate"),
						req.getParameter("tolerance"),req.getParameter("delayCodeGroupCode"),req.getParameter("emailid"));	
				   
				   filename="viewExcelReliabilityReportFlights.xls";
		    } 
		        
	 	   
		    if(req.getParameter("delay").equals("yes")) {		        	
		           excel.Populate_Delay_Report_ExcelFormat(req.getParameter("airlinecode"),
							req.getParameter("airportcode"),req.getParameter("startdate"),req.getParameter("emailid"));				     
		           filename="delayFlightReport.xls";
		     }
        
				
				
				
	         /*----------------------- Here Below is the File  Download Code not working with the AJAX cal --------------------
		     res.setContentType("text/html");
		     PrintWriter out = res.getWriter();
		     
		     System.out.println(filepath +req.getParameter("emailid")+"/"+filename.trim());
		     
		     res.setContentType("APPLICATION/OCTET-STREAM");   
		     res.setHeader("Content-Disposition","attachment; filename=\"" + filename.trim() + "\"");
		     FileInputStream fileInputStream = new FileInputStream(filepath +req.getParameter("emailid")+"/"+filename.trim());  
		     //FileInputStream fileInputStream = new FileInputStream("C:/data/operations/jai.wardhan@stobartair.com/delayFlightReport.xls");
		     int i;   
		     while ((i=fileInputStream.read()) != -1) { System.out.println(i);out.write(i); }
		     fileInputStream.close();   
		     out.close();
		     */
	
		     logger.info(req.getParameter("emailid")+" : Have Download the Reliablity Report on:"+ new Date()); 
	      
    
	}

	
	
	
	
	
	
	
	
	
	
	
	
	


	//-------THis Will be Called When Delay  Flight  Report  link is called from the Home Page ----------------- 
	@RequestMapping(value = "/delayflightreport",method = {RequestMethod.POST,RequestMethod.GET}) 
	public String GroundOpsDelayflightreport(HttpServletRequest req,ModelMap model) throws Exception{
		
		   //Formatting today date...
		   Date today                     = new Date();               
		   SimpleDateFormat formattedDate = new SimpleDateFormat("yyyy-MM-dd");
		   Calendar                     c = Calendar.getInstance();  
		   String fromdate                = (String)(formattedDate.format(c.getTime()));
		   String todate                  = fromdate;
		   model.put("startdate",fromdate);
		   model.put("enddate",todate);	
		   
		   if(req.getParameter("startdate") != null) {	
			   fromdate  = req.getParameter("startdate");
			   todate    = req.getParameter("enddate");
			   model.put("startdate",req.getParameter("startdate"));			   
			   model.put("enddate",req.getParameter("enddate"));			   
		   }
		 	   
		   model.put("airlinelist",flt.Populate_Operational_Airline(req.getParameter("airlinecode"), req.getParameter("emailid")));		
		   model.put("airportlist",flt.Populate_Operational_Airport(req.getParameter("airportcode"), req.getParameter("emailid")));
		   
		   
		   //--------- FOR GENERAL FLIGHTS---------------------------- 
		    model.put("reportbody",flt.PopulateDelayFlightReport(req.getParameter("airlinecode"),
		         req.getParameter("airportcode"),fromdate,todate,req.getParameter("flightno") ,req.getParameter("emailid") ));
		   
		
			
		   
		   //--------- FOR CANCLE FLIGHTS--------------------- 
		   model.put("reportbody_C",flt.Populate_Reliablity_Report_body_Cancle_Flights(req.getParameter("airlinecode"),
			         req.getParameter("airportcode"),fromdate,todate,"0"));
		   
		   
		   
		    model.addAttribute("airlinecode",req.getParameter("airlinecode").toLowerCase());
			model.put("profilelist",req.getSession().getAttribute("profilelist"));
			model.addAttribute("emailid",req.getParameter("emailid"));
			model.addAttribute("password",req.getParameter("password"));
			model.put("usertype",req.getParameter("usertype"));
			logger.info("User id:"+req.getParameter("emailid")+" Login to DELAY Flight Report");			
			return "groundoperation/reports/delayreport";
			
	}
	
	
	
	


	//--------- THIS PART WILL DO DB UPDATE FROM THE AJAX  CALL FROM DELAY FLIGHT REPORT 
	@ResponseBody
	@RequestMapping(method = {RequestMethod.POST,RequestMethod.GET}, value="/delayaction")
	public int delayAction(ModelMap model,HttpServletRequest req) {		   
		   if(refisuser.addDelayFeedback(req)) {
			   model.put("status","Feedback updated");
			   // Trigger Email Notification to all User
			   return 1;	
		   }
		   else
		   {
			   model.put("status","Not updated plz check log. Or contact IT on it@stobartair.com");
			   return 0;	
		   }
		   
		    
	 }
	
	
	
	
	
	//****************** GROUND OPS DOCUMENT SEARCH ***********************************************
	//-------THis Will be Called from header search document TOP Right.  
	@RequestMapping(value = "/searchdocuments",method = {RequestMethod.POST,RequestMethod.GET})
	public String groundopsdocumentsearch(HttpServletRequest req, ModelMap model) throws Exception {	
           model.put("profilelist",req.getSession().getAttribute("profilelist"));
		   model.addAttribute("emailid",req.getParameter("emailid"));
		   model.addAttribute("password",req.getParameter("password"));
		   model.put("usertype",req.getParameter("usertype"));		   
		   model.put("gopsfilelist",docserv.seachDocuments(req.getParameter("myInput")));
		   model.put("docname", req.getParameter("myInput"));
		   
		   return "groundoperation/searchdocument";  
	}
	
	
	
	
	
	
	
	
	

	
	
	
	//****************** GROUND OPS DOCUMENT REPORT AND MANAGMENT GCI GCM GCR***********************************************
	//-------THis Will be Called When GCI GCM GCR called from Ground Ops  
	@RequestMapping(value = "/listdocuments",method = {RequestMethod.POST,RequestMethod.GET})
	public String groundopsdocumentlist(HttpServletRequest req, ModelMap model) throws Exception {	
           
		   model.put("profilelist",req.getSession().getAttribute("profilelist"));
		   model.addAttribute("emailid",req.getParameter("emailid"));
		   model.addAttribute("password",req.getParameter("password"));
		   model.put("usertype",req.getParameter("usertype"));

		   int status              = 0;
		   String readviewstring   = "groundoperation/folderlist";
		   String updateviewstring = "groundoperation/folderupdate";

		   if(req.getParameter("cat").equals("home")) {
			   model.put("foldername","All Latest Documents");
		   }
		   
		   if(req.getParameter("cat").equals("gci")) {
			   model.put("foldername","Ground Crew Instructions");		
		   }
		   
		   if(req.getParameter("cat").equals("gcm")) {
			   model.put("foldername","Ground Crew Memo");
		   }
		   
		   if(req.getParameter("cat").equals("gcr")) {
			   model.put("foldername","Ground Crew Reminder");
		   }

	    
		   if(req.getParameter("cat").equals("mand")) {
			   model.put("foldername","De-Icing Manuals"); 
		   }
		   
		   if(req.getParameter("cat").equals("mang")) {
			   model.put("foldername","Ground Ops Manual"); 
		   }
		   
		   if(req.getParameter("cat").equals("mans")) {
			   model.put("foldername","Safety Manual"); 
		   }

		   
		   if(req.getParameter("cat").equals("saf")) {
			   model.put("foldername","Safety Compliance"); 
		   }

		   
		   if(req.getParameter("cat").equals("trd")) {
			   model.put("foldername","Dispatch and Load Control."); 
		   }
		   
		   if(req.getParameter("cat").equals("scm")) {
			   model.put("foldername","Safety Compliance Monitoring."); 
		   }
		   
		   if(req.getParameter("cat").equals("sgo")) {
			   model.put("foldername","Ground Ops Statistics."); 
		   }
	
		   if(req.getParameter("cat").equals("ssb")) {
			   model.put("foldername","Safety Bulletins."); 
		   }
		   if(req.getParameter("cat").equals("ssm")) {
			   model.put("foldername","Safety Manual."); 
		   }
           
		   //-- Documentation Menu --
		   if(req.getParameter("cat").equals("dchm")) {
			   model.put("foldername","Catering - HAACP Manual."); 
		   }
		   
		   if(req.getParameter("cat").equals("dcle")) {
			   model.put("foldername","Cleaning."); 
		   }
		   
		   if(req.getParameter("cat").equals("dcom")) {
			   model.put("foldername","Compliance Monitoring."); 
		   }

		   // Forms Menu
		   if(req.getParameter("cat").equals("formsei")) {
			   model.put("foldername","Aer Lingus Forms."); 
		   }
		   if(req.getParameter("cat").equals("formsbe")) {
			   model.put("foldername","Fly Be."); 
		   }
		   if(req.getParameter("cat").equals("formsre")) {
			   model.put("foldername","Stobart Air."); 
		   }
		   
		   if(req.getParameter("operation") != null){
			       
			       //--- If the data is comming from alfreso then this vaue will be passed to View 
			       //-- Will avoid the Update Button on view 
				   if(req.getParameter("alfresco") != null) {
				       if(req.getParameter("alfresco").equals("YES")) {
				    	   model.put("alfresco","YES");
				    	   //  Write a function whic will pull list of folder content from the 
				    	   //  model.put("gopsfilelist",docserv.getAllDocuments(req,"GOPS"));
				       }
				   }    
				   //-- END of  Alfresco 
				   
				   
				   if(req.getParameter("operation").equals("update")) { 
					  model.put("gopsfilelist",docserv.getAllDocuments(req,"GOPS"));
					  return updateviewstring;
				   }
				   
				   if(req.getParameter("operation").equals("view")) { 
					  model.put("gopsfilelist",docserv.getAllDocuments(req,"GOPS"));
					  return readviewstring;
				    }
				   
				   if(req.getParameter("operation").equals("remove")) { 
					   if(docserv.deleteDocumentById(Integer.parseInt(req.getParameter("docid")))){
							 model.put("status","Successfully Removed");
							 logger.info("User id:"+req.getParameter("emailid")+" Removed Document ID:"+req.getParameter("docid"));
						}
						else
						{
							 model.put("status","File not Removed please check with IT.");
							 logger.error("User id:"+req.getParameter("emailid")+"Couldnt Removed Document ID:"+req.getParameter("docid"));
						}
					  model.put("gopsfilelist",docserv.getAllDocuments(req,"GOPS"));
					  return updateviewstring;
				   
				   }// End of Remove
				   
			}//End of Operation 
		   
		   return readviewstring;
		   
	}// End of Ground Ops Document List Function 		   


	
	
	
	
	
	//-------THis Will be Called When Add File will be Called from the GCI - GCM  - GCR  edit Screen  
	@RequestMapping(value = "/addfiletofolder",method = {RequestMethod.POST,RequestMethod.GET})
	public String addfiletofolde(@RequestParam("gfile") MultipartFile[] files,HttpServletRequest req, ModelMap model) throws Exception {	
		  
		   model.put("profilelist",req.getSession().getAttribute("profilelist"));
		   model.addAttribute("emailid",req.getParameter("emailid"));
		   model.addAttribute("password",req.getParameter("password"));
		   model.put("usertype",req.getParameter("usertype"));
		
		   /*/
		   int status=0;

		   //*********WILL UPLOAD SINGLE FILE************************
		   if(docserv.addUploadFiletoDatabaseAndFolder(req,file)) {			   
			   model.put("status","Successfully Added");	
		   }
		   else
		   {
			   model.put("status","Error while uploading !!!");
			   
		   }
		   
		  */   
		   
		
		

		 //*********WILL UPLOAD MULTIPLE FILE************************
		
		 int status=0;
		 Arrays.asList(files).stream().forEach(file ->{
		 try{
			if(docserv.addUploadFiletoDatabaseAndFolder(req,file)) { model.put("status","Successfully Added"); }else{ model.put("status","Error while uploading !!!");}
	       } catch (IOException | SQLException e) {e.printStackTrace();logger.error("While Uploading file :"+e.toString());}
		
		 });
		 
		 
		   
		   //******* Pupulate List of File *******************
		   model.put("gopsfilelist",docserv.getAllDocuments(req,"GOPS"));
		   
		   
		   if(req.getParameter("cat").equals("home")) {
			   model.put("foldername","All Latest Documents");
			   return "groundoperation/folderupdate";
		   }			   
		   
		   if(req.getParameter("cat").equals("gci")) {
			   model.put("foldername","Ground Crew Instructions");			   
		   }
		   
		   if(req.getParameter("cat").equals("gcm")) {
			   model.put("foldername","Ground Crew Memo");
		   }
		   
		   if(req.getParameter("cat").equals("gcr")) {
			   model.put("foldername","Ground Crew Reminder");
		   }
		   
		    
		   if(req.getParameter("cat").equals("mand")) {
			   model.put("foldername","De-Icing Manuals"); 
		   }
		   
		   if(req.getParameter("cat").equals("mang")) {
			   model.put("foldername","Ground Ops Manual"); 
		   }
		   
		   if(req.getParameter("cat").equals("mans")) {
			   model.put("foldername","Safety Manual"); 
		   }

		   if(req.getParameter("cat").equals("saf")) {
			   model.put("foldername","Safety Compliance"); 
		   }

		   if(req.getParameter("cat").equals("trd")) {
			   model.put("foldername","Dispatch and Load Control."); 
		   }
      
		   if(req.getParameter("cat").equals("scm")) {
			   model.put("foldername","Safety Compliance Monitoring."); 
		   }
		   if(req.getParameter("cat").equals("sgo")) {
			   model.put("foldername","Ground Ops Statistics."); 
		   }
	
		   if(req.getParameter("cat").equals("ssb")) {
			   model.put("foldername","Safety Bulletins."); 
		   }
		   
		   if(req.getParameter("cat").equals("ssm")) {
			   model.put("foldername","Safety Manual."); 
		   }
		   
		   //-- Documentation Menu --
		   if(req.getParameter("cat").equals("dchm")) {
			   model.put("foldername","Catering - HAACP Manual."); 
		   }
		   
		   if(req.getParameter("cat").equals("dcle")) {
			   model.put("foldername","Cleaning."); 
		   }

		   if(req.getParameter("cat").equals("dcom")) {
			   model.put("foldername","Compliance Monitoring."); 
		   }
		   
		   
		   // Forms Menu
		   if(req.getParameter("cat").equals("formsei")) {
			   model.put("foldername","Aer Lingus Forms."); 
		   }
		   if(req.getParameter("cat").equals("formsbe")) {
			   model.put("foldername","Fly Be."); 
		   }
		   if(req.getParameter("cat").equals("formsre")) {
			   model.put("foldername","Stobart Air."); 
		   }
		   
           
		   
		   logger.info("User id:"+req.getParameter("emailid")+" File Updated to the Folder :"+req.getParameter("cat"));
		   return "groundoperation/folderupdate";
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
				   status = refisuser.removeRefisUser_FromDb(req.getParameter("userinsubject"));
				   if(status > 0) {
					   model.put("status","User id :(&nbsp;&nbsp;"+req.getParameter("userinsubject")+"&nbsp;&nbsp;) Removed Successfully..");	   
				   }				  
				   else
				   {
					   model.put("status","User id :(&nbsp;&nbsp;"+req.getParameter("userinsubject")+"&nbsp;&nbsp;) Not Removed Please contact IT..");	
				   }
				   
				}
				
				
				
				
				//-- Add new User page
				if(req.getParameter("operation").equals("addnew")) {				  
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


   
	

