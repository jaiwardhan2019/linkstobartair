package com.linkportal.datamodel;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;
import java.util.List;

import org.springframework.jdbc.core.RowMapper;

public class crewDetailRowmapper implements  RowMapper<crewDetail> {

	@Override
	public crewDetail mapRow(ResultSet rs, int rowNum) throws SQLException {		   
		   		   
		crewDetail crew = new crewDetail(
				   rs.getString("CREW_NO"),
				   rs.getString("CREW_FIRSTNAME"),
				   rs.getString("CREW_LASTNAME"),
				   rs.getString("POSITION"));		   
	       return crew;
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
