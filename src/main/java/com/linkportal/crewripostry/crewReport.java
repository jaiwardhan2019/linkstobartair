package com.linkportal.crewripostry;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.SQLException;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.http.HttpEntity;
import org.springframework.web.bind.annotation.PathVariable;

import com.linkportal.datamodel.crewDetail;
import com.linkportal.datamodel.fligthSectorLog;


public interface crewReport {

	
	//--------- These all Methods for Voyager Report -------
	public List<crewDetail>  showCrewList(String crewCode , String StartDateop , String endDateop , List<String> rankList );
	
	public List<crewDetail>  showScheduledCrewListForSelectedDate(String crewid, String datop);
	
	public List<crewDetail>  showCrewCaptionFirstOfficer();
		
	public List<fligthSectorLog>  getFlightSectorListForDateCrew(String dateOfOperation , String crewDetail)throws Exception;
	
	
	
	public void createVoyagerReportWithFreeMakerTemplet(HttpServletRequest request,HttpServletResponse response ) throws Exception;


	
	
	//--------- These all Methods for the Crew Breafing Manager Loading PPMS  Token and view report -------
	public String getLoginToken();
	
	public Integer getTokenBalance();

	public int readTokenFromFileAndInsertToDatabase(File fileName, String addedby , String addedDate)throws FileNotFoundException;
	
    //-- Transfer Data From MySql to  Sql Server
    public void trasferDataFromMYSqlToSqlServer() throws SQLException; 
	
}
