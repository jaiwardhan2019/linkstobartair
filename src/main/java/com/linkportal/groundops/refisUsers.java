package com.linkportal.groundops;

import org.apache.commons.codec.binary.Base64;



public class refisUsers {
	

	   private String username;
	   private String password;
	   private String description;
	   private String email;
	   private String enabled;
	   
		   
	   public refisUsers(String username, String password, String description, String email, String enabled) {
			super();
			this.username = username;
			this.password = password;
			this.description = description;
			this.email = email;
			this.enabled = enabled;
	   }


	public String getUsername() {
		return username;
	}


	public void setUsername(String username) {
		this.username = username;
	}


	public String getPassword() {
		return password;
	}


	public void setPassword(String password) {
		this.password = password;
	}


	public String getDescription() {
		return description;
	}


	public void setDescription(String description) {
		this.description = description;
	}


	public String getEmail() {
		return email;
	}


	public void setEmail(String email) {
		this.email = email;
	}


	public String getEnabled() {
		return enabled;
	}


	public void setEnabled(String enabled) {
		this.enabled = enabled;
	}
	   
	 
	public String getPasswordDecodeBase64() {
		if (this.password != null){
			return new String(Base64.decodeBase64(password.getBytes()));
		} else {
			return null;
		}
	}
	
		   

	public void setPasswordDecodeBase64(String comments) {
		if (comments != null) {
			this.password = new String(Base64.encodeBase64(comments.getBytes()));
		} else {
			this.password = null;
		}
	}
	   
	   
	
		
		   
	

}
