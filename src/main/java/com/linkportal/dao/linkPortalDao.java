package com.linkportal.dao;

/*
 * This Class File Contain all SQL required for this entire project
 * 
 */

public class linkPortalDao {
	
	
	public String findCrewConnexUserInitialPassword(String emailid) {
		   String[] FirstName_LastName=emailid.split("[@._]"); 
		   String sql  = "select Initials, WebPassword  from CrewMember where  Namefirst like UPPER('"+FirstName_LastName[0].trim()+"%')  and Namelast like UPPER('"+FirstName_LastName[1].trim()+"')";
		  return sql;
	}// End of String function 
	
	
	public String findStobartairExternalUser(String userid , String password) {
		   String sql  = "select * from ";
		   return sql;
	}// End of String function 
	
	
	
	public String updateGdprConsentToStaffTravleDb(String userid , String password) {
		   String sql  = "Update * from ";
		   return sql;
	}// End of String function 
	
		
	
	
	
	
}
