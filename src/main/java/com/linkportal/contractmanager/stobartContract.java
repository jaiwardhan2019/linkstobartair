package com.linkportal.contractmanager;

import java.io.File;
import java.io.IOException;
import java.nio.file.DirectoryStream;
import java.nio.file.FileSystems;
import java.nio.file.Files;
import java.nio.file.NotDirectoryException;
import java.nio.file.Path;


import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Date;

import org.springframework.beans.factory.annotation.Value;




public class stobartContract {
	
	   private String department;
	   private String subdepartment;	   
	   private String department_code;
	   private String subdepartment_code;
	   private int    dept_sub_code;
	   private String contractor_name; 
	   private String contractor_contact_detail; 
	   private String refrence_no;
	   private String contract_description; 
	   private String status; 
	   private String start_date; 
	   private String end_date;
	   private String entered_by_email;
	   private String is_admin;
	   
	   
	  
	   
	   
	


	public stobartContract(String department, String subdepartment, String department_code, String subdepartment_code,
			int dept_sub_code, String contractor_name, String contractor_contact_detail, String refrence_no,
			String contract_description, String status, String start_date, String end_date, String entered_by_email, String is_admin) {
		super();
		this.department = department;
		this.subdepartment = subdepartment;
		this.department_code = department_code;
		this.subdepartment_code = subdepartment_code;
		this.dept_sub_code = dept_sub_code;
		this.contractor_name = contractor_name;
		this.contractor_contact_detail = contractor_contact_detail;
		this.refrence_no = refrence_no;
		this.contract_description = contract_description;
		this.status = status;
		this.start_date = start_date;
		this.end_date = end_date;
		this.entered_by_email = entered_by_email;
		this.is_admin=is_admin;
	}












	public String getDepartment() {
		return department;
	}




	public void setDepartment(String department) {
		this.department = department;
	}





	public String getSubdepartment() {
		return subdepartment;
	}



	public void setSubdepartment(String subdepartment) {
		this.subdepartment = subdepartment;
	}








	public String getDepartment_code() {
		return department_code;
	}








	public void setDepartment_code(String department_code) {
		this.department_code = department_code;
	}








	public String getSubdepartment_code() {
		return subdepartment_code;
	}








	public void setSubdepartment_code(String subdepartment_code) {
		this.subdepartment_code = subdepartment_code;
	}








	public int getDept_sub_code() {
		return dept_sub_code;
	}








	public void setDept_sub_code(int dept_sub_code) {
		this.dept_sub_code = dept_sub_code;
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






	public String getIs_admin() {
		return is_admin;
	}








	public void setIs_admin(String is_admin) {
		this.is_admin = is_admin;
	}





 
	
    @Override
	public String toString() {
		return "stobartContract [department=" + department + ", subdepartment=" + subdepartment + ", department_code="
				+ department_code + ", subdepartment_code=" + subdepartment_code + ", dept_sub_code=" + dept_sub_code
				+ ", contractor_name=" + contractor_name + ", contractor_contact_detail=" + contractor_contact_detail
				+ ", refrence_no=" + refrence_no + ", contract_description=" + contract_description + ", status="
				+ status + ", start_date=" + start_date + ", end_date=" + end_date + ", entered_by_email="
				+ entered_by_email + ", is_admin=" + is_admin + "]";
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
	   

	  











	public int getContractAge(String startdate) throws ParseException {
    	   
   
    	   
    	   String format = "yyyy-MM-dd";    		 
		   SimpleDateFormat sdf = new SimpleDateFormat(format);			 
		   Date dateObj1 = sdf.parse(startdate);
		   
		   DateTimeFormatter dtf = DateTimeFormatter.ofPattern(format);
		   LocalDateTime currentdateandtime = LocalDateTime.now();		   
		   
		   Date dateObj2 = sdf.parse(currentdateandtime.toString());
    	   
		   long diff = dateObj2.getTime() - dateObj1.getTime();
			 
		   int diffDays = (int) (diff / (24 * 60 * 60 * 1000));
			    	   
	   
	   return diffDays;
    }	
	
   
   

}
