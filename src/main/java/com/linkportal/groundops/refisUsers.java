package com.linkportal.groundops;

import org.springframework.stereotype.Service;

import com.linkportal.security.EncryptDecrypt;


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
		this.password =password;
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

	

	@Override
	public String toString() {
		return "refisUsers [username=" + username + ", password=" + password + ", description=" + description
				+ ", email=" + email + ", enabled=" + enabled + "]";
	}
	   

		   
	

}
