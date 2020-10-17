package com.linkportal.smsreportusers;

public class smsConsumerEntity {
	
	
    //--------- All Variable Declaration And Mapping with the Table--------------
	private int userId;
    private String mgmtGroup;
    private String firstName;
    private String lastName;
    private String phoneNo;
    private final String addedBy;
    private String addedDate;




	public smsConsumerEntity(int userId, String mgmtGroup, String firstName, String lastName, String phoneNo,
			String addedBy, String addedDate) {
		super();
		this.userId = userId;
		this.mgmtGroup = mgmtGroup;
		this.firstName = firstName;
		this.lastName = lastName;
		this.phoneNo = phoneNo;
		this.addedBy = addedBy;
		this.addedDate = addedDate;
	}

	
	
	

	public int getUserId() {
		return userId;
	}


	public void setUserId(int userId) {
		this.userId = userId;
	}


	public String getMgmtGroup() {
		return mgmtGroup;
	}


	public void setMgmtGroup(String mgmtGroup) {
		this.mgmtGroup = mgmtGroup;
	}


	public String getFirstName() {
		return firstName;
	}


	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}


	public String getLastName() {
		return lastName;
	}


	public void setLastName(String lastName) {
		this.lastName = lastName;
	}


	public String getPhoneNo() {
		return phoneNo;
	}


	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
	}


	public String getAddedBy() {
		return addedBy;
	}


	public void setAddedBy(String addedBy) {
		addedBy = addedBy;
	}


	public String getAddedDate() {
		return addedDate;
	}


	public void setAddedDate(String addedDate) {
		this.addedDate = addedDate;
	}





	@Override
	public String toString() {
		return "smsConsumerEntity [userId=" + userId + ", mgmtGroup=" + mgmtGroup + ", firstName=" + firstName
				+ ", lastName=" + lastName + ", phoneNo=" + phoneNo + ", addedBy=" + addedBy + ", addedDate="
				+ addedDate + ", getUserId()=" + getUserId() + ", getMgmtGroup()=" + getMgmtGroup()
				+ ", getFirstName()=" + getFirstName() + ", getLastName()=" + getLastName() + ", getPhoneNo()="
				+ getPhoneNo() + ", getAddedBy()=" + getAddedBy() + ", getAddedDate()=" + getAddedDate()
				+ ", getClass()=" + getClass() + ", hashCode()=" + hashCode() + ", toString()=" + super.toString()
				+ "]";
	}


    

}
