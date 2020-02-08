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
import java.util.Arrays;

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
import com.linkportal.groundops.manageRefisUser;


@Controller
public class groundOpsController {

	
	@Autowired
	linkUsers dbusr;
	
	@Autowired
	manageRefisUser refisuser;
	
	@Autowired
	manageStobartContract contract;
	
	

	
	
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
					System.out.println("View Update Selected");					
					model.put("gopsuserdetail", refisuser.viewGopsUserDetail(req.getParameter("userinsubject").trim()));
					return "groundoperation/viewUpdateRefisusers"; 
				}
				
				
				
				
				//-- Update Ground Ops User --
				if(req.getParameter("operation").equals("update")) {
			   	   if(refisuser.updateGopsUserDetail(req) == 1){
					  model.put("status","User Updated...");
				    }
			   	   else
			   	   {
			   		model.put("status","User Not Updated check log file.");
			   	   }
				   model.put("gopsuserdetail", refisuser.viewGopsUserDetail(req.getParameter("userid").trim()));					
				   return "groundoperation/viewUpdateRefisusers"; 
				}
				
				
				
				
				
				//-- Remove Ground Ops User --
				if(req.getParameter("operation").equals("remove")) {
				   System.out.println("Remove Operation is selected ");
				   status=refisuser.removeRefisUser_FromDb(req.getParameter("userinsubject"));
				   model.put("status","User id :&nbsp;"+req.getParameter("userinsubject")+"&nbsp; Removed Successfully..");	
				}
				
				
				
				
				//-- Add new User--
				if(req.getParameter("operation").equals("addnew")) {
				  System.out.println("Add new is selected ");
				  model.put("status","New Ground Handler Created Successfully..");
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
			
		    
		    
		return "groundoperation/manageRefisusers";
	}
	
	




} //---- END OF CONTROLLER CLASS ----------


   
	

