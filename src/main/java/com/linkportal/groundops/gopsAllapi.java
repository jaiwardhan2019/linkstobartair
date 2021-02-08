package com.linkportal.groundops;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.linkportal.datamodel.flightDelayComment;

public interface gopsAllapi {

	List<refisUsers> showRefisUser();

	List<refisUsers> searchRefisUser(String name);

	refisUsers viewGopsUserDetail(String username);

	int updateGopsUserDetail(HttpServletRequest req);

	int addnewGopsUserDetail(HttpServletRequest req);

	int removeRefisUser_FromDb(String accountid);

	String getAllStationList(String userid);

	String getAllAirlineList(String userid);

	String getAllEligibleAirlineforGH(String userid);

	String getAllEligibleAirportforGH(String stobartUser);

	boolean addDelayFeedback(HttpServletRequest req);

	List<flightDelayComment> showAllComment(HttpServletRequest req);

	String getPuncStaticforGroundOpsHomePage();
	

	void notifyGroundHandlersForDelayComment(HttpServletRequest req) throws Exception;
	
	
	//-------- This function will update Ground Ops Home Page Flashing message on the home page.
	void updateGroudopsHomePageFlashingMessage(String Message , String addedBy);
	
	
	String getGroudopsHomePageFlashingMessage();

	
	//--- For the Ground Ops Users Profile Management ADD , REMOVE	
	String updateGroundOpsUsersProfile(String emailid,String profileid,String action);
	
	
	

}
