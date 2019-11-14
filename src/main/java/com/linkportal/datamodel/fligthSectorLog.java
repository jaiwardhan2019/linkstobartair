package com.linkportal.datamodel;

import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.io.Serializable;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Properties;

import org.springframework.context.annotation.Scope;
import org.springframework.web.context.WebApplicationContext;

@Scope(WebApplicationContext.SCOPE_REQUEST)
public class fligthSectorLog implements Serializable{
	

	private String flightDate;
	
	
	
	//---Air Craft Detail 
	private String aircraftReg;
	private String aircraftType;
	private String flightNo;
	
	
	//--Out Station
	private String from;
	private String to;
	
	

	
	
	//Flight Timing 
	
	private String std;
	private String etd;
	private String atd;
	private String airborn;	 
	private String eta;
	private String sta;
	private String ata;
	private String touchdown;
	private String AtaAtd;
	
	
	
	//------ PAX ------------
	private String noOfSeats;
	private String bookedPax;
	private String totalOnBoard;
	
	
	
	//Sector Comments
	private String sectorComments1;
	private String sectorComments2;
	private String sectorComments3;
	private String sectorComments4;
	
	


	
	
	// DELAYS CODE TIME DESCRIPTION
	private String delayCode1;
	private String delayCode1_time;
	private String delayCode1_desc;
	
	private String delayCode2;
	private String delayCode2_time;
	private String delayCode2_desc;
	
	private String delayCode3;
	private String delayCode3_time;
	private String delayCode3_desc;
	
	private String delayCode4;
	private String delayCode4_time;
	private String delayCode4_desc;
	
	
	// FLIGHT NOTE 
	private String flightnote;

	
	
	
	
	//-------- FUEL DETAIL-------------
	private String fuelAtthetimeofdep;
	private String fuelburn;
	private String fuelAtthetimeofarr;
	private String fuelUplift;
	
	
	
	
	//-------- CAPTION FIRST OFFICER DETAIL-------------
	private String flightCaption;
	private String flightFirstOfficer;
	
	
	
	public fligthSectorLog(String flightDate,String aircraftReg, String aircraftType, String flightNo, String from,
			String to, String std, String etd, String atd, String eta, String sta, String ata,  String airborn,String touchdown,String AtaAtd,String noOfSeats,
			String bookedPax, String totalOnBoard,String sectorComments1,String sectorComments2,String sectorComments3,String sectorComments4,
			  String delayCode1, String delayCode1_time,String delayCode1_desc,String delayCode2, String delayCode2_time,String delayCode2_desc,
			  String delayCode3, String delayCode3_time, String delayCode3_desc, String delayCode4,String delayCode4_time, String delayCode4_desc,
		      String fuelAtthetimeofdep,String fuelburn , String fuelAtthetimeofarr ,String fuelUplift,
		      String flightCaption , String flightFirstOfficer,String flightnote
			  ) 
	      {		
		
		super();
		this.flightDate = flightDate;
		this.aircraftReg = aircraftReg;
		this.aircraftType = aircraftType;
		this.flightNo = flightNo;
		this.from = from;
		this.to = to;
		this.std = std;
		this.etd = etd;
		this.atd = atd;
		this.eta = eta;
		this.sta = sta;
		this.ata = ata;		
		this.AtaAtd=AtaAtd;
		
		this.airborn=airborn;
		this.touchdown=touchdown;
		this.noOfSeats = noOfSeats;
		this.bookedPax = bookedPax;
		this.totalOnBoard = totalOnBoard;
		
		this.sectorComments1=sectorComments1;
		this.sectorComments2=sectorComments2;
		this.sectorComments3=sectorComments3;
		this.sectorComments4=sectorComments4;
		
		
		this.delayCode1=delayCode1;
		this.delayCode1_time=delayCode1_time;
		this.delayCode1_desc=delayCode1_desc;
		
		
		this.delayCode2=delayCode2;
		this.delayCode2_desc=delayCode2_desc;
		this.delayCode2_time=delayCode2_time;
		
		this.delayCode3=delayCode3;
		this.delayCode3_desc=delayCode3_desc;
		this.delayCode3_time=delayCode3_time;
		
		this.delayCode4=delayCode4;
		this.delayCode4_desc=delayCode4_desc;
		this.delayCode4_time=delayCode4_time;
	
		
		
		//-------- FUEL DETAIL-------------
		this.fuelAtthetimeofdep=fuelAtthetimeofdep;
		this.fuelburn=fuelburn;
		this.fuelAtthetimeofarr=fuelAtthetimeofarr;
		this.fuelUplift=fuelUplift;
		
		
		
		//-------- CAPTION FIRST OFFICER DETAIL-------------
		this.flightCaption=flightCaption;
		this.flightFirstOfficer=flightFirstOfficer;
		
		
		// FLIGHT NOTE -----------------
	    this.flightnote=flightnote;
		
		

	}//---------- End Of Constructor 



	


	




	//-------------- THis Function Will Built Delay Code Group Base on 4 given code -------------------- 
	public String IATA_DelCodeGroup() throws IOException {		   
    
	    
		 ClassLoader classLoader = this.getClass().getClassLoader();
		 File configFile=new File(classLoader.getResource("delaycodegroup.properties").getFile());
		 FileReader reader=new FileReader(configFile);
		 Properties p=new Properties(); 
		 p.load(reader);
	
		 String Delay_Code_Group="";
		 boolean commastatus=false;
		   
		    
		    if(this.getDelayCode1() != null) {
		    	Delay_Code_Group= Delay_Code_Group + p.getProperty(this.getDelayCode1());
		       	commastatus=true;
		    }
		    
		   
		   if(this.getDelayCode2() != null) {
		       if(commastatus) {
		         Delay_Code_Group= Delay_Code_Group + ","+p.getProperty(this.getDelayCode2());
		       }
		       else
		       {
		    	   Delay_Code_Group= Delay_Code_Group+p.getProperty(this.getDelayCode2()); 
		    	   commastatus=true;
		       }
		    	
		    }
		    
		   if(this.getDelayCode3() != null) {
			       if(commastatus) {
			         Delay_Code_Group= Delay_Code_Group + ","+p.getProperty(this.getDelayCode3());
			       }
			       else
			       {
			    	   Delay_Code_Group= Delay_Code_Group+p.getProperty(this.getDelayCode3()); 
			    	   commastatus=true;
			       }
			    	
			}
		    
		   if(this.getDelayCode4() != null) {
			       if(commastatus) {
			         Delay_Code_Group= Delay_Code_Group + ","+p.getProperty(this.getDelayCode4());
			       }
			       else
			       {
			    	   Delay_Code_Group= Delay_Code_Group+p.getProperty(this.getDelayCode4()); 
			    	   commastatus=true;
			       }
			    	
		   }
		  
		return Delay_Code_Group.trim();
		
	   
	}//--------------- End Of Function Delay Code.
	
	
	
	
	
	
	//------  USED IN THE VIEW JSP PAGE ---------------------------------
	public  List<String> getFlightNoteRemarks() throws IOException, ParseException, Exception {
	        
		
			 ClassLoader classLoader = this.getClass().getClassLoader();
			 File dbproperty=new File(classLoader.getResource("database.properties").getFile());
			 FileReader reader=new FileReader(dbproperty);
			 Properties dbp=new Properties(); 
			 dbp.load(reader);
			 
			 Class.forName(dbp.getProperty("sqlserver.datasource.driver-class-name"));	
			 java.sql.Connection conn = DriverManager.getConnection(dbp.getProperty("sqlserver.datasource.connectionurl"));
			 java.sql.Statement sta = conn.createStatement();				 
			 List<String> NoteRemark = new ArrayList<String>();
			 ResultSet rs1 =  sta.executeQuery("Select NOTE FROM DELAY_NOTES WHERE REPLACE(FLTID, ' ', '')='" +this.flightNo+"' and DATOP='"+this.flightDate+"'"); 
			 boolean recordnotexist=true;
			
			 while(rs1.next()){			  
			     NoteRemark.add(rs1.getString("NOTE"));
				 recordnotexist=false;	 
			 }
			 
			 //if(recordnotexist) {NoteRemark.add("");}
			 conn.close();
	       return NoteRemark;
   }//------------- End Of Function -----------


	
	
	
	//------  USED FOR EXCEL REPORT ---------------------------------
	public  String getFlightNoteRemarks_For_Excel() throws IOException, ParseException, Exception {
	        
		
			 ClassLoader classLoader = this.getClass().getClassLoader();
			 File dbproperty=new File(classLoader.getResource("database.properties").getFile());
			 FileReader reader=new FileReader(dbproperty);
			 Properties dbp=new Properties(); 
			 dbp.load(reader);
			 
			 Class.forName(dbp.getProperty("sqlserver.datasource.driver-class-name"));	
			 java.sql.Connection conn = DriverManager.getConnection(dbp.getProperty("sqlserver.datasource.connectionurl"));
			 java.sql.Statement sta = conn.createStatement();				 
			 String NoteRemark1="";
			 ResultSet rs1 =  sta.executeQuery("Select NOTE FROM DELAY_NOTES WHERE REPLACE(FLTID, ' ', '')='" +this.flightNo+"' and DATOP='"+this.flightDate+"'"); 
			 boolean recordnotexist=true;			
			 while(rs1.next()){			  
			     NoteRemark1=NoteRemark1+rs1.getString("NOTE");
				 recordnotexist=false;	 
			 }			 
			 if(recordnotexist) {NoteRemark1="";}
		
	       return NoteRemark1;
   }//------------- End Of Function -----------












	//----------- Return Total Delay in the hh:mm  format ----------
	public String getTotalDelayTime() throws ParseException {
		int totalDelayTime = 0;
		boolean foundstatus=false;
		if ( this.getDelayCode1() != null ) {
			totalDelayTime += Integer.valueOf(this.getDelayCode1_time());
			foundstatus=true;
		}	
		if ( this.getDelayCode2() != null ) {
			totalDelayTime += Integer.valueOf(this.getDelayCode2_time());
			foundstatus=true;
		}	
		if ( this.getDelayCode3() != null ) {
			totalDelayTime += Integer.valueOf(this.getDelayCode3_time());
			foundstatus=true;
		}	
		if ( this.getDelayCode4() != null ) {
			totalDelayTime += Integer.valueOf(this.getDelayCode4_time());
			foundstatus=true;
		}	
		
		if(foundstatus) {
			SimpleDateFormat sd = new SimpleDateFormat("mm");
			Date dt = sd.parse(Integer.toString(totalDelayTime));
			sd = new SimpleDateFormat("HH:mm");		
			return sd.format(dt);
		}
		else
		{
			return "";
		}
		
	}//------------ End of Function getTotalDelayTime()

	

	
	

	//-------- This will take Minutes and Convert into HH:MM  format like  70 -> 01:10 Minutes  
	public String getAtaMinusAtd() throws ParseException {		
		SimpleDateFormat sdf = new SimpleDateFormat("mm");
			Date dt = sdf.parse(this.getAtaAtd());
		    sdf = new SimpleDateFormat("HH:mm");
		    return sdf.format(dt);
	 	
	}
	
	
	
	

	//-------- This will take Date in YYYY-MM-DD format  and Convert into DD-MM-YYYY   
	public String getFlightDatop() throws ParseException {		
		    SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-mm-dd");
			Date dt1 = sdf1.parse(this.getFlightDate());
		    sdf1 = new SimpleDateFormat("dd-mm-yyyy");
		    return sdf1.format(dt1);
	 	
	}
	
	
	
		
	
	
	
	
	


	public String getFuelAtthetimeofdep() {
		return fuelAtthetimeofdep;
	}




	public void setFuelAtthetimeofdep(String fuelAtthetimeofdep) {
		this.fuelAtthetimeofdep = fuelAtthetimeofdep;
	}




	public String getFuelburn() {
		return fuelburn;
	}




	public void setFuelburn(String fuelburn) {
		this.fuelburn = fuelburn;
	}




	public String getFuelAtthetimeofarr() {
		return fuelAtthetimeofarr;
	}




	public void setFuelAtthetimeofarr(String fuelAtthetimeofarr) {
		this.fuelAtthetimeofarr = fuelAtthetimeofarr;
	}




	public String getFuelUplift() {
		return fuelUplift;
	}




	public void setFuelUplift(String fuelUplift) {
		this.fuelUplift = fuelUplift;
	}




	public String getFlightCaption() {
		return flightCaption;
	}




	public void setFlightCaption(String flightCaption) {
		this.flightCaption = flightCaption;
	}




	public String getFlightFirstOfficer() {
		return flightFirstOfficer;
	}




	public void setFlightFirstOfficer(String flightFirstOfficer) {
		this.flightFirstOfficer = flightFirstOfficer;
	}




	/**
	 * @return the tail
	 */
	public String getAircraftReg() {
		return aircraftReg;
	}
	
	
	/**
	 * @param tail the tail to set
	 */
	public void setAircraftReg(String aircraftReg) {
		this.aircraftReg = aircraftReg;
	}
	
	
	/**
	 * @return the aircraftType
	 */
	public String getAircraftType() {
		return aircraftType;
	}
	
	
	/**
	 * @param aircraftType the aircraftType to set
	 */
	public void setAircraftType(String aircraftType) {
		this.aircraftType = aircraftType;
	}
	
	
	/**
	 * @return the noOfSeats
	 */
	public String getNoOfSeats() {
		return noOfSeats;
	}
	
	
	/**
	 * @param noOfSeats the noOfSeats to set
	 */
	public void setNoOfSeats(String noOfSeats) {
		this.noOfSeats = noOfSeats;
	}
	
	
	/**
	 * @return the flightNo
	 */
	public String getFlightNo() {
		return flightNo;
	}
	
	
	/**
	 * @param flightNo the flightNo to set
	 */
	public void setFlightNo(String flightNo) {
		this.flightNo = flightNo;
	}
	
	
	
	
	/**
	 * @return the flightDate
	 */
	public String getFlightDate() {
		return flightDate;
	}
	
	
	/**
	 * @param flightDate the flightDate to set
	 */
	public void setFlightDate(String flightDate) {
		this.flightDate = flightDate;
	}

	
	
	
	
	
	
	
	public String getFrom() {
		return from;
	}






	public void setFrom(String from) {
		this.from = from;
	}






	public String getTo() {
		return to;
	}






	public void setTo(String to) {
		this.to = to;
	}






	public String getDelayCode1() {
		return delayCode1;
	}






	public void setDelayCode1(String delayCode1) {
		this.delayCode1 = delayCode1;
	}






	public String getDelayCode2() {
		return delayCode2;
	}






	public void setDelayCode2(String delayCode2) {
		this.delayCode2 = delayCode2;
	}






	/**
	 * @return the etd
	 */
	public String getEtd() {
		return etd;
	}
	
	
	/**
	 * @param etd the etd to set
	 */
	public void setEtd(String etd) {
		this.etd = etd;
	}
	
	
	/**
	 * @return the eta
	 */
	public String getEta() {
		return eta;
	}
	
	
	/**
	 * @param eta the eta to set
	 */
	public void setEta(String eta) {
		this.eta = eta;
	}
	
	
	/**
	 * @return the std
	 */
	public String getStd() {
		return std;
	}
	
	
	/**
	 * @param std the std to set
	 */
	public void setStd(String std) {
		this.std = std;
	}
	
	
	/**
	 * @return the sta
	 */
	public String getSta() {
		return sta;
	}
	
	
	/**
	 * @param sta the sta to set
	 */
	public void setSta(String sta) {
		this.sta = sta;
	}
	
	
	
	
	/**
	 * @return the atd
	 */
	public String getAtd() {
		return atd;
	}
	
	
	/**
	 * @param atd the atd to set
	 */
	public void setAtd(String atd) {
		this.atd = atd;
	}
	
	
	/**
	 * @return the ata
	 */
	public String getAta() {
		return ata;
	}
	
	
	/**
	 * @param ata the ata to set
	 */
	public void setAta(String ata) {
		this.ata = ata;
	}
	
	
	
	
	
	
	public String getAirborn() {
		return airborn;
	}






	public void setAirborn(String airborn) {
		this.airborn = airborn;
	}






	public String getTouchdown() {
		return touchdown;
	}






	public void setTouchdown(String touchdown) {
		this.touchdown = touchdown;
	}

   




	public void setAtaAtd(String ataAtd) {
		AtaAtd = AtaAtd;
	}

   


	public String getAtaAtd() {
		return AtaAtd;
	}



	/**
	 * @return the bookedPax
	 */
	public String getBookedPax() {
		return bookedPax;
	}
	
	
	/**
	 * @param bookedPax the bookedPax to set
	 */
	public void setBookedPax(String bookedPax) {
		this.bookedPax = bookedPax;
	}
	
	
	/**
	 * @return the totalOnBoard
	 */
	public String getTotalOnBoard() {
		return totalOnBoard;
	}
	
	
	/**
	 * @param totalOnBoard the totalOnBoard to set
	 */
	public void setTotalOnBoard(String totalOnBoard) {
		this.totalOnBoard = totalOnBoard;
	}






	public String getSectorComments1() {
		return sectorComments1;
	}






	public void setSectorComments1(String sectorComments1) {
		this.sectorComments1 = sectorComments1;
	}






	public String getSectorComments2() {
		return sectorComments2;
	}






	public void setSectorComments2(String sectorComments2) {
		this.sectorComments2 = sectorComments2;
	}






	public String getSectorComments3() {
		return sectorComments3;
	}






	public void setSectorComments3(String sectorComments3) {
		this.sectorComments3 = sectorComments3;
	}






	public String getSectorComments4() {
		return sectorComments4;
	}






	public void setSectorComments4(String sectorComments4) {
		this.sectorComments4 = sectorComments4;
	}






	public String getDelayCode1_time() throws ParseException {
		   //SimpleDateFormat sdf = new SimpleDateFormat("mm");
		   //Date dt = sdf.parse(this.delayCode1_time);
		   //sdf = new SimpleDateFormat("mm");
		  // System.out.println(sdf.format(dt));
		//return sdf.format(dt);
		return this.delayCode1_time;
	}






	public void setDelayCode1_time(String delayCode1_time) {
		this.delayCode1_time = delayCode1_time;
	}






	public String getDelayCode1_desc() {
		return delayCode1_desc;
	}






	public void setDelayCode1_desc(String delayCode1_desc) {
		this.delayCode1_desc = delayCode1_desc;
	}







	public String getDelayCode2_time() throws ParseException {
		  /* SimpleDateFormat sdf = new SimpleDateFormat("mm");
		   Date dt = sdf.parse(this.delayCode2_time);
		   sdf = new SimpleDateFormat("mmmm");
		return sdf.format(dt);
		*/
		return this.delayCode2_time;
	}







	public void setDelayCode2_time(String delayCode2_time) {
		this.delayCode2_time = delayCode2_time;
	}






	public String getDelayCode2_desc() {
		return delayCode2_desc;
	}






	public void setDelayCode2_desc(String delayCode2_desc) {
		this.delayCode2_desc = delayCode2_desc;
	}






	public String getDelayCode3() {
		return delayCode3;
	}






	public void setDelayCode3(String delayCode3) {
		this.delayCode3 = delayCode3;
	}







	public String getDelayCode3_time() throws ParseException {
		   SimpleDateFormat sdf = new SimpleDateFormat("mm");
		   Date dt = sdf.parse(this.delayCode3_time);
		   sdf = new SimpleDateFormat("mmmm");
		//return sdf.format(dt);
		   return this.delayCode3_time;
	}







	public void setDelayCode3_time(String delayCode3_time) {
		this.delayCode3_time = delayCode3_time;
	}






	public String getDelayCode3_desc() {
		return delayCode3_desc;
	}






	public void setDelayCode3_desc(String delayCode3_desc) {
		this.delayCode3_desc = delayCode3_desc;
	}






	public String getDelayCode4() {
		return delayCode4;
	}






	public void setDelayCode4(String delayCode4) {
		this.delayCode4 = delayCode4;
	}






	public String getDelayCode4_time() throws ParseException {
		   /*SimpleDateFormat sdf = new SimpleDateFormat("mm");
		   Date dt = sdf.parse(this.delayCode4_time);
		   sdf = new SimpleDateFormat("mmmm");
		return sdf.format(dt);*/
		return this.delayCode4_time;
	}






	public void setDelayCode4_time(String delayCode4_time) {
		this.delayCode4_time = delayCode4_time;
	}






	public String getDelayCode4_desc() {
		return delayCode4_desc;
	}






	public void setDelayCode4_desc(String delayCode4_desc) {
		this.delayCode4_desc = delayCode4_desc;
	}

    


	
	public String getFlightnote() {
		return flightnote;
	}
 
	

	public void setFlightnote(String flightnote) {
		this.flightnote = flightnote;
	}






	

}// --------------- End Of Main PoJo Class --------------------
