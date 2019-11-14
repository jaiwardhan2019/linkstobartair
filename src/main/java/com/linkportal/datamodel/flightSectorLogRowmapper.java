package com.linkportal.datamodel;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;
import java.util.List;

import org.springframework.jdbc.core.RowMapper;

public class flightSectorLogRowmapper implements  RowMapper<fligthSectorLog> {

	@Override
	public fligthSectorLog mapRow(ResultSet rs, int rowNum) throws SQLException {		   
		   		   
		   fligthSectorLog flt = new fligthSectorLog(
				   rs.getString("FLIGHT_DATE"),
				   rs.getString("LONG_REG"),
				   rs.getString("ACTYP"),
				   rs.getString("FLTID"),
				   rs.getString("DEPSTN"),			
				   rs.getString("ARRSTN"),				   
				   rs.getString("STD_DATE_TIME"),
				   rs.getString("ETD_DATE_TIME"),
				   rs.getString("ATD_DATE_TIME"),
				   rs.getString("ETA_DATE_TIME"),
				   rs.getString("STA_DATE_TIME"),
				   rs.getString("ATA_DATE_TIME"),
				   rs.getString("TOFF_DATE_TIME"),
				   rs.getString("TDWN_DATE_TIME"),
				   rs.getString("ATA_ATD"),				   
				   rs.getString("SCR_SEATS"),
				   rs.getString("BOOKED"),
				   rs.getString("PAX"),
				   
				   //---------- This Part is For the Sector Comment 
				   rs.getString("note1"),
				   rs.getString("note2"),
				   rs.getString("note3"),
				   rs.getString("note4"),
				   
				 //---------- This Part is For Delay Code and Desc. 
				   rs.getString("DELAY_CODE_1"),
				   rs.getString("DUR1"),
				   rs.getString("DELAY_CODE_1_DESCRIPTION"),
				   
				   rs.getString("DELAY_CODE_2"),
				   rs.getString("DUR2"),
				   rs.getString("DELAY_CODE_2_DESCRIPTION"),

				   rs.getString("DELAY_CODE_3"),
				   rs.getString("DUR3"),
				   rs.getString("DELAY_CODE_3_DESCRIPTION"),

				   rs.getString("DELAY_CODE_4"),
				   rs.getString("DUR4"),
				   rs.getString("DELAY_CODE_4_DESCRIPTION"),
				   
				   rs.getString("DEPFOB"),
				   rs.getString("BURN"),
				   rs.getString("ARRFOB"),
				   rs.getString("uplift1"),
				   rs.getString("Captain"),
				   rs.getString("FirstOfficer"),
				   rs.getString("note")				   
				   
				   );
		   
	       return flt;
	}
	


}//  End of function 
