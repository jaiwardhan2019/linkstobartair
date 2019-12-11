package com.linkportal.contractmanager;

import java.io.File;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

public interface manageStobartContract {
	
	public List<stobartContract> showAllContract(String dept,String subdept);

	public stobartContract viewContract(String crefno);
	
	public int addNewContract(HttpServletRequest req);       // Will add new  contract to the database     return 1 means success
	
	public int updateNewContract(String crefno);    // Will update new  contract to the database  return 1 means success
	
	public void removeContract(String crefno);       // Will update new  contract to the database     return 1 means success  
	
	public List<String> showFilesFromFolder(String foldername);
	
	
	
}
