package com.linkportal.datamodel;

public class AirLineNameCode {
	
	private String airlinename;
	private String airlineiatacode;
	private String airlineiceaocode;
	
	
	
	
	public AirLineNameCode(String airlinename, String airlineiatacode, String airlineiceaocode) {
		super();
		this.airlinename = airlinename;
		this.airlineiatacode = airlineiatacode;
		this.airlineiceaocode = airlineiceaocode;
	}
	
	
	
	
	
	public String getAirlinename() {
		return airlinename;
	}
	
	
	public void setAirlinename(String airlinename) {
		this.airlinename = airlinename;
	}
	
	
	public String getAirlineiatacode() {
		return airlineiatacode;
	}
	
	
	public void setAirlineiatacode(String airlineiatacode) {
		this.airlineiatacode = airlineiatacode;
	}
	
	
	public String getAirlineiceaocode() {
		return airlineiceaocode;
	}
	
	
	public void setAirlineiceaocode(String airlineiceaocode) {
		this.airlineiceaocode = airlineiceaocode;
	}





	@Override
	public String toString() {
		return "AirLineNameCode [airlinename=" + airlinename + ", airlineiatacode=" + airlineiatacode
				+ ", airlineiceaocode=" + airlineiceaocode + "]";
	}
    
	
	
	

}
