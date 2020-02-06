package com.linkportal.groundops;

import java.util.List;

public interface manageRefisUser {
	

	public List<refisUsers> showRefisUser();
	
	public List<refisUsers> searchRefisUser(String name);
	
	public int removeRefisUser_FromDb(String accountid);
	

}
