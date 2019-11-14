package com.linkportal.datamodel;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

public class delaycodeGroupMasterRowmapper implements  RowMapper<delaycodeGroupMaster> {
	
	
	@Override
	public delaycodeGroupMaster mapRow(ResultSet rs, int rowNum) throws SQLException {	
		   delaycodeGroupMaster code = new delaycodeGroupMaster(rs.getString("dcode_group"),rs.getString("delcount"));
		   return code;
	}
	

}//  End of function 
