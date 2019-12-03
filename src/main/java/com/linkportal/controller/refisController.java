package com.linkportal.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
 



import com.linkportal.dbripostry.linkUsers;
import com.linkportal.refis.manageRefisUser;


@Controller
public class refisController {

	
	@Autowired
	linkUsers dbusr;
	
	@Autowired
	manageRefisUser refisuser;
	
	
	
    //---------- Logger Initializer------------------------------- 
	private Logger logger = Logger.getLogger(HomeController.class);
	
		


	//------- This Part Will be Called from the Login Page index.jsp 
	@RequestMapping(value = "/refisHomePage",method = {RequestMethod.POST,RequestMethod.GET}) 
	public String HomePage(HttpServletRequest req,ModelMap model) throws Exception{
	       
		  if(req.getParameter("emailid") == null) {return "index";}
		  model.addAttribute("emailid",req.getParameter("emailid"));
		  model.addAttribute("password",req.getParameter("password"));			
		  model.put("profilelist", dbusr.getUser_Profile_List_From_DataBase(req.getParameter("emailid"))); //<<-- Populate Profile List with the map object 
		  
		  return "groundoperation/refishome";
		  
	}//----------- End of Function 


	
	
	
	
	
	//-------THis Will be Called When Refis User Links is called from Ground Ops  
	@RequestMapping(value = "/managerefisuser",method = {RequestMethod.POST,RequestMethod.GET})
	public String refisuserlist(HttpServletRequest req, ModelMap model) throws Exception {	
		
			model.addAttribute("emailid",req.getParameter("emailid"));
			model.addAttribute("password",req.getParameter("password"));			
			model.put("profilelist", dbusr.getUser_Profile_List_From_DataBase(req.getParameter("emailid")));
			
			
			//--------- Start Remove Operation -------------------- 
			if(req.getParameter("user") != null){	
				
				try {
					
					/*
						int delstatus=staffuser.removeStaff_FromDb(Integer.parseInt(req.getParameter("account")));
						if(delstatus == 0){		
							model.put("deletestatus","<span style='color:green;'> <b> User ID  : "+req.getParameter("account")+"  Removed !! </b></span>");					    	
						    logger.info("User ID  : "+req.getParameter("account")+" Removed from Staff Travel Database by :"+req.getParameter("emailid")); 
						}
						else
						{
							model.put("deletestatus","<span style='color:red;'> <b> User ID  : "+req.getParameter("account")+" Not Removed !! please try again </b></span>");
					    	
						}
				*/
				}catch(NumberFormatException ww) {logger.error(ww);}
				
			}//---------- End Of Account Removed Operation 
			
			
		    
		    if(req.getParameter("user") != null){		    			    	
		    	model.put("refisAccountlist", refisuser.searchRefisUser(req.getParameter("user")));		    	
		    }
		    else
		    {
		    	model.put("refisAccountlist", refisuser.showRefisUser());
		    }
			
		return "groundoperation/manageRefisusers";
	}
	
	

	
	 // location to store file uploaded
    private static final String UPLOAD_DIRECTORY = "c:/stobart_contract";
  
    
 
    // upload settings
    private static final int MEMORY_THRESHOLD   = 1024 * 1024 * 3;  // 3MB
    private static final int MAX_FILE_SIZE      = 1024 * 1024 * 40; // 40MB
    private static final int MAX_REQUEST_SIZE   = 1024 * 1024 * 50; // 50MB
    
	
	
	
	//-------THis Will be Called When Refis User Links is called from Ground Ops  
	@RequestMapping(value = "/contractManager",method = {RequestMethod.POST,RequestMethod.GET})
	public String ManageContract(HttpServletRequest req, HttpServletResponse res, ModelMap model) throws Exception {	
		
			model.addAttribute("emailid",req.getParameter("emailid"));
			model.addAttribute("password",req.getParameter("password"));			
			model.put("profilelist", dbusr.getUser_Profile_List_From_DataBase(req.getParameter("emailid")));
			
		   System.out.println("Write Add operation ;"+req.getParameter("cfile"));
			
			if(req.getParameter("event") != null){
				
				//--------- Add New Contract ------------
				if(req.getParameter("event").equals("add")){
					
				 
				   
				   // checks if the request actually contains upload file
			        if (!ServletFileUpload.isMultipartContent(req)) {
			            // if not, we stop here
			            PrintWriter writer = res.getWriter();
			            writer.println("Error: Form must has enctype=multipart/form-data.");
			            writer.flush();
			            return null;			       
			        }
			        
			        // creates the directory if it does not exist
			        File uploadDir = new File(UPLOAD_DIRECTORY);
			        if(!uploadDir.exists()) {
			            uploadDir.mkdir();
			            System.out.println("Creating Directory:"+UPLOAD_DIRECTORY);
			        }
			 			
			        
					List<FileItem> multiparts = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(req);
				 
				    for(FileItem item : multiparts){
				       if(!item.isFormField()){
				           String name = new File(item.getName()).getName();
				           item.write( new File(UPLOAD_DIRECTORY + File.separator + name));
				       }
				       
				     }//-- End of for loop 
				
				
 
			        }//--------- End of  if(req.getParameter("event") != null){
			    			        
			        
			        
			        
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				//--------- Show All Contract ------------
				if(req.getParameter("event").equals("listcontract")){
					
				   System.out.println("Write Add operation"+req.getParameter("cfile"));
					
				}

				
				//--------- View One Contract ------------
				if(req.getParameter("event").equals("viewcontract")){
					
				   System.out.println("Write Add operation"+req.getParameter("cfile"));
					
				}

				
				
				return "contractmanager/addnewcontract";
				
			}
			
		
			return "contractmanager/contractmanager";
			
	}//------ End of Contract Manager controller 
	
	
	
	
	
	
}
