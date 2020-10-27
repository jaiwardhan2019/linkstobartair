package com.linkportal.airlinemanager;

import com.linkportal.exception.airlineDataException;

import javax.servlet.http.HttpServletRequest;
import java.sql.SQLException;
import java.util.List;

public interface airDataManager {

	public boolean addAirLine(HttpServletRequest req) throws airlineDataException, SQLException;

	public boolean updateAirline(HttpServletRequest req) throws airlineDataException, SQLException;

	public void removeAirLine(String string);

	public airLineEntity findAirline(String string);

	public List listAirLineData();


}
