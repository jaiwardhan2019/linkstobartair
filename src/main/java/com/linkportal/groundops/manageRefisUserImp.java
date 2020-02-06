package com.linkportal.groundops;

import java.util.List;

import javax.sql.DataSource;

import org.apache.log4j.Logger;
import org.apache.poi.util.Beta;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;


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
			      
			   //jdbcTemplateRefis.execute("SET FOREIGN_KEY_CHECKS=1");
		  
		   
		   }catch(Exception exp) {
			   logger.error(exp);
			   System.out.println(exp.toString());   
		   
		   }
		
		   return status;
	
	}

}
