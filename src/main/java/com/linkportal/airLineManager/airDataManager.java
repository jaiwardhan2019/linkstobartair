package com.linkportal.airLineManager;

import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.linkportal.exception.airlineDataManagerException;
import com.linkportal.exception.smsReportUserException;
import com.linkportal.smsreportusers.smsConsumerEntity;

public interface airDataManager {

	boolean addAirLine(HttpServletRequest req) throws airlineDataManagerException, SQLException;

	boolean updateAirline(HttpServletRequest req) throws airlineDataManagerException, SQLException;

	void removeAirLine(String string);

	airLineEntity findAirline(String string);

	List listAirLineData();


}
