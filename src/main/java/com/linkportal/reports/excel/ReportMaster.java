package com.linkportal.reports.excel;

import java.io.IOException;
import java.text.ParseException;

import javax.servlet.http.HttpServletResponse;

public interface ReportMaster {
	

    //----------- This Will Generate Excel Report --------------------------------------	
	public int Populate_Reliablity_Report_ExcelFormat(String airline,String airport,
			String startDate,String endDate,String tolerance ,String delayCodeGroupCode , String useremai) throws  IOException, ParseException, Exception ;
	
		

}
