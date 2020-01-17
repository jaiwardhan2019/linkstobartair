package com.linkportal.batchjob;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.sql.DataSource;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.support.rowset.SqlRowSet;
import org.springframework.stereotype.Repository;

import com.linkportal.contractmanager.stobartContract;
import com.linkportal.contractmanager.stobartContractRowmapper;


import com.linkportal.email.linkPortalEmail;





@Repository
public class linkBatchJobImp implements linkBatchJob{
	
	   private static final Logger LOGGER = Logger.getLogger(linkBatchJobImp.class);
   	   
	   
	   
	   private static final DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");

	   private static final String SqlForContarctExpireyin180days="SELECT CONTRACT_DEPT_SUBDET.DEPARTMENT , CONTRACT_DEPT_SUBDET.SUBDEPARTMENT, CONTRACT_DEPT_SUBDET.DEPARTMENT_CODE , CONTRACT_DEPT_SUBDET.SUBDEPARTMENT_CODE , CONTRACT_MASTER.DEPT_SUB_CODE " + 
	   		                " , CONTRACT_MASTER.contractor_name , CONTRACT_MASTER.contractor_contact_detail,CONTRACT_MASTER.refrence_no, " + 
	                        "   CONTRACT_MASTER.description,CONTRACT_MASTER.status,CONTRACT_MASTER.start_date,CONTRACT_MASTER.end_date,CONTRACT_MASTER.entered_by_email , CONTRACT_ACCESS.is_admin  " + 
	   	                    "   FROM CONTRACT_DEPT_SUBDET,CONTRACT_MASTER , CONTRACT_ACCESS  WHERE CONTRACT_MASTER.DEPT_SUB_CODE = CONTRACT_DEPT_SUBDET.ID " + 
	                        "   AND  CONTRACT_MASTER.DEPT_SUB_CODE = CONTRACT_ACCESS.dept_sub_code  AND  CONTRACT_MASTER.entered_by_email=CONTRACT_ACCESS.user_email AND CONTRACT_MASTER.STATUS in ('Active','Dactive')";

	   
 
	   @Autowired
	   linkPortalEmail emailinst;
	   
	   
	   
	   
		
		//-------------- reading application.properties file -----------------
		@Value("${mail.host}") String mailhostserver;	
		@Value("${mail.From}") String emailfrom;
		@Value("${mail.subject.contract}") String emailsubject;
		@Value("${mail.body.contractRenew}") String emailBodyRenew;
		@Value("${mail.body.contractExpiry}") String emailBodyExpired;
		@Value("${stobart.contract.folder}") String contractpath;
		
		
		
	

		
		
		
	   
	   @Autowired
	   DataSource dataSourcemysql;		
	
	   JdbcTemplate jdbcTempBatch;	
			
	
	   public linkBatchJobImp(DataSource dataSourcemysql) {
		      jdbcTempBatch = new JdbcTemplate(dataSourcemysql);			   
	   }


	
		@Override
		public void notify_Contarct_Admin_About_ContractExpiry() {
		   	try{
		   		
		   		//-------- SEARCH FOR THE CONTRACT WHO IS GOING TO EXPIRE IN 180 DAYS -----------
		    	 List<stobartContract>   contractlist = jdbcTempBatch.query(SqlForContarctExpireyin180days,new stobartContractRowmapper());
		     	
		    	 
		    	 Iterator it=contractlist.iterator();
		    	 while(it.hasNext()){	    	    	
		    	   	
		    		stobartContract contr=(stobartContract)it.next();
		    	   	int noofDaysToExpire = contr.noofDaysToExpire(contr.getEnd_date());
	    	    	
	    	   	
		    	   	
		    	  //---- FOR ABOUT TO EXPIRE IN 180 DAYS 
		    	   	if((noofDaysToExpire >= 0) && (noofDaysToExpire <= 180)){
		    	   		emailBodyRenew = emailBodyRenew.replaceAll("CONTRACTNO", contr.getRefrence_no());
		    	   		emailBodyRenew = emailBodyRenew.replaceAll("NDAYS", Integer.toString(noofDaysToExpire) );		
		    	    	emailinst.sendTextHtmlEmail(mailhostserver, emailfrom,collectAdminEmailList(contr.getRefrence_no()), (emailsubject+contr.getRefrence_no()), emailBodyRenew.replaceAll("CONTRACTNO", contr.getRefrence_no()),contractpath+"stobart_contract/"+contr.getRefrence_no()+".zip");
		    	    } 
		    	     
		    	    
		    	   	

		    	   	//---- FOR FULLY EXPIRED CONTRACT 
		    	   	if((noofDaysToExpire <= 0) || (contr.getStatus().equals("Dactive"))) {	    	    		
		    	    	emailinst.sendTextHtmlEmail(mailhostserver, emailfrom,collectAdminEmailList(contr.getRefrence_no()), (emailsubject+contr.getRefrence_no()), emailBodyExpired.replaceAll("CONTRACTNO", contr.getRefrence_no()),contractpath+"stobart_contract/"+contr.getRefrence_no()+".zip");

	    	    	} 
			    	   	

		    	 
		    	 } //------ END OF WHILE LOOP    
		    	 
		    	 
		    	 
		   		
	    	}catch(Exception exc) {LOGGER.error("Issue in Method :=> linkbatch.notify_Contarct_Admin_About_ContractExpiry() @:"+dateTimeFormatter.format(LocalDateTime.now())+exc.toString());}
	    	
		   	
	 
		}//---------- END OF FUNCTION ---------------
		
	
	
		
		
		//--- WILL TAKE INPUT AS REFNO AND RETRUN EMAIL LIST OF ALL ADMIN USER AND OTHERS WHO QUALIFY FOR EMAIL   
	    private String collectAdminEmailList(String refNo){	    	
	    	    String adminEmailList=null;
	    	    String sqlforemail="SELECT  distinct user_email FROM CORPORATE_PORTAL.CONTRACT_ACCESS where is_admin='Y' or eligible_for_email_notification='Y' and "
	    	    		+ " dept_sub_code in(SELECT dept_sub_code FROM CORPORATE_PORTAL.CONTRACT_MASTER where   refrence_no='"+refNo+"')";
	    	    
	    	    SqlRowSet rs =  jdbcTempBatch.queryForRowSet(sqlforemail);
	    	    while(rs.next()){
	    	    	if(adminEmailList != null) {adminEmailList = adminEmailList +","+rs.getString("user_email");}
	    	    	else
	    	    	{adminEmailList = rs.getString("user_email");}
	    	    }//--- End Of While loop
	    	    
	    	    //System.out.println("List of admin to be notified:"+adminEmailList);
	    	    
	    	return adminEmailList;
	    }
		
		
		
		
		
		
		

}//---------END OF CLASS FILE 
