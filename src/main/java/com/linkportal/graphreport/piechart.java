package com.linkportal.graphreport;

import java.sql.SQLException;

public interface piechart {
	
	public String createBarchartForHomePage() throws Exception;
	public String createPieChart(String airline, String airportcode, String startdate, String enddate , String tolrance) throws Exception;
	public String createPieChart_For_Flight_Report(String airline, String airportcode, String datop, String emailid) throws Exception;


}
