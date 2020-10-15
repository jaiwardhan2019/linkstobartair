package com.linkportal.smsreportconsumer;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.transaction.Transactional;

import org.springframework.data.repository.CrudRepository;
import org.codehaus.plexus.component.annotations.Component;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

@Service
//public interface smsConsumerRepos extends CrudRepository<smsConsumerDto, Long> {
public interface smsConsumerRepos{
		public void test();
}

