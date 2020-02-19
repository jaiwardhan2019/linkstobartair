package com.linkportal.docmanager;

public interface pdfWordReportBuilder {	
	   
	   //******** FOR THE DAILY SUMMARY REPORT ********
	   public void createDailySummaryReport_PDF(String airline , String Operation , String datop , String useremail);
	   
	   public void createDailySummaryReport_DOC(String airline , String Operation , String datop , String useremail);
	   
	
}
