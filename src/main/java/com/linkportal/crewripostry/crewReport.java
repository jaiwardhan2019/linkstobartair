package com.linkportal.crewripostry;

import java.util.List;

import com.linkportal.datamodel.crewDetail;
import com.linkportal.datamodel.crewFlightRoster;

public interface crewReport {

	public List<crewDetail>  showCrewList(String datop);
	
	public List<crewFlightRoster>  showCrewFlightSchedule(String crewid, String datop);
	
	
	
	
}
