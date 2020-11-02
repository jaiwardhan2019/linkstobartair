package com.linkportal.datamodel;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;
import java.util.List;

import org.springframework.jdbc.core.RowMapper;

public class flightDelayCommentRowmapper implements  RowMapper<flightDelayComment> {

	@Override
	public flightDelayComment mapRow(ResultSet rs, int rowNum) throws SQLException {		   
		   		   
		flightDelayComment delcomment = new flightDelayComment(
				   rs.getString("Flight_No"),
				   rs.getString("Flight_Date"),
				   rs.getString("Status"),
				   rs.getString("Action_Status"),
				   rs.getString("Comment"),
				   rs.getString("stobart_attributable_Delay"),
				   rs.getString("Entry_Date_Time"),
				   rs.getString("Closing_Date_Time"),
				   rs.getString("Entery_By"));	
	       return delcomment;
	}


}//  End of function 

