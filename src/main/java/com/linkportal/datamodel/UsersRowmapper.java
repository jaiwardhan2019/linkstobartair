package com.linkportal.datamodel;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;
import java.util.List;

import org.springframework.jdbc.core.RowMapper;

public class UsersRowmapper implements  RowMapper<Users> {

	@Override
	public Users mapRow(ResultSet rs, int rowNum) throws SQLException {		   
		   		   
		Users linkuser = new Users(
				   rs.getString("FIRST_NAME"),
				   rs.getString("LAST_NAME"),
				   rs.getString("EMAIL_ID"),
				   rs.getString("ACTIVE_STATUS"),
				   rs.getString("ADMIN_STATUS"),
				   rs.getString("LAST_LOGIN_DATE_TIME"),
				   rs.getString("INTERNAL_EXTERNAL_USER"));
		   
	       return linkuser;
	}
	


}//  End of function 
