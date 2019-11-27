package com.linkportal.staffTravel;

import java.util.List;

public interface manageStaffTravelUser {
	
	
	public List<staffTravelUsers> showStaffTravelUsers();
	
	public List<staffTravelUsers> searchStaffTravelUsers(String name);
	
	public int removeStaff_FromDb(int accountid);
	
	
	

}
