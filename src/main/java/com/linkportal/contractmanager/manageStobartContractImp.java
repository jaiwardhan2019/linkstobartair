package com.linkportal.contractmanager;

import java.io.File;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.linkportal.refis.refisUsersRowmapper;

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
	public int updateNewContract(String crefrno) {
		   
		   System.out.println("Write Sql Query for update ");
		
		return 0;
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






}
