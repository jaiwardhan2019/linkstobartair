package com.linkportal.smsreportconsumer;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;




@Entity
@Table(name="Sms_Report_Consumer_Master")
public class smsConsumerEntity {
	
	    //--------- All Variable Declaration And Mapping with the Table--------------
	    @Id
	    @GeneratedValue
	    private Long Consumerid;
	    
	     
	    @Column(name="ConsumerName")
	    private String Consumer_Name;
	     
	    
	    @Column(name="ConsumerPhone")
	    private String Consumer_Phone;
	    
	    
	    @Column(name="AddedBy", nullable=false, length=200)
	    private String Added_By;
	    
	    
	    @Column(name="AddedDateTime")
	    private String AddedDate_Time;
        
	    
	    //---------  Getter && Setter  ---------
		public Long getConsumerid() {
			return Consumerid;
		}


		public void setConsumerid(Long consumerid) {
			Consumerid = consumerid;
		}


		public String getConsumer_Name() {
			return Consumer_Name;
		}


		public void setConsumer_Name(String consumer_Name) {
			Consumer_Name = consumer_Name;
		}


		public String getConsumer_Phone() {
			return Consumer_Phone;
		}


		public void setConsumer_Phone(String consumer_Phone) {
			Consumer_Phone = consumer_Phone;
		}


		public String getAdded_By() {
			return Added_By;
		}


		public void setAdded_By(String added_By) {
			Added_By = added_By;
		}


		public String getAddedDate_Time() {
			return AddedDate_Time;
		}


		public void setAddedDate_Time(String addedDate_Time) {
			AddedDate_Time = addedDate_Time;
		}


		
		@Override
		public String toString() {
			return "smsConsumerEntity [Consumerid=" + Consumerid + ", Consumer_Name=" + Consumer_Name
					+ ", Consumer_Phone=" + Consumer_Phone + ", Added_By=" + Added_By + ", AddedDate_Time="
					+ AddedDate_Time + "]";
		}
	    	    
	     
	    

}
