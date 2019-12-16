package com.linkportal.contractmanager;

import java.io.BufferedInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import javax.servlet.http.HttpServletRequest;
import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class manageStobartContractImp implements manageStobartContract{
	
	@Autowired
	DataSource dataSourcemysql;
	

	JdbcTemplate jdbcTemplateRefis;	


	
	

	public manageStobartContractImp(DataSource dataSourcemysql) {		
		   
		   jdbcTemplateRefis = new JdbcTemplate(dataSourcemysql);
		   
	}
	
	
	
     
	
	
    // -------------  THIS WILL SHOW THE LIST OF CONTRACT --------------- 
	@Override
	public List<stobartContract> showAllContract(String dept, String subdept) {		
		   String sqlListContract="SELECT * FROM CORPORATE_PORTAL.CONTRACT_MASTER order by entry_date_time desc";
		   
		   //************* BUILT SQL ON SEARCH PARAMETER ***************
		   if(!dept.equals("ALL")){
			   sqlListContract="SELECT * FROM CORPORATE_PORTAL.CONTRACT_MASTER  where department='"+dept+"' order by entry_date_time desc";
			   if(!subdept.equals("ALL")){
				   sqlListContract="SELECT * FROM CORPORATE_PORTAL.CONTRACT_MASTER  where department='"+dept+"' and sub_department='"+subdept+"'  order by entry_date_time desc";
				   
			   }
			   
		   }
		   
		   
		   
		   List  Contract = jdbcTemplateRefis.query(sqlListContract,new stobartContractRowmapper());
		
		return Contract;
	}
	
	
	


	// -------------  THIS WILL SHOW ONE CONTRACT --------------- 
	@Override
	public stobartContract viewContract(String crefno) {
		 String sql="SELECT * FROM CORPORATE_PORTAL.CONTRACT_MASTER where refrence_no=?";   		 
		 return jdbcTemplateRefis.queryForObject(sql, new Object[]{crefno}, new stobartContractRowmapper());	    
	
	}



	
	
	
	
	
	
    //--------- THIS FUNCTION WILL ADD CONTRACT DETAIL INTO THE DATABASE -----------
	@Override
	public int addNewContract(HttpServletRequest req) {
		
		   DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");
		   
		   LocalDateTime currentdateandtime = LocalDateTime.now();
	
		
		   String insertQuery="INSERT INTO  CORPORATE_PORTAL.CONTRACT_MASTER (department ,sub_department , contractor_name, contractor_contact_detail,"
		   		  + " refrence_no,description,status,start_date,end_date,entered_by_email,entry_date_time)"
				  
		   		  +"VALUES ('"+req.getParameter("department")+"','"+req.getParameter("subdepartment")+"','"+req.getParameter("ccompany")+"'"
				  + ",'"+req.getParameter("ccontract")+"','"+req.getParameter("refno")+"','"+req.getParameter("cdescription")+"', "
				  		+ "'Active','"+req.getParameter("startDate")+"','"+req.getParameter("endDate")+"'"
				  				+ ",'"+req.getParameter("emailid")+"','"+currentdateandtime+"')";
		   
		  
		   int stats=jdbcTemplateRefis.update(insertQuery);		
		   
		  
		return stats;
	}

	
	
	
	
	
	
	@Override
	public int updateNewContract(HttpServletRequest req) {
		
		   DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");
		   LocalDateTime currentdateandtime = LocalDateTime.now();
		  
		   String updateSql = "UPDATE CORPORATE_PORTAL.CONTRACT_MASTER SET department ='"+req.getParameter("department")+"' , sub_department ='"+req.getParameter("subdepartment")+"',"
		   		+ " contractor_name ='"+req.getParameter("ccompany")+"' ,contractor_contact_detail = '"+req.getParameter("ccontract").trim()+"',"
		   		+ " status='"+req.getParameter("status")+"', start_date='"+req.getParameter("startDate")+"', end_date='"+req.getParameter("endDate")+"', "
		   		+ " entered_by_email='"+req.getParameter("emailid")+"', entry_date_time='"+currentdateandtime+"' ,description='"+req.getParameter("cdescription")+"'  WHERE refrence_no ='"+req.getParameter("refno")+"'";		   
		   
		   int rows = jdbcTemplateRefis.update(updateSql);	
		return rows;
	}
	

	
	
	@Override
	public void removeContract(String refrenceno) {
		// TODO Auto-generated method stub		
		jdbcTemplateRefis.execute("delete from CORPORATE_PORTAL.CONTRACT_MASTER  where refrence_no='"+refrenceno+"'");
	}




    //----------- THIS FUNCTION WILL TAKE FOLDER NAME AS INPUT AND RETURN LIST STRING AS FILE NAME IN THERE  
	@Value("${stobart.contract.folder}") String CONTRACT_DIRECTORY;
	@Override
	public List<String> showFilesFromFolder(String foname) {	
		   List<String> CfileList = new ArrayList<String>();
		   File foldername = new File(CONTRACT_DIRECTORY+"stobart_contract/"+foname+"/"); 
		   if(foldername.isDirectory()) {
			   String[] fileList = foldername.list();
			   for (String filename : fileList) {
				   CfileList.add(filename);
			   }
			   return CfileList;
		   }
		   else
		   {
			   return null; 
		   }
		   

		
	}//--------- END OF FUNCTION --------------





	 //-------- TAKE DIRECTORY AS INPUT AND REMOVE ALL FILE FROM THERE 
	@Override
	public boolean removeFolderWithallFile(File dir) {
		   
	   	 if (dir.isDirectory()) { 
    		 File[] children = dir.listFiles(); 
    		 for (int i = 0; i < children.length; i++) { 
    			 boolean success = removeFolderWithallFile(children[i]); 
    			 if (!success) { return false; } 
    			 }
    		 } // either file or an empty directory 
    	   
    	    return dir.delete();
	}






	@Override
	public byte[] zipFiles(File directory, String[] files) throws IOException {
		
	        ByteArrayOutputStream baos = new ByteArrayOutputStream();
	        ZipOutputStream zos = new ZipOutputStream(baos);
	        byte bytes[] = new byte[4096];
	        
	       
	        
	        
	        for (String fileName : files) {
	        	
	            try (FileInputStream fis = new FileInputStream(directory.getPath()
	                    + "/" + fileName);
	                   
	                    BufferedInputStream bis = new BufferedInputStream(fis)) {
	               
	                zos.putNextEntry(new ZipEntry(fileName));
	               
	                int bytesRead;
	                while ((bytesRead = bis.read(bytes)) != -1) {
	                    zos.write(bytes, 0, bytesRead);
	                   
	                }
	                zos.closeEntry();
	            }
	        }
	    
	        zos.flush();
	        baos.flush();
	        zos.close();
	        baos.close();
	       
	        return baos.toByteArray();
	    }
   
   
}







