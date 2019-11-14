package com.linkportal.datamodel;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;
import java.util.List;

import org.springframework.jdbc.core.RowMapper;

public class crewFlightRosterRowmapper implements  RowMapper<crewFlightRoster> {

	@Override
	public crewFlightRoster mapRow(ResultSet rs, int rowNum) throws SQLException {		   
		
		/*
		crewFlightRoster crewRsoter = new crewFlightRoster(
				   rs.getString("CREW_NO"),
				   rs.getString("CREW_NAME"),
				   rs.getString("POSITION"));	
		
		
	       return crewRsoter;
	*/
		return null;
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
