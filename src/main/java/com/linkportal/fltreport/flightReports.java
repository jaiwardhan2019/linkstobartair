package com.linkportal.fltreport;

import java.io.IOException;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.Dictionary;
import java.util.HashMap;
import java.util.List;

import com.linkportal.datamodel.fligthSectorLog;


public interface flightReports {
	
	String Populate_Operational_Airport(String airportcode, String useremail) throws Exception;

	String Populate_Operational_Airline(String airlinecode, String useremail) throws Exception;

	String Populate_Operational_AirlineReg(String airlinecode, String useremail) throws Exception;
	
	
	//-------- For May Fly Report -------------------
    List Populate_MayFly_Report_body(String airline, String airport, String shortby, String date, int no, String emailid);
    List Populate_MayFly_Report_body(String airline, String airport, String shortby, String date, String emailid);
	
	
	//-------- For Reliablity Report body Report -------------------
    List Populate_Reliablity_Report_body(String airline, String airport,
                                         String startDate, String endDate, String tolerance, String delayCodeGroupCode) throws Exception;
	
    
	
	//-------- For Reliablity Report body FOR CANCLE FLIGHT  -------------------
    List Populate_Reliablity_Report_body_Cancle_Flights(String airline, String airport,
                                                        String startDate, String endDate, String tolerance) throws Exception;
	

	
	
	//-------- GOPS REFIS - FLIGHT REPORT -------------------
    List PopulateFlightReport(String airline, String airport, String shortby, String date, String flightno, String emailid);
	
    List PopulateDelayFlightReport(String airline, String airport, String fdate, String tdate, String flightno, String emailid);
	
    List PopulateOnTimePerformanceReport(String airline, String airport, String fdate, String tdate, String delaycodegroup, String emailid);

	
	
	
	
	
	
	

	
	//-------- For Daily Summary Report -------------------	
	
    List<String> Populate_Flybe_FligtList(String Airline, String Operation, String dateofoperation);
    
	String CompletionKPI_Pax_KPI(String Airline, String Operation, String dateofoperation)throws Exception;
	
	HashMap<String, Integer> PunctualityTargetPerCent(String Airline, String Operation, String dateofoperation);
	
	String PunctualityStatistics(String Airline, String Operation, String dateofoperation)throws Exception;
	
	String  NoOfDepartureDelaysByIATADelayCodeCategory(String Airline, String Operation, String dateofoperation);
	
	List<String> getNarrativeSummaryofRootDelays(String Airline, String Operation, String dateofoperation);
	
	String getSummaryofCancelledFlights(String Airline, String Operation, String dateofoperation)throws Exception;

	

}
