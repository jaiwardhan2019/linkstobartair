package com.linkportal.staffTravel;

import java.util.List;

import org.springframework.transaction.annotation.Transactional;

public interface manageStaffTravelUser {	
	
	public List<staffTravelUsers> showStaffTravelUsers();	
	
	public List<staffTravelUsers> searchStaffTravelUsers(String name);
	
	public int removeStaff_FromDb(int accountid, String name);

}
