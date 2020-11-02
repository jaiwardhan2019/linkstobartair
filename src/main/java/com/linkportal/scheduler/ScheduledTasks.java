package com.linkportal.scheduler;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.linkportal.batchjob.linkBatchJob;

import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.concurrent.TimeUnit;

/**
 * Created by Jai Wardhan 
 * https://mkyong.com/java/quartz-scheduler-example/?utm_source=mkyong.com&utm_medium=Referral&utm_campaign=afterpost-related&utm_content=link0
 * https://mkyong.com/java/how-to-run-a-task-periodically-in-java/
 * https://www.freeformatter.com/cron-expression-generator-quartz.html  <<--- CORN EXPRESSION 
 */

@Component
public class ScheduledTasks {
	
	
	@Autowired
	linkBatchJob  linkbatch;
	
	
    private boolean isJobEnabled = true;
	
	
	  
    /*
     *   ________Pending Batch Job ________
     *   
     * - Amos .xml file loading from pdc. 
     * - Link User removal if they dont login for 3 year.
     * - Aerobytes creating .excel file and sending them via email.
     * 
     * 
     
    
    
    @Scheduled(fixedRate = 2000)
    public void scheduleTaskWithFixedRate() {
        logger.info("Fixed Rate Task :: Execution Time - {}", dateTimeFormatter.format(LocalDateTime.now()) );
    
    }
    
    

    @Scheduled(fixedDelay = 2000)
    public void scheduleTaskWithFixedDelay() {
        logger.info("Fixed Delay Task :: Execution Time - {}", dateTimeFormatter.format(LocalDateTime.now()));
        try {
            TimeUnit.SECONDS.sleep(5);
        } catch (InterruptedException ex) {
            logger.error("Ran into an error {}", ex);
            throw new IllegalStateException(ex);
        }
    }

    

    
    @Scheduled(fixedRate = 2000, initialDelay = 5000)
    public void scheduleTaskWithInitialDelay() {
        logger.info("Fixed Rate Task with Initial Delay :: Execution Time - {}", dateTimeFormatter.format(LocalDateTime.now()));
    }

 
    
    @Scheduled(cron = "0 * * * * ?")
    public void scheduleTaskWithCronExpression() {
        logger.info("Hi THis is testing for every minute execution  By JAI WARDHAN:", dateTimeFormatter.format(LocalDateTime.now()));
    }


    
    @Scheduled(cron = "0 * * * * ?")
    public void cronJobSch() {

       System.out.println("Java cron job expression JAI WARDHAN" );
    }
        
          @Scheduled(cron = "0 * * * * ?")  <<-- Every Minutes 

    0 0 8 * * MON-FRI   <<-- Monday to Friday 8 am in the Morning 
    
    
    0 0 0 * * ?  <<-- EVERY DAY AT MIDNIGHT 12 
    */
    
    
    /*------------- THIS METHOD WILL LET THE ADMIN OF ALL DEPARTMENT KNOW ABOUT IF THERE ANY CONTRACT IS GOING TO EXPIRED 
     * - IN 6 * MONTH TIME.
     * - ADMIN WILL BE KEEP ON GETTING EMAIL ON DAILY BASIS  
    */ 
	

	
	

	
	@Scheduled(cron = "${mail.body.contract.cornsetting}")
    public void stobartContractManager() {
    	
  		   linkbatch.notify_Contarct_Admin_About_ContractExpiry();
     
    } // ------- END OF FUNCTION 
       
    
	
	/*
	 * This corn job will check the Corporate Portal Database
	 * (CORPORATE_PORTAL.Gops_Flight_Delay_Comment_Master) for all the flight comment which is 3 year
	 * old and remove them for good
	 */

	@Value("${delayflight.comment.ageindays}")
	int commentAge;
	
	@Scheduled(cron = "${delayflight.comment.removal.cornsetting}") 
	public void removeDelayFlightCommentOverthreeYear() throws SQLException {

		linkbatch.removeDelayFlightComment(commentAge);

	} // ------- END OF FUNCTION    
	
	
	/*
	 * This corn job will check the Corporate Portal Database
	 * (CORPORATE_PORTAL.Gops_Crew_Planning_Token) for the Crew Planning Application Login Token 
	 * Once the total count is less then 100 then it update to admin user
	 */
    @Scheduled(cron = "${ppstoken.lowlevel.cornsetting}")  
	public void notifyAdminAboutTheLowLevelOFToken(){
		
		linkbatch.notify_PPS_Login_Token_LowLevel();
		
	} // ------- END OF FUNCTION    
	
	
	
	
	
	
	
	
    
}
