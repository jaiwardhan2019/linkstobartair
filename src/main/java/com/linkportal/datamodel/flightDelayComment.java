package com.linkportal.datamodel;

import java.io.Serializable;
import java.util.Date;

import org.apache.commons.codec.binary.Base64;


public class flightDelayComment implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = -9035123784258555856L;

	
	private String flightNumber;
	private String flightDate;	
	private String status;
	private String action;
	private String comments;
	private String dateTimeEntered;
	private String enteredBy;
	
	
	public flightDelayComment(String flightNumber, String flightDate, String status, String action, String comments,
			String dateTimeEntered, String enteredBy) {
		super();
		this.flightNumber = flightNumber;
		this.flightDate = flightDate;
		this.status = status;
		this.action = action;
		this.comments = comments;
		this.dateTimeEntered = dateTimeEntered;
		this.enteredBy = enteredBy;
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


	
	
	@Override
	public String toString() {
		return "flightDelayComment [flightNumber=" + flightNumber + ", flightDate=" + flightDate + ", status=" + status
				+ ", action=" + action + ", comments=" + comments + ", dateTimeEntered=" + dateTimeEntered
				+ ", enteredBy=" + enteredBy + "]";
	}
	
	
	
	
	
	
	
	
}
