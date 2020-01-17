/*
   https://www.journaldev.com/2532/javamail-example-send-mail-in-java-smtp
   https://www.codejava.net/java-ee/javamail/send-e-mail-in-html-format-using-javamail-api   <<--- HTML EMIAL 
   https://www.codejava.net/java-ee/javamail/send-e-mail-with-attachment-in-java         <<-- HTML EMIAL WITH ATTACHMENT 
*/

package com.linkportal.email;

import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.util.*;
import javax.mail.*;
import javax.mail.internet.*;
import javax.activation.*;

import java.util.Properties;  
import javax.mail.*;  
import javax.mail.internet.*; 


import org.apache.log4j.Logger;
import org.springframework.context.annotation.Bean;
import org.springframework.stereotype.Repository;

import com.linkportal.batchjob.linkBatchJobImp; 


@Repository
public class linkPortalEmailImp implements linkPortalEmail {
	
	private static final Logger LOGGER = Logger.getLogger(linkPortalEmailImp.class);	
    
	
	@Override
	public void sendTextHtmlEmail(String hostserver ,String mailfrom, String mailTo, String Subject, String emailbody, String attachFiles) {
	   	
 	   try{
 		   
 			    
 		  // sets SMTP server properties
 	        Properties properties = new Properties();
 	        properties.put("mail.smtp.host", hostserver);
 	        //properties.put("mail.smtp.port", port);
 	       // properties.put("mail.smtp.auth", "true");
 	       // properties.put("mail.smtp.starttls.enable", "true");
 	 
 	 
 	        Session session = Session.getInstance(properties); 	 
 	        //session.setDebug(true);
 	       
 	        
 	        // creates a new e-mail message
 	        Message msg = new MimeMessage(session);
 	 
 	        msg.setFrom(new InternetAddress(mailfrom));
  	        msg.addRecipients(Message.RecipientType.CC,InternetAddress.parse(mailTo));
 	        msg.setSubject(Subject);
 	        msg.setSentDate(new Date());
 	        msg.setContent(emailbody, "text/html");
 	       
 	       
 	        
 	        
 	        //--- THIS PART FOR THE FILE ATTACHMENT ----
 	       if(attachFiles != null) { 	         
 	          MimeBodyPart messageBodyPart = new MimeBodyPart();
 	 	      messageBodyPart.setContent(emailbody, "text/html");
 	 	      Multipart multipart = new MimeMultipart();
 	          multipart.addBodyPart(messageBodyPart);
 	          MimeBodyPart attachPart = new MimeBodyPart();
 	          try{
 	        	  
	 	           attachPart.attachFile(attachFiles); 	           
	 	           multipart.addBodyPart(attachPart); 	        
	 	           msg.setContent(multipart);
	 	           
 	         }catch (IOException ex) {LOGGER.error("Error While Doing Attachment "+ex.toString());} 	
 	          
 	          
 	          
 	          
 	          

 	       }//--- END OF IF ---
 	        
 	 
 	        // Sends the e-mail
 	        Transport.send(msg);
		        
     	   
        }catch(Exception e) {LOGGER.error("Error in sendTextEmail function:"+e.toString());LOGGER.info(e.toString());}  
 	   
 	
		
	}//-------- END OF METHOD -------------

	
		
		

}
