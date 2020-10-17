package com.linkportal.smsreportusers;

import java.sql.SQLException;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.servlet.http.HttpServletRequest;

import org.springframework.data.repository.CrudRepository;
import org.codehaus.plexus.component.annotations.Component;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

import com.linkportal.exception.smsReportUserException;

@Repository
public interface smsConsumerService {

	boolean addSmsUser(HttpServletRequest req) throws smsReportUserException, SQLException;

	boolean updateSmsUser(HttpServletRequest req) throws smsReportUserException, SQLException;

	void removeSmsUser(String string);

	smsConsumerEntity findSmsUser(String string);

	List listSmsUser();

}
