package com.linkportal.contractmanager;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;



public class stobartContractRowmapper  implements  RowMapper<stobartContract>{
       
	   @Override 
 	   public stobartContract mapRow(ResultSet rs, int rowNum) throws SQLException {
            
		   stobartContract ctrAccount = new stobartContract(
			
				   rs.getString("department"),
				   rs.getString("sub_department"),
				   rs.getString("contractor_name"),
				   rs.getString("contractor_contact_detail"),
				   rs.getString("refrence_no"),
				   rs.getString("description"),				   
				   rs.getString("status"),
				   rs.getString("start_date"),
				   rs.getString("end_date"),				
		           rs.getString("entered_by_email"));
		   
          return ctrAccount;
	   }

}
	   
