package com.linkportal.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FileReader;
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
import java.util.Properties;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.linkportal.email.linkPortalEmail;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.dao.EmptyResultDataAccessException;
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

import com.google.common.base.Strings;
import com.linkportal.contractmanager.manageStobartContract;
import com.linkportal.datamodel.fligthSectorLog;
import com.linkportal.dbripostry.linkUsers;
import com.linkportal.docmanager.DocumentService;
import com.linkportal.docmanager.documentManager;
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
	DocumentService docserv;

	@Autowired
	gopsAllapi gopsobj;

	@Autowired
	ReportMaster excel;


	@Value("${spring.operations.excel.reportsfileurl}")
	String filepath;
	@Value("${stobartair.delay.code}")
	String StobartairDelayCode;
	@Value("${nonstobartair.delay.code}")
	String NonstobartairDelayCode;
	@Value("${groundops.delay.code}")
	String GroundopsDelayCode;

	




	// ---------- Logger Initializer-------------------------------
	private final Logger logger = Logger.getLogger(HomeController.class);

	// ------- This Part Will be Called from the Login Page index.jsp
	@RequestMapping(value = "/groundopsHomePage", method = { RequestMethod.POST, RequestMethod.GET })
	public String HomePage(HttpServletRequest req, ModelMap model) throws Exception{


	    String[] userEmailId   =  req.getParameter("profilelist").toString().split("#");
	    model.addAttribute("profilelist",req.getParameter("profilelist"));	

		
		

		// --- Show today Punctuality Status
		model.put("DailyPunctStatistics", gopsobj.getPuncStaticforGroundOpsHomePage());

		// --- List top 10 document
		model.put("gopsfilelist", docserv.getAllDocuments(req, "home"));
		
		model.put("voiceofguest", docserv.getVoiceOfGuestImage(req.getParameter("cat")));
		
		model.put("emergencyresponseplan", docserv.getEmergencyResponsPlanDocument(req.getParameter("cat")));
		
		model.put("gopsflashingmessage",gopsobj.getGroudopsHomePageFlashingMessage());		
		
		
		model.put("usertype", req.getParameter("usertype"));
		return "groundoperation/groundopshome";

	}// ----------- End of Function
	
	
	
	

	// ------- This Part Will be Called from the Login Page index.jsp
	@RequestMapping(value = "/groundopskeycontact", method = { RequestMethod.POST, RequestMethod.GET })
	public String GroundopsKeyContact(HttpServletRequest req, ModelMap model) throws Exception {

	    String[] userEmailId   =  req.getParameter("profilelist").toString().split("#");
	    model.addAttribute("profilelist",req.getParameter("profilelist"));	

		model.put("usertype", req.getParameter("usertype"));
		return "groundoperation/keycontacts";

	}// ----------- End of Function
	
	
	
	
	
	

	// *********************** FLIGHT REPORT SECTION ***********************
	// -------THis Will be Called When MayFly Report link is called from the Home
	// Page -----------------
	@RequestMapping(value = "/flightreport", method = { RequestMethod.POST, RequestMethod.GET })
	public String GroundOpsflightreport(HttpServletRequest req, ModelMap model) throws Exception {

		String[] userEmailId   =  req.getParameter("profilelist").toString().split("#");
	    model.addAttribute("profilelist",req.getParameter("profilelist"));	

		// Formatting today date...
		Date today = new Date();
		SimpleDateFormat formattedDate = new SimpleDateFormat("yyyy-MM-dd");
		Calendar c = Calendar.getInstance();
		String todaydate = formattedDate.format(c.getTime());
		model.put("datop", todaydate);
		if (req.getParameter("datop") != null) {
			todaydate = req.getParameter("datop");
			model.put("datop", req.getParameter("datop"));
		}

		model.put("airlinelist",
				flt.Populate_Operational_Airline(req.getParameter("airlinecode"), userEmailId[0]));
		model.put("airportlist",
				flt.Populate_Operational_Airport(req.getParameter("airportcode"), userEmailId[0]));

		// -------------- FOR AIRCRAFT REPORT ---------------------------------
		model.put("reportbody",
				flt.PopulateFlightReport(req.getParameter("airlinecode"), req.getParameter("airportcode"),
						req.getParameter("sortby"), todaydate, req.getParameter("flightno"),
						userEmailId[0]));
		model.put("reportbody_cancle",
				flt.Populate_MayFly_Report_body(req.getParameter("airlinecode"), req.getParameter("airportcode"),
						req.getParameter("sortby"), todaydate, 0, userEmailId[0]));

		// -------------- FOR GRAPH ---------------------------------
		String dataPoints = chart.createPieChart_For_Flight_Report(req.getParameter("airlinecode"),
				req.getParameter("airportcode"), req.getParameter("datop"), userEmailId[0]);
		model.addAttribute("dataPoints", dataPoints);

		model.addAttribute("airlinecode", req.getParameter("airlinecode").toLowerCase());
		model.put("usertype", req.getParameter("usertype"));
		logger.info("User id:" + userEmailId[0] + " Login to flightreports Report");
		return "groundoperation/reports/flightreports";
	}

	
	
	
	// -------THis Will be Called When Reliablity Flight Report link is called from
	// the Home Page -----------------
	@RequestMapping(value = "/reliablityflightreport", method = { RequestMethod.POST, RequestMethod.GET })
	public String GroundOpsReliablityflightreport(HttpServletRequest req, ModelMap model) throws Exception {

		String[] userEmailId   =  req.getParameter("profilelist").toString().split("#");
	    model.addAttribute("profilelist",req.getParameter("profilelist"));	

		// Formatting today date...
		Date today = new Date();
		SimpleDateFormat formattedDate = new SimpleDateFormat("yyyy-MM-dd");
		Calendar c = Calendar.getInstance();
		String fromdate = formattedDate.format(c.getTime());
		String todate = fromdate;

		model.put("startdate", fromdate);
		model.put("enddate", todate);
		if (req.getParameter("startdate") != null) {
			fromdate = req.getParameter("startdate");
			todate = req.getParameter("enddate");
			model.put("startdate", req.getParameter("startdate"));
			model.put("enddate", req.getParameter("enddate"));
		}

		model.put("tolerance", req.getParameter("tolerance"));
		model.put("airlinelist",
				flt.Populate_Operational_Airline(req.getParameter("airlinecode"), userEmailId[0]));
		model.put("airportlist",
				flt.Populate_Operational_Airport(req.getParameter("airportcode"), userEmailId[0]));
		
		model.addAttribute("delaycode",req.getParameter("delayCodeGroupCode"));

		
		
		String delayCode = req.getParameter("delayCodeGroupCode");
		if(delayCode.equalsIgnoreCase("ALL"))
		{ 
			delayCode = null;
		}
		else 
		{
			if(delayCode.equalsIgnoreCase("GOPS")) { delayCode = GroundopsDelayCode;}
			if(delayCode.equalsIgnoreCase("SAD"))  { delayCode = StobartairDelayCode;}
			if(delayCode.equalsIgnoreCase("NSAD")) { delayCode = NonstobartairDelayCode;}
		 }
		
		
		
		
		// --------- FOR GENERAL FLIGHTS----------------------------
		model.put("reportbody",
				flt.Populate_Reliablity_Report_body(req.getParameter("airlinecode"), req.getParameter("airportcode"),
						fromdate, todate, req.getParameter("tolerance"), delayCode));

		// --------- FOR CANCLE FLIGHTS---------------------
		model.put("reportbody_C", flt.Populate_Reliablity_Report_body_Cancle_Flights(req.getParameter("airlinecode"),
				req.getParameter("airportcode"), fromdate, todate, req.getParameter("tolerance")));

		model.addAttribute("airlinecode", req.getParameter("airlinecode").toLowerCase());
		model.put("usertype", req.getParameter("usertype"));
		logger.info("User id:" + userEmailId[0] + " Login to reliablity flight Report");
		return "groundoperation/reports/reliablity";

	}

	// --------- THIS PART WILL DO DB UPDATE FROM THE AJAX
	@RequestMapping(value = "/CreateExcelReport", method = { RequestMethod.POST, RequestMethod.GET })
	public void CreateExcelReport(ModelMap model, HttpServletRequest req, HttpServletResponse res)
			throws Exception {
		String[] userEmailId   =  req.getParameter("profilelist").toString().split("#");
	    model.addAttribute("profilelist",req.getParameter("profilelist"));	

		String filename = "";

		// ---Building Delay Code Group	
		String delaycodegroup = req.getParameter("delayCodeGroupCode");
		if(!Strings.isNullOrEmpty(delaycodegroup)) {
			if(delaycodegroup.equalsIgnoreCase("GOPS")) { delaycodegroup = GroundopsDelayCode;}
			if(delaycodegroup.equalsIgnoreCase("SAD"))  { delaycodegroup = StobartairDelayCode;}
			if(delaycodegroup.equalsIgnoreCase("NSAD")) { delaycodegroup = NonstobartairDelayCode;}
		}
		

		if (req.getParameter("delay").equals("no")) {
			excel.Populate_Reliablity_Report_ExcelFormat(req.getParameter("airlinecode"),
					req.getParameter("airportcode"), req.getParameter("startdate"), req.getParameter("enddate"),
					req.getParameter("tolerance"), delaycodegroup, userEmailId[0]);
			filename = "viewExcelReliabilityReportFlights.xls";
		}

		if (req.getParameter("delay").equals("yes")) {
			excel.Populate_Delay_Report_ExcelFormat(req.getParameter("airlinecode"), req.getParameter("airportcode"),
					req.getParameter("startdate"),req.getParameter("enddate"), userEmailId[0]);
			filename = "delayFlightReport.xls";
		}

		
		if (req.getParameter("delay").equals("otp")) {	
			excel.Populate_On_Time_Performance_Report_ExcelFormat(req.getParameter("airlinecode"), req.getParameter("airportcode"),
					req.getParameter("startdate"),req.getParameter("enddate"), userEmailId[0],delaycodegroup);		
		
		}
			
		logger.info(userEmailId[0] + " : Have Download the Reliablity Report on:" + new Date());

	}

	
	
	
	
	// -------THis Will be Called When Delay Flight Report link is called from the
	// Home Page -----------------
	@RequestMapping(value = "/delayflightreport", method = { RequestMethod.POST, RequestMethod.GET })
	public String GroundOpsDelayflightreport(HttpServletRequest req, ModelMap model) throws Exception {

		String[] userEmailId   =  req.getParameter("profilelist").toString().split("#");
	    model.addAttribute("profilelist",req.getParameter("profilelist"));	

		// Formatting today date...
		Date today = new Date();
		SimpleDateFormat formattedDate = new SimpleDateFormat("yyyy-MM-dd");
		Calendar c = Calendar.getInstance();
		String fromdate = formattedDate.format(c.getTime());
		String todate = fromdate;
		model.put("startdate", fromdate);
		model.put("enddate", todate);

		if (req.getParameter("startdate") != null) {
			fromdate = req.getParameter("startdate");
			todate = req.getParameter("enddate");
			model.put("startdate", req.getParameter("startdate"));
			model.put("enddate", req.getParameter("enddate"));
		}

		model.put("airlinelist",
				flt.Populate_Operational_Airline(req.getParameter("airlinecode"), userEmailId[0]));

		model.put("airportlist",
				flt.Populate_Operational_Airport(req.getParameter("airportcode"), userEmailId[0]));

		// --------- FOR Delay FLIGHTS----------------------------
		model.put("reportbody",
				flt.PopulateDelayFlightReport(req.getParameter("airlinecode"), req.getParameter("airportcode"),
						fromdate, todate, req.getParameter("flightno"), userEmailId[0]));

		// --------- FOR CANCLE FLIGHTS---------------------
		model.put("reportbody_C",flt.Populate_Reliablity_Report_body_Cancle_Flights(req.getParameter("airlinecode"),
		req.getParameter("airportcode"),fromdate,todate,"0"));

		model.addAttribute("airlinecode", req.getParameter("airlinecode").toLowerCase());
		model.put("usertype", req.getParameter("usertype"));
		logger.info("User id:" + userEmailId[0] + " Login to DELAY Flight Report");
		return "groundoperation/reports/delayreport";

	}
	
	
	

	// -------THis Will be Called When Delay Flight Report link is called from the
	// Home Page -----------------
	@RequestMapping(value = "/otpflightreport", method = { RequestMethod.POST, RequestMethod.GET })
	public String Otpflightreport(HttpServletRequest req, ModelMap model) throws Exception {
		String[] userEmailId   =  req.getParameter("profilelist").toString().split("#");
	    model.addAttribute("profilelist",req.getParameter("profilelist"));	

		
		// Formatting today date...
		Date today = new Date();
		SimpleDateFormat formattedDate = new SimpleDateFormat("yyyy-MM-dd");
		Calendar c = Calendar.getInstance();
		String fromdate = formattedDate.format(c.getTime());
		String todate = fromdate;
		model.put("startdate", fromdate);
		model.put("enddate", todate);

		if (req.getParameter("startdate") != null) {
			fromdate = req.getParameter("startdate");
			todate = req.getParameter("enddate");
			model.put("startdate", req.getParameter("startdate"));
			model.put("enddate", req.getParameter("enddate"));
		}

		model.put("airlinelist",
				flt.Populate_Operational_Airline(req.getParameter("airlinecode"), userEmailId[0]));
		model.put("airportlist",
				flt.Populate_Operational_Airport(req.getParameter("airportcode"), userEmailId[0]));

		// ---Building Delay Code Group	
		String delaycodegroup = req.getParameter("delayCodeGroupCode");
		if(delaycodegroup.equalsIgnoreCase("GOPS")) { delaycodegroup = GroundopsDelayCode;}
		if(delaycodegroup.equalsIgnoreCase("SAD"))  { delaycodegroup = StobartairDelayCode;}
		if(delaycodegroup.equalsIgnoreCase("NSAD")) { delaycodegroup = NonstobartairDelayCode;}
	
		// --------- FLIGHT NOTES REPORT ----------------------------
		model.put("flightnotes", flt.PopulateOnTimePerformanceReport(req.getParameter("airlinecode"),
				req.getParameter("airportcode"), fromdate, todate, delaycodegroup, userEmailId[0]));
		
		  
		//-------------- FOR GRAPH --------------------------------- 			     
		String dataPoints = chart.createPieChart_For_OTP_Flight_Report(req.getParameter("airlinecode"), req.getParameter("airportcode"), fromdate, todate, delaycodegroup);
		model.addAttribute("dataPoints",dataPoints); 
		
		

		model.addAttribute("airlinecode", req.getParameter("airlinecode").toLowerCase());
		model.addAttribute("delaycode", req.getParameter("delayCodeGroupCode"));
		model.put("usertype", req.getParameter("usertype"));
		logger.info("User id:" + userEmailId[0] + " Login to OTP Flight Report");
		return "groundoperation/reports/otpreport";

	}

	// --------- THIS PART WILL DO DB UPDATE FROM THE AJAX CALL FROM DELAY FLIGHT
	@ResponseBody
	@RequestMapping(method = { RequestMethod.POST, RequestMethod.GET }, value = "/delayaction")
	public int delayAction(ModelMap model, HttpServletRequest req) throws Exception{
		
		if(refisuser.addDelayFeedback(req)){
			
		   //------- This will send email to all  
		   refisuser.notifyGroundHandlersForDelayComment(req);			
		   model.put("status", "Feedback updated && Email sent out to Airport Manager");  
		   return 1;
		   
		} 
		else
		{
			model.put("status", "Not updated plz check log. Or contact IT on it@stobartair.com");
			return 0;
		}

	}

	
	
	/* 
	 * All GROUND OPS DOCUMENT SEARCH
	 * This Will be Called from header search document TOP Right.
	 * 
	 */
	@RequestMapping(value = "/searchdocuments", method = { RequestMethod.POST, RequestMethod.GET })
	public String groundopsdocumentsearch(HttpServletRequest req, ModelMap model) throws Exception {
		
		String[] userEmailId   =  req.getParameter("profilelist").toString().split("#");
	    model.addAttribute("profilelist",req.getParameter("profilelist"));
		model.put("usertype", req.getParameter("usertype"));
		model.put("gopsfilelist", docserv.seachDocuments(req.getParameter("myInput")));
		model.put("docname", req.getParameter("myInput"));
		return "groundoperation/searchdocument";
	}
	
	
	

	// ****************** GROUND OPS DOCUMENT REPORT AND MANAGMENT GCI GCM
	@RequestMapping(value = "/listlinkdocuments", method = { RequestMethod.POST, RequestMethod.GET })
	public String linkdocumentlist(HttpServletRequest req, ModelMap model) throws Exception {

		String[] userEmailId   =  req.getParameter("profilelist").toString().split("#");
	    model.addAttribute("profilelist",req.getParameter("profilelist"));
		model.put("usertype", req.getParameter("usertype"));

		int status = 0;
		String readviewstring   = "linkfolderlist";
		String updateviewstring = "linkfolderupdate";

		String alfrescoFolder = null;
		model.put("foldername", Build_Folder_Label(req.getParameter("cat")));
	
	 
		if (req.getParameter("operation") != null) {

			// --- If the data is comming from alfreso then this value will be passed to
			// View
			if (req.getParameter("alfresco") != null) {
				if (req.getParameter("alfresco").equals("YES")) {
					//----- This will create path of alfresco folder
					alfrescoFolder = Build_Folder_Label("PATH"+req.getParameter("cat").trim());
					model.put("alfresco", "YES");
					model.put("gopsfilelist", docserv.listAlfrescoDocumets(alfrescoFolder, req.getParameter("cat")));
					return "linkalfrescofolderlist";
				}
			}
			// -- END of Alfresco

			
			if (req.getParameter("operation").equals("update")) {
				model.put("gopsfilelist", docserv.getAllDocuments(req, "LINK"));
				return updateviewstring;
			}

			if (req.getParameter("operation").equals("view")) {
				model.put("gopsfilelist", docserv.getAllDocuments(req, "LINK"));
				return readviewstring;
			}

			
			if (req.getParameter("operation").equals("remove")) {
				if (docserv.deleteDocumentById(Integer.parseInt(req.getParameter("docid")))) {
					model.put("status", "Successfully Removed");
					logger.info("User id:" + req.getParameter("emailid") + " Removed Document ID:"
							+ req.getParameter("docid") + " From Folder :"+Build_Folder_Label(req.getParameter("cat")));
				} else {
					model.put("status", "File not Removed please check with IT.");
					logger.error("User id:" + req.getParameter("emailid") + "Couldnt Removed Document ID:"
							+ req.getParameter("docid") + " From Folder :"+Build_Folder_Label(req.getParameter("cat")));
				}
				model.put("gopsfilelist", docserv.getAllDocuments(req, "GOPS"));
				return updateviewstring;

			} // End of Remove

		} // End of Operation

		return readviewstring;

	}// End of Ground Ops Document List Function

	
	
	
	
	
	

	// ****************** GROUND OPS DOCUMENT REPORT AND MANAGMENT GCI GCM
	@RequestMapping(value = "/listdocuments", method = { RequestMethod.POST, RequestMethod.GET })
	public String groundopsdocumentlist(HttpServletRequest req, ModelMap model) throws Exception {

		String[] userEmailId   =  req.getParameter("profilelist").toString().split("#");
	    model.addAttribute("profilelist",req.getParameter("profilelist"));
		model.put("usertype", req.getParameter("usertype"));

		int status = 0;
		String readviewstring   = "groundoperation/folderlist";
		String updateviewstring = "groundoperation/folderupdate";

		String alfrescoFolder = null;
		model.put("foldername", Build_Folder_Label(req.getParameter("cat")));
	
	 
		if (req.getParameter("operation") != null) {

			// --- If the data is comming from alfreso then this value will be passed to
			// View
			if (req.getParameter("alfresco") != null) {
				if (req.getParameter("alfresco").equals("YES")) {
					//----- This will create path of alfresco folder
					alfrescoFolder = Build_Folder_Label("PATH"+req.getParameter("cat").trim());
					model.put("alfresco", "YES");
					model.put("gopsfilelist", docserv.listAlfrescoDocumets(alfrescoFolder, req.getParameter("cat")));
					return "groundoperation/alfrescofolderlist";
				}
			}
			// -- END of Alfresco

			
			if (req.getParameter("operation").equals("update")) {
				model.put("gopsfilelist", docserv.getAllDocuments(req, "GOPS"));
				return updateviewstring;
			}

			if (req.getParameter("operation").equals("view")) {
				model.put("gopsfilelist", docserv.getAllDocuments(req, "GOPS"));
				return readviewstring;
			}

			if (req.getParameter("operation").equals("remove")) {
				if (docserv.deleteDocumentById(Integer.parseInt(req.getParameter("docid")))) {
					model.put("status", "Successfully Removed");
					logger.info("User id:" + req.getParameter("emailid") + " Removed Document ID:"
							+ req.getParameter("docid") + " From Folder :"+Build_Folder_Label(req.getParameter("cat")));
				} else {
					model.put("status", "File not Removed please check with IT.");
					logger.error("User id:" + req.getParameter("emailid") + "Couldnt Removed Document ID:"
							+ req.getParameter("docid") + " From Folder :"+Build_Folder_Label(req.getParameter("cat")));
				}
				model.put("gopsfilelist", docserv.getAllDocuments(req, "GOPS"));
				return updateviewstring;

			} // End of Remove

		} // End of Operation

		return readviewstring;

	}// End of Ground Ops Document List Function

	
	
	
	
	// -------THis Will be Called When Add File will be Called from the GCI - GCM -
	// GCR edit Screen
	@RequestMapping(value = "/addfiletofolder", method = { RequestMethod.POST, RequestMethod.GET })
	public String addfiletofolde(@RequestParam("gfile") MultipartFile[] files, HttpServletRequest req, ModelMap model)
			throws Exception {

		String[] userEmailId   =  req.getParameter("profilelist").toString().split("#");
	    model.addAttribute("profilelist",req.getParameter("profilelist"));
		model.put("usertype", req.getParameter("usertype"));

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

		int status = 0;
		Arrays.asList(files).stream().forEach(file -> {
			try {
				if (docserv.addUploadFiletoDatabaseAndFolder(req, file)) {
					model.put("status", "Successfully Added");
				} else {
					model.put("status", "Error while uploading !!!");
				}
			} catch (IOException | SQLException e) {
				e.printStackTrace();
				logger.error("While Uploading file :" + e.toString());
			}

		});

		// ******* Pupulate List of File *******************
		model.put("gopsfilelist", docserv.getAllDocuments(req, "GOPS"));
		model.put("foldername", Build_Folder_Label(req.getParameter("cat")));
		if (req.getParameter("cat").equals("home")) {			
			return "groundoperation/folderupdate";
		}

		logger.info(
				"User id:" + userEmailId[0] + " File Updated to the Folder :" +Build_Folder_Label(req.getParameter("cat")));
		return "groundoperation/folderupdate";
	}

	
	
	
	// ****************** GROUND OPS EXTERNAL USER MANAGMENT
	// -------THis Will be Called When Refis User Links is called from Ground Ops
	@RequestMapping(value = "/managegopssuser", method = { RequestMethod.POST, RequestMethod.GET })
	public String groundopsuserlist(HttpServletRequest req, ModelMap model) throws Exception {
		int status = 0;
		String[] userEmailId   =  req.getParameter("profilelist").toString().split("#");
	    model.addAttribute("profilelist",req.getParameter("profilelist"));
		model.put("usertype", req.getParameter("usertype"));

		// --------- Start Remove Operation --------------------
		if (req.getParameter("operation") != null) {

			// -- View Ground Ops User --
			if (req.getParameter("operation").equals("view")) {

				refisUsers userobject = refisuser.viewGopsUserDetail(req.getParameter("userinsubject").trim());
				model.put("password", encdec.decrypt(userobject.getPassword()));
				model.put("gopsuserdetail", userobject);
				model.put("listofairline", refisuser.getAllAirlineList(req.getParameter("userinsubject").trim()));
				model.put("listofstation", refisuser.getAllStationList(req.getParameter("userinsubject").trim()));
				return "groundoperation/users/viewUpdateRefisusers";
			}

			// -- Update Ground Ops User --
			if (req.getParameter("operation").equals("update")) {
				if (refisuser.updateGopsUserDetail(req) == 1) {
					model.put("status", "User Updated...");
				} else {
					model.put("status", "User Not Updated Please check log file.");
				}

				refisUsers userobject = refisuser.viewGopsUserDetail(req.getParameter("userid").trim());
				model.put("password", encdec.decrypt(userobject.getPassword()));

				model.put("gopsuserdetail", userobject);
				model.put("listofairline", refisuser.getAllAirlineList(req.getParameter("userinsubject").trim()));
				model.put("listofstation", refisuser.getAllStationList(req.getParameter("userinsubject").trim()));
				return "groundoperation/users/viewUpdateRefisusers";
			}

			// -- Remove Ground Ops User --
			if (req.getParameter("operation").equals("remove")) {
				status = refisuser.removeRefisUser_FromDb(req.getParameter("userinsubject"));
				if (status > 0) {
					model.put("status", "User id :&nbsp;&nbsp;" + req.getParameter("userinsubject")
							+ "&nbsp;&nbsp; Removed Successfully..");
				} else {
					model.put("status", "User id :&nbsp;&nbsp;" + req.getParameter("userinsubject")
							+ "&nbsp;&nbsp; Not Removed Please contact IT..");
				}

			}

			// -- Add new User Form  Page To enter Data 
			if (req.getParameter("operation").equals("addnew")) {
				model.put("listofairline", refisuser.getAllAirlineList(req.getParameter("userinsubject").trim()));
				model.put("listofstation", refisuser.getAllStationList(req.getParameter("userinsubject").trim()));
				return "groundoperation/users/addNewRefisusers";
			}
			

			// -- Add new User Create / Add new entry to database
			if (req.getParameter("operation").equals("createuser")) {

				int statusaddition = refisuser.addnewGopsUserDetail(req);

				if (statusaddition == 1) {
					model.put("status", "User Created Successfully ..");
		            
					/*  These Profile Need to be added to the new GH User   
					 *  •	Mayfly       -> 1
						•	Delay Report -> 7
						•	Forms        -> 17
						•	Documentation -> 16
						•	Training      -> 14
						•	Safety and Compliance -> 13
						•	Manuals        -> 12
						•	GCI/GCM/GCR    - > 11
						•	Weight Statements -> 15
					 * */
					
		            String[] alllinkprof = { "1", "7","17","16","14","13","12","11","15"};
		            List profilelist = Arrays.asList(alllinkprof);
					dbusr.UpdateLinkProfiletoDataBase(req.getParameter("userid").trim(),profilelist);
				}

				if (statusaddition == 0) {
					model.put("status", "User Not Updated Please check log file.");
				}

				if (statusaddition == 2) {
					model.put("userid", req.getParameter("userid"));
					model.put("description", req.getParameter("description"));
					model.put("password", req.getParameter("userpassword"));
					model.put("listofairline", refisuser.getAllAirlineList(req.getParameter("userinsubject").trim()));
					model.put("listofstation", refisuser.getAllStationList(req.getParameter("userinsubject").trim()));
					model.put("status", "User Allready Exist please choose different name.");
					return "groundoperation/users/addNewRefisusers";
				}

			}

		} // ---------- End Of Account Removed Operation

		// ---- USER SEARCH PART -------------------
		if (req.getParameter("user") != null) {
			model.put("refisAccountlist", refisuser.searchRefisUser(req.getParameter("user")));
		} else {
			model.put("refisAccountlist", refisuser.showRefisUser());
		}

		return "groundoperation/users/manageRefisusers";
	}
	
	
	
	/*
	 * This Method will take Document Cateogery as parameter and return the label
	 * after reading from the folderlabel.properties file in the resources folder
	 */
	private String Build_Folder_Label(String catogery) throws IOException {
		if (Strings.isNullOrEmpty(catogery)) {
			return null;
		}
		ClassLoader classLoader = this.getClass().getClassLoader();
		File configFile = new File(classLoader.getResource("folderlabel.properties").getFile());
		FileReader reader = new FileReader(configFile);
		Properties folderLabel = new Properties();
		folderLabel.load(reader);
		return folderLabel.getProperty(catogery.toUpperCase());
	}
	

} // ---- END OF CONTROLLER CLASS ----------
