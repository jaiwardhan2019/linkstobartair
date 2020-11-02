package com.linkportal.datamodel;

import java.io.Serializable;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.time.format.DateTimeFormatter;  
import java.time.LocalDateTime;  

import org.apache.commons.codec.binary.Base64;


public class flightDelayComment implements Serializable {


	private static final long serialVersionUID = -9035123784258555856L;

	
	private String flightNumber;
	private String flightDate;	
	
	private String status;
	private String action;
	private String comments;
	private String stobartdelay;
	private String dateTimeEntered;
	private String dateTimeClosed;
	private String enteredBy;
	
	
	public flightDelayComment(String flightNumber, String flightDate, String status, String action, String comments, String stobartdelay,
			String dateTimeEntered,String dateTimeClosed, String enteredBy) {
		super();
		this.flightNumber = flightNumber;
		this.flightDate = flightDate;
		this.status = status;
		this.action = action;
		this.comments = comments;
		this.stobartdelay = stobartdelay;
		this.dateTimeEntered = dateTimeEntered;
		this.dateTimeClosed = dateTimeClosed;
		this.enteredBy = enteredBy;
	}

		

	public String getDateTimeClosed() {
		return dateTimeClosed;
	}



	public void setDateTimeClosed(String dateTimeClosed) {
		this.dateTimeClosed = dateTimeClosed;
	}



	public String getFlightNumber() {
		return flightNumber;
	}


	public void setFlightNumber(String flightNumber) {
		this.flightNumber = flightNumber;
	}


	public String getFlightDate() {
		return flightDate;
	}


	public void setFlightDate(String flightDate) {
		this.flightDate = flightDate;
	}


	public String getStatus() {
		return status;
	}


	public void setStatus(String status) {
		this.status = status;
	}


	public String getAction() {
		return action;
	}


	public void setAction(String action) {
		this.action = action;
	}


	public String getComments() {
		return comments;
	}


	public String getStobartdelay() {
		return stobartdelay;
	}



	public void setStobartdelay(String stobartdelay) {
		this.stobartdelay = stobartdelay;
	}



	public void setComments(String comments) {
		this.comments = comments;
	}


	public String getDateTimeEntered() {
		return dateTimeEntered;
	}


	public void setDateTimeEntered(String dateTimeEntered) {
		this.dateTimeEntered = dateTimeEntered;
	}


	public String getEnteredBy() {
		return enteredBy;
	}


	public void setEnteredBy(String enteredBy) {
		this.enteredBy = enteredBy;
	}


	public static long getSerialversionuid() {
		return serialVersionUID;
	}



	public long noofDaysOpened() throws ParseException {

		SimpleDateFormat sdformat = new SimpleDateFormat("dd/MM/yyyy HH:mm");
		Date firstDate = sdformat.parse(this.dateTimeEntered);
		long noOfDateDifference=0;
		
		
		if(this.status.equalsIgnoreCase("close")){
			Date secondDate = sdformat.parse(this.dateTimeClosed);
			noOfDateDifference= ( (secondDate.getTime() - firstDate.getTime()) / (1000 * 60 * 60 * 24));
			this.setAction("taken");
		}


		if(this.status.equalsIgnoreCase("open")){
			Date secondDate = sdformat.parse(sdformat.format(new Date()));
			noOfDateDifference=(int)( (secondDate.getTime() - firstDate.getTime()) / (1000 * 60 * 60 * 24));
		}
		return noOfDateDifference;
	}



	@Override
	public String toString() {
		return "flightDelayComment [flightNumber=" + flightNumber + ", flightDate=" + flightDate + ", status=" + status
				+ ", action=" + action + ", comments=" + comments + ", stobartdelay=" + stobartdelay
				+ ", dateTimeEntered=" + dateTimeEntered + ", dateTimeClosed=" + dateTimeClosed + ", enteredBy="
				+ enteredBy + "]";
	}
	
	
	
		
	
	
	
	
}
