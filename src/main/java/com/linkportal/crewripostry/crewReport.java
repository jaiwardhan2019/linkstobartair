package com.linkportal.crewripostry;

import java.util.List;

import com.linkportal.datamodel.crewDetail;
import com.linkportal.datamodel.crewFlightRoster;

public interface crewReport {

	List<crewDetail>  showCrewList(String datop);
	
	List<crewFlightRoster>  showCrewFlightSchedule(String crewid, String datop);
	
	List<crewDetail>  showCrewCaptionFirstOfficer();	
	
	
}
