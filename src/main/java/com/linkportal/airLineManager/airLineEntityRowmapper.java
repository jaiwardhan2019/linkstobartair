package com.linkportal.airLineManager;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;


public class airLineEntityRowmapper implements  RowMapper<airLineEntity> {

	@Override
	public airLineEntity mapRow(ResultSet rs, int rowNum) throws SQLException {
		airLineEntity  entityRow = new airLineEntity(rs.getInt("id"),rs.getString("iata_code"),rs.getString("icao_code"),rs.getString("airline_name"),rs.getString("status") ,rs.getString("sla_one") , rs.getString("sla_two"), 
				rs.getString("comment"), rs.getString("createdbyuseremail"),rs.getString("createddate"));
		return entityRow;
	}

}
