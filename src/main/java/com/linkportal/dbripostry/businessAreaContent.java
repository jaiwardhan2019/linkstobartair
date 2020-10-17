package com.linkportal.dbripostry;

public interface businessAreaContent {

	   String Show_Content(int bcid);
	   boolean Update_Content(String content, int bcid, String emailid);
	   void  Remove_Content(String bcid);
	   void  Add_Content(String bcid);
	   
}
