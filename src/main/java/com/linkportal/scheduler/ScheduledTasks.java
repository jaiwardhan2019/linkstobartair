package com.linkportal.scheduler;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.linkportal.batchjob.linkBatchJob;

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
	
	
	  
    /*
    
    
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
	

	
	
	//@Scheduled(cron = "0 * * * * ?")
	
	@Scheduled(cron = "${mail.body.contract.cornsetting}")
    public void stobartContractManager() {
    	
  		   linkbatch.notify_Contarct_Admin_About_ContractExpiry();
     
    } // ------- END OF FUNCTION 
       
    
	
	/*
	
	@Scheduled(cron = "0 * * * * ?")
    public void Test() {
    	  
		   System.out.println("Hi there this is testing ");
  		   
    } // ------- END OF FUNCTION 
   
    */
    
    
}
