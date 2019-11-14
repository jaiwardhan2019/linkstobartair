package com.linkportal.datamodel;

public class crewDetail {
	
	private String  crewid;
	private String  crewName;
	private String  position;
	
	public crewDetail(String crewid, String crewName, String position) {
		super();
		this.crewid = crewid;
		this.crewName = crewName;
		this.position = position;
	}

	public String getCrewid() {
		return crewid;
	}

	public void setCrewid(String crewid) {
		this.crewid = crewid;
	}

	public String getCrewName() {
		return crewName;
	}

	public void setCrewName(String crewName) {
		this.crewName = crewName;
	}

	public String getPosition() {
		return position;
	}

	public void setPosition(String position) {
		this.position = position;
	}

	
	
	@Override
	public String toString() {
		return "crewDetail [crewid=" + crewid + ", crewName=" + crewName + ", position=" + position + "]";
	}
	
    
	


	
	
	
	
}
