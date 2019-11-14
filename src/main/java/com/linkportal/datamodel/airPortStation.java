package com.linkportal.datamodel;

import java.util.Date;

import org.springframework.context.annotation.Scope;
import org.springframework.web.context.WebApplicationContext;

@Scope(WebApplicationContext.SCOPE_REQUEST)
public class airPortStation {
	
		private String airportcode;
		private String airportname;
	    
		public String getAirportcode() {
	        return airportcode;
	    }

	    public String getAirportname() {
	        return airportname;
	    }

	    public void setAirportcode(String airportcode) {
	        this.airportcode = airportcode;
	    }

	    public void setAirportname(String airportname) {
	        this.airportname = airportname;
	    }
}//---------- End of Class file   