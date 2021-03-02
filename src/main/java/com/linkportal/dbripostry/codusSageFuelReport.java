package com.linkportal.dbripostry;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

public interface codusSageFuelReport {
	
	
	public List<codusSageFuelInvoice> populateFuelInvoices(HttpServletRequest req); 
	
	

}
