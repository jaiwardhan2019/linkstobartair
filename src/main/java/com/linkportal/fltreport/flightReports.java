package com.linkportal.fltreport;

import java.io.IOException;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.Dictionary;
import java.util.HashMap;
import java.util.List;

import com.linkportal.datamodel.fligthSectorLog;


public interface flightReports {
	
	public String Populate_Operational_Airport(String airportcode) throws Exception;	
	public String Populate_Operational_Airline(String airlinecode) throws Exception;
	
	
	//-------- For May Fly Report -------------------
    public List Populate_MayFly_Report_body(String airline, String airport, String shortby , String date, int no);
    public List Populate_MayFly_Report_body(String airline, String airport, String shortby , String date);
	
	
	//-------- For Reliablity Report body Report -------------------
	public List Populate_Reliablity_Report_body(String airline,String airport,
			String startDate,String endDate,String tolerance ,String delayCodeGroupCode) throws Exception;
	
    
	
	//-------- For Reliablity Report body FOR CANCLE FLIGHT  -------------------
	public List Populate_Reliablity_Report_body_Cancle_Flights(String airline,String airport,
			String startDate,String endDate,String tolerance) throws Exception;
	

	
	

	
	//-------- For Daily Summary Report -------------------	
	
    public List<String> Populate_Flybe_FligtList(String Airline, String Operation,String dateofoperation);
    
	public String CompletionKPI_Pax_KPI(String Airline, String Operation, String dateofoperation)throws Exception;
	
	public  HashMap<String, Integer> PunctualityTargetPerCent(String Airline, String Operation, String dateofoperation);
	
	public String PunctualityStatistics(String Airline, String Operation, String dateofoperation)throws Exception;	
	
	public String  NoOfDepartureDelaysByIATADelayCodeCategory(String Airline, String Operation, String dateofoperation);	
	
	public List<String> getNarrativeSummaryofRootDelays(String Airline, String Operation, String dateofoperation);
	
	public String getSummaryofCancelledFlights(String Airline, String Operation, String dateofoperation)throws Exception;

	

}
