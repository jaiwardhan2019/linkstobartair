package com.linkportal.groundops;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

public interface gopsAllapi {
	

	public List<refisUsers> showRefisUser();
	
	public List<refisUsers> searchRefisUser(String name);
	
	public refisUsers viewGopsUserDetail(String username);	
	
	public int  updateGopsUserDetail(HttpServletRequest req);
	
	public int  addnewGopsUserDetail(HttpServletRequest req);
	
	public int removeRefisUser_FromDb(String accountid);
	
	public String getAllStationList(String userid);
	
	public String getAllAirlineList(String userid);
	
	
	public String getAllEligibleAirlineforGH(String userid);
	
	public String getAllEligibleAirportforGH(String stobartUser);
	
	
	

}
