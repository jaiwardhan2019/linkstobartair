package com.linkportal.datamodel;

import org.springframework.context.annotation.Scope;
import org.springframework.web.context.WebApplicationContext;

//----- WILL BE USE FOR THE BUSINESS AREA DATA MANAGEMENT-------------------

@Scope(WebApplicationContext.SCOPE_REQUEST)
public class businessAreaData {
	
	private String content_header;
	private String content_text;
	private String users;
	
	
	public businessAreaData(String content_header,String content_text,String users) {
		   
		   this.content_header= content_header;
		   this.content_text  = content_text;
		   this.users         = users;
	}
	
	
	public String getContent_header(){return content_header;}
	public String getContent_text()  {return content_text;}
	public String getUsers()         {return users;}
	
	

} //---------------- End of  Class 
