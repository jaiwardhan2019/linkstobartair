package com.linkportal.contractmanager;

import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;

import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

public interface manageStobartContract {
	
	List<stobartContract> showAllContract(String emailid, String dept, String subdept, String cdetail, String isarchived);

	stobartContract viewContract(String crefno, String useremail);
	
	stobartContract renewContract(String crefno, String emailid)throws SQLException;
	
	String populate_Department(String usremail, String dept)throws SQLException;
	
	String populate_SubDepartment(String usremail, String dept, String subdept)throws SQLException;
	
	
	int addNewContract(HttpServletRequest req)throws SQLException;       // Will add new  contract to the database     return 1 means success
	
	int updateNewContract(HttpServletRequest req)throws SQLException;    // Will update new  contract to the database  return 1 means success
	
	void removeContract(String crefno);       // Will remove contract from database     return 1 means success
	
	List<String> showFilesFromFolder(String foldername);
	
	boolean removeFolderWithallFile(File foldername);

	
	List<contractProfile> showProfileListOfUser(String useremailid);
	
	int addNewContractProfiletoUser(HttpServletRequest req)throws SQLException;
	
	void removeContractProfileofUser(int profileid, String useremailid)throws SQLException;
	
	
	void appenFiletoDataBase(HttpServletRequest req, @RequestParam("photo") MultipartFile file)throws IOException, ServletException,SQLException;
	
	
	

	
	
}
