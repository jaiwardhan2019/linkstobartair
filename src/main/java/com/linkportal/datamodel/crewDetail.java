package com.linkportal.datamodel;

import java.util.List;

public class crewDetail {
	
	private String  crewid;
	private String  crewFirstName;
	private String  crewLastName;
	private String  position;
	private String  station;
	

	

	public crewDetail(String crewid, String crewFirstName, String crewLastName, String position, String station) {
		super();
		this.crewid = crewid;
		this.crewFirstName = crewFirstName;
		this.crewLastName = crewLastName;
		this.position = position;
		this.station = station;
	}

	
	
	
	
	public String getStation() {
		return station;
	}





	public void setStation(String station) {
		this.station = station;
	}





	public String getCrewid() {
		return crewid;
	}

	public void setCrewid(String crewid) {
		this.crewid = crewid;
	}

	public String getCrewFirstName() {
		return crewFirstName;
	}

	public void setCrewFirstName(String crewFirstName) {
		this.crewFirstName = crewFirstName;
	}

	public String getCrewLastName() {
		return crewLastName;
	}

	public void setCrewLastName(String crewLastName) {
		this.crewLastName = crewLastName;
	}

	public String getPosition() {
		return position;
	}

	public void setPosition(String position) {
		this.position = position;
	}

	public String getCrewFullName() {		
		return this.crewFirstName+ " " +this.crewLastName;
	}
	
	@Override
	public String toString() {
		return "crewDetail [crewid=" + crewid + ", crewFirstName=" + crewFirstName + ", crewLastName=" + crewLastName
				+ ", position=" + position + "]";
	}
	
}
