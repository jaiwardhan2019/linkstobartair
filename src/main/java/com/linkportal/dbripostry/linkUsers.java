package com.linkportal.dbripostry;

import java.util.List;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.Map;

import com.linkportal.datamodel.Users;

public interface linkUsers {
	
	   void updateUser_detail_LastLoginDateTime(String useremail);
	   
	   //Map getUser_Profile_List_From_DataBase(String useremail);
	   String getUser_Profile_List_From_DataBase(String useremail , String passWord);
	   
	   List getLinkUserListFromDatabase(String username);
	  
	   Users getLinkUserDetails(String emailid);

	   String[] getUserpProfileAndLinkProfile(String emailid);
	   
	   String[] getUserpProfileandAllgroundopsProfile(String emailid);
	   
	   
	   
	   
	   boolean Validate_External_User(String username, String password);
	   
         
	   void UpdateUserpProfileAndActiveStatustoDataBase(String emailid, String activestatus, String adminstatus);
	   
	   void UpdateLinkProfiletoDataBase(String emailid, List alllinkprof);
	   
	   void RemoveUserpProfileAndLinkProfiletoDataBase(String emailid, List alllinkprof);
	   
	   

	   
	   void  UpdateGopsProfiletoDataBase(String emailid, List alllinkprof);
	   
	
	   
	   
}// End of class
