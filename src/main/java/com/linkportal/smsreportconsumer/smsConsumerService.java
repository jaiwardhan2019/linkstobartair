package com.linkportal.smsreportconsumer;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
 
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import com.linkportal.exceptions.RecordNotFoundException;
import com.linkportal.smsreportconsumer.smsConsumerEntity;

@Service
public class smsConsumerService {
	
	@Autowired
	smsConsumerRepository SmsCon; 
	
	
	public List<smsConsumerEntity> getAllsmsConsumer(){
	       List<smsConsumerEntity> employeeList = SmsCon.findAll();	         
	        if(employeeList.size() > 0) {
	            return employeeList;
	        } else {
	            return new ArrayList<smsConsumerEntity>();
	        }
	 }
	 
	 public smsConsumerEntity getSmsConsumerById(Long id) throws RecordNotFoundException 
	    {
	        Optional<smsConsumerEntity> employee = SmsCon.findById(id);
	         
	        if(employee.isPresent()) {
	            return employee.get();
	        } else {
	            throw new RecordNotFoundException("No User Found given id");
	        }
	    }
	
	
	   public smsConsumerEntity createOrUpdategetSmsConsumer(smsConsumerEntity entity) throws RecordNotFoundException 
	    {
	        Optional<smsConsumerEntity> user = SmsCon.findById(entity.getConsumerid());
	         
	        if(user.isPresent()){
	        	
	        	smsConsumerEntity newEntity = SmsCon.getOne(entity.getConsumerid()); 
	        	newEntity.setConsumer_Name(entity.getConsumer_Name());
	        	newEntity.setConsumer_Phone(entity.getConsumer_Phone());
		        newEntity = SmsCon.save(newEntity);	             
	            return newEntity;
	            
	        }
	        else
	        {
	            entity = SmsCon.save(entity);	             
	            return entity;
	        }
	    } 	
	
	
	   
	   
	  public int  deleteSmsConsumer(Long id){		  
		  
		     Optional<smsConsumerEntity> employee = SmsCon.findById(id);
	         
	         if(employee.isPresent()) {
	        	SmsCon.deleteById(id);
	        	return 1;
	         }
	         else
	         {
	        	return 0;
	         }
		
	  }
	 
	 
	 
	

}
