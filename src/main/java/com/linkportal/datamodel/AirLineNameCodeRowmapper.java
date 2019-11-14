package com.linkportal.datamodel;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;
import java.util.List;

import org.springframework.jdbc.core.RowMapper;

public class AirLineNameCodeRowmapper implements  RowMapper<AirLineNameCode> {

	@Override
	public AirLineNameCode mapRow(ResultSet rs, int rowNum) throws SQLException {		   
		   		   
		AirLineNameCode airline = new AirLineNameCode(
				   rs.getString("name"),
				   rs.getString("iata_code"),
				   rs.getString("icao_code"));		   
	       return airline;
	}
	


}//  End of function 



  /*****  SAMPLE RETURNING STRING LIST FROM JDBCTEMPLET ******************
   List<String> names = jdbcTemplateMysql.query(sql1, new RowMapper<String>() {
	      public String mapRow(ResultSet resultSet, int i) throws SQLException {
	        return resultSet.getString("name");
	      }
	    });
   
   System.out.println(names);
   */
