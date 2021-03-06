package com.linkportal.controller;


import java.io.FileInputStream;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import com.linkportal.dbripostry.businessAreaContent;
import com.linkportal.dbripostry.crewConnexUser;
import com.linkportal.dbripostry.linkUsers;
import com.linkportal.fltreport.flightReports;
import com.linkportal.graphreport.piechart;
import com.linkportal.groundops.gopsAllapi;
import com.linkportal.reports.excel.ReportMaster;
import com.linkportal.security.UserSecurityLdap;
import com.linkportal.staffTravel.manageStaffTravelUser;
import com.linkportal.docmanager.DocumentService;

/**
 * @author Jai.Wardhan
 *
 */

@Controller
public class HomeController {
	
      
	@Autowired
    Environment environment;
	
	@Autowired
	crewConnexUser crewuser;
	
	@Autowired
	linkUsers dbusr;
	
	@Autowired
	manageStaffTravelUser staff;
	
	@Autowired
	businessAreaContent bac;

	@Autowired
	flightReports flt;
	
	@Autowired
	piechart chart;
	
	
	
	@Autowired
	ReportMaster excel;
	
	@Autowired
	DocumentService  docobj;

	@Autowired
	gopsAllapi  gopsobj; 
	
	
	
	//-------------- reading application.properties file -----------------
	@Value("${spring.ldap.urls}") String ldapurl;	
	@Value("${spring.operations.excel.reportsfileurl}") String filepath;
	@Value("${application.homepage.link}") String homepagelink;

	@Value("${stobartair.delay.code}")
	String StobartairDelayCode;
	@Value("${nonstobartair.delay.code}")
	String NonstobartairDelayCode;
	@Value("${groundops.delay.code}")
	String GroundopsDelayCode;

	

	
	

	
	
		
	public String useremailid;
	
	
    //---------- Logger Initializer------------------------------- 
	private final Logger logger = Logger.getLogger(HomeController.class);
	
	
	
	
	
	
	

	
	@GetMapping("/index")
	String Login_Page() {
		return "index";
	}

	@GetMapping("/")
	String home_page(){
		return "index";
	}

	

	
	
	
	@GetMapping("/logout")
	String Log_out(HttpServletRequest request){
		
		HttpSession session=request.getSession();
		session.setAttribute("userEmail","");
		session.setAttribute("profilelist","");		
		return "index";
		
	}
		
	
  
	//------- This Part Will be Called from the Login Page index.jsp 
	@RequestMapping(value = "/verifyuser", method = RequestMethod.POST)
	public String Verify_Save_User(HttpServletRequest req,ModelMap model,UserSecurityLdap ldp) throws Exception{
		   
		   boolean isStobartUser = req.getParameter("emailid").indexOf("@stobartair.com") != -1;
		   model.addAttribute("gopsflashingmessage",gopsobj.getGroudopsHomePageFlashingMessage());		
			  
		   
		   // -- If Ground Handler,External User
		   if(!isStobartUser) {			
	
			  if(dbusr.Validate_External_User(req.getParameter("emailid"),req.getParameter("password"))) {
		
				  dbusr.updateUser_detail_LastLoginDateTime(req.getParameter("emailid"));
				  //req.getSession().setAttribute("profilelist", dbusr.getUser_Profile_List_From_DataBase(req.getParameter("emailid")));
				  model.addAttribute("profilelist", dbusr.getUser_Profile_List_From_DataBase(req.getParameter("emailid"),req.getParameter("password")));
				  model.put("usertype","E");	
				  model.put("voiceofguest", docobj.getVoiceOfGuestImage("-"));
				  model.put("DailyPunctStatistics",gopsobj.getPuncStaticforGroundOpsHomePage());
				  model.put("gopsfilelist",docobj.getAllDocuments(req,"home"));		
				  
				  return "groundoperation/groundopshome";
			  }
			  else 
			  {
				  model.put("errormessage","Please try again Still if you are unable to logon then Please Contact Your Line Manager or IT <br><br>&nbsp;&nbsp;&nbsp; <b> servicedesk@stobartair.com </b>");
				  return "security/gerror";
				  
			  }
			  			   
		   }//--- End of If Ground Handler,External User
		   

		   
		   
		// -- If Stobart User  Execute this area 
		   if(ldp.Validate_User_With_Ldap(req.getParameter("emailid"),req.getParameter("password"),ldapurl)){
			  //This Function Will Update DB for new user and their count
			  dbusr.updateUser_detail_LastLoginDateTime(req.getParameter("emailid")); 
			  

				
			   //-- Check if profile exist for the Gops ,  if not then create one for the default profile. 
			   String[] alllinkprof = { "1", "15","17","16","14","13","12","11","15"};  
			   List profilelist = Arrays.asList(alllinkprof);
			   dbusr.UpdateLinkProfiletoDataBase(req.getParameter("emailid"),profilelist);
				
	 		  // Populate Profile List with the map object and place on the session object
			  //req.getSession().setAttribute("profilelist", dbusr.getUser_Profile_List_From_DataBase(req.getParameter("emailid")));
			   model.addAttribute("profilelist", dbusr.getUser_Profile_List_From_DataBase(req.getParameter("emailid"),req.getParameter("password")));
			  
			  logger.info("User id:"+req.getParameter("emailid")+" Verified With AD");			  
		      return "linkhome";
		   }
		   else
		   {
			 model.put("userstatus",req.getParameter("emailid"));
			 return "security/error";
		   }

		   
		   
		   
		   
	}//----------- End of Function 

	
	
	
	
	
	
	
	

	//------- This Part Will be Called from the Login Page index.jsp 
	@RequestMapping(value = "/HomePage",method = {RequestMethod.POST,RequestMethod.GET}) 
	public String HomePage(HttpServletRequest req,ModelMap model,UserSecurityLdap ldp) throws Exception{
		   model.addAttribute("emailid",req.getParameter("emailid"));
		   model.addAttribute("password",req.getParameter("password"));			
		   //model.put("profilelist", dbusr.getUser_Profile_List_From_DataBase(req.getParameter("emailid"))); //<<-- Populate Profile List with the map object 
		   //model.put("profilelist",req.getSession().getAttribute("profilelist"));
		   model.addAttribute("profilelist",req.getParameter("profilelist"));
		   String dataPoints = null;	
		   return "linkhome";
	}//----------- End of Function 




	
	//------------  This is Business Area Update ------------
	@RequestMapping(value = "/businesarea" , method = {RequestMethod.POST,RequestMethod.GET})
	public String Login_businessupdate(HttpServletRequest req, ModelMap model){		 
		   model.addAttribute("cat",req.getParameter("cat"));
		   if(!req.getParameter("cat").equals("00")){
		     model.addAttribute("content",bac.Show_Content(Integer.parseInt(req.getParameter("cat"))));
		   }
		   
		   model.addAttribute("password",req.getParameter("password"));
		   model.addAttribute("emailid",req.getParameter("emailid"));
		   //model.put("profilelist", dbusr.getUser_Profile_List_From_DataBase(req.getParameter("emailid"))); 
		   model.addAttribute("profilelist",req.getParameter("profilelist"));
		   return "businessarea/businessareahome";
	}
	
	
	
	
	//-------THis is Business Updates Controller ----------------- 
	@RequestMapping(value = "/businessupdates" , method = {RequestMethod.POST,RequestMethod.GET})
	public String Login_connectairupdate(HttpServletRequest req, ModelMap model) {
		model.addAttribute("emailid",req.getParameter("emailid"));
		model.addAttribute("password",req.getParameter("password"));
  	    //model.put("profilelist", dbusr.getUser_Profile_List_From_DataBase(req.getParameter("emailid"))); 
	    model.put("newslist", docobj.getAllDocuments(req, "NEWS"));
	    model.addAttribute("profilelist",req.getParameter("profilelist"));
		return "businessupdatehome/businessupdates";
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	//------------ This Part will be used for the Crew Connex SSO----------------	
	@RequestMapping(value="/logincrewconnex",method = {RequestMethod.POST,RequestMethod.GET}) 
	public String login_crewconnex(ModelMap model,HttpServletRequest req) {

	      String[] userEmailId   =  req.getParameter("profilelist").toString().split("#");
	      model.addAttribute("profilelist",req.getParameter("profilelist"));

		   model.addAttribute("emailid",req.getParameter("emailid"));
		   model.addAttribute("password",req.getParameter("password"));
		 
		   if(crewuser.getCrewUserInitialPassword(req.getParameter("emailid")).length() > 2) {
		
			   model.addAttribute("userinitial",crewuser.getCrewUserInitial());			   
			   model.addAttribute("userpassword",crewuser.getCrewUserWebpasswor());
			   logger.info("User id:"+req.getParameter("emailid")+" Login Crew Connex.");
			   return "security/logincrewconnex";
		   }
		   else
		   {
				 logger.info("User id:"+userEmailId[0]+" Unable to Login Crew Connex.");
				 return "security/crewconnexerror";  
		   }
		   
	}//------- End Of Login CrewConnex Method 
  
	
	
	
	
	//------------ This Part will be used for the Loging In Qpulse SSO from Ground Ops Application----------------	
		
	@Value("${qpulse.service.user.name}") 	    String qpulseUserName;
	@Value("${qpulse.service.user.emailid}") 	String qpulseUserEmailId;
	@Value("${qpulse.service.user.password}") 	String qpulseUserPassword;
	
	
	@RequestMapping(value = "/loginqpulse", method = RequestMethod.POST)
	public String login_Qpulse(HttpServletRequest req, ModelMap model) {
		
   		  String[] userEmailId   =  req.getParameter("profilelist").toString().split("#");	      
		   boolean isStobartUser = userEmailId[0].indexOf("@stobartair.com") != -1;
		   
		   if(isStobartUser) {			   
			   model.addAttribute("username",req.getParameter("username"));
			   model.addAttribute("password",req.getParameter("password"));		   
			   model.addAttribute("emailid",userEmailId);	
			   logger.info("Stobart User : "+req.getParameter("username")+" Login to Q Pulse ");
		    }
		    else
		    {
			   model.addAttribute("username",qpulseUserName);
			   model.addAttribute("password",qpulseUserPassword);		   
			   model.addAttribute("emailid",qpulseUserEmailId);
			   logger.info("Ground Handler : "+req.getParameter("emailid")+" Login to Q Pulse ");
		    	
		    }
			   
		   
		   return "security/loginqpulse";
	}//------- End Of Login CrewConnex Method 
	
	
	
	
	
	
	
    
	//------------ This Part will be used for the Loging In Staff Travel ----------------	
	@RequestMapping(value = "/stafftravelloginprocess", method = RequestMethod.POST)
	public String login_staff_travel(HttpServletRequest req, ModelMap model) {
		   model.addAttribute("username",req.getParameter("j_username"));
		   model.addAttribute("password",req.getParameter("j_password"));
		   model.addAttribute("emailid",req.getParameter("emailid"));
		   model.addAttribute("profilelist",req.getParameter("profilelist"));
		   return "security/stafftravelloginprocess";
	}//------- End Of Login CrewConnex Method 
	
	
	

	//------------ This Part will be used for the Loging In Staff Travel----------------	
	@RequestMapping(value = "/stafftravellogin", method = RequestMethod.POST)
	public String login_staff_travel_login(HttpServletRequest req, ModelMap model) {
		   model.addAttribute("username",req.getParameter("j_username"));
		   model.addAttribute("password",req.getParameter("j_password"));
		   model.addAttribute("emailid",req.getParameter("emailid"));
		   staff.updateUserGdprConsent(req.getParameter("emailid"));
		   model.addAttribute("profilelist",req.getParameter("profilelist"));		   
		   logger.info("User id:"+req.getParameter("j_username")+" Login to Staff Travel");
		   return "security/stafftravellogin";
	}//------- End Of Login CrewConnex Method 
	
	
	
	
	
	
	//------------ This Part will be used for the Loging In Al Fresco Document Management System----------------	

	@RequestMapping(value = "/logonalfresco", method = RequestMethod.POST)
	public String login_alfresco(HttpServletRequest req, ModelMap model) {
		   model.addAttribute("username",req.getParameter("loginid_a"));
		   model.addAttribute("password",req.getParameter("pass_a"));
		   logger.info("User id:"+req.getParameter("loginid_a")+" Login to Alfresco");
		   return "security/logonalfresco";
	}//------- End Of Login CrewConnex Method 
	
	

	
	
	
	
	
	//-------THis is Connect Air Controller ----------------- 
	@RequestMapping(value = "/employeediscount" ,method = {RequestMethod.POST,RequestMethod.GET})
	public String show_employee_discount_page(HttpServletRequest req, ModelMap model) {	 
		   model.addAttribute("emailid",req.getParameter("emailid"));
		   model.addAttribute("password",req.getParameter("password"));
		   model.addAttribute("profilelist",req.getParameter("profilelist"));
		   return "empdiscount/employee_discount";
	}
	
	
	
	
	//-------THis is livewell Page Controller ----------------- 
	@RequestMapping(value = "/livewell" ,method = {RequestMethod.POST,RequestMethod.GET})
	public String show_livewell_page(HttpServletRequest req, ModelMap model) {	
		   model.addAttribute("password",req.getParameter("password"));  
		   model.addAttribute("emailid",req.getParameter("emailid"));
		   model.addAttribute("profilelist",req.getParameter("profilelist"));
		   return "livewell/livewell";
	}
	
	
	
	

	
	//-------THis is livewell Page Controller ----------------- 
	@RequestMapping(value = "/loginhrmanagment" ,method = {RequestMethod.POST,RequestMethod.GET})
	public String login_Hr_managmanet_System(HttpServletRequest req, ModelMap model) {	
		   model.put("USERID",req.getParameter("USERID"));
		   model.put("PWD",req.getParameter("PWD"));
		   model.addAttribute("emailid",req.getParameter("emailid"));
		   model.addAttribute("profilelist",req.getParameter("profilelist"));
		   return "security/loginhrmanagment";
	}
	
	
	
	
	
	
	
	
	
	
	

	//-------THis Will be Called When MayFly  Report link is called from the Home Page ----------------- 
	@RequestMapping(value = "/flight_mayFly_report",method = {RequestMethod.POST,RequestMethod.GET}) 
	public String flight_mayFly_report(HttpServletRequest req,ModelMap model) throws Exception{	
		
		String[] userEmailId   =  req.getParameter("profilelist").toString().split("#");
		model.addAttribute("profilelist",req.getParameter("profilelist"));	
		
		
		model.put("airlinelist",flt.Populate_Operational_Airline(req.getParameter("airlineCode"),userEmailId[0]));		
		model.put("airportlist",flt.Populate_Operational_Airport(req.getParameter("airportcode"),userEmailId[0]));	
	
		model.put("reportbody",flt.Populate_MayFly_Report_body(req.getParameter("airlineCode"),req.getParameter("airportcode"),req.getParameter("sortby"),req.getParameter("datop"),userEmailId[0]));	
		model.put("reportbody_cancle",flt.Populate_MayFly_Report_body(req.getParameter("airlineCode"),req.getParameter("airportcode"),req.getParameter("sortby"),req.getParameter("datop"),0,userEmailId[0]));		
		
		  
	   //-------------- FOR GRAPH --------------------------------- 
		     
	    String dataPoints =chart.createPieChart_For_Flight_Report(req.getParameter("airlineCode"), req.getParameter("airportcode"),req.getParameter("datop"),userEmailId[0]);
	    model.addAttribute("dataPoints",dataPoints); 
	   
	
		
		
		model.addAttribute("airlinecode",req.getParameter("airlineCode").toLowerCase());		
		
			
		
	    Date today = new Date();               
	    SimpleDateFormat formattedDate = new SimpleDateFormat("yyyy-MM-dd");
	    Calendar c = Calendar.getInstance();  
	    String todaydate = formattedDate.format(c.getTime());
	    model.put("datop",todaydate);
        
	    if(req.getParameter("datop") != null) {
	    	model.put("datop",req.getParameter("datop"));
	    }
		
		
		
		logger.info("User id:"+userEmailId[0]+" Login to MayFly Report");
		return "flightreports/mayflyreport";
	}
	
	

	
	//-------THis Will be Called When Relaiablity Report FORM link will be Called----------------- 
	@RequestMapping(value = "/reliabilityReportForm",method = {RequestMethod.POST,RequestMethod.GET}) 
	public String flight_Reliability_Report_Form(HttpServletRequest req,ModelMap model) throws Exception{
		
		String[] userEmailId   =  req.getParameter("profilelist").toString().split("#");
		model.addAttribute("profilelist",req.getParameter("profilelist"));	
		
		model.put("airlinelist",flt.Populate_Operational_Airline("ALL",userEmailId[0]));		
		model.put("airportlist",flt.Populate_Operational_Airport("ALL",userEmailId[0]));
		
		Date today = new Date();               
		SimpleDateFormat formattedDate = new SimpleDateFormat("yyyy-MM-dd");
		Calendar c = Calendar.getInstance();  
		String todaydate = formattedDate.format(c.getTime());
		model.put("todaydate",todaydate);
		
		
		
		logger.info("User id:"+userEmailId[0]+" Run Reliablity Report");
		return "flightreports/reliabilityReportForm";
	}
	
	

	// -------THis Will be Called When Relaiablity Report BODY link will be Called

	@RequestMapping(value = "/reliabilityReport", method = { RequestMethod.POST, RequestMethod.GET })
	public String flight_Reliability_Report(HttpServletRequest req, ModelMap model) throws Exception {

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
		return "flightreports/reliabilityReportHome";
	}// --------------- End Of Function -------------

	
	
	
	//-------THis Will be FOR RELIABLITY ACTION  ----------------- 
	@RequestMapping(value = "/reliabilityAction",method = {RequestMethod.POST,RequestMethod.GET}) 
	public String flight_Reliability_Action(HttpServletRequest req,ModelMap model) throws Exception{	
		
		  String[] userEmailId   =  req.getParameter("profilelist").toString().split("#");
		  model.addAttribute("profilelist",req.getParameter("profilelist"));	
		
		  model.put("airlinelist",flt.Populate_Operational_Airline("ALL",userEmailId[0]));		
		  model.put("airportlist",flt.Populate_Operational_Airport("ALL",userEmailId[0]));
		  Date today = new Date();               
		  SimpleDateFormat formattedDate = new SimpleDateFormat("yyyy-MM-dd");
		  Calendar c = Calendar.getInstance();  
		  String todaydate = formattedDate.format(c.getTime());
		  
 	      model.put("startDate",todaydate);
		  model.put("endDate",todaydate);	
	
		  logger.info("User id:"+userEmailId[0]+" Run Reliability Action");
		  return "flightreports/reliabilityAction";
	}//--------------- End Of Function -------------
	
	

	//-------RELIABLITY ACTION REPORT BODY----------------- 
	@RequestMapping(value = "/reliabilityActionReport",method = {RequestMethod.POST,RequestMethod.GET}) 
	public String ReliabilityActionReport(HttpServletRequest req,ModelMap model) throws Exception{		
		
		   String[] userEmailId   =  req.getParameter("profilelist").toString().split("#");
		   model.addAttribute("profilelist",req.getParameter("profilelist"));	
		
		   model.put("airlinelist",flt.Populate_Operational_Airline(req.getParameter("airlineCode"),userEmailId[0]));		
		   model.put("airportlist",flt.Populate_Operational_Airport(req.getParameter("airportCode"),userEmailId[0]));
		
		   model.addAttribute("airlinecode",req.getParameter("airlineCode").toLowerCase());
		   model.addAttribute("startDate",req.getParameter("startDate"));
		   model.addAttribute("endDate",req.getParameter("endDate"));		   
		   model.addAttribute("tolerance",req.getParameter("tolerance"));
		   model.addAttribute("delayCodeGroupCode",req.getParameter("delayCodeGroupCode"));		   
		   
	   
		   
		 //--------- FOR GENERAL FLIGHTS---------------------------- 
		   model.put("reportbody",flt.Populate_Reliablity_Report_body(req.getParameter("airlineCode"),
		         req.getParameter("airportCode"),req.getParameter("startDate"),req.getParameter("endDate"),
		         req.getParameter("tolerance"),req.getParameter("delayCodeGroupCode")));
  
			   
		   logger.info("User id:"+userEmailId[0]+" Run Reliability Report");
		   return "flightreports/reliabilityActionReport";
		   
		   
	}//--------------- End Of Function -------------
			
	
	
	
	
	
	
	
	
	
	
	
	


	//--------- THIS PART WILL DO DB UPDATE FROM THE AJAX  JAI
	@ResponseBody
	@RequestMapping(method = {RequestMethod.POST,RequestMethod.GET}, value="/reliabilityAction_Update")
	public int getGroupChatSize(HttpServletRequest req) {
		   
		   System.out.println(req.getParameter("readvalue"));
		   System.out.println("Write a DB Update Function here");	   
		   
		   
		return 1;	    
	}
	
	
	
	
	
	
	
	
	
	

	
	
	//-------THis Will be Called When Daily Summary Report  FORM  will be Called----------------- 
	@RequestMapping(value = "/flight_daily_summary_report_form",method = {RequestMethod.POST,RequestMethod.GET}) 
	public String flight_daily_summary_form(HttpServletRequest req, ModelMap model) throws Exception {	

		   String[] userEmailId   =  req.getParameter("profilelist").toString().split("#");
		   model.addAttribute("profilelist",req.getParameter("profilelist"));	
		   model.addAttribute("airlinelist",flt.Populate_Operational_Airline(req.getParameter("airlineCode"),userEmailId[0]));		  
		   Date today = new Date();               
		   SimpleDateFormat formattedDate = new SimpleDateFormat("yyyy-MM-dd");
		   Calendar c = Calendar.getInstance();  
		   String todaydate = formattedDate.format(c.getTime());
		   model.put("todaydate",todaydate);
		   logger.info("User id:"+userEmailId[0]+" Run Daily Summary Report");
		   return "flightreports/dailysummaryform";
		   
	}
	


	
	
	
	//-------THis Will be Called When Daily Summary REPORT link Is Called ---------------- 
	@RequestMapping(value = "/flight_daily_summary_report",method = {RequestMethod.POST,RequestMethod.GET}) 
	public String flight_daily_summary_report(HttpServletRequest req, ModelMap model) throws Exception {	
		   
		   
		   String Airline=req.getParameter("airlineCode");
		   String Operation=req.getParameter("airlineOperationCode");
		   String dateofoperation=req.getParameter("flightDate");	
		   model.addAttribute("profilelist",req.getParameter("profilelist"));
		   // JAI- Under Construction --------
		   //pdfdoc.createDailySummaryReport_PDF("Aer Lingus", "ALL", "2019-09-01",req.getParameter("emailid"));
		   //pdfdoc.createDailySummaryReport_DOC("Aer Lingus", "ALL", "2019-09-01",req.getParameter("emailid"));
		   
		   
		   //********* THIS PART WILL POPULATE LIST OF LFIGHTS FOR FLYBE  
		   if(Airline.equals("BE")){
			   model.put("flybeflightlist",flt.Populate_Flybe_FligtList(Airline, Operation, dateofoperation));
		
			   
		   }
		   
		   
		   
		   //*********************** BUILDING REPORT BODY **************
		   model.put("cancleflights",flt.getSummaryofCancelledFlights(Airline, Operation, dateofoperation));
		   model.put("rootdelaylist",flt.getNarrativeSummaryofRootDelays(Airline, Operation, dateofoperation));
		   model.addAttribute("delaycodegroupstat",flt.NoOfDepartureDelaysByIATADelayCodeCategory(Airline, Operation, dateofoperation));
		   model.put("punctualityTarget",flt.PunctualityTargetPerCent(Airline, Operation, dateofoperation));	
		   model.put("punctualitystatus",flt.PunctualityStatistics(Airline, Operation, dateofoperation));		   
		   model.put("fltCompletionkpipax",flt.CompletionKPI_Pax_KPI(Airline, Operation, dateofoperation));
		   
		   
			  
		 //*********************** END OF REPORT BODY  **************
		   
		   
		   
		   
		   
		   model.addAttribute("emailid",req.getParameter("emailid"));
		   model.addAttribute("password",req.getParameter("password"));
		   model.addAttribute("airlinecode",req.getParameter("airlineCode").toLowerCase());
		   model.addAttribute("Operation",req.getParameter("airlineOperationCode"));
		   model.addAttribute("dateofoperation",req.getParameter("flightDate"));
		   
		   return "flightreports/dailysummaryreport";
	}
	
	

	//-------THis Will be Called When Relaiablity Report FORM link TO CREATE EXCEL REPORT Called----------------- 
	@RequestMapping(value = "/Create_Excel_Reliability_Report",method = {RequestMethod.POST,RequestMethod.GET}) 
	public void Create_Excel_Reliability_Report(ModelMap model,HttpServletRequest req,HttpServletResponse res) throws Exception{
		 
		excel.Populate_Reliablity_Report_ExcelFormat(req.getParameter("airlineCode"),
				req.getParameter("airportCode"),req.getParameter("startDate"),req.getParameter("endDate"),
				req.getParameter("tolerance"),req.getParameter("delayCodeGroupCode"),req.getParameter("emailid"));	
		   
		
		
		        
		//----------------------- Here Below is the File  Download Code --------------------
		          String filename="viewExcelReliabilityReportFlights.xls";
			 	  res.setContentType("text/html");  
			      PrintWriter out = res.getWriter();  
			         
	
			      res.setContentType("APPLICATION/OCTET-STREAM");   
			      res.setHeader("Content-Disposition","attachment; filename=\"" + filename.trim() + "\"");
			      FileInputStream fileInputStream = new FileInputStream(filepath +req.getParameter("emailid")+"/"+filename.trim());  
			      int i;   
			      while ((i=fileInputStream.read()) != -1) { out.write(i); }
			      fileInputStream.close();   
			      out.close();   
			      logger.info(req.getParameter("emailid")+" : Have Download the Reliablity Report on:"+ new Date()); 
		
		
	}// End of Create_Excel_Reliability_Report Method 
	
	
	
	
	
	
	
	
	
	
	
	 
}//-------------- End Of Main Class HomeController ------------- 
