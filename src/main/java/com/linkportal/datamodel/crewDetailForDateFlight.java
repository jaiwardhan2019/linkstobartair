package com.linkportal.datamodel;

public class crewDetailForDateFlight {
	
	
	private String datop;
	private String fltId;
	private String crewNo;
	private String crewName;
	private String crewPosition;
	private String pilotOrCrew;
	
	
	public crewDetailForDateFlight(String datop, String fltId, String crewNo, String crewName, String crewPosition,
			String pilotOrCrew) {
		super();
		this.datop = datop;
		this.fltId = fltId;
		this.crewNo = crewNo;
		this.crewName = crewName;
		this.crewPosition = crewPosition;
		this.pilotOrCrew = pilotOrCrew;
	}

	

	public String getDatop() {
		return datop;
	}


	public void setDatop(String datop) {
		this.datop = datop;
	}


	public String getFltId() {
		return fltId;
	}


	public void setFltId(String fltId) {
		this.fltId = fltId;
	}


	public String getCrewNo() {
		return crewNo;
	}


	public void setCrewNo(String crewNo) {
		this.crewNo = crewNo;
	}


	public String getCrewName() {
		return crewName;
	}


	public void setCrewName(String crewName) {
		this.crewName = crewName;
	}


	public String getCrewPosition() {
		return crewPosition;
	}


	public void setCrewPosition(String crewPosition) {
		this.crewPosition = crewPosition;
	}


	public String getPilotOrCrew() {
		return pilotOrCrew;
	}


	public void setPilotOrCrew(String pilotOrCrew) {
		this.pilotOrCrew = pilotOrCrew;
	}



	@Override
	public String toString() {
		return "crewDetailForDateFlight [datop=" + datop + ", fltId=" + fltId + ", crewNo=" + crewNo + ", crewName="
				+ crewName + ", crewPosition=" + crewPosition + ", pilotOrCrew=" + pilotOrCrew + "]";
	}
	
	
	
	

}
