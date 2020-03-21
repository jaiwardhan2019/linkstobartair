package com.linkportal.smsreportconsumer;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.linkportal.smsreportconsumer.smsConsumerEntity;

@Repository
public interface smsConsumerRepository extends JpaRepository<smsConsumerEntity, Long> { 

	
	    

}
