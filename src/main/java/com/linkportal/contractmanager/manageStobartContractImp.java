package com.linkportal.contractmanager;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
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
		   String sqlListContract="SELECT * FROM CORPORATE_PORTAL.CONTRACT_MASTER  order by department";
		   
		   if(!dept.equals("ALL")){
			   sqlListContract="SELECT * FROM CORPORATE_PORTAL.CONTRACT_MASTER  where department='"+dept+"' order by department";
			   if(!subdept.equals("ALL")){
				   sqlListContract="SELECT * FROM CORPORATE_PORTAL.CONTRACT_MASTER  where department='"+dept+"' and sub_department='"+subdept+"'  order by department";
				   
			   }
			   
		   }
		   
		   System.out.println(sqlListContract);
		   
		   List  Contract = jdbcTemplateRefis.query(sqlListContract,new stobartContractRowmapper());
		
		return Contract;
	}
	
	
	
	
	
	
	
	
	
	
    //--------- THIS FUNCTION WILL ADD CONTRACT DETAIL INTO THE DATABASE -----------
	@Override
	public int addNewContract(HttpServletRequest req) {
		
		   DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");
		   LocalDateTime currentdateandtime = LocalDateTime.now();
	
		
		   String insertQuery="INSERT INTO  CORPORATE_PORTAL.CONTRACT_MASTER (department ,sub_department , contractor_name, contractor_contact_detail,"
		   		  + " refrence_no,description,status,start_date,end_date,entered_by_email)"
				  
		   		  +"VALUES ('"+req.getParameter("department")+"','"+req.getParameter("subdepartment")+"','"+req.getParameter("ccompany")+"'"
				  + ",'"+req.getParameter("ccontract")+"','"+req.getParameter("refno")+"','"+req.getParameter("cdescription")+"', "
				  		+ "'Active','"+req.getParameter("startDate")+"','"+req.getParameter("endDate")+"'"
				  				+ ",'"+req.getParameter("emailid")+"')";
		   
		  
		   int stats=jdbcTemplateRefis.update(insertQuery);		
		   
		  
		return stats;
	}

	
	
	
	
	
	
	@Override
	public int updateNewContract() {
		// TODO Auto-generated method stub
		return 0;
	}

	
	
	@Override
	public int removeContract() {
		// TODO Auto-generated method stub
		return 0;
	}





}
