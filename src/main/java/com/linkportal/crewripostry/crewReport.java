package com.linkportal.crewripostry;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.List;

import org.springframework.http.HttpEntity;
import org.springframework.web.bind.annotation.PathVariable;

import com.linkportal.datamodel.crewDetail;
import com.linkportal.datamodel.crewFlightRoster;

public interface crewReport {

	public List<crewDetail>  showCrewList(String datop);
	
	public List<crewFlightRoster>  showCrewFlightSchedule(String crewid, String datop);
	
	public List<crewDetail>  showCrewCaptionFirstOfficer();

	public String getLoginToken();
	
	public Integer getTokenBalance();

	public int readTokenFromFileAndInsertToDatabase(File fileName, String addedby , String addedDate)throws FileNotFoundException;
	
	public HttpEntity<byte[]> createPdf(String fileName) throws IOException;

	
}
