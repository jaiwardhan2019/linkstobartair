package com.linkportal.email;

public interface linkPortalEmail {

	   void sendTextHtmlEmail(String hostserver, String from, String to, String Subject, String emailbody, String attachment);
	
}
