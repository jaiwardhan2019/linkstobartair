package com.linkportal.dbripostry;

import java.time.Year;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.google.common.base.Strings;
import com.linkportal.datamodel.flightSectorLogRowmapper;
import com.linkportal.datamodel.fligthSectorLog;

@Repository
public class codusSageFuelReportImp implements codusSageFuelReport {

	private static final String MasterSqlForallInvoice = "SELECT top 1000 scheme.Codisplinvdm.item As Invoice_No,\r\n"
			+ "scheme.Codisplinvdm.date_1 As DATE1 , scheme.Codisplinvhm.batch as Batch,\r\n"
			+ "scheme.Codisplinvhm.analysis_codes2 as Financial_Year , scheme.Codisplinvhm.period ,\r\n"
			+ "scheme.Codisplinvhm.supplier as Supplier_Code, scheme.Codisplinvhm.name as Supplier_Name, \r\n"
			+ "scheme.Codisplinvhm.analysis_codes3 As Franchise, scheme.Codisplinvdm.nominal_code As Nominal_Code,\r\n"
			+ "scheme.Codisplinvdm.vat_code, scheme.Codisplinvdm.local_value AS Amount_From_Line_Item_Table,\r\n"
			+ "scheme.Codisplinvdm.analysis_1 AS IATA_CODE , scheme.Codisplinvdm.analysis_2 AS Ticket_No,\r\n"
			+ "scheme.Codisplinvdm.analysis_3 AS Flight_No, scheme.Codisplinvdm.analysis_4 AS Aircraft_Reg,\r\n"
			+ "scheme.Codisplinvdm.name_1 AS TYPE_FUEL_AIRPORT_FEE, scheme.Codisplinvdm.value_1\r\n"
			+ "FROM scheme.Codisplinvhm  JOIN scheme.Codisplinvdm  ON scheme.Codisplinvhm.item = scheme.Codisplinvdm.item \r\n"
			+ "and scheme.Codisplinvhm.supplier = scheme.Codisplinvdm.supplier\r\n"
			+ "where scheme.Codisplinvdm.nominal_code in ('R026-3-20-10-010','R026-3-20-10-005') ";
	
	private static final String CurrentYearLasttwoDigit = Year.now().toString().substring(2);

	
	
	@Autowired
	DataSource datasourceaalive;

	JdbcTemplate jdbcTemplate;

	public codusSageFuelReportImp(DataSource datasourceaalive) {
		this.jdbcTemplate = new JdbcTemplate(datasourceaalive);
	}

	@Override
	public List<codusSageFuelInvoice> populateFuelInvoices(HttpServletRequest req) {


		String sqlForInvoiceList = MasterSqlForallInvoice;

		if (!Strings.isNullOrEmpty(req.getParameter("batch"))) {
			sqlForInvoiceList = sqlForInvoiceList + "and scheme.Codisplinvhm.batch like '%" + req.getParameter("batch")+"%'";
		}
		
		if (!Strings.isNullOrEmpty(req.getParameter("invoiceno"))) {
			sqlForInvoiceList = sqlForInvoiceList + "and scheme.Codisplinvdm.item like '%"+ req.getParameter("invoiceno") + "%'";
		}

		if (!Strings.isNullOrEmpty(req.getParameter("financialyear"))) {
			sqlForInvoiceList = sqlForInvoiceList + "and scheme.Codisplinvhm.analysis_codes2 like '%"+req.getParameter("financialyear") + "'";
		} 
		else 
		{
			sqlForInvoiceList = sqlForInvoiceList + "and scheme.Codisplinvhm.analysis_codes2 like '%"+CurrentYearLasttwoDigit+"'";

		}
		sqlForInvoiceList = sqlForInvoiceList + " order by DATE1";
		//System.out.println(sqlForInvoiceList);
		List<codusSageFuelInvoice> invoiceList = jdbcTemplate.query(sqlForInvoiceList,new codusSageFuelInvoiceRowmapper());

		return invoiceList;
	}

	
	
}
