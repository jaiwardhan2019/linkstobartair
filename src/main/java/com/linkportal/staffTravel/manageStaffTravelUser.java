package com.linkportal.staffTravel;

import java.util.List;

import org.springframework.transaction.annotation.Transactional;

public interface manageStaffTravelUser {	
	
	List<staffTravelUsers> showStaffTravelUsers();
	
	List<staffTravelUsers> searchStaffTravelUsers(String name);
	
	int removeStaff_FromDb(int accountid, String name);
	
	void updateUserGdprConsent(String emailid);

	
}
