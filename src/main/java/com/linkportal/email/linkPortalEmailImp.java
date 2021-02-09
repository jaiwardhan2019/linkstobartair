/*
   https://www.journaldev.com/2532/javamail-example-send-mail-in-java-smtp
   https://www.codejava.net/java-ee/javamail/send-e-mail-in-html-format-using-javamail-api   <<--- HTML EMIAL 
   https://www.codejava.net/java-ee/javamail/send-e-mail-with-attachment-in-java         <<-- HTML EMIAL WITH ATTACHMENT 
*/

package com.linkportal.email;

import java.io.IOException;

import java.util.*;
import javax.mail.*;
import javax.mail.internet.*;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Repository;





@Repository
public class linkPortalEmailImp extends emailServiceUtility implements linkPortalEmail{
	
	
	@Value("${mail.From}") String emailFrom;
	
	private static final Logger LOGGER = Logger.getLogger(linkPortalEmailImp.class);	
    
  
	
	@Override
	public void sendTextHtmlEmail(String mailTo, String Subject, String emailbody) {

		try {

			Message msg = new MimeMessage(createSession());
			msg.setFrom(new InternetAddress(emailFrom));
			msg.addRecipients(Message.RecipientType.BCC, InternetAddress.parse(mailTo));
			msg.setSubject(Subject);
			msg.setSentDate(new Date());
			msg.setContent(emailbody, "text/html");

			// Sends the e-mail
			Transport.send(msg);

		} catch (Exception e) {
			System.out.println(e);
			LOGGER.error("Error in sendTextEmail function:" + e.toString());
			LOGGER.info(e.toString());
		}

	}// -------- END OF METHOD -------------
	
	
	@Override
	public void sendTextHtmlEmailWithAttachment(String emailTo, String Subject, String emailbody, String attachment) {
		try {

			Message msg = new MimeMessage(createSession());
			msg.setFrom(new InternetAddress(emailFrom));
			msg.addRecipients(Message.RecipientType.BCC, InternetAddress.parse(emailTo));
			msg.setSubject(Subject);
			msg.setSentDate(new Date());
			msg.setContent(attachFileWithMessage(emailbody, attachment, msg));

			// Sends the e-mail
			Transport.send(msg);

		} catch (Exception e) {
			LOGGER.error("Error in sendTextEmail function:" + e.toString());
			LOGGER.info(e.toString());
		}

	}

	@Override
	public void sendHtmlEmailOnTemplate(String EmailTo, String flightInfostr, String emailbody) {
		try {

			Mail mail = new Mail();
			mail.setFrom(emailFrom);
			mail.setTo(EmailTo);
			mail.setSubject("Update on Flight No: "+flightInfostr);
	

			Map model = new HashMap();
			model.put("flightDetail", flightInfostr);
			model.put("flightComment", emailbody);
			
			mail.setModel(model);
			sendSimpleMessageWithHtmlTemplet(mail);

		} catch (Exception e) {			
			LOGGER.error("Error in sendTextEmail function:" + e.toString());		
		}

	}
	
	
	
	
	
	
	
}
