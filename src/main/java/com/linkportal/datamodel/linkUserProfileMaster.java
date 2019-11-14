package com.linkportal.datamodel;


/*--- THIS CALSS FILE IS USED IN THE HEADER.JSP FILE TO POPULTATE LINKS MENU AS PER PROFILE ASSIGNMENT
 * 
 * 
*/

public class linkUserProfileMaster {
	
	private Boolean flightReport;
	private Boolean flightReport_mayFlyReport;
	private Boolean flightReport_relablityReport;
	private Boolean flightReport_dailySummaryReport;
	
	public linkUserProfileMaster(Boolean flightReport, Boolean flightReport_mayFlyReport,
			Boolean flightReport_relablityReport, Boolean flightReport_dailySummaryReport) {
		super();
		this.flightReport = flightReport;
		this.flightReport_mayFlyReport = flightReport_mayFlyReport;
		this.flightReport_relablityReport = flightReport_relablityReport;
		this.flightReport_dailySummaryReport = flightReport_dailySummaryReport;
	}

	
	public Boolean getFlightReport() {
		return flightReport;
	}

	public void setFlightReport(Boolean flightReport) {
		this.flightReport = flightReport;
	}

	public Boolean getFlightReport_mayFlyReport() {
		return flightReport_mayFlyReport;
	}

	public void setFlightReport_mayFlyReport(Boolean flightReport_mayFlyReport) {
		this.flightReport_mayFlyReport = flightReport_mayFlyReport;
	}

	public Boolean getFlightReport_relablityReport() {
		return flightReport_relablityReport;
	}

	
	public void setFlightReport_relablityReport(Boolean flightReport_relablityReport) {
		this.flightReport_relablityReport = flightReport_relablityReport;
	}

	
	public Boolean getFlightReport_dailySummaryReport() {
		return flightReport_dailySummaryReport;
	}

	
	public void setFlightReport_dailySummaryReport(Boolean flightReport_dailySummaryReport) {
		this.flightReport_dailySummaryReport = flightReport_dailySummaryReport;
	}
	
	
	
	
	
	
}// ----------- End Of Class -------------- 
