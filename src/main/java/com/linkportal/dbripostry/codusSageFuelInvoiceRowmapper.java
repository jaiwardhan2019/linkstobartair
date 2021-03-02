package com.linkportal.dbripostry;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;



public class codusSageFuelInvoiceRowmapper implements  RowMapper<codusSageFuelInvoice> {

	@Override
	public codusSageFuelInvoice mapRow(ResultSet rs, int rowNum) throws SQLException {
		
		codusSageFuelInvoice invObj = new codusSageFuelInvoice(
		rs.getString("Invoice_No"),
		rs.getString("DATE1"),
		rs.getString("Batch"),
		rs.getString("Financial_Year"),
		rs.getString("period"),		
		rs.getString("Supplier_Code"),		
		rs.getString("Supplier_Name"),		
		rs.getString("Franchise"),			
		rs.getString("Nominal_Code"),		
		rs.getString("vat_code"),
		rs.getString("Amount_From_Line_Item_Table"),
		rs.getString("IATA_CODE"),
		rs.getString("Ticket_No"),
		rs.getString("Flight_No"),
		rs.getString("Aircraft_Reg"),
		rs.getString("TYPE_FUEL_AIRPORT_FEE"),
		rs.getString("value_1")
		);
		return invObj;
	}
    
  
}