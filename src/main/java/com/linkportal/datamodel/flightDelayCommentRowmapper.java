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
				   rs.getString("Action_Status]"),
				   rs.getString("Comment"),
				   rs.getString("Entry_Date_Time"),
				   rs.getString("Entery_By"));		   
	       return delcomment;
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
