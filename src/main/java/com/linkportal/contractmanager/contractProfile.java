package com.linkportal.contractmanager;

public class contractProfile {
	
	   private int profileid;
	   private String department;
	   private String subDepartment;
	   private String adminstatus;
	   private String eligibleforemailnotification;
	   

	public contractProfile(int profileid, String department, String subDepartment, String adminstatus , String eligibleforemailnotification) {
		super();
		this.profileid = profileid;
		this.department = department;
		this.subDepartment = subDepartment;
		this.adminstatus = adminstatus;
		this.eligibleforemailnotification=eligibleforemailnotification;
	}


	public int getProfileid() {
		return profileid;
	}


	public void setProfileid(int profileid) {
		this.profileid = profileid;
	}


	public String getDepartment() {
		return department;
	}


	public void setDepartment(String department) {
		this.department = department;
	}


	public String getSubDepartment() {
		return subDepartment;
	}


	public void setSubDepartment(String subDepartment) {
		this.subDepartment = subDepartment;
	}


	public String getAdminstatus() {
		return adminstatus;
	}


	public void setAdminstatus(String adminstatus) {
		this.adminstatus = adminstatus;
	}

     
	public String getEligibleforemailnotification() {
		return eligibleforemailnotification;
	}


	public void setEligibleforemailnotification(String eligibleforemailnotification) {
		this.eligibleforemailnotification = eligibleforemailnotification;
	}


	
	@Override
	public String toString() {
		return "contractProfile [profileid=" + profileid + ", department=" + department + ", subDepartment="
				+ subDepartment + ", adminstatus=" + adminstatus + ", eligibleforemailnotification="
				+ eligibleforemailnotification + "]";
	}

   
	   
	
	

}
