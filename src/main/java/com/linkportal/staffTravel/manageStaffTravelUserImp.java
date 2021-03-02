package com.linkportal.staffTravel;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

import javax.sql.DataSource;

import org.apache.log4j.Logger;
import org.apache.poi.util.Beta;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.EnableTransactionManagement;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;







@Transactional
@Repository
public class manageStaffTravelUserImp implements manageStaffTravelUser {

	   
		@Autowired
		 DataSource dataSourcestafftravel;
		  
  
		JdbcTemplate jdbcTemplateStaff;	

	
		
		
		
	    manageStaffTravelUserImp(DataSource dataSourcestafftravel) {			
	    	 jdbcTemplateStaff = new JdbcTemplate(dataSourcestafftravel);			
		}

	    
	    //---------- Logger Initializer------------------------------- 
	    private final Logger logger = Logger.getLogger(manageStaffTravelUserImp.class);

	
	    
	    
	    
	    
	    
		//---------- will show all Staff Travel users from the data base 
		@Override
		public List<staffTravelUsers> showStaffTravelUsers() {			
			   String sqlListStaff="SELECT * FROM stafftravel.account  order by first_name";			
			   List  staffAccount = jdbcTemplateStaff.query(sqlListStaff,new staffTravelUsersRowmapper());			   
			return staffAccount;
		}
	
		
		
	    //---------- Will Search Specific User from the data base 
		@Override
		public List<staffTravelUsers> searchStaffTravelUsers(String name) {
			
			   String sqlListStaff="SELECT * FROM stafftravel.account  where first_name like '"+name+"%' or surname like '"+name+"%' ";
			   //sqlListStaff="SELECT * FROM stafftravel.account  where  status='LEFT'";	
			   List  staffAccount = jdbcTemplateStaff.query(sqlListStaff,new staffTravelUsersRowmapper());			   
			   
			return staffAccount;
	
		}


        //https://dzone.com/articles/bountyspring-transactional-management
		//https://stackoverflow.com/questions/8490852/spring-transactional-isolation-propagation
		
		@Override	
		@Transactional(rollbackFor=Exception.class,propagation= Propagation.REQUIRES_NEW)
		public int removeStaff_FromDb(int accountid,String flname) {
			   
			 int status=1;	
	           
			   try {				   
		
				   
			       jdbcTemplateStaff.execute("SET FOREIGN_KEY_CHECKS=0");			   
			        
		           //delete Passport no 685 <<-- Account detail need to be removed
			       
			       status = jdbcTemplateStaff.update("DELETE FROM  stafftravel.passport_information where passport_name like '%"+flname+"%'");
			       status = jdbcTemplateStaff.update("DELETE FROM stafftravel.account WHERE id="+accountid);
			       status = jdbcTemplateStaff.update("DELETE FROM stafftravel.eligible_passenger where eligible_passenger_list_id in (select id from stafftravel.eligible_passenger_list where account_id="+accountid+")"); 
			       status = jdbcTemplateStaff.update("DELETE FROM stafftravel.eligible_passenger_list where account_id="+accountid);
			       status = jdbcTemplateStaff.update("DELETE FROM stafftravel.apis_information where id in(SELECT id FROM stafftravel.travel_request where account_id="+accountid+")");
			       status = jdbcTemplateStaff.update("DELETE FROM stafftravel.travel_request where account_id="+accountid);				   
				   status = jdbcTemplateStaff.update("DELETE FROM stafftravel.travel_request_eligible_passenger where travel_request_passengers_travelling_id="+accountid);
				   
				   // SELECT * FROM stafftravel.apis_information;  <<--- THis is left 
					   
			   jdbcTemplateStaff.execute("SET FOREIGN_KEY_CHECKS=1");
			  
			   
			   }catch(Exception exp) {
				   logger.error(exp);
				   System.out.println(exp.toString());   
			   
			   }
			
			   return status;
			   
		}//------- End Of Method removeStaff_FromDb
		
		
		

		@Override
		public void updateUserGdprConsent(String emailid) {
			 
			  try {
			 
					   DateTimeFormatter current_date_time = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");
					   LocalDateTime now = LocalDateTime.now();
					   String[] FirstName_LastName=emailid.split("[@._]"); 
					   String sql="SELECT Count(*) FROM stafftravel.account where email='"+emailid+"'";
					   long foundstatus = jdbcTemplateStaff.queryForObject(sql,Long.class);
					   if(foundstatus > 0) {
						   //If found then update the current time
						   jdbcTemplateStaff.execute("UPDATE stafftravel.account SET GDPR_CONSENT_DATE_TIME='"+now+"', GDPR_CONSENT='Y' WHERE email='"+emailid+"'");
						   logger.info("User id:=>"+emailid+" Have Confirm Consent FOR GDPR. @:"+now);
					   }
					   else
					   {
						   logger.info("User id:=>"+emailid+" is Not Setup With the Staff Travel.");
						   //Here you can write email to the admin Informing that User Id is not setup with the Staff Travel
					   }
			
			   
			  } catch(Exception sq){ logger.error("Error While Updating GDPR Consent to Staff Travel"+sq.toString());}
			   
			 		
		       

			  }// End of function 

	

}
