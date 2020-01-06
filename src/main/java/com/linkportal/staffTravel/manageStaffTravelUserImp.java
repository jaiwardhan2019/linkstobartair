package com.linkportal.staffTravel;

import java.util.List;

import javax.sql.DataSource;

import org.apache.log4j.Logger;
import org.apache.poi.util.Beta;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.EnableTransactionManagement;
import org.springframework.transaction.annotation.Transactional;







@Repository
public class manageStaffTravelUserImp implements manageStaffTravelUser {

	   
		@Autowired
		 DataSource dataSourcestafftravel;
		  
  
		JdbcTemplate jdbcTemplateStaff;	

	
		
		
		
	    manageStaffTravelUserImp(DataSource dataSourcestafftravel) {			
	    	 jdbcTemplateStaff = new JdbcTemplate(dataSourcestafftravel);			
		}

	    
	    //---------- Logger Initializer------------------------------- 
	    private Logger logger = Logger.getLogger(manageStaffTravelUserImp.class);

	
	    
	    
	    
	    
	    
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



		@Override	
		@Transactional
		public int removeStaff_FromDb(int accountid) {
			   
			 int status=1;	
	           
			   try {				   
		
			   jdbcTemplateStaff.execute("SET FOREIGN_KEY_CHECKS=0");
				   
			       /*
			       status = jdbcTemplateStaff.update("DELETE FROM stafftravel.account WHERE id="+accountid);
				   */
			   
			       //----- TO Remove Relatives from the list  
			       status = jdbcTemplateStaff.update("DELETE FROM stafftravel.eligible_passenger where eligible_passenger_list_id in(1416,1710,1416,1710)"); 
				   //status = jdbcTemplateStaff.update("DELETE FROM stafftravel.eligible_passenger_list where id=1308"); 
			       
			       /*
				   status = jdbcTemplateStaff.update("DELETE FROM stafftravel.passport_information where apis_information_id="+accountid);
				   status = jdbcTemplateStaff.update("DELETE FROM stafftravel.travel_request where account_id="+accountid);
				   status = jdbcTemplateStaff.update("DELETE FROM stafftravel.travel_request_eligible_passenger where eligible_passenger_id="+accountid);
				   status = jdbcTemplateStaff.update("DELETE FROM stafftravel.apis_information where id="+accountid);
				   status = jdbcTemplateStaff.update("DELETE FROM stafftravel.travel_request_eligible_passenger where travel_request_passengers_travelling_id="+accountid);			   
                 */
				   
			   jdbcTemplateStaff.execute("SET FOREIGN_KEY_CHECKS=1");
			  
			   
			   }catch(Exception exp) {logger.error(exp);}
			
			   return status;
			   
		}//------- End Of Method removeStaff_FromDb
	

}
