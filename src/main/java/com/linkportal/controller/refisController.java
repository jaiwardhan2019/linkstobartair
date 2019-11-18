package com.linkportal.controller;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.linkportal.dbripostry.linkUsers;
import com.linkportal.graphreport.piechart;
import com.linkportal.security.UserSecurityLdap;

@Controller
public class refisController {

	
	@Autowired
	linkUsers dbusr;
	
	@Autowired
	piechart chart;
	
	
	
    //---------- Logger Initializer------------------------------- 
	private Logger logger = Logger.getLogger(HomeController.class);
	
		


	//------- This Part Will be Called from the Login Page index.jsp 
	@RequestMapping(value = "/refisHomePage",method = {RequestMethod.POST,RequestMethod.GET}) 
	public String HomePage(HttpServletRequest req,ModelMap model,UserSecurityLdap ldp) throws Exception{
	
		  model.addAttribute("emailid",req.getParameter("emailid"));
		  model.addAttribute("password",req.getParameter("password"));			
		  model.put("profilelist", dbusr.getUser_Profile_List_From_DataBase(req.getParameter("emailid"))); //<<-- Populate Profile List with the map object 
		  //String dataPoints = null;	
		  //dataPoints = chart.createBarchartForHomePage();
		  //model.addAttribute("dataPoints",dataPoints); 
	
		  return "groundoperation/refishome";
		  
	}//----------- End of Function 


	
	
	
	
	
	
}
