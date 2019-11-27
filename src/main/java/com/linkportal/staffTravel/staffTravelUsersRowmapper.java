package com.linkportal.staffTravel;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.linkportal.datamodel.Users;

public class staffTravelUsersRowmapper implements  RowMapper<staffTravelUsers> {

	@Override
	public staffTravelUsers mapRow(ResultSet rs, int rowNum) throws SQLException {
		
		staffTravelUsers staffAccount = new staffTravelUsers(
				   rs.getInt("id"),
				   rs.getString("department"),
				   rs.getString("email"),
				   rs.getString("first_name"),
				   rs.getString("surname"),
				   rs.getString("status"));
	       return staffAccount;

	}

}
