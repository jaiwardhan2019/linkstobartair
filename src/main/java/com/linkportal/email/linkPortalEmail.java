package com.linkportal.email;

public interface linkPortalEmail {


	/*  
	* https://www.journaldev.com/2532/javamail-example-send-mail-in-java-smtp#javamail-example-8211-send-mail-in-java-with-attachment
	* Note :  If you want send email without attachment then pass null as a value at the end on variable attachment
	*         For the attached file you need to provide full path of the file as a String.	
	*/
	void sendTextHtmlEmail(String to, String Subject, String emailbody);
	
	
	/*
	 * Signature of Email with attachment
	 * sendTextHtmlEmailWithAttachment(FromEmail, emailSubject ,emailBody ,"c://data//groundops//alfresco//Company Policies//Email Policy.pdf");
	 * 
	 * */
	void sendTextHtmlEmailWithAttachment(String to, String Subject, String emailbody, String attachment);
	
	
	
	/*
	 * This one is will send email based on the templet stored in the resources/templets/email-templet.ftl
	 * this is also going to add Image file as per defined in the templet file. 
	 * */
	void sendHtmlEmailOnTemplate(String to, String flightInfo, String emailbody);
	
	
	
	
	
	
	
	   
}
