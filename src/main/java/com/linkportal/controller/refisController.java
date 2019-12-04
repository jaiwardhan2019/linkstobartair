package com.linkportal.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;


import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

import com.linkportal.contractmanager.manageStobartContract;
import com.linkportal.dbripostry.linkUsers;
import com.linkportal.refis.manageRefisUser;


@Controller
public class refisController {

	
	@Autowired
	linkUsers dbusr;
	
	@Autowired
	manageRefisUser refisuser;
	
	@Autowired
	manageStobartContract contract;
	
	
	@Value("${stobart.contract.folder}") String UPLOAD_DIRECTORY;
	
	
	
	
	
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
	
	

	
	
	
	//-------THis Will be Called When Refis User Links is called from Ground Ops  
	@RequestMapping(value = "/contractManager",method = {RequestMethod.POST,RequestMethod.GET})
	public String ManageContract(HttpServletRequest req, ModelMap model) throws Exception {	
		
			model.addAttribute("emailid",req.getParameter("emailid"));
			model.addAttribute("password",req.getParameter("password"));			
			model.put("profilelist", dbusr.getUser_Profile_List_From_DataBase(req.getParameter("emailid")));
			
		  
			
			if(req.getParameter("event") != null){
				
				//--------- Add New Contract ------------
				if(req.getParameter("event").equals("addnew")){
				   
		         }			        
					
				
				
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
	
	
	
	
	
	
	//************** WILL UPLOAD FILE AND ADD ENTRY TO THE THE DATABASE *********************************
	@RequestMapping(value = "/addcontracttodatabase",method = {RequestMethod.POST,RequestMethod.GET})
    public String singleFileUpload(@RequestParam("file") MultipartFile file,HttpServletRequest req,ModelMap model) {
        
		   
		   model.addAttribute("emailid",req.getParameter("emailid"));
		   model.addAttribute("password",req.getParameter("password"));			
		   model.put("profilelist", dbusr.getUser_Profile_List_From_DataBase(req.getParameter("emailid")));
			
		
	      
		
	        // This Part of Code will Upload file to the folder
	        File uploadDir = new File(UPLOAD_DIRECTORY+"stobart_contract/");
	        if(!uploadDir.exists()) {
	            uploadDir.mkdir();	            
	        }
		
	        
	        try {
	
		            // This Part will save file into the folder  
		            byte[] bytes = file.getBytes();
		            Path path = Paths.get(UPLOAD_DIRECTORY+"stobart_contract/"+ file.getOriginalFilename());
		            Files.write(path, bytes);
		            System.out.println("File Uploaded:"+file.getOriginalFilename());
		            logger.info("Contract File Uploaded to the folder by:"+req.getParameter("emailid"));
		            model.put("fileuploadstatus","Contract File is Uploaded..");
		            
		            
 		            // This Part will Insert Data to the database 		            
		            if(contract.addNewContract() == 1) {		            	
			           logger.info("Contract Detail is added to the database by:"+req.getParameter("emailid"));
			           model.put("fileuploadstatus","Contract File is Uploaded..");		            	
		            }
		            
	        } catch (IOException e) {
	        	logger.error(e);
	        	model.put("fileuploadstatus","Contract File Not Uploaded !!!..");	        
	        }
	        
	        return "contractmanager/contractmanager";
    	
	       
    }
	
	
	//Save Multiple File 
	//https://www.mkyong.com/spring-mvc/spring-mvc-file-upload-example/
    private void saveUploadedFiles(List<MultipartFile> files) throws IOException {

        for (MultipartFile file : files) {

            if (file.isEmpty()) {
                continue; //next pls
            }

            byte[] bytes = file.getBytes();
            Path path = Paths.get(UPLOAD_DIRECTORY+"stobart_contract/" + file.getOriginalFilename());
            Files.write(path, bytes);

        }

    }

	
	
}
