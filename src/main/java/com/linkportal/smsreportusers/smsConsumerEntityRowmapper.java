package com.linkportal.smsreportusers;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.linkportal.groundops.refisUsers;

public class smsConsumerEntityRowmapper implements  RowMapper<smsConsumerEntity> {

	@Override
	public smsConsumerEntity mapRow(ResultSet rs, int rowNum) throws SQLException {
		smsConsumerEntity smsUsr = new smsConsumerEntity(rs.getInt("userId"),rs.getString("userGroup"), rs.getString("userFirstName"), 
				rs.getString("userLastName"),rs.getString("userPhoneNo") , rs.getString("addedByUserName") ,rs.getString("addedDate"));
		return smsUsr;
	}
	

}
