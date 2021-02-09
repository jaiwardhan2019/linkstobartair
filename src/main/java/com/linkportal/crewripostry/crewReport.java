package com.linkportal.crewripostry;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.http.HttpEntity;
import org.springframework.web.bind.annotation.PathVariable;

import com.linkportal.datamodel.crewDetail;
import com.linkportal.datamodel.crewFlightRoster;

public interface crewReport {

	//--------- These all Methods for Voyager Report -------
	public List<crewDetail>  showCrewList(String StartDateop , String endDateop , List<String> rankList );
	
	public List<crewFlightRoster>  showCrewFlightSchedule(String crewid, String datop);
	
	public List<crewDetail>  showCrewCaptionFirstOfficer();
	
	public HttpEntity<byte[]> createPdfWithVelocityTemplet(String fileName) throws IOException;
	
	public void createVoyagerReportWithFreeMakerTemplet(HttpServletRequest request,HttpServletResponse response ) throws Exception;


	//--------- These all Methods for the Crew Breafing Manager -------
	public String getLoginToken();
	
	public Integer getTokenBalance();

	public int readTokenFromFileAndInsertToDatabase(File fileName, String addedby , String addedDate)throws FileNotFoundException;
	

	
}
