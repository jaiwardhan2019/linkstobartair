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
import com.linkportal.groundops.gopsAllapi;


@Controller
public class stobartContractManagerController {

	
	@Autowired
	linkUsers dbusr;
	
	@Autowired
	gopsAllapi refisuser;
	
	@Autowired
	manageStobartContract contract;
	
	
	
    //---------- Logger Initializer------------------------------- 
	private final Logger logger = Logger.getLogger(HomeController.class);
	
		
	
	
	//*******************************CONTRACT MANAGER CONTROLLER****************************************
	
	@RequestMapping(value = "/contractManager",method = {RequestMethod.POST,RequestMethod.GET})
	public String ManageContract(HttpServletRequest req, ModelMap model) throws Exception {	
		
		
	      String[] userEmailId   =  req.getParameter("profilelist").toString().split("#");
	      model.addAttribute("profilelist",req.getParameter("profilelist"));	

		  String rootdirectory = new java.io.File( "/" ).getCanonicalPath();

		    
			
			if(req.getParameter("event") != null){
				
				
					
					//--------- This Part will display Add  Contract View------------
					if(req.getParameter("event").equals("addnew")){
						
						model.put("departmentlist", contract.populate_Department(userEmailId[0],req.getParameter("department")));
						model.put("subdepartmentlist", contract.populate_SubDepartment(userEmailId[0],req.getParameter("department"),"ALL"));

						
						if(req.getParameter("departmentselected") != null){
								
							model.put("cdescription",req.getParameter("cdescription"));
							model.put("startDate",req.getParameter("startDate"));
							model.put("endDate",req.getParameter("endDate"));
							model.put("endDate",req.getParameter("endDate"));
							model.put("endDate",req.getParameter("endDate"));
							model.put("ccompany",req.getParameter("ccompany"));
							model.put("ccontract",req.getParameter("ccontract"));							
						}	
						
					
						return "contractmanager/addnewcontract";
					   
			         }		
					
		
					
					
					
					
					
					
					//---------  This Part will display Search Contract And Display  View----
					if(req.getParameter("event").equals("search")){					
						
						 String status="";
						 int nochecked=0;
						
					    if(req.getParameter("Active") != null) {					    	
					    	status=status+"'"+req.getParameter("Active")+"'";
					    	nochecked=nochecked + 1;
					    	model.put("Active", "checked");
					    }
					    
					    if(req.getParameter("Dactive") != null) {
					       if(nochecked > 0) {status = status +",";}	
					       status=status+"'"+req.getParameter("Dactive")+"'";
					       nochecked=nochecked + 1;
					       model.put("Dactive", "checked");
					       					       
					    }
					    
					    
					    if(req.getParameter("Archived") != null) {
					    	if(nochecked > 0) {status = status +",";}		
					    	status=status+"'"+req.getParameter("Archived")+"'";
					    	nochecked=nochecked + 1;	
					    	model.put("Archived", "checked");
					    }
					    
					    
					    
						 
						
						model.put("contractlist", contract.showAllContract(userEmailId[0],req.getParameter("department"),req.getParameter("subdepartment"),req.getParameter("cdescription"),status.trim()));
						model.put("departmentlist", contract.populate_Department(userEmailId[0],req.getParameter("department")));
					
						if(req.getParameter("department").equals("ALL")) {
						   model.put("subdepartmentlist", contract.populate_SubDepartment(userEmailId[0],req.getParameter("department"),"ALL"));	
						}
						else
						{
						   model.put("subdepartmentlist", contract.populate_SubDepartment(userEmailId[0],req.getParameter("department"),req.getParameter("subdepartment")));
						}
						
						 model.put("cdescription",req.getParameter("cdescription"));
						
						 
						return "contractmanager/contractmanager";
					   
			         }	
					//-------- END OF SEARCH  BUTTON EVENT ----------
				
				
					
					
					
					
					
					
					
					
					
					
					
					//--------- This Part will display Update Contract View -----------
					if(req.getParameter("event").equals("view")){		
						
					        //------ Select Contract from database
						model.put("contractdetail", contract.viewContract(req.getParameter("refno"),userEmailId[0]));
						model.put("departmentlist", contract.populate_Department(userEmailId[0],req.getParameter("departmentselected")));						
						model.put("subdepartmentlist", contract.populate_SubDepartment(userEmailId[0],req.getParameter("departmentselected"),req.getParameter("subdepartmentselected")));
						
						
						//------ Select Contract file list from File System
						model.put("filelist",contract.showFilesFromFolder(req.getParameter("refno")));
						
					
						
					   return "contractmanager/updatecontract";
					   
			         }	
					

					
					
					//--------- WILL SHOW CONTRACT TO VIEW  -----------
					if(req.getParameter("event").equals("showcontract")){		
						
					        //------ Select Contract from database
						model.put("contractdetail", contract.viewContract(req.getParameter("refno"),userEmailId[0]));
						//------ Select Contract file list from File System
						model.put("filelist",contract.showFilesFromFolder(req.getParameter("refno")));	
					   return "contractmanager/showcontract";
					   
			         }	
						
					
					//--------- This Part will display Update Contract View -----------
					if(req.getParameter("event").equals("renew")){		
						
					    //------ Select Contract from database						
						model.put("contractdetail", contract.renewContract(req.getParameter("refno"),userEmailId[0]));
						model.put("departmentlist", contract.populate_Department(userEmailId[0],req.getParameter("departmentselected").trim()));
						model.put("subdepartmentlist", contract.populate_SubDepartment(userEmailId[0],req.getParameter("departmentselected").trim(),req.getParameter("subdepartmentselected").trim()));
						model.put("contractupdate","<br><p align='center'><span style='color:green;font-weight:bold;font-size:10pt;'> Contract Renewed .&nbsp;<i class='fa fa-smile-o  fa-2x'> </i></span></p>");
			    	    return "contractmanager/updatecontract";
					   
			         }	
						
				
				
				
					
					//--------- This Part will Remove CONTRACT + FOLDER  -----------
					if(req.getParameter("event").equals("remove")){		
						
						
						
						contract.removeContract(req.getParameter("refno").trim()); //<<-  Remove from database
						//This part will remove Directory from the root and remove record from database.
					    File directory=new File(rootdirectory+"/data/stobart_contract/"+req.getParameter("refno").trim());
					    
					    if(contract.removeFolderWithallFile(directory)){  //<<--- Remove folder and file in there 				    	
						     contract.removeContract(req.getParameter("refno").trim()); //<<-  Remove from database 
	                         
						     //--- IF ZIP FILE EXIST THEN REMOVE 
						     boolean zipfiledelstatus=false;
							 File zipfile = new File(rootdirectory+"/data/stobart_contract/"+req.getParameter("refno").trim()+".zip");
					         if(zipfile.isFile()) {zipfiledelstatus=zipfile.delete();}
							   
					    
					    
					    }
					    
					    
					    
					    
						model.put("contractupdate","<span style='color:green;font-weight:bold;font-size:10pt;'> Contract no:"+req.getParameter("refno")+" Removed Successfully.&nbsp;<i class='fa fa-smile-o  fa-2x'> </i></span>");
						model.put("contractlist", contract.showAllContract(userEmailId[0],"ALL","ALL",null,null));

						model.put("departmentlist", contract.populate_Department(userEmailId[0],"All"));						
						model.put("subdepartmentlist", contract.populate_SubDepartment(userEmailId[0],"ALL","ALL"));
						model.put("Active", "checked");
						return "contractmanager/contractmanager";
							
					} //  End of Contract Remove Part--
					
					
					
					
					
					
					
					
					
					
					
					//--------- This Part REMOVE FILE FROM Folder  -----------
					if(req.getParameter("event").equals("removefilefromfolder")){	
					
					    //------ Remove File from the Contract Folder							
						File filenametoremove=new File(rootdirectory+"/data/stobart_contract/"+req.getParameter("refno").trim()+"/"+req.getParameter("filename"));
						boolean delstatus=filenametoremove.delete();
							
						model.put("contractdetail", contract.viewContract(req.getParameter("refno"),userEmailId[0]));
						model.put("filelist",contract.showFilesFromFolder(req.getParameter("refno")));
						model.put("departmentlist", contract.populate_Department(userEmailId[0],req.getParameter("department")));						
						model.put("subdepartmentlist", contract.populate_SubDepartment(userEmailId[0],req.getParameter("department"),req.getParameter("subdepartment")));
						model.put("contractupdate","<br><p align='center'><span style='color:green;font-weight:bold;font-size:10pt;'> File Removed Successfully .&nbsp;<i class='fa fa-smile-o  fa-2x'> </i></span></p>");

						
					   return "contractmanager/updatecontract";
			   
					
					
					}//------- END of REMOVE FILE PART -----------------
					
					
				
			
			}//----- END OF If(req.getParameter("event") != null){
			
			
			
			model.put("contractlist", contract.showAllContract(userEmailId[0],"ALL","ALL",null,null));
			model.put("departmentlist", contract.populate_Department(userEmailId[0],"ALL"));
			model.put("subdepartmentlist", contract.populate_SubDepartment(userEmailId[0],"ALL","ALL"));
			model.put("Active", "checked");
			
			
			return "contractmanager/contractmanager";
			
			
			
			
	}//------ End of Contract Manager controller 
	
	
	
	
	
	
	
	
	
	
	@Value("${stobart.contract.folder}") String UPLOAD_DIRECTORY;	
	
	//************** WILL UPLOAD FILE AND ADD ENTRY TO THE THE DATABASE *********************************
	@RequestMapping(value = "/addcontracttodatabase",method = {RequestMethod.POST,RequestMethod.GET})
    public String singleFileUpload(@RequestParam("cfile") MultipartFile file,HttpServletRequest req,ModelMap model) throws SQLException {
        
		  
	      String[] userEmailId   =  req.getParameter("profilelist").toString().split("#");
	      model.addAttribute("profilelist",req.getParameter("profilelist"));	
		
	       
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
		            Path path = Paths.get(UPLOAD_DIRECTORY+"stobart_contract/"+req.getParameter("refno").trim()+"/"+file.getOriginalFilename().replaceAll("[\\\\/:*&?\"<>|]",""));
		            Files.write(path, bytes);		    
		            logger.info("Contract File Uploaded to the folder by:"+userEmailId[0]);
		            
 		            // This Part will Insert Form Data to the database 		            
		            if(contract.addNewContract(req) == 1) {	
			           logger.info("Contract no:"+req.getParameter("refno")+" is added to the database by :"+userEmailId[0]); 
			           model.put("fileuploadstatus","Contract File is Uploaded..");		            	
		            }
		            
	
		            
	        } catch (Exception e) {
	        	logger.error(e);	        	
	        	model.put("contractupdate","<p align='center'><span style='color:red;font-weight:bold;font-size:10pt;'> Contract  Not Added Please Try Again !!!..&nbsp;<i class='fa fa-frown-o fa-2x'><br>"+e.toString()+"</i></span></p>");	
	        	
	        	model.put("contractlist", contract.showAllContract(userEmailId[0],"ALL","ALL",null,null)); 
	        	return "contractmanager/contractmanager";
	        }
	        
	        
	        
			model.put("contractupdate","<p align='center'><span style='color:green;font-weight:bold;font-size:10pt;'> Contract no:( "+req.getParameter("refno")+" ) Successfully Added.&nbsp;<i class='fa fa-smile-o  fa-2x'> </i></span></p>");
			model.put("contractlist", contract.showAllContract(userEmailId[0],"ALL","ALL",null,null)); 
			model.put("departmentlist", contract.populate_Department(userEmailId[0],"ALL"));						
			model.put("subdepartmentlist", contract.populate_SubDepartment(userEmailId[0],"ALL","ALL"));
			model.put("Active", "checked"); 
			logger.info("Contract no:"+req.getParameter("refno")+" Created in System by :"+userEmailId[0]); 
	        return "contractmanager/contractmanager";
    	
	       
    }

	
	

	
	//************** WILL UPDATE CONTRACT TO THE DATABASE AND ADD MORE FILE TO THE FOLDER *********************************
	@RequestMapping(value = "/updatecontracttodatabase",method = {RequestMethod.POST,RequestMethod.GET})
    public String UpdateFileUploadAddData(@RequestParam("cfile") MultipartFile file,HttpServletRequest req,ModelMap model) throws SQLException {
        
		 
	      String[] userEmailId   =  req.getParameter("profilelist").toString().split("#");
	      model.addAttribute("profilelist",req.getParameter("profilelist"));
	      
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
				            Path path = Paths.get(UPLOAD_DIRECTORY+"stobart_contract/"+req.getParameter("refno").trim()+"/"+file.getOriginalFilename().replaceAll("['\\\\/:*&?\"<>|]",""));
				            Files.write(path, bytes);		    
				            logger.info("Contract File Uploaded to the folder by:"+userEmailId[0]);
			
	        	   } 
	        	   // END OF FILE UPLOAD PART -------
		            
	        	   
 		            // This Part will Update Form Data to the database 		            
		            if(contract.updateNewContract(req) == 1) {		            	
		            	logger.info("Contract no:"+req.getParameter("refno")+" Update in System by :"+userEmailId[0]); 
			          		            	
		            }
		            
		            
		            
	        } catch (Exception e) {
	        	logger.error(e);	        	
	        	model.put("contractupdate","<p align='center'><span style='color:red;font-weight:bold;font-size:10pt;'> Contract  Not Update. Please Try Again !!!..&nbsp;<i class='fa fa-frown-o fa-2x'> </i><br>"+e.toString()+"</span></p>");	
	        	model.put("contractlist", contract.showAllContract(userEmailId[0],"ALL","ALL",null,null)); 
				model.put("departmentlist", contract.populate_Department(userEmailId[0],"ALL"));						
				model.put("subdepartmentlist", contract.populate_SubDepartment(userEmailId[0],"ALL","ALL"));
				model.put("Active", "checked"); 
	        	return "contractmanager/contractmanager";
	        }
	        
	        
	       
	        
			model.put("contractdetail", contract.viewContract(req.getParameter("refno"),userEmailId[0]));
			model.put("filelist",contract.showFilesFromFolder(req.getParameter("refno")));
			model.put("departmentlist", contract.populate_Department(userEmailId[0],req.getParameter("department")));						
			model.put("subdepartmentlist", contract.populate_SubDepartment(userEmailId[0],req.getParameter("department"),req.getParameter("subdepartment")));
			model.put("contractupdate","<p align='center'><span style='color:green;font-weight:bold;font-size:10pt;'> Contract  Successfully Updated.&nbsp;<i class='fa fa-smile-o  fa-2x'> </i></span></p>");
			return "contractmanager/updatecontract";
	        
	        
	       
    }
	//************** END OF UPDATE CONTRACT TO THE DATABASE AND ADD MORE FILE TO THE FOLDER *********************************
	
	

	//--------- THIS PART WILL DO DB UPDATE FROM THE AJAX  
	@ResponseBody
	@RequestMapping(method = {RequestMethod.POST,RequestMethod.GET}, value="/zipfolderanddownload/{refno}")
	public int zipFolderandDownload(@PathVariable("refno") String refno,HttpServletRequest req,HttpServletResponse res) throws Exception{
	

		 String dirPath=UPLOAD_DIRECTORY+"stobart_contract/"+refno;
		
	       final Path sourceDir = Paths.get(dirPath);
	        String zipFileName = dirPath.concat(".zip");
	        try {
	            final ZipOutputStream outputStream = new ZipOutputStream(new FileOutputStream(zipFileName));
	            Files.walkFileTree(sourceDir, new SimpleFileVisitor<Path>() {
	                @Override
	                public FileVisitResult visitFile(Path file, BasicFileAttributes attributes) {
	                    try {
	                        Path targetFile = sourceDir.relativize(file);
	                        outputStream.putNextEntry(new ZipEntry(targetFile.toString()));
	                        byte[] bytes = Files.readAllBytes(file);
	                        outputStream.write(bytes, 0, bytes.length);
	                        outputStream.closeEntry();
	                    } catch (IOException e) {
	                    	logger.error("While zipping Contract no ::"+refno+"::"+e.toString());
	                    }
	                    return FileVisitResult.CONTINUE;
	                }
	            });
	            outputStream.close();
	            
	            
	        } catch (IOException e) {	           
	            logger.error("While zipping Contract no ::"+refno+"::"+e.toString());
	        }		
	        
	     logger.info("Contract no :"+refno+" Been Zipped and Downloaded on:"+ new Date());
	       
	     return 1;  
    
	}
	



} //---- END OF CONTROLLER CLASS ----------


   
	

