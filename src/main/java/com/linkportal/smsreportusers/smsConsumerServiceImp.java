package com.linkportal.smsreportusers;

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
import org.springframework.jdbc.support.rowset.SqlRowSet;
import org.springframework.stereotype.Repository;
import com.google.common.base.Strings;
import com.linkportal.contractmanager.stobartContractRowmapper;
import com.linkportal.datamodel.flightSectorLogRowmapper;
import com.linkportal.datamodel.fligthSectorLog;
import com.linkportal.exception.smsReportUserException;
import com.linkportal.fltreport.flightReportsImp;
import com.linkportal.groundops.gopsAllapi;

@Repository
public class smsConsumerServiceImp implements smsConsumerService {

	@Autowired
	DataSource dataSourcesqlservercp;

	
	// ---------- Logger Initializer-------------------------------
	private final Logger logger = Logger.getLogger(flightReportsImp.class);

	JdbcTemplate jdbcTemplateSqlServerCp;

	smsConsumerServiceImp(DataSource dataSourcesqlservercp) {
		jdbcTemplateSqlServerCp = new JdbcTemplate(dataSourcesqlservercp);
	}

	// --- Created New User in DB
	@Override
	public boolean addSmsUser(HttpServletRequest req) throws smsReportUserException, SQLException {
		boolean updateStatus = false;
		if (validateFormData(req)) {
			DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");
			LocalDateTime currentdateandtime = LocalDateTime.now();
			String sqlinsert = null;
			sqlinsert = "INSERT INTO Gops_Sms_Report_Users (userGroup,userFirstName,userLastName,userPhoneNo,addedDate,addedByUserName)  "
					+ "VALUES('" + req.getParameter("department") + "','" + req.getParameter("firstname") + "','"
					+ req.getParameter("lastname") + "','" + req.getParameter("phoneno") + "','"
					+ currentdateandtime.toString() + "','" + req.getParameter("emailid") + "')";
			jdbcTemplateSqlServerCp.execute(sqlinsert);
		}

		req = null;
		return updateStatus;
	}

	// --- Created New User in DB
	@Override
	public boolean updateSmsUser(HttpServletRequest req) throws smsReportUserException, SQLException {

		boolean updateStatus = false;
		if (validateFormData(req)) {
			DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");
			LocalDateTime currentdateandtime = LocalDateTime.now();
			String sqlinsert = null;
			Connection conn = dataSourcesqlservercp.getConnection();
			sqlinsert = "UPDATE Gops_Sms_Report_Users  SET  userGroup = ? , userFirstName = ?, "
					+ "      userLastName = ?, userPhoneNo=?  WHERE userId=?";
			PreparedStatement pstm = conn.prepareStatement(sqlinsert);
			pstm.setString(1, req.getParameter("department"));
			pstm.setString(2, req.getParameter("firstname"));
			pstm.setString(3, req.getParameter("lastname"));
			pstm.setString(4, req.getParameter("phoneno"));
			pstm.setString(5, req.getParameter("userinsubject"));
			int rows = pstm.executeUpdate();
			updateStatus = true;

		}
		req = null;
		return updateStatus;
	}

	// --- Remove User
	@Override
	public void removeSmsUser(String userId) {
		jdbcTemplateSqlServerCp.execute("delete from Gops_Sms_Report_Users where userid=" + userId);
	}

	// ---------- Find User
	@Override
	public smsConsumerEntity findSmsUser(String userId) {
		return jdbcTemplateSqlServerCp.queryForObject("select * from Gops_Sms_Report_Users where userid=?",
				new Object[] { userId }, new smsConsumerEntityRowmapper());
	}

	// ---------- List all User
	@Override
	public List<smsConsumerEntity> listSmsUser() {
		List<smsConsumerEntity> smsUserList = jdbcTemplateSqlServerCp
				.query("select * from Gops_Sms_Report_Users order by userid desc", new smsConsumerEntityRowmapper());
		return smsUserList;
	}

	// -------- form field validation..
	private boolean validateFormData(HttpServletRequest req) throws smsReportUserException {
		boolean validationStatus = false;
		if (Strings.isNullOrEmpty(req.getParameter("firstname"))) {
			throw new smsReportUserException("First Name is missing ");
		} else {
			validationStatus = true;
		}
		if (Strings.isNullOrEmpty(req.getParameter("lastname"))) {
			throw new smsReportUserException("Last Name missing ");
		} else {
			validationStatus = true;
		}
		if (Strings.isNullOrEmpty(req.getParameter("phoneno"))) {
			throw new smsReportUserException("Phone No missing ");
		} else {
			validationStatus = true;
		}
		if (Strings.isNullOrEmpty(req.getParameter("department"))) {
			throw new smsReportUserException("Department missing ");
		} else {
			validationStatus = true;
		}
		return validationStatus;
	}
	// ---------- End of Method ----------

}
