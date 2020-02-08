package com.linkportal.groundops;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

import org.apache.commons.codec.binary.Base64;

import javax.servlet.http.HttpServletRequest;
import javax.sql.DataSource;

import org.apache.commons.codec.binary.Base64;
import org.apache.log4j.Logger;
import org.apache.poi.util.Beta;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.linkportal.contractmanager.stobartContractRowmapper;


@Transactional
@Repository
public class manageRefisUserImp implements manageRefisUser  {

	 
	@Autowired
	 DataSource dataSourcesqlservercp;
	  

	 JdbcTemplate jdbcTemplateRefis;	


		
		
		
	    manageRefisUserImp(DataSource dataSourcesqlservercp) {			
	    	jdbcTemplateRefis = new JdbcTemplate(dataSourcesqlservercp);			
		}

	    
	    //---------- Logger Initializer------------------------------- 
	    private Logger logger = Logger.getLogger(manageRefisUserImp.class);

	
	 
	
	
	
	
	
	
    
	//---------- will show all Staff Travel users from the data base 
	@Override
	public List<refisUsers> showRefisUser() {			
		   String sqlListRefis="SELECT * FROM link_user_master where internal_external_user='E'  order by first_name";			
		   List  refisUsers = jdbcTemplateRefis.query(sqlListRefis,new refisUsersRowmapper());			   
		return refisUsers;
	}
	
	
	
	
	@Override
	public List<refisUsers> searchRefisUser(String name) {
		
		   String sqlListRefis="SELECT * FROM link_user_master where internal_external_user='E' and first_name like '%"+name+"%' order by first_name";
		   List  refisUsers = jdbcTemplateRefis.query(sqlListRefis,new refisUsersRowmapper());			   

		return refisUsers;
	}

	
	
	
	@Override	
	@Transactional(rollbackFor=Exception.class,propagation= Propagation.REQUIRES_NEW)
	public int removeRefisUser_FromDb(String emailid) {
		   int status=1;	
		   
		   try {				   
				
			   
			   //jdbcTemplateRefis.execute("SET FOREIGN_KEY_CHECKS=0");
	           
		       status = jdbcTemplateRefis.update("DELETE FROM  link_user_master WHERE internal_external_user='E' and email_id='"+emailid+"'");
		       status = jdbcTemplateRefis.update("DELETE FROM link_user_profile_list WHERE user_email='"+emailid+"'");
			   //** NEED TO REMOVE AIRLINE AND AIRPORT LIST ATTACHED WITH THIS USER AS WELL   
		       
		       
			   //jdbcTemplateRefis.execute("SET FOREIGN_KEY_CHECKS=1");
		  
		   
		   }catch(Exception exp) {
			   logger.error(exp);
			   System.out.println(exp.toString());   
		   
		   }
		
		   return status;
	
	}




	@Override
	public refisUsers viewGopsUserDetail(String username) {		
		   String viewsql="SELECT * FROM link_user_master where internal_external_user='E' and first_name=?";
		   //System.out.println(viewsql);
		   return jdbcTemplateRefis.queryForObject(viewsql, new Object[]{username}, new refisUsersRowmapper());	
	}


	


	@Override
	public int updateGopsUserDetail(HttpServletRequest req) {
		   String viewsql="SELECT * FROM link_user_master where internal_external_user='E' and first_name=?";
		   //System.out.println(viewsql);
		   
		   try {
				  
			   DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");
			   LocalDateTime currentdateandtime = LocalDateTime.now();		   
			   Connection conn= dataSourcesqlservercp.getConnection();		   
		
			   
			   
			   String SQL_UPDATE = "UPDATE link_user_master SET first_name=? , email_id=? , active_status=? , gh_password=? , gops_user_creation_date=? "
				   		+ " WHERE first_name=?";
			 
			   
			   
			   
				   PreparedStatement pstm = conn.prepareStatement(SQL_UPDATE);
					   pstm.setString(1,req.getParameter("userid"));					  	  
					   pstm.setString(2,req.getParameter("useremail"));
					   pstm.setString(3,req.getParameter("status"));
					   pstm.setString(4,Base64.encodeBase64(req.getParameter("userpassword").getBytes()).toString());
					   pstm.setString(5,currentdateandtime.toString());
					   pstm.setString(6,req.getParameter("userid").trim());		
				   int rows = pstm.executeUpdate();
				   pstm = null;
				   conn.close();
			   
			   }catch(Exception ex) {logger.error("While Updating Ground OPS USER :"+ex.toString()); return 0;}	
				
		   
		   
		   return 1;	
		
	}

}
