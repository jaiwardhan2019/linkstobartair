package com.linkportal.groundops;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.linkportal.groundops.refisUsers;

public class refisUsersRowmapper implements  RowMapper<refisUsers> {

	@Override
	public refisUsers mapRow(ResultSet rs, int rowNum) throws SQLException {
		
		refisUsers refisAccount = new refisUsers(				   
				   rs.getString("first_name"),
				   rs.getString("gh_password"),
				   rs.getString("description"),
				   rs.getString("email_id"),				
		           rs.getString("active_status"));
				   
	       return refisAccount;

	    }

}
