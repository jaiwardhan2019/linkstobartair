package com.linkportal.refis;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.linkportal.refis.refisUsers;

public class refisUsersRowmapper implements  RowMapper<refisUsers> {

	@Override
	public refisUsers mapRow(ResultSet rs, int rowNum) throws SQLException {
		
		refisUsers refisAccount = new refisUsers(				   
				   rs.getString("username"),
				   rs.getString("password"),
				   rs.getString("description"),
				   rs.getString("email"),				
		           rs.getInt("enabled"));
				   
	       return refisAccount;

	    }

}
