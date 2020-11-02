package com.linkportal.reports.excel;

import java.io.IOException;
import java.text.ParseException;

import javax.servlet.http.HttpServletResponse;

public interface ReportMaster {

	// ----------- This Will Generate Excel Report
	// --------------------------------------
	int Populate_Reliablity_Report_ExcelFormat(String airline, String airport, String startDate, String endDate,
			String tolerance, String delayCodeGroupCode, String useremai) throws Exception;
	

	// ----------- This Will Generate Excel Report For Delay Flights
	// --------------------------------------
	int Populate_Delay_Report_ExcelFormat(String airline, String airport, String Startflightdate, String Endflightdate,
			String emailid) throws Exception;

	
	// ------- This will Generate On Time Performance Report for Flights
	int Populate_On_Time_Performance_Report_ExcelFormat(String airline, String airport, String Startflightdate,
			String Endflightdate, String emailid, String DelayCodeList) throws Exception;

}
