package com.linkportal.contractmanager;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;



public class contractProfileRowmapper  implements  RowMapper<contractProfile>{
       
	   @Override 
 	   public contractProfile mapRow(ResultSet rs, int rowNum) throws SQLException {
            
		   contractProfile profile = new contractProfile(
				   rs.getInt("dept_sub_code"), 			
				   rs.getString("department"),
				   rs.getString("subdepartment"),
				   rs.getString("is_admin"));
		   
          return profile;
	   }

}
	   
