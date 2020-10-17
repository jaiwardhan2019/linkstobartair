package com.linkportal.airLineManager;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.sql.DataSource;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.google.common.base.Strings;
import com.linkportal.exception.airlineDataManagerException;
import com.linkportal.exception.airlineDataManagerException;
import com.linkportal.fltreport.flightReportsImp;
import com.linkportal.smsreportusers.smsConsumerEntity;
import com.linkportal.smsreportusers.smsConsumerEntityRowmapper;

@Repository
public class airDataManagerImp implements airDataManager {

	@Autowired
	DataSource dataSourcesqlservercp;

	// ---------- Logger Initializer-------------------------------
	private final Logger logger = Logger.getLogger(flightReportsImp.class);

	JdbcTemplate jdbcTemplate;

	airDataManagerImp(DataSource dataSourcesqlservercp) {
		jdbcTemplate = new JdbcTemplate(dataSourcesqlservercp);
	}

	@Override
	public boolean addAirLine(HttpServletRequest req) throws airlineDataManagerException, SQLException {

		boolean updateStatus = false;
		if (validateAirlineData(req)) {
			DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");
			LocalDateTime currentdateandtime = LocalDateTime.now();
			String sqlinsert = null;
			Connection conn = dataSourcesqlservercp.getConnection();

			String SQL_ADD = "INSERT INTO  AirlineMaster (iata_code,icao_code,airline_name , status  , sla_one "
					+ ", sla_two , comment ,createdbyuseremail  , createddate)"
					+ "values (? , ? , ? , ?, ?, ? , ? , ? , ? )";

			PreparedStatement pstm = conn.prepareStatement(SQL_ADD);
			pstm.setString(1, req.getParameter("iatacode"));
			pstm.setString(2, req.getParameter("icaocode"));
			pstm.setString(3, req.getParameter("airlinename"));
			pstm.setString(4, req.getParameter("status"));
			pstm.setString(5, req.getParameter("slaone"));
			pstm.setString(6, req.getParameter("slatwo"));
			pstm.setString(7, req.getParameter("comment"));
			pstm.setString(8, req.getParameter("emailid"));
			pstm.setString(9, currentdateandtime.toString());
			int rows = pstm.executeUpdate();
			updateStatus = true;

		}
		req = null;
		return updateStatus;

	}

	@Override
	public boolean updateAirline(HttpServletRequest req) throws airlineDataManagerException, SQLException {

		boolean updateStatus = false;
		if (validateAirlineData(req)) {
			DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");
			LocalDateTime currentdateandtime = LocalDateTime.now();
			String sqlinsert = null;
			Connection conn = dataSourcesqlservercp.getConnection();
			sqlinsert = "UPDATE AirlineMaster  SET  iata_code = ? , icao_code = ?, airline_name = ? , status = ?"
					+ " , sla_one = ?, sla_two=? ,  comment = ? , createdbyuseremail = ? , createddate = ? WHERE id=?";

			PreparedStatement pstm = conn.prepareStatement(sqlinsert);
			pstm.setString(1, req.getParameter("iatacode"));
			pstm.setString(2, req.getParameter("icaocode"));
			pstm.setString(3, req.getParameter("airlinename"));
			pstm.setString(4, req.getParameter("status"));
			pstm.setString(5, req.getParameter("slaone"));
			pstm.setString(6, req.getParameter("slatwo"));
			pstm.setString(7, req.getParameter("comment"));
			pstm.setString(8, req.getParameter("emailid"));
			pstm.setString(9, currentdateandtime.toString());
			pstm.setString(10, req.getParameter("userinsubject"));
			int rows = pstm.executeUpdate();
			updateStatus = true;

		}
		req = null;
		return updateStatus;

	}

	@Override
	public void removeAirLine(String id) {
		jdbcTemplate.execute("delete from AirlineMaster where id=" + id);
	}

	@Override
	public airLineEntity findAirline(String airId) {
		return jdbcTemplate.queryForObject("select * from AirlineMaster where id=?", new Object[] { airId },
				new airLineEntityRowmapper());
	}

	@Override
	public List<airLineEntity> listAirLineData() {
		List<airLineEntity> smsUserList = jdbcTemplate.query("select * from AirlineMaster order by id desc",
				new airLineEntityRowmapper());
		return smsUserList;
	}

	// -------- form field validation..
	private boolean validateAirlineData(HttpServletRequest req) throws airlineDataManagerException {
		boolean validationStatus = false;
		if (Strings.isNullOrEmpty(req.getParameter("iatacode"))) {
			throw new airlineDataManagerException("Iata Code Missing ");
		} else {
			validationStatus = true;
		}
		if (Strings.isNullOrEmpty(req.getParameter("icaocode"))) {
			throw new airlineDataManagerException("Icao Code Missing ");
		} else {
			validationStatus = true;
		}

		if (Strings.isNullOrEmpty(req.getParameter("airlinename"))) {
			throw new airlineDataManagerException("Airline Name missing ");
		} else {
			validationStatus = true;
		}

		if (Strings.isNullOrEmpty(req.getParameter("status"))) {
			throw new airlineDataManagerException("Status Missing ");
		} else {
			validationStatus = true;
		}

		/*
		 * if (Strings.isNullOrEmpty(req.getParameter("slaone"))) { throw new
		 * airlineDataManagerException("Sla One Missing "); } else { validationStatus =
		 * true; }
		 * 
		 * 
		 * if (Strings.isNullOrEmpty(req.getParameter("slatwo"))) { throw new
		 * airlineDataManagerException("Sla two Missing "); } else { validationStatus =
		 * true; }
		 * 
		 * if (Strings.isNullOrEmpty(req.getParameter("emailid"))) { throw new
		 * airlineDataManagerException("User Email ID Missing"); } else {
		 * validationStatus = true; }
		 * 
		 */

		return validationStatus;
	}
	// ---------- End of Method ----------

}
