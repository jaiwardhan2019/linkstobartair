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
	
	

	
	
	
	//-------START CONTRACT MANAGER CONTROLLER--------------------------------------------------------
	
	@RequestMapping(value = "/contractManager",method = {RequestMethod.POST,RequestMethod.GET})
	public String ManageContract(HttpServletRequest req, ModelMap model) throws Exception {	
		
			model.addAttribute("emailid",req.getParameter("emailid"));
			model.addAttribute("password",req.getParameter("password"));			
			model.put("profilelist", dbusr.getUser_Profile_List_From_DataBase(req.getParameter("emailid")));
		    String rootdirectory = new java.io.File( "/" ).getCanonicalPath();

		  
			
			if(req.getParameter("event") != null){
				
				
				
				//--------- This Part will display Add  Contract View------------
				if(req.getParameter("event").equals("addnew")){
					
					return "contractmanager/addnewcontract";
				   
		         }		
				
				
				
				
				//---------  This Part will display Search Contract And Display  View----
				if(req.getParameter("event").equals("search")){					
					
					model.put("contractlist", contract.showAllContract(req.getParameter("department"),req.getParameter("subdepartment")));
					return "contractmanager/contractmanager";
				   
		         }	
				
				
				
				
				//--------- This Part will display Update Contract View -----------
				if(req.getParameter("event").equals("view")){		
					
					model.addAttribute("emailid",req.getParameter("emailid"));
					model.addAttribute("password",req.getParameter("password"));			
					model.put("profilelist", dbusr.getUser_Profile_List_From_DataBase(req.getParameter("emailid")));
						
			        //------ Select Contract from database
					model.put("contractdetail", contract.viewContract(req.getParameter("refno")));
					//------ Select Contract from File System
					model.put("filelist",contract.showFilesFromFolder(req.getParameter("refno")));
					
				   return "contractmanager/updatecontract";
				   
		         }	
				
				
				
				
				
				
				//--------- This Part will Remove CONTRACT + FOLDER  -----------
				if(req.getParameter("event").equals("remove")){		
						
					//This part will remove Directory from the root and remove record from database.
				    File directory=new File(rootdirectory+"/data/stobart_contract/"+req.getParameter("refno").trim());
				    
				    if(contract.removeFolderWithallFile(directory)){  //<<--- Remove folder and file in there 				    	
					       contract.removeContract(req.getParameter("refno").trim()); //<<-  Remove from database 
					}
				    
					model.put("contractupdate","<span style='color:green;font-weight:bold;font-size:12pt;'> Contract Removed Successfully.&nbsp;<i class='fa fa-smile-o  fa-2x'> </i></span>");
					model.put("contractlist", contract.showAllContract("ALL","ALL"));
					return "contractmanager/contractmanager";
						
				}	
				
				

				//--------- This Part REMOVE FILE FROM Folder  -----------
				if(req.getParameter("event").equals("removefilefromfolder")){		
				    //------ Remove File from the Contract Folder							
					File filenametoremove=new File(rootdirectory+"/data/stobart_contract/"+req.getParameter("refno").trim()+"/"+req.getParameter("filename"));
					boolean delstatus=filenametoremove.delete();
					
					model.put("contractdetail", contract.viewContract(req.getParameter("refno")));
					model.put("filelist",contract.showFilesFromFolder(req.getParameter("refno")));
					model.put("contractupdate","<span style='color:green;font-weight:bold;font-size:12pt;'> File Removed Successfully.&nbsp;<i class='fa fa-smile-o  fa-2x'> </i></span>");
					
				   return "contractmanager/updatecontract";
					
				
				}//------- END of REMOVE FILE PART -----------------
				
				
				
			
			}//----- END OF If(req.getParameter("event") != null){
			
			
			
			model.put("contractlist", contract.showAllContract("ALL","ALL"));
			return "contractmanager/contractmanager";
			
	}//------ End of Contract Manager controller 
	
	
	
	
	
	
	
	
	
	
	@Value("${stobart.contract.folder}") String UPLOAD_DIRECTORY;	
	
	//************** WILL UPLOAD FILE AND ADD ENTRY TO THE THE DATABASE *********************************
	@RequestMapping(value = "/addcontracttodatabase",method = {RequestMethod.POST,RequestMethod.GET})
    public String singleFileUpload(@RequestParam("cfile") MultipartFile file,HttpServletRequest req,ModelMap model) {
        
		   
		   model.addAttribute("emailid",req.getParameter("emailid"));
		   model.addAttribute("password",req.getParameter("password"));			
		   model.put("profilelist", dbusr.getUser_Profile_List_From_DataBase(req.getParameter("emailid")));
			
		
	       
	        try {
			        // This Part of Code Will Create Main Folder (stobart_contract) if not exist 
			        File uploadDir = new File(UPLOAD_DIRECTORY+"stobart_contract/");
			        if(!uploadDir.exists()) {
			            uploadDir.mkdir();
			            logger.info("Main Folder stobart_contract Created ");
			            
			        }
			        
			        File contractFolder = new File(UPLOAD_DIRECTORY+"stobart_contract/"+req.getParameter("refno").trim()+"/");
		            if(!contractFolder.exists()){
		            	contractFolder.mkdir();
		            	logger.info("Contract Refrence No Folder Created ");			            	
		            }
		            
		          
			        
	 	            // This Part will Upload File to into the folder  
		            byte[] bytes = file.getBytes();
		            Path path = Paths.get(UPLOAD_DIRECTORY+"stobart_contract/"+req.getParameter("refno").trim()+"/"+file.getOriginalFilename());
		            Files.write(path, bytes);		    
		            logger.info("Contract File Uploaded to the folder by:"+req.getParameter("emailid"));
		            
 		            // This Part will Insert Form Data to the database 		            
		            if(contract.addNewContract(req) == 1) {		            	
			           logger.info("Contract Detail is added to the database by:"+req.getParameter("emailid"));
			           model.put("fileuploadstatus","Contract File is Uploaded..");		            	
		            }
		            
	
		            
	        } catch (Exception e) {
	        	logger.error(e);	        	
	        	model.put("contractupdate","<span style='color:red;font-weight:bold;font-size:12pt;'> Contract  Not Added Please Try Again !!!..&nbsp;<i class='fa fa-frown-o fa-2x'> </i></span>");	
	        	model.put("contractlist", contract.showAllContract("ALL","ALL")); 
	        	return "contractmanager/contractmanager";
	        }
	        
	        
	        
			model.put("contractupdate","<span style='color:green;font-weight:bold;font-size:12pt;'> Contract  Successfully Added.&nbsp;<i class='fa fa-smile-o  fa-2x'> </i></span>");
			model.put("contractlist", contract.showAllContract("ALL","ALL")); 
	        return "contractmanager/contractmanager";
    	
	       
    }

	
	

	
	//************** WILL UPDATE CONTRACT TO THE DATABASE AND ADD MORE FILE TO THE FOLDER *********************************
	@RequestMapping(value = "/updatecontracttodatabase",method = {RequestMethod.POST,RequestMethod.GET})
    public String UpdateFileUploadAddData(@RequestParam("cfile") MultipartFile file,HttpServletRequest req,ModelMap model) {
        
		   
		   model.addAttribute("emailid",req.getParameter("emailid"));
		   model.addAttribute("password",req.getParameter("password"));			
		   model.put("profilelist", dbusr.getUser_Profile_List_From_DataBase(req.getParameter("emailid")));
			
		
	       
	        try {
			      
	        	
	        	
	        	   if(file.getSize() > 0) { 
			        	
	        	
			        	    // This Part of Code Will Create Main Folder (stobart_contract) if not exist 
					        File uploadDir = new File(UPLOAD_DIRECTORY+"stobart_contract/");
					        if(!uploadDir.exists()) {
					            uploadDir.mkdir();
					            logger.info("Main Folder stobart_contract Created ");
					            
					        }
					        
					        File contractFolder = new File(UPLOAD_DIRECTORY+"stobart_contract/"+req.getParameter("refno").trim()+"/");
				            if(!contractFolder.exists()){
				            	contractFolder.mkdir();
				            	logger.info("Contract Refrence No Folder Created ");			            	
				            }
				            
				          
					        
			 	            // This Part will Upload File to into the folder  
				            byte[] bytes = file.getBytes();
				            Path path = Paths.get(UPLOAD_DIRECTORY+"stobart_contract/"+req.getParameter("refno").trim()+"/"+file.getOriginalFilename());
				            Files.write(path, bytes);		    
				            logger.info("Contract File Uploaded to the folder by:"+req.getParameter("emailid"));
			
	        	   } 
	        	   // END OF FILE UPLOAD PART -------
		            
	        	   
 		            // This Part will Insert Form Data to the database 		            
		            if(contract.updateNewContract(req) == 1) {		            	
			           logger.info("Contract Detail is Updated by:"+req.getParameter("emailid"));
			          		            	
		            }
		            
		            
		            
	        } catch (Exception e) {
	        	logger.error(e);	        	
	        	model.put("contractupdate","<span style='color:red;font-weight:bold;font-size:12pt;'> Contract  Not Update. Please Try Again !!!..&nbsp;<i class='fa fa-frown-o fa-2x'> </i></span>");	
	        	model.put("contractlist", contract.showAllContract("ALL","ALL")); 
	        	return "contractmanager/contractmanager";
	        }
	        
	        
	       
	        
			model.put("contractdetail", contract.viewContract(req.getParameter("refno")));
			model.put("filelist",contract.showFilesFromFolder(req.getParameter("refno")));
			model.put("contractupdate","<span style='color:green;font-weight:bold;font-size:12pt;'> Contract  Successfully Updated.&nbsp;<i class='fa fa-smile-o  fa-2x'> </i></span>");
			
			return "contractmanager/updatecontract";
	        
	        
	       
    }
	//************** END OF UPDATE CONTRACT TO THE DATABASE AND ADD MORE FILE TO THE FOLDER *********************************
	
	
   



} //---- END OF CONTROLLER CLASS ----------


   
	

