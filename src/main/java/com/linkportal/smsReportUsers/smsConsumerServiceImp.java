package com.linkportal.smsReportUsers;

import javax.sql.DataSource;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.linkportal.fltreport.flightReportsImp;
import com.linkportal.groundops.gopsAllapi;

@Repository
public class smsConsumerServiceImp implements smsConsumerService{
	
	

    @Autowired
    DataSource dataSourcesqlservercp;
    
    
    @Autowired
    gopsAllapi gopsobj;
    

    //---------- Logger Initializer------------------------------- 
	private Logger logger = Logger.getLogger(flightReportsImp.class);

    
	JdbcTemplate jdbcTemplateSqlServerCp;	
		

	
	smsConsumerServiceImp(DataSource dataSourcesqlservercp){ 
		jdbcTemplateSqlServerCp      = new JdbcTemplate(dataSourcesqlservercp);		
	}
	
	


	

	@Override
	public String addSmsUser() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public String upateSmsUser() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void removeSmsUser() {
		// TODO Auto-generated method stub
		
	}

	


}
