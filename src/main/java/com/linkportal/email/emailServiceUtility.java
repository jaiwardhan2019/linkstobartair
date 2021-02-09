package com.linkportal.email;

import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.ClassPathResource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.ui.freemarker.FreeMarkerTemplateUtils;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.Session;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;

import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.util.Properties;



//https://memorynotfound.com/spring-mail-sending-email-freemarker-html-template-example/
public abstract class emailServiceUtility {
	
	
	@Value("${mail.host}") String emailHostServer;
	
	
	@Autowired
	private JavaMailSender emailSender;

	@Autowired
	private Configuration freemarkerConfig;
	
	
	private static final Logger LOGGER = Logger.getLogger(emailServiceUtility.class);	
	
	
	
	
	
	public void sendSimpleMessageWithHtmlTemplet(Mail mail) throws MessagingException, IOException, TemplateException {
		
		MimeMessage message = emailSender.createMimeMessage();
		MimeMessageHelper helper = new MimeMessageHelper(message, MimeMessageHelper.MULTIPART_MODE_MIXED_RELATED,
				StandardCharsets.UTF_8.name());

		//helper.addAttachment("logo.png", new ClassPathResource("static/images/emaillogo.png"));
	
		Template t = freemarkerConfig.getTemplate("delayflightreportnotification.ftl");
		String html = FreeMarkerTemplateUtils.processTemplateIntoString(t, mail.getModel());

		helper.setBcc(builtEmailIdArray(mail.getTo()));		
		helper.setText(html, true);
		helper.setSubject(mail.getSubject());
		helper.setFrom(mail.getFrom());

		emailSender.send(message);
	}
	 
	
	

	protected Session createSession() {
		Session session = null;
		// sets SMTP server properties
		Properties properties = new Properties();
		properties.put("mail.smtp.host", emailHostServer);
		// properties.put("mail.smtp.port", port);
		// properties.put("mail.smtp.auth", "true");
		// properties.put("mail.smtp.starttls.enable", "true");
		session = Session.getInstance(properties);
		session.setDebug(true);
		return session;
	}

	
	
	
	
	protected Multipart attachFileWithMessage(String emailbody, String fileToAttachedWithFullPath, Message msg)
			throws MessagingException {
		Multipart multipart = new MimeMultipart();
		try {
			// --- THIS PART FOR THE FILE ATTACHMENT ----
			MimeBodyPart messageBodyPart = new MimeBodyPart();
			messageBodyPart.setContent(emailbody, "text/html");
			multipart.addBodyPart(messageBodyPart);
			MimeBodyPart attachPart = new MimeBodyPart();
			attachPart.attachFile(fileToAttachedWithFullPath);
			multipart.addBodyPart(attachPart);
			msg.setContent(multipart);

		} catch (IOException ex) {
			LOGGER.error("Error While Doing Email Attachment " + ex.toString());
		}

		return multipart;

	} // End of Method
    
	
	
	
	public String[] builtEmailIdArray(String emailListWithComma) {
		String[] emailIds = emailListWithComma.split(",");
		return emailIds;
	}
	

}
