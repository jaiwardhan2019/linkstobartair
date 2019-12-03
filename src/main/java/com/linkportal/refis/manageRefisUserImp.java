package com.linkportal.refis;

import java.util.List;

import javax.sql.DataSource;

import org.apache.log4j.Logger;
import org.apache.poi.util.Beta;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import org.springframework.transaction.annotation.Transactional;



@Repository
public class manageRefisUserImp implements manageRefisUser  {

	 
	@Autowired
	 DataSource dataSourceopswebsys;
	  

	 JdbcTemplate jdbcTemplateRefis;	


		
		
		
	    manageRefisUserImp(DataSource dataSourceopswebsys) {			
	    	jdbcTemplateRefis = new JdbcTemplate(dataSourceopswebsys);			
		}

	    
	    //---------- Logger Initializer------------------------------- 
	    private Logger logger = Logger.getLogger(manageRefisUserImp.class);

	
	 
	
	
	
	
	
	
    
	//---------- will show all Staff Travel users from the data base 
	@Override
	public List<refisUsers> showRefisUser() {			
		   String sqlListRefis="SELECT * FROM ops_web_sys.gops_user  order by username";			
		   List  refisUsers = jdbcTemplateRefis.query(sqlListRefis,new refisUsersRowmapper());			   
		return refisUsers;
	}
	
	
	
	
	@Override
	public List<refisUsers> searchRefisUser(String name) {
		
		   String sqlListRefis="SELECT * FROM ops_web_sys.gops_user   where username like '%"+name+"%' order by username";
		   List  refisUsers = jdbcTemplateRefis.query(sqlListRefis,new refisUsersRowmapper());			   

		return refisUsers;
	}

	
	
	
	@Override
	public int removeRefisUser_FromDb(int accountid) {
		// TODO Auto-generated method stub
		return 0;
	}

}
