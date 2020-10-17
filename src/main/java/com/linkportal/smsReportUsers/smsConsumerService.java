package com.linkportal.smsReportUsers;


import javax.persistence.Column;
import javax.persistence.Entity;

import org.springframework.data.repository.CrudRepository;
import org.codehaus.plexus.component.annotations.Component;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;


public interface smsConsumerService{	
	
	public String addSmsUser();

	public String upateSmsUser();
	
	public void removeSmsUser();
	
	
}

