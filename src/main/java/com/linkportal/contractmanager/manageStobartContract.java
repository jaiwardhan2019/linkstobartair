package com.linkportal.contractmanager;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

public interface manageStobartContract {
	
	public List<stobartContract> showAllContract(String dept,String subdept);
	
	public int addNewContract(HttpServletRequest req);       // Will add new  contract to the database     return 1 means success
	
	public int updateNewContract();    // Will update new  contract to the database  return 1 means success
	
	public int removeContract();       // Will update new  contract to the database     return 1 means success  
	
}
