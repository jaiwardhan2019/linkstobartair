package com.linkportal.dbripostry;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import javax.sql.DataSource;
import org.apache.log4j.Logger;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.linkportal.controller.HomeController;

@Repository
public class staffTravelUserImp implements staffTravelUser{

	 @Autowired
	 DataSource dataSourcestafftravel;
	 
	 
     	  
	  JdbcTemplate jdbcTemplate;	

	  

	  staffTravelUserImp(DataSource dataSourcestafftravel){ 			
	
		  jdbcTemplate = new JdbcTemplate(dataSourcestafftravel);
	  
	  }
	 
	 
	 

    //---------- Logger Initializer------------------------------- 
	private Logger logger = Logger.getLogger(staffTravelUserImp.class);
	
	

	@Override
	public void updateUserGdprConsent(String emailid) {
		 
		  try {
		 
				   DateTimeFormatter current_date_time = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");
				   LocalDateTime now = LocalDateTime.now();
				   String[] FirstName_LastName=emailid.split("[@._]"); 
				   String sql="SELECT Count(*) FROM stafftravel.account where email='"+emailid+"'";
				   long foundstatus = jdbcTemplate.queryForObject(sql,Long.class);
				   if(foundstatus > 0) {
					   //If found then update the current time
					   jdbcTemplate.execute("UPDATE stafftravel.account SET GDPR_CONSENT_DATE_TIME='"+now+"', GDPR_CONSENT='Y' WHERE email='"+emailid+"'");
					   logger.info("User id:=>"+emailid+" Have Confirm Consent FOR GDPR. @:"+now);
				   }
				   else
				   {
					   logger.info("User id:=>"+emailid+" is Not Setup With the Staff Travel.");
					   //Here you can write email to the admin Informing that User Id is not setup with the Staff Travel
				   }
		
		   
		  } catch(Exception sq){ logger.error("Error While Updating GDPR Consent to Staff Travel"+sq.toString());}
		   
		 		
	       

		  }// End of function 

		  
	} //  End of  Class 
