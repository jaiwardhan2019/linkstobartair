package com.linkportal.smsreportconsumer;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;


//https://springframework.guru/configuring-spring-boot-for-microsoft-sql-server/


@Entity
@Table(name="Sms_Report_Consumer_Master")
public class smsConsumerDto {
	
	    //--------- All Variable Declaration And Mapping with the Table--------------
	    
	    @Id
	    @GeneratedValue(strategy = GenerationType.IDENTITY)	  
	    private Long Consumerid;
	    
	     
	    @Column
	    private String mgmtGroup;
	     
	    
	    @Column
	    private String firstName;
	    
	    @Column
	    private String lastName;
	    
	    
	    @Column(length = 100, nullable = false, unique = true)
	    private String AddedBy;
	    
	    
	    @Column
	    private String addedDate;


		public Long getConsumerid() {
			return Consumerid;
		}


		public void setConsumerid(Long consumerid) {
			Consumerid = consumerid;
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


		public String getAddedBy() {
			return AddedBy;
		}


		public void setAddedBy(String addedBy) {
			AddedBy = addedBy;
		}


		public String getAddedDate() {
			return addedDate;
		}


		public void setAddedDate(String addedDate) {
			this.addedDate = addedDate;
		}


		@Override
		public String toString() {
			return "smsConsumerDto [Consumerid=" + Consumerid + ", mgmtGroup=" + mgmtGroup + ", firstName=" + firstName
					+ ", lastName=" + lastName + ", AddedBy=" + AddedBy + ", addedDate=" + addedDate + "]";
		}
        
	    

}
