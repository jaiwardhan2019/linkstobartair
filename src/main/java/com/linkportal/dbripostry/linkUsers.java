package com.linkportal.dbripostry;

import java.util.List;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.Map;

import com.linkportal.datamodel.Users;

public interface linkUsers {
	
	   public void updateUser_detail_LastLoginDateTime(String useremail);
	   
	   public Map getUser_Profile_List_From_DataBase(String useremail);
	   
	   public List getLinkUserListFromDatabase(String username);
	  
	   public Users getLinkUserDetails(String emailid);	

	   public  String[] getUserpProfileAndLinkProfile(String emailid);
	   
	   
         
	   public  void UpdateUserpProfileAndActiveStatustoDataBase(String emailid,String activestatus,String adminstatus);
	   
	   public  void UpdateLinkProfiletoDataBase(String emailid,String activestatus,String adminstatus, List alllinkprof);
	   
	   public  void RemoveUserpProfileAndLinkProfiletoDataBase(String emailid,List alllinkprof);
		
	   
	
	   
	   
}// End of class
