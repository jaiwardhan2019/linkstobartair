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
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.linkportal.dbripostry.linkUsers;
import com.linkportal.staffTravel.manageStaffTravelUser;




@Controller
public class staffTravelControler {


	@Autowired
	linkUsers dbusr;
	
	@Autowired
	manageStaffTravelUser staffuser;
	

	
    //---------- Logger Initializer------------------------------- 
	private Logger logger = Logger.getLogger(staffTravelControler.class);
	
	
	

	
	//-------THis Will be Called When Daily Summary REPORT link Is Called ---------------- 
	@RequestMapping(value = "/stafflist",method = {RequestMethod.POST,RequestMethod.GET})
	public String staffListReport(HttpServletRequest req, ModelMap model) throws Exception {	
		
			model.addAttribute("emailid",req.getParameter("emailid"));
			model.addAttribute("password",req.getParameter("password"));			
			//model.put("profilelist", dbusr.getUser_Profile_List_From_DataBase(req.getParameter("emailid")));
			model.put("profilelist",req.getSession().getAttribute("profilelist")); 
			
			//--------- Start Remove Operation -------------------- 
			if(req.getParameter("account") != null){	
				
			   try{
					
						int delstatus=staffuser.removeStaff_FromDb(Integer.parseInt(req.getParameter("account")),req.getParameter("flname"));
						model.put("deletestatus","<span style='color:green;'> <b> User ID  : "+req.getParameter("account")+"  Removed !! </b></span>");					    	
					    logger.info("User ID  : "+req.getParameter("account")+" Removed from Staff Travel Database by :"+req.getParameter("emailid")); 
				
			   }catch(NumberFormatException ww) {logger.error(ww);}
				
			}//---------- End Of Account Removed Operation 
			
			
		    
		    if(req.getParameter("user") != null){		    	
		    	
		    	model.put("staffAccountlist", staffuser.searchStaffTravelUsers(req.getParameter("user").trim()));
		    	
		    }
		    else
		    {
		    	model.put("staffAccountlist", staffuser.showStaffTravelUsers());
		  
		    	
		    }
			
		return "stafftravel/managestaff";
	}
	
	
	
	
	

	
	
	
}//----------- End Of Main Controller --------------------
