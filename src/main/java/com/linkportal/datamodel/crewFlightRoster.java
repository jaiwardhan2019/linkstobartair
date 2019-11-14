package com.linkportal.datamodel;

import java.io.Serializable;

import org.springframework.context.annotation.Scope;
import org.springframework.web.context.WebApplicationContext;

/*
 * THIS POJO CLASS WILL BE USE FOR THE VOYAGER REPORT WHERE CREW CAN SEE THEIR SCHEDULE FLIGHT 
 * FOR TODAY AND TOMORROW 
 * 
 * */
@Scope(WebApplicationContext.SCOPE_REQUEST)
public class crewFlightRoster implements Serializable {
	
	private String datop;
	private String flightreg;
	private String fltid;
	private String fromstn;
	private String tostn;
	private String std;
	private String sta;
	private String block;
	
	private  String note;
	private  String note1;
	private  String note2;
	private  String note3;
	private  String note4;
	
	
	
	public crewFlightRoster(String datop, String flightreg, String fltid, String fromstn, String tostn, String std,
			String sta, String block, String note, String note1, String note2, String note3, String note4) {
		super();
		this.datop = datop;
		this.flightreg = flightreg;
		this.fltid = fltid;
		this.fromstn = fromstn;
		this.tostn = tostn;
		this.std = std;
		this.sta = sta;
		this.block = block;
		this.note = note;
		this.note1 = note1;
		this.note2 = note2;
		this.note3 = note3;
		this.note4 = note4;
	}



	public String getDatop() {
		return datop;
	}



	public void setDatop(String datop) {
		this.datop = datop;
	}



	public String getFlightreg() {
		return flightreg;
	}



	public void setFlightreg(String flightreg) {
		this.flightreg = flightreg;
	}



	public String getFltid() {
		return fltid;
	}



	public void setFltid(String fltid) {
		this.fltid = fltid;
	}



	public String getFromstn() {
		return fromstn;
	}



	public void setFromstn(String fromstn) {
		this.fromstn = fromstn;
	}



	public String getTostn() {
		return tostn;
	}



	public void setTostn(String tostn) {
		this.tostn = tostn;
	}



	public String getStd() {
		return std;
	}



	public void setStd(String std) {
		this.std = std;
	}



	public String getSta() {
		return sta;
	}



	public void setSta(String sta) {
		this.sta = sta;
	}



	public String getBlock() {
		return block;
	}



	public void setBlock(String block) {
		this.block = block;
	}



	public String getNote() {
		return note;
	}



	public void setNote(String note) {
		this.note = note;
	}



	public String getNote1() {
		return note1;
	}



	public void setNote1(String note1) {
		this.note1 = note1;
	}



	public String getNote2() {
		return note2;
	}



	public void setNote2(String note2) {
		this.note2 = note2;
	}



	public String getNote3() {
		return note3;
	}



	public void setNote3(String note3) {
		this.note3 = note3;
	}



	public String getNote4() {
		return note4;
	}



	public void setNote4(String note4) {
		this.note4 = note4;
	}



	
	
	@Override
	public String toString() {
		return "crewFlightRoster [datop=" + datop + ", flightreg=" + flightreg + ", fltid=" + fltid + ", fromstn="
				+ fromstn + ", tostn=" + tostn + ", std=" + std + ", sta=" + sta + ", block=" + block + ", note=" + note
				+ ", note1=" + note1 + ", note2=" + note2 + ", note3=" + note3 + ", note4=" + note4 + "]";
	}
	
	
	
	
	
	

}//-------- END OF CLASS ------------
