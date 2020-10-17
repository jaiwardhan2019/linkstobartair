package com.linkportal.airLineManager;

public class airLineEntity {
	
	private int  id;
	private String iata_code;
	private String icao_code;
	private String airline_name;
	private String status;
	private String sla_one;
	private String sla_two;
	private String comment;
	private String createdbyuseremail;
	private String createddate;
	
	
	
	public airLineEntity(int id, String iata_code, String icao_code, String airline_name, String status, String sla_one,
			String sla_two, String comment, String createdbyuseremail, String createddate) {
		super();
		this.id = id;
		this.iata_code = iata_code;
		this.icao_code = icao_code;
		this.airline_name = airline_name;
		this.status = status;
		this.sla_one = sla_one;
		this.sla_two = sla_two;
		this.comment = comment;
		this.createdbyuseremail = createdbyuseremail;
		this.createddate = createddate;
	}



	public int getId() {
		return id;
	}



	public void setId(int id) {
		this.id = id;
	}



	public String getIata_code() {
		return iata_code;
	}



	public void setIata_code(String iata_code) {
		this.iata_code = iata_code;
	}



	public String getIcao_code() {
		return icao_code;
	}



	public void setIcao_code(String icao_code) {
		this.icao_code = icao_code;
	}



	public String getAirline_name() {
		return airline_name;
	}



	public void setAirline_name(String airline_name) {
		this.airline_name = airline_name;
	}



	public String getStatus() {
		return status;
	}



	public void setStatus(String status) {
		this.status = status;
	}



	public String getSla_one() {
		return sla_one;
	}



	public void setSla_one(String sla_one) {
		this.sla_one = sla_one;
	}



	public String getSla_two() {
		return sla_two;
	}



	public void setSla_two(String sla_two) {
		this.sla_two = sla_two;
	}



	public String getComment() {
		return comment;
	}



	public void setComment(String comment) {
		this.comment = comment;
	}



	public String getCreatedbyuseremail() {
		return createdbyuseremail;
	}



	public void setCreatedbyuseremail(String createdbyuseremail) {
		this.createdbyuseremail = createdbyuseremail;
	}



	public String getCreateddate() {
		return createddate;
	}



	public void setCreateddate(String createddate) {
		this.createddate = createddate;
	}



	@Override
	public String toString() {
		return "airLineEntity [id=" + id + ", iata_code=" + iata_code + ", icao_code=" + icao_code + ", airline_name="
				+ airline_name + ", status=" + status + ", sla_one=" + sla_one + ", sla_two=" + sla_two + ", comment="
				+ comment + ", createdbyuseremail=" + createdbyuseremail + ", createddate=" + createddate + "]";
	}
	
	
	
	
	
	

}
