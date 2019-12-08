package com.linkportal.contractmanager;

import java.io.File;
import java.io.IOException;
import java.nio.file.DirectoryStream;
import java.nio.file.FileSystems;
import java.nio.file.Files;
import java.nio.file.NotDirectoryException;
import java.nio.file.Path;

import org.springframework.beans.factory.annotation.Value;

public class stobartContract {
	
	   private String department;
	   private String sub_department;
	   private String contractor_name; 
	   private String contractor_contact_detail; 
	   private String refrence_no;
	   private String contract_description; 
	   private String status; 
	   private String start_date; 
	   private String end_date;
	   private String entered_by_email;
	   
	   
	   
	   
	

	public stobartContract(String department, String sub_department, String contractor_name,
			String contractor_contact_detail, String refrence_no, String contract_description, String status,
			String start_date, String end_date, String entered_by_email) {
		super();
		this.department = department;
		this.sub_department = sub_department;
		this.contractor_name = contractor_name;
		this.contractor_contact_detail = contractor_contact_detail;
		this.refrence_no = refrence_no;
		this.contract_description = contract_description;
		this.status = status;
		this.start_date = start_date;
		this.end_date = end_date;
		this.entered_by_email = entered_by_email;
	}




	public String getDepartment() {
		return department;
	}




	public void setDepartment(String department) {
		this.department = department;
	}




	public String getSub_department() {
		return sub_department;
	}




	public void setSub_department(String sub_department) {
		this.sub_department = sub_department;
	}




	public String getContractor_name() {
		return contractor_name;
	}




	public void setContractor_name(String contractor_name) {
		this.contractor_name = contractor_name;
	}




	public String getContractor_contact_detail() {
		return contractor_contact_detail;
	}




	public void setContractor_contact_detail(String contractor_contact_detail) {
		this.contractor_contact_detail = contractor_contact_detail;
	}




	public String getRefrence_no() {
		return refrence_no;
	}




	public void setRefrence_no(String refrence_no) {
		this.refrence_no = refrence_no;
	}




	public String getContract_description() {
		return contract_description;
	}




	public void setContract_description(String contract_description) {
		this.contract_description = contract_description;
	}




	public String getStatus() {
		return status;
	}




	public void setStatus(String status) {
		this.status = status;
	}




	public String getStart_date() {
		return start_date;
	}




	public void setStart_date(String start_date) {
		this.start_date = start_date;
	}




	public String getEnd_date() {
		return end_date;
	}




	public void setEnd_date(String end_date) {
		this.end_date = end_date;
	}




	public String getEntered_by_email() {
		return entered_by_email;
	}




	public void setEntered_by_email(String entered_by_email) {
		this.entered_by_email = entered_by_email;
	}




	@Override
	public String toString() {
		return "stobartContract [department=" + department + ", sub_department=" + sub_department + ", contractor_name="
				+ contractor_name + ", contractor_contact_detail=" + contractor_contact_detail + ", refrence_no="
				+ refrence_no + ", contract_description=" + contract_description + ", status=" + status
				+ ", start_date=" + start_date + ", end_date=" + end_date + ", entered_by_email=" + entered_by_email
				+ "]";
	}


	//--------- THIS FUNCTION WILL SHOW THE NO OF FILE IN THE ONTRACT FOLDER -----------------------------
	public int getFilesCount() throws IOException, NotDirectoryException {	    
		   int fileCount=0;
		   String rootdirectory = new java.io.File( "/" ).getCanonicalPath();
		   File directory=new File(rootdirectory+"/data/stobart_contract/"+this.refrence_no);
		   if(directory.isDirectory()) {
		      fileCount=directory.list().length;
		   }
		   
	       return fileCount;
	}	   
	   
	
	

}
