package com.linkportal.datamodel;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;
import java.util.List;

import org.springframework.jdbc.core.RowMapper;

public class crewDetailForDateFlightRowmapper implements  RowMapper<crewDetailForDateFlight> {

	@Override
	public crewDetailForDateFlight mapRow(ResultSet rs, int rowNum) throws SQLException {		   
		   		   
		crewDetailForDateFlight crewDetail = new crewDetailForDateFlight(
				   rs.getString("DATOP"),
				   rs.getString("FLTID"),
				   rs.getString("CREW_NO"),
				   rs.getString("CREW_NAME"),				   
				   rs.getString("POSITION"),
				   rs.getString("P_OR_C"));		  
		
	       return crewDetail;
	}
	


}//  End of function 



