package com.linkportal.controller;


import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Calendar;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.linkportal.dbripostry.linkUsers;
import com.linkportal.crewripostry.crewReport;




@Controller
public class crewReportsControler {

    
	@Autowired
	crewReport crewInfo;
	
	@Autowired
	linkUsers usrprof;
		
	

	
    //---------- Logger Initializer------------------------------- 
	private final Logger logger = Logger.getLogger(crewReportsControler.class);
	
	
	
	
	
	//-------THis Will be Called When Daily Summary REPORT link Is Called ---------------- 
	@RequestMapping(value = "/voyagerReport",method = {RequestMethod.POST,RequestMethod.GET}) 
	public String voyagerReport(HttpServletRequest req, ModelMap model) throws Exception {	
		   
		
		   String selectoptionString="";
		   String todayselection    ="";
		   String tomorrowselection ="";
		   
	
			//------ BUILTING TODAY AND TOMORROW VARRIABLE ------------
		    Date today = new Date();               
			SimpleDateFormat formattedDate = new SimpleDateFormat("yyyy-MM-dd");
			Calendar c = Calendar.getInstance();  
			String todaydate = formattedDate.format(c.getTime());
			c.add(Calendar.DATE, 1);  // number of days to add      
			String tomorrow = formattedDate.format(c.getTime());
			
			
			
			
			//************ THIS PART WILL TAKE CARE OF DATE SELECTION AND CAPTION LIST POPULATION *************
			if(req.getParameter("flightdate") != null) {
				 
				 if(req.getParameter("flightdate").equalsIgnoreCase(todaydate))
				 {todayselection="selected";}else{tomorrowselection="selected";}
				 //------ ONCE DATE IS SELECTED -----------------------------------------------
				 model.put("captionlist", crewInfo.showCrewList(req.getParameter("flightdate")));
				 selectoptionString="<option value='"+todaydate+"'"+todayselection+">TODAY&nbsp;&nbsp;("+todaydate+")</option>\r\n"+ 
		 		                    "<option value='"+tomorrow+"'"+tomorrowselection+">TOMORROW&nbsp;&nbsp;( "+tomorrow+")</option>";
		 
			 }
			 else
			 {
				//------  DATE IS NOT SELECTED -----------------------------------------------
				 model.put("captionlist", crewInfo.showCrewList(todaydate));
				 selectoptionString="<option value="+todaydate+">TODAY&nbsp;&nbsp;("+todaydate+")</option>\r\n"+ 
		 		                    "<option value="+tomorrow+">TOMORROW&nbsp;&nbsp;( "+tomorrow+")</option>";
		 
			 }
			 model.put("selectoption", selectoptionString);

			 
			 
			 
			 
			 /** THIS PART WILL TAKE CARE OF CAPTION SCHEDULE REPORT**/
			 if((req.getParameter("flightdate") != null) && (req.getParameter("crewcode") != null)) {				 
				 model.put("selectedcaption", req.getParameter("crewcode")); 
				 
				 System.out.println("Crew Date;"+req.getParameter("flightdate"));
				 System.out.println("Crew Code;"+req.getParameter("crewcode"));
					 
			 }
			 
			 
			 
			 
			 
			 
			 //model.put("profilelist", usrprof.getUser_Profile_List_From_DataBase((String)req.getParameter("emailid"))); 
			 model.put("profilelist",req.getSession().getAttribute("profilelist")); 
			 model.addAttribute("emailid",req.getParameter("emailid")); 
			 model.addAttribute("password",req.getParameter("password"));
		   
		 return "crewreport/voyagereport";
	}
	
	
	
	
	
	
	
	
	
	

	
	
	
}//----------- End Of Main Controller --------------------
