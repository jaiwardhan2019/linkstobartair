package com.linkportal.graphreport;

import java.sql.SQLException;

public interface piechart {
	
	String createBarchartForHomePage() throws Exception;
	
	String createPieChart(String airline, String airportcode, String startdate, String enddate, String tolrance) throws Exception;
	
	String createPieChart_For_Flight_Report(String airline, String airportcode, String datop, String emailid) throws Exception;
	
	String createPieChart_For_OTP_Flight_Report(String airline, String airportcode, String fromDate, String toDate , String delyCode) throws Exception;


}
