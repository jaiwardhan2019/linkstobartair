package com.linkportal.contractmanager;

import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

public interface manageStobartContract {
	
	public List<stobartContract> showAllContract(String emailid,String dept,String subdept, String cdetail , String isarchived);

	public stobartContract viewContract(String crefno, String useremail);
	
	public stobartContract renewContract(String crefno)throws SQLException;
	
	public String populate_Department(String usremail ,String dept)throws SQLException;
	
	public String populate_SubDepartment(String usremail,String dept,String subdept)throws SQLException;
	
	
	public int addNewContract(HttpServletRequest req)throws SQLException;       // Will add new  contract to the database     return 1 means success
	
	public int updateNewContract(HttpServletRequest req)throws SQLException;    // Will update new  contract to the database  return 1 means success
	
	public void removeContract(String crefno);       // Will remove contract from database     return 1 means success  
	
	public List<String> showFilesFromFolder(String foldername);
	
	public boolean removeFolderWithallFile(File foldername);	

	
	public List<contractProfile> showProfileListOfUser(String useremailid); 
	
	public int addNewContractProfiletoUser(HttpServletRequest req)throws SQLException;
	
	public void removeContractProfileofUser(int profileid, String useremailid)throws SQLException;
	
	
	

	
	
}
