package com.linkportal.sql;

import java.io.Serializable;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.context.annotation.Scope;
import org.springframework.web.context.WebApplicationContext;

/*
 * This Class File Contain all SQL required for this entire project
 * 
 */
@Scope(WebApplicationContext.SCOPE_REQUEST)
public class GroundOpsSqlBuilder implements Serializable{
	

	private final DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
	private final Date date             = new Date();
	private final String curent_date    = dateFormat.format(date);
	
	
    private String sqlmaster="select  (select top 1 CREW_NO from crewinfo where legs.fltid = crewinfo.fltid and legs.datop = crewinfo.datop and legs.legno = crewinfo.legno and position = 'CAPT') as Captain ,(select top 1 CREW_NO from crewinfo where legs.fltid = crewinfo.fltid and legs.datop = crewinfo.datop and legs.legno = crewinfo.legno and position = 'FO') as FirstOfficer,AIRCRAFT_V.SHORT_REG, STUFF(AIRCRAFT_V.LONG_REG,3,0,'-') as 'LONG_REG', AIRCRAFT_V.DESCRIPTION, LEGS.ACTYP, AIRCRAFT_V.SCR_SEATS, AIRCRAFT_V.AIRCRAFT_OWNER_CODE,\r\n" + 
    		" LEGS.DEPSTN, LEGS.ARRSTN, SUBSTRING(LEGS.DATOP,0,12) as \"FLIGHT_DATE\", LEGS.AC, REPLACE(LEGS.FLTID, ' ', '') as FLTID, LEGS.LEGNO, LEGS.DEPSTN, LEGS.ARRSTN,\r\n" + 
    		" REPLACE(SUBSTRING(LEGS.ETD,11,6),'.', ':')  as \"ETD_DATE_TIME\",  REPLACE(SUBSTRING(LEGS.ETA,11,6),'.', ':')  as \"ETA_DATE_TIME\",\r\n" + 
    		" REPLACE(SUBSTRING(LEGS.STD,11,6),'.', ':') as \"STD_DATE_TIME\",   REPLACE(SUBSTRING(LEGS.STA,11,6),'.', ':')  as \"STA_DATE_TIME\",\r\n" + 
    		" REPLACE(SUBSTRING(LEGS.ATD,11,6),'.', ':') as \"ATD_DATE_TIME\",   REPLACE(SUBSTRING(LEGS.ATA,11,6),'.', ':')  as \"ATA_DATE_TIME\",\r\n" + 
    		" REPLACE(SUBSTRING(LEGS.TOFF,11,6),'.', ':') as \"TOFF_DATE_TIME\", REPLACE(SUBSTRING(LEGS.TDWN,11,6),'.', ':')  as \"TDWN_DATE_TIME\",\r\n" + 
    		" datediff(minute, convert(datetime, REPLACE(Legs.atd, '.', ':'), 120), convert(datetime, REPLACE(Legs.ata, '.', ':'), 120)) as ATA_ATD, LEGS.BOOK, PBI.BOOKED, LEGS.PAX, LEGS.STC, LEGS.STATUS,\r\n" + 
    		" DELAYCODE1.NumCode AS DELAY_CODE_1, DELAYCODE1.Description AS DELAY_CODE_1_DESCRIPTION, LEGS.DUR1,\r\n" + 
    		" DELAYCODE2.NumCode AS DELAY_CODE_2, DELAYCODE2.Description AS DELAY_CODE_2_DESCRIPTION, LEGS.DUR2,\r\n" + 
    		" DELAYCODE3.NumCode AS DELAY_CODE_3, DELAYCODE3.Description AS DELAY_CODE_3_DESCRIPTION, LEGS.DUR3,\r\n" + 
    		" DELAYCODE4.NumCode AS DELAY_CODE_4, DELAYCODE4.Description AS DELAY_CODE_4_DESCRIPTION, LEGS.DUR4,\r\n" + 
    		" fuel.beginningfuel, fuel.BURN, fuel.DEPFOB, fuel.ARRFOB, fuel.uplift1, fuel.uplift2, fuel.uplift3,\r\n" + 
    		" legs3.ADULTS, legs3.MALES, legs3.FEMALES, legs3.CHILDREN, legs3.INFANTS,\r\n" + 
    		" flight_note.note , flight_note.note1,flight_note.note2,flight_note.note3,flight_note.note4 \r\n" + 
    		" FROM Legs left join fuel on  fuel.FLTID=legs.FLTID and fuel.datop=legs.datop and fuel.LEGNO=legs.LEGNO \r\n" + 
    		" left join legs3 on  legs3.FLTID=legs.FLTID and legs3.datop=legs.datop and legs3.LEGNO=legs.LEGNO \r\n" + 
    		" left join PBI on  pbi.FLTID=legs.FLTID and pbi.datop=legs.datop and pbi.LEGNO=legs.LEGNO \r\n" + 
    		" left join DelayCode as DelayCode1 on  DelayCode1.NumCode=legs.DELAY1 or DelayCode1.AlphaCode=legs.DELAY1 \r\n" + 
    		" left join DelayCode as DelayCode2 on  DelayCode2.NumCode=legs.DELAY2 or DelayCode2.AlphaCode=legs.DELAY2 \r\n" + 
    		" left join DelayCode as DelayCode3 on  DelayCode3.NumCode=legs.DELAY3 or DelayCode3.AlphaCode=legs.DELAY3\r\n" + 
    		" left join DelayCode as DelayCode4 on  DelayCode4.NumCode=legs.DELAY4 or DelayCode4.AlphaCode=legs.DELAY4\r\n" + 
    		" left join flight_note on  flight_note.fltid=legs.fltid and flight_note.datop=legs.datop "+
    		" and flight_note.depstn=legs.depstn and flight_note.arrstn=legs.arrstn\r\n" + 
    		" left join ( \r\n" + 
    		" select Distinct rtrim(AC_MISC.SHORT_REG) as \"SHORT_REG\", AC_MISC.LONG_REG, AC_MISC.DESCRIPTION, actype_versions_misc.actype, actype_Versions_misc.scr_seats, acreg_unit_map.acown as \"AIRCRAFT_OWNER_CODE\" from acreg_unit_map,ac_misc,ac_versions,actype_versions_misc where acreg_unit_map.acreg=ac_misc.ac and acreg_unit_map.actyp=actype_versions_misc.actype\r\n" + 
    		" and actype_versions_misc.version=ac_Versions.version and ac_versions.ac=ac_misc.ac\r\n" + 
    		" )as \"AIRCRAFT_V\" on legs.ac=(CONCAT (AIRCRAFT_V.AIRCRAFT_OWNER_CODE, AIRCRAFT_V.actype, AIRCRAFT_V.SHORT_REG)) ";
    

	
    private String lightSqlMaster="select AIRCRAFT_V.SHORT_REG, STUFF(AIRCRAFT_V.LONG_REG,3,0,'-') as 'LONG_REG', AIRCRAFT_V.DESCRIPTION, LEGS.ACTYP, AIRCRAFT_V.SCR_SEATS, AIRCRAFT_V.AIRCRAFT_OWNER_CODE,\r\n" + 
    		" LEGS.DEPSTN, LEGS.ARRSTN, SUBSTRING(LEGS.DATOP,0,12) as \"FLIGHT_DATE\", LEGS.AC, REPLACE(LEGS.FLTID, ' ', '') as FLTID, LEGS.LEGNO, LEGS.DEPSTN, LEGS.ARRSTN,\r\n" + 
    		" REPLACE(SUBSTRING(LEGS.ETD,11,6),'.', ':')  as \"ETD_DATE_TIME\",  REPLACE(SUBSTRING(LEGS.ETA,11,6),'.', ':')  as \"ETA_DATE_TIME\",\r\n" + 
    		" REPLACE(SUBSTRING(LEGS.STD,11,6),'.', ':') as \"STD_DATE_TIME\",   REPLACE(SUBSTRING(LEGS.STA,11,6),'.', ':')  as \"STA_DATE_TIME\",\r\n" + 
    		" REPLACE(SUBSTRING(LEGS.ATD,11,6),'.', ':') as \"ATD_DATE_TIME\",   REPLACE(SUBSTRING(LEGS.ATA,11,6),'.', ':')  as \"ATA_DATE_TIME\",\r\n" + 
    		" REPLACE(SUBSTRING(LEGS.TOFF,11,6),'.', ':') as \"TOFF_DATE_TIME\", REPLACE(SUBSTRING(LEGS.TDWN,11,6),'.', ':')  as \"TDWN_DATE_TIME\",\r\n" + 
    		" datediff(minute, convert(datetime, REPLACE(Legs.atd, '.', ':'), 120), convert(datetime, REPLACE(Legs.ata, '.', ':'), 120)) as ATA_ATD, LEGS.BOOK, PBI.BOOKED, LEGS.PAX, LEGS.STC, LEGS.STATUS,\r\n" + 
    		" DELAYCODE1.NumCode AS DELAY_CODE_1, DELAYCODE1.Description AS DELAY_CODE_1_DESCRIPTION, LEGS.DUR1,\r\n" + 
    		" DELAYCODE2.NumCode AS DELAY_CODE_2, DELAYCODE2.Description AS DELAY_CODE_2_DESCRIPTION, LEGS.DUR2,\r\n" + 
    		" DELAYCODE3.NumCode AS DELAY_CODE_3, DELAYCODE3.Description AS DELAY_CODE_3_DESCRIPTION, LEGS.DUR3,\r\n" + 
    		" DELAYCODE4.NumCode AS DELAY_CODE_4, DELAYCODE4.Description AS DELAY_CODE_4_DESCRIPTION, LEGS.DUR4,\r\n" + 
    		" fuel.beginningfuel, fuel.BURN, fuel.DEPFOB, fuel.ARRFOB, fuel.uplift1, fuel.uplift2, fuel.uplift3,\r\n" + 
    		" legs3.ADULTS, legs3.MALES, legs3.FEMALES, legs3.CHILDREN, legs3.INFANTS,\r\n" + 
    		" flight_note.note , flight_note.note1,flight_note.note2,flight_note.note3,flight_note.note4 \r\n" + 
    		" FROM Legs left join fuel on  fuel.FLTID=legs.FLTID and fuel.datop=legs.datop and fuel.LEGNO=legs.LEGNO \r\n" + 
    		" left join legs3 on  legs3.FLTID=legs.FLTID and legs3.datop=legs.datop and legs3.LEGNO=legs.LEGNO \r\n" + 
    		" left join PBI on  pbi.FLTID=legs.FLTID and pbi.datop=legs.datop and pbi.LEGNO=legs.LEGNO \r\n" + 
    		" left join DelayCode as DelayCode1 on  DelayCode1.NumCode=legs.DELAY1 or DelayCode1.AlphaCode=legs.DELAY1 \r\n" + 
    		" left join DelayCode as DelayCode2 on  DelayCode2.NumCode=legs.DELAY2 or DelayCode2.AlphaCode=legs.DELAY2 \r\n" + 
    		" left join DelayCode as DelayCode3 on  DelayCode3.NumCode=legs.DELAY3 or DelayCode3.AlphaCode=legs.DELAY3\r\n" + 
    		" left join DelayCode as DelayCode4 on  DelayCode4.NumCode=legs.DELAY4 or DelayCode4.AlphaCode=legs.DELAY4\r\n" + 
    		" left join flight_note on  flight_note.fltid=legs.fltid and flight_note.datop=legs.datop "+
    		" and flight_note.depstn=legs.depstn and flight_note.arrstn=legs.arrstn\r\n" + 
    		" left join ( \r\n" + 
    		" select Distinct rtrim(AC_MISC.SHORT_REG) as \"SHORT_REG\", AC_MISC.LONG_REG, AC_MISC.DESCRIPTION, actype_versions_misc.actype, actype_Versions_misc.scr_seats, acreg_unit_map.acown as \"AIRCRAFT_OWNER_CODE\" from acreg_unit_map,ac_misc,ac_versions,actype_versions_misc where acreg_unit_map.acreg=ac_misc.ac and acreg_unit_map.actyp=actype_versions_misc.actype\r\n" + 
    		" and actype_versions_misc.version=ac_Versions.version and ac_versions.ac=ac_misc.ac\r\n" + 
    		" )as \"AIRCRAFT_V\" on legs.ac=(CONCAT (AIRCRAFT_V.AIRCRAFT_OWNER_CODE, AIRCRAFT_V.actype, AIRCRAFT_V.SHORT_REG)) ";
    
    
	
		//-------------- This Will Generate SQL for the  MayFly Report FOR JSP ----------------------------------------------------------------
		public String builtFlightReportSql(String airline,String airport,String shortby,String ofdate,String flightno) throws NullPointerException{
	 		    
			    sqlmaster += " WHERE legs.status !='CNL'";
			    
			    if(ofdate.length()  > 0 ){ sqlmaster += " AND legs.datop='"+ofdate+"'"; }
	 		    if(flightno.trim().length() > 0){ sqlmaster += " AND REPLACE(LEGS.FLTID,' ', '')  like '%"+flightno+"%'"; }
				if((airline != null) && (!airline.equals("ALL"))){ 				    
					if(airline.length() == 2) {sqlmaster += " AND SUBSTRING(LEGS.FLTID,1,3) in ('"+airline+"')"; }else {sqlmaster += " AND SUBSTRING(LEGS.FLTID,1,3) in ("+airline+")"; }
				}
				if((airport != null) && (!airport.equals("ALL"))){ 
				    if(airport.length() == 3) {sqlmaster += " AND LEGS.DEPSTN in ('"+airport+"')"; }else {sqlmaster += " AND LEGS.DEPSTN in ("+airport+")";}
				}	
				if(shortby != null){sqlmaster +=  " order by '"+shortby+"'";}else {sqlmaster +=  " order by ETD_DATE_TIME";}
				
				//System.out.println(sqlmaster);
				
				
			return sqlmaster;
		}//------------- End Of Myfly Report SQL --------------------------------

		
		

		//-------------- This Will Generate SQL for the  Delay Flights Report  ----------------------------------------------------------------
		public String builtDelayFlightReportSql(String airline,String airport,String shortby,String ofdate,String todate,String flightno) throws NullPointerException{
	 		    
			    if(ofdate.length()  > 0 ){ sqlmaster += " WHERE legs.datop between '"+ofdate+"' and '"+todate+"'"; }  	
			   
	 		    if(flightno.trim().length() > 0){ sqlmaster += " AND REPLACE(LEGS.FLTID,' ', '')  like '%"+flightno+"%'"; }
			    
				if((airline != null) && (!airline.equals("ALL"))){ 				    
					if(airline.length() == 2) {sqlmaster += " AND SUBSTRING(LEGS.FLTID,1,3) in ('"+airline+"')"; }else {sqlmaster += " AND SUBSTRING(LEGS.FLTID,1,3) in ("+airline+")"; }
				}
				
				
				if((airport != null) && (!airport.equals("ALL"))){ 
				    if(airport.length() == 3) {sqlmaster += " AND LEGS.DEPSTN in ('"+airport+"')"; }else {sqlmaster += " AND LEGS.DEPSTN in ("+airport+")";}
				}	
				
				sqlmaster +="\n AND (datediff(minute, convert(datetime, REPLACE(Legs.std, '.', ':'), 120), convert(datetime, REPLACE(Legs.atd, '.', ':'), 120)) > 0)";

				//sqlmaster +="\n AND  (DUR1+DUR2+DUR3+DUR4 > 0)";

				if(shortby != null){sqlmaster +=  " order by '"+shortby+"'";}else {sqlmaster +=  " order by  FLIGHT_DATE desc";}
			    
				//System.out.println(sqlmaster);
				
			return sqlmaster;
		}//------------- End Of SQL --------------------------------
		
		

		//-------------- This Will Generate SQL for the  Delay Flights Report  ----------------------------------------------------------------
		public String builtDelayFlightCommentSql(String ofdate,String todate) throws NullPointerException{	 		   
			   return "Select * from Gops_Flight_Delay_Comment_Master WHERE Flight_Date between '"+ofdate+"' and '"+todate+"'";
		}//------------- End Of Myfly Report SQL --------------------------------

	
		

	

		//-------------- This Will Generate SQL for the  MayFly Report FOR JSP ----------------------------------------------------------------
		public String builtOnTimePerformanceReportSql(String airline,String airport,String fromdate,String todate,String delaycodegroup) throws NullPointerException{
	 		    
			    lightSqlMaster += " WHERE legs.datop between '"+fromdate+"' and '"+todate+"'";   	
			   
	 			if((airline != null) && (!airline.equals("ALL"))){ 				    
					if(airline.length() == 2) {lightSqlMaster += " AND SUBSTRING(LEGS.FLTID,1,3) in ('"+airline+"')"; }else {lightSqlMaster += " AND SUBSTRING(LEGS.FLTID,1,3) in ("+airline+")"; }
				}
				
				
				if((airport != null) && (!airport.equals("ALL"))){ 
				    if(airport.length() == 3) {lightSqlMaster += " AND LEGS.DEPSTN in ('"+airport+"')"; }else {lightSqlMaster += " AND LEGS.DEPSTN in ("+airport+")";}
				}	
				
				
				if(!delaycodegroup.equals("ALL")){ 
				    lightSqlMaster += " AND  legs.DELAY1+legs.DELAY2+legs.DELAY3+legs.DELAY4 in ("+delaycodegroup+")";
				}	

				// Flight_Note and Legs Table Joint  where flight notes all row should be displayed 
				
				//System.out.println(lightSqlMaster);
				
			return sqlmaster;
		}//------------- End Of Myfly Report SQL --------------------------------

	
	
	
}//--------------------- End Of Class ------------------------------------------------------
