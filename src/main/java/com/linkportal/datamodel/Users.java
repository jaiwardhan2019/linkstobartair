package com.linkportal.datamodel;

import java.io.Serializable;

import org.springframework.context.annotation.Scope;
import org.springframework.web.context.WebApplicationContext;

@Scope(WebApplicationContext.SCOPE_REQUEST)
public class Users implements Serializable {
	

	private String  firstName;
	private String  lastName;
	private String  emailId;
	private String  activeStatus;
	private String  adminStatus;
	private String  lastLoginDateTime;
	private String  stobart_external_user;
	
	
	public Users(String firstName, String lastName, String emailId,String  activeStatus, String adminStatus, String lastLoginDateTime, String stobart_external_user) {
		super();
		this.firstName = firstName;
		this.lastName = lastName;
		this.emailId = emailId;
		this.activeStatus=activeStatus;
		this.adminStatus = adminStatus;
		this.lastLoginDateTime = lastLoginDateTime;
		this.stobart_external_user=stobart_external_user;
	}

  
	public String getFirstName() {
		return firstName;
	}


	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}


	public String getLastName() {
		return lastName;
	}


	public void setLastName(String lastName) {
		this.lastName = lastName;
	}


	public String getEmailId() {
		return emailId;
	}


	public void setEmailId(String emailId) {
		this.emailId = emailId;
	}

	public String getActiveStatus() {
		return activeStatus;
	}


	public void setActiveStatus(String activeStatus) {
		this.activeStatus = activeStatus;
	}
	

	public String getAdminStatus() {
		return adminStatus;
	}


	public void setAdminStatus(String adminStatus) {
		this.adminStatus = adminStatus;
	}


	public String getLastLoginDateTime() {
		return lastLoginDateTime;
	}


	public void setLastLoginDateTime(String lastLoginDateTime) {
		this.lastLoginDateTime = lastLoginDateTime;
	}


	public String getStobart_external_user() {
		return stobart_external_user;
	}


	public void setStobart_external_user(String stobart_external_user) {
		this.stobart_external_user = stobart_external_user;
	}

	
	

	@Override
	public String toString() {
		return "Users [firstName=" + firstName + ", lastName=" + lastName + ", emailId=" + emailId + ", activeStatus="
				+ activeStatus + ", adminStatus=" + adminStatus + ", lastLoginDateTime=" + lastLoginDateTime
				+ ", stobart_external_user=" + stobart_external_user + "]";
	}


	
	
	
	

	
	
	

}
