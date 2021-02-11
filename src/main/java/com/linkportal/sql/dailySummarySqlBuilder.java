package com.linkportal.sql;

import java.io.Serializable;

import org.springframework.context.annotation.Scope;
import org.springframework.web.context.WebApplicationContext;

@Scope(WebApplicationContext.SCOPE_REQUEST)
public class dailySummarySqlBuilder implements Serializable{

    private String sql="select 1 as Captain , 2 as FirstOfficer, AIRCRAFT_V.SHORT_REG, STUFF(AIRCRAFT_V.LONG_REG,3,0,'-') as 'LONG_REG', AIRCRAFT_V.DESCRIPTION, LEGS.ACTYP, AIRCRAFT_V.SCR_SEATS, AIRCRAFT_V.AIRCRAFT_OWNER_CODE,\r\n" + 
    		" LEGS.DEPSTN, LEGS.ARRSTN, SUBSTRING(LEGS.DATOP,0,12) as \"FLIGHT_DATE\", LEGS.AC, REPLACE(LEGS.FLTID, ' ', '') as FLTID, LEGS.LEGNO, LEGS.DEPSTN, LEGS.ARRSTN,\r\n" + 
    		" REPLACE(SUBSTRING(LEGS.ETD,11,6),'.', ':')  as \"ETD_DATE_TIME\",  REPLACE(SUBSTRING(LEGS.ETA,11,6),'.', ':')  as \"ETA_DATE_TIME\",\r\n" + 
    		" REPLACE(SUBSTRING(LEGS.STD,11,6),'.', ':') as \"STD_DATE_TIME\",   REPLACE(SUBSTRING(LEGS.STA,11,6),'.', ':')  as \"STA_DATE_TIME\",\r\n" + 
    		" REPLACE(SUBSTRING(LEGS.ATD,11,6),'.', ':') as \"ATD_DATE_TIME\",   REPLACE(SUBSTRING(LEGS.ATA,11,6),'.', ':')  as \"ATA_DATE_TIME\",\r\n" + 
    		" REPLACE(SUBSTRING(LEGS.TOFF,11,6),'.', ':') as \"TOFF_DATE_TIME\", REPLACE(SUBSTRING(LEGS.TDWN,11,6),'.', ':')  as \"TDWN_DATE_TIME\",\r\n" + 
    		" datediff(minute, convert(datetime, REPLACE(Legs.atd, '.', ':'), 120), convert(datetime, REPLACE(Legs.ata, '.', ':'), 120)) as ATA_ATD, "+
    		" datediff(minute, convert(datetime, REPLACE(Legs.std, '.', ':'), 120), convert(datetime, REPLACE(Legs.sta, '.', ':'), 120)) as STA_STD ," +
    		" LEGS.BOOK, PBI.BOOKED, LEGS.PAX, LEGS.STC, LEGS.STATUS,\r\n" +     		
    		" DELAYCODE1.NumCode AS DELAY_CODE_1, DELAYCODE1.Description AS DELAY_CODE_1_DESCRIPTION, LEGS.DUR1,\r\n" + 
    		" DELAYCODE2.NumCode AS DELAY_CODE_2, DELAYCODE2.Description AS DELAY_CODE_2_DESCRIPTION, LEGS.DUR2,\r\n" + 
    		" DELAYCODE3.NumCode AS DELAY_CODE_3, DELAYCODE3.Description AS DELAY_CODE_3_DESCRIPTION, LEGS.DUR3,\r\n" + 
    		" DELAYCODE4.NumCode AS DELAY_CODE_4, DELAYCODE4.Description AS DELAY_CODE_4_DESCRIPTION, LEGS.DUR4,\r\n" + 
    		
    		" fuel.beginningfuel, fuel.BURN, fuel.DEPFOB, fuel.ARRFOB, fuel.uplift1, fuel.uplift2, fuel.uplift3,\r\n" + 
    		" legs3.ADULTS, legs3.MALES, legs3.FEMALES, legs3.CHILDREN, legs3.INFANTS,\r\n" + 
    		" flight_note.note ,flight_note.note1,flight_note.note2,flight_note.note3,flight_note.note4 \r\n" + 
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
    		" )as \"AIRCRAFT_V\" on legs.ac=(CONCAT (AIRCRAFT_V.AIRCRAFT_OWNER_CODE, AIRCRAFT_V.actype, AIRCRAFT_V.SHORT_REG))";
    
    	   
	   
	   
	   
	   
	 ////////------------------ FOR THE DAILY SUMMARY REPORT ---------------------------------------------------
  
	 
	    
	    
	    
	  //------------No. Of Departure Delays By IATA Delay Code Category
	  public String NoOfDepartureDelaysByIATADelaycodeCategory(String airline,String operation ,String datop) {
		     
		     String sqlstring="select dcode_group, alphacode, numcode,\r\n"; 
		     
		          	
                    //---------------- IN CASE OF BE Flight Selected 
                	
                	if((airline.equals("BE"))){
 		      		 
                		 if(operation.equals("All Operation")) { 
     	                    sqlstring=sqlstring+"(select count (*) from legs where datop = '"+datop+"'  and  FLTID like '"+airline+"%'  and delay1 <> '' and (delay1 = alphacode or delay1 = numcode)) +\r\n" + 
     	   			     		"(select count (*) from legs where datop = '"+datop+"' and  FLTID like '"+airline+"%' and delay2 <> '' and (delay2 = alphacode or delay2 = numcode)) +\r\n" + 
     	   			     		"(select count (*) from legs where datop = '"+datop+"' and  FLTID like '"+airline+"%' and delay3 <> '' and (delay3 = alphacode or delay3 = numcode)) +\r\n" + 
     	   			     		"(select count (*) from legs where datop = '"+datop+"' and  FLTID like '"+airline+"%' and delay4 <> '' and (delay4 = alphacode or delay4 = numcode)) as delcount\r\n"; 
                	     } 
 		    		     
                		 if(operation.equals("CPA")) { 
                			 
     	                    sqlstring=sqlstring+"(select count (*) from legs where datop = '"+datop+"'  and   SUBSTRING(FLTID,1,3)='BE' and FLTID not like 'BE 6%'   and delay1 <> '' and (delay1 = alphacode or delay1 = numcode)) +\r\n" + 
          	   			     		"(select count (*) from legs where datop = '"+datop+"' and   SUBSTRING(FLTID,1,3)='BE' and FLTID not like 'BE 6%'    and delay2 <> '' and (delay2 = alphacode or delay2 = numcode)) +\r\n" + 
          	   			     		"(select count (*) from legs where datop = '"+datop+"' and   SUBSTRING(FLTID,1,3)='BE' and FLTID not like 'BE 6%'    and delay3 <> '' and (delay3 = alphacode or delay3 = numcode)) +\r\n" + 
          	   			     		"(select count (*) from legs where datop = '"+datop+"' and   SUBSTRING(FLTID,1,3)='BE' and FLTID not like 'BE 6%'    and delay4 <> '' and (delay4 = alphacode or delay4 = numcode)) as delcount\r\n"; 
                		 }
 		    		     
                		 if(operation.equals("Franchise")) { 
     	                    sqlstring=sqlstring+"(select count (*) from legs where datop = '"+datop+"'  and  FLTID like '"+airline+" 6%'  and delay1 <> '' and (delay1 = alphacode or delay1 = numcode)) +\r\n" + 
         	   			     		"(select count (*) from legs where datop = '"+datop+"' and  FLTID like '"+airline+" 6%'   and delay2 <> '' and (delay2 = alphacode or delay2 = numcode)) +\r\n" + 
         	   			     		"(select count (*) from legs where datop = '"+datop+"' and  FLTID like '"+airline+" 6%'   and delay3 <> '' and (delay3 = alphacode or delay3 = numcode)) +\r\n" + 
         	   			     		"(select count (*) from legs where datop = '"+datop+"' and  FLTID like '"+airline+" 6%'   and delay4 <> '' and (delay4 = alphacode or delay4 = numcode)) as delcount\r\n"; 
                      		 } 
 		    	    
                		  
                	
                	}
                	else
                	{
                		
                		//------------ FOR SELECTED AIRLINE --------------
                		if(!airline.equals("ALL")) {
                		 
                            sqlstring=sqlstring+"(select count (*) from legs where datop = '"+datop+"'  and  FLTID like '"+airline+"%'  and delay1 <> '' and (delay1 = alphacode or delay1 = numcode)) +\r\n" + 
            				"(select count (*) from legs where datop = '"+datop+"' and  FLTID like '"+airline+"%' and delay2 <> '' and (delay2 = alphacode or delay2 = numcode)) +\r\n" + 
            				"(select count (*) from legs where datop = '"+datop+"' and  FLTID like '"+airline+"%' and delay3 <> '' and (delay3 = alphacode or delay3 = numcode)) +\r\n" + 
            				"(select count (*) from legs where datop = '"+datop+"' and  FLTID like '"+airline+"%' and delay4 <> '' and (delay4 = alphacode or delay4 = numcode)) as delcount\r\n"; 
                        
                		}
                		else
                			
                			
                		{
                			
                			//-------- FOR ALL FLIGHTS AND ALL OPERATION---------- 
    	                    sqlstring=sqlstring+"(select count (*) from legs where datop = '"+datop+"'  and delay1 <> '' and (delay1 = alphacode or delay1 = numcode)) +\r\n" + 
    	    			     		"(select count (*) from legs where datop = '"+datop+"' and delay2 <> '' and (delay2 = alphacode or delay2 = numcode)) +\r\n" + 
    	    			     		"(select count (*) from legs where datop = '"+datop+"' and delay3 <> '' and (delay3 = alphacode or delay3 = numcode)) +\r\n" + 
    	    			     		"(select count (*) from legs where datop = '"+datop+"' and delay4 <> '' and (delay4 = alphacode or delay4 = numcode)) as delcount\r\n"; 
    	                            
               				}
                		
                		
                	}
                    
                 	sqlstring=sqlstring+"from Stobart_DelayCodeGroup order by dcode_group";
		     
                   
		     
		     
		  return sqlstring;
		  
	  }  
	
	  
	  
	  //------------Narrative Summary of Root Delays:
	    public String getSqlforNarrativeSummaryofRootDelays(String airline,String operation ,String datop) {	
			   
	    	sql += " WHERE  LEGS.STATUS IN ('ATA') AND legs.datop='"+datop+"'";
			   
	    	if((!airline.equals("ALL"))){ 	    	
		    		if((airline.equals("BE"))){
		      		   if(operation.equals("All Operation")) { sql += "AND SUBSTRING(LEGS.FLTID,1,3)='"+airline+"'"; } 
		    		   if(operation.equals("CPA")) { sql += "AND SUBSTRING(LEGS.FLTID,1,3)='BE' and legs.FLTID not like 'BE 6%'"; }
		    		   if(operation.equals("Franchise")) { sql += "AND LEGS.FLTID like 'BE 6%'"; } 
		    		}
		    		else
		    		{	
		    		     sql += "AND SUBSTRING(LEGS.FLTID,1,3)='"+airline+"' "; 
		    		}
	        } 
			
			   sql +=  "  and  LEGS.DUR1+LEGS.DUR2+LEGS.DUR3+LEGS.DUR4 > 0 order by  ETD_DATE_TIME";
			
			  
			
	    return sql;	
	  } 	
	  
	  
	  
	  
	  
	  
	  //------------- For the Cancelled Flights --------------------------------
	  public String getSqlFortheCancelledFlights(String airline,String operation ,String datop) {
		  
			sql += " WHERE  LEGS.STATUS IN ('CNL') AND legs.datop='"+datop+"'";
			   
	    	if((!airline.equals("ALL"))){ 
	    	
		    		if((airline.equals("BE"))){
		      		   if(operation.equals("All Operation")) { sql += "AND SUBSTRING(LEGS.FLTID,1,3)='"+airline+"'"; } 
		    		   if(operation.equals("CPA")) { sql += "AND SUBSTRING(LEGS.FLTID,1,3)='BE' and legs.FLTID not like 'BE 6%'"; }
		    		   if(operation.equals("Franchise")) { sql += "AND LEGS.FLTID like 'BE 6%'"; } 
		    		}
		    		else
		    		{	
		    		     sql += "AND SUBSTRING(LEGS.FLTID,1,3)='"+airline+"'"; 
		    		}
	        } 
			
			   sql +=  " order by  ETD_DATE_TIME";
		    
		
		  return sql;
		  
	  }    
	    
	    
	    
	    
	    
	
	
}// ----------- END OF CLASS ---------------------------
