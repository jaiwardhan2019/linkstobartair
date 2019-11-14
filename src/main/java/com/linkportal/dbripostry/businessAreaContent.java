package com.linkportal.dbripostry;

public interface businessAreaContent {

	   public String Show_Content(int bcid);
	   public int Update_Content(String content, int bcid,String emailid);
	   public void  Remove_Content(String bcid);
	   public void  Add_Content(String bcid);
	   
}
