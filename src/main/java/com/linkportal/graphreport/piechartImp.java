package com.linkportal.graphreport;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Dictionary;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;


import com.linkportal.datamodel.delaycodeGroupMasterRowmapper;
import com.linkportal.groundops.gopsAllapi;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonObject;


@Repository
public class piechartImp implements piechart{
	
    @Autowired
    DataSource dataSourcesqlserver;
    
    @Autowired
    gopsAllapi gopsobj;
    

    @Value("${groundops.delay.code}")
    String groundOpsDelayCodeGroup;
    
    @Value("${stobartair.delay.code}")
    String stobartAirDelayCodeGroup;
    
	@Value("${nonstobartair.delay.code}")
	String nonStobartAirDelayCodeGroup;
	

    
	JdbcTemplate jdbcTemplate;	

	
	
	piechartImp(DataSource dataSourcesqlserver){ 
		jdbcTemplate = new JdbcTemplate(dataSourcesqlserver);
	}


	
	
	///////////////////------------ THIS PART IS FOR RELIABLITY  REPORT ------------------////////////////////////	
    


	@Override
	public String createPieChart(String airline, String port, String startdate,String enddate , String tolrance) throws SQLException,NumberFormatException {
		
		
		   String graphstring="";
		
		   //------------ REPORT ITEMS -------------------
		   int totalflights=0;
		   int NumFlown=0;
		   int NumCancelled=0;
		   int ontimeflights=0;		   
		   int Late_Lessthen5minute=0;
		   int Late_Lessthen15Minute=0;
		   int Late_Above15Minute=0;	
		   
		   //------------ SQL TO PULL OFF DETAIL FROM PDC -------------
		   
		   String andstring="";
		   if((!airline.equals("ALL"))){andstring += " AND SUBSTRING(LEGS.FLTID,1,3)='"+airline+"'";}
		   if((!port.equals("ALL"))){andstring += " AND LEGS.DEPSTN='"+port+"'"; } 
	
		   
		  String sqlstrkpi="select sum(case when status != 'RTR' then 1 else 0 end ) as totalflights,\r\n" + 
		  		"	   sum(case when status = 'ATA' and (datediff(minute, convert(datetime, REPLACE(LEGS.STD, '.', ':'), 120), convert(datetime, REPLACE(LEGS.ATD, '.', ':'), 120)) >= "+tolrance+") then 1 else 0 end ) as NumFlown, \r\n" + 
		  		"	   sum(case when status = 'CNL' then 1 else 0 end) as NumCancelled\r\n" + 
		  		//"	   sum(case when status = 'ATA' and DUR1+DUR2+DUR3+DUR4 < 5 then 1 else 0 end) as Late_Lessthen5minute,\r\n" + 
		  		//"	   sum(case when status = 'ATA' and DUR1+DUR2+DUR3+DUR4 < 15 then 1 else 0 end)  as Late_Lessthen15Minute,\r\n" + 
		  		//"	   sum(case when status = 'ATA' and DUR1+DUR2+DUR3+DUR4 > 15 then 1 else 0 end) as Late_Above15Minute, \r\n" + 
		  		//"	   sum(case when status = 'ATA' and (datediff(minute, convert(datetime, REPLACE(LEGS.STD, '.', ':'), 120), convert(datetime, REPLACE(LEGS.ATD, '.', ':'), 120)) = 0) then 1 else 0 end) as ontimeflights \r\n" + 		  		
		  		"	   from LEGS  where  DATOP between '"+startdate+"' and  '"+enddate+"'"+andstring;
		  
		   
		   
		   Connection connection = dataSourcesqlserver.getConnection();
		   Statement stac = connection.createStatement();
		   ResultSet rsc = stac.executeQuery(sqlstrkpi);		   

	   	      if(rsc.next()){
				
		   		   if(rsc.getString("totalflights") != null) {
		   			  
		   			   
		   			     totalflights         = Integer.parseInt(rsc.getString("NumFlown"));		   			    
		   			     NumCancelled         = Integer.parseInt(rsc.getString("NumCancelled"));
		   			    // ontimeflights        = Integer.parseInt(rsc.getString("ontimeflights"));		   
		   			    // Late_Lessthen5minute = Integer.parseInt(rsc.getString("Late_Lessthen5minute"));
		   			    // Late_Lessthen15Minute= Integer.parseInt(rsc.getString("Late_Lessthen15Minute"));
		   			    // Late_Above15Minute   = Integer.parseInt(rsc.getString("Late_Above15Minute"));	
		   			     
		   			     
		   			   
		   			    Gson gsonObj = new Gson();
		   			    Map<Object,Object> map1 = null;
		   			    List<Map<Object,Object>> list = new ArrayList<Map<Object,Object>>();
		   			     
		   			    map1 = new HashMap<Object,Object>(); 
		   			    map1.put("label", "Flights Count"); 
		   			    map1.put("y", totalflights); 
		   			    list.add(map1);
		   			    /*
		   			    map1 = new HashMap<Object,Object>(); 
		   			    map1.put("label", "Total Flown"); 
		   			    map1.put("y", NumFlown); 
		   			    list.add(map1);
		   			    */
		   			    map1 = new HashMap<Object,Object>(); 
		   			    map1.put("label", "Cancelled Count"); 
		   			    map1.put("y", NumCancelled); 
		   			    list.add(map1);

		   			    
		   			    
		   			    /*
		   			    map1 = new HashMap<Object,Object>(); 
		   			    map1.put("label", "On Time"); 
		   			    map1.put("y", ontimeflights); 
		   			    list.add(map1);
		   			    
		   			    
		   			    
		   			    map1 = new HashMap<Object,Object>(); 
		   			    map1.put("label", "Late Less Then 5 Minutes"); 
		   			    map1.put("y", Late_Lessthen5minute); 
		   			    list.add(map1);
		   			    
		   			    
		   			    map1 = new HashMap<Object,Object>(); 
		   			    map1.put("label", "Late Less Then 15 Minute"); 
		   			    map1.put("y", Late_Lessthen15Minute); 
		   			    list.add(map1);
		   			    
		   			    map1 = new HashMap<Object,Object>(); 
		   			    map1.put("label", "Late Over 15 Minute"); 
		   			    map1.put("y", Late_Above15Minute); 
		   			    list.add(map1);
		   			     */
		   			    graphstring = gsonObj.toJson(list);
		   		   			
		   		   }
	   	     
	   	      } 
	   	      
	   	   
		   totalflights=0;
		   NumFlown=0;
		   NumCancelled=0;
		   ontimeflights=0;		   
		   Late_Lessthen5minute=0;
		   Late_Lessthen15Minute=0;
		   Late_Above15Minute=0;	
	   	      
	   	   sqlstrkpi=null;   
	   	   rsc.close();	
	   	   stac.close();   
	   	   connection.close();
	   	   
		return graphstring;
	}




	
	
	///////------------------- FOR THE FLIGHT REPORTS ----------
	@Override
	public String createPieChart_For_Flight_Report(String airline, String airportcode, String datop, String useremail) throws Exception {
		   
		
		   DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		   Date date = new Date();
		   String curent_date=dateFormat.format(date);
		
	  	
		
		   String graphstring="[0]";
		
		   //------------ REPORT ITEMS -------------------
		   int totalflights=0;
		   int NumFlown=0;
		   int NumCancelled=00;
		   int ontimealldepart=0;		   
		   int alldelay=0;
		   int Late_morethen15Minute=0;
		   int Late_morethen30Minute=0;	
		   int NumAirborn=0;
		   int ontimeallarival=0;	

		   //------------ SQL TO PULL OFF DETAIL FROM PDC -------------
			
			 String sqlstrkpi="select sum(case when status != 'RTR' then 1 else 0 end ) as totalflights,\r\n" + 
			  		"	   sum(case when status = 'ATA' then 1 else 0 end ) as NumFlown, \r\n" + 
			  		"	   sum(case when status = 'DEP' then 1 else 0 end) as NumAirborn,\r\n" + 
			  		"	   sum(case when status = 'CNL' then 1 else 0 end) as NumCancelled,\r\n" + 
			  		"	   sum(case when status = 'ATA' and (datediff(minute, convert(datetime, REPLACE(LEGS.STD, '.', ':'), 120), convert(datetime, REPLACE(LEGS.ATD, '.', ':'), 120)) = 0) then 1 else 0 end) as ontimealldepart, \r\n" + 
			  		"	   sum(case when status = 'ATA' and (datediff(minute, convert(datetime, REPLACE(LEGS.STA, '.', ':'), 120), convert(datetime, REPLACE(LEGS.ATA, '.', ':'), 120)) = 0) then 1 else 0 end) as ontimeallarival, \r\n" + 
			  		"	   sum(case when status = 'ATA' and (datediff(minute, convert(datetime, REPLACE(LEGS.STD, '.', ':'), 120), convert(datetime, REPLACE(LEGS.ATD, '.', ':'), 120)) > 0) then 1 else 0 end) as alldelay,\r\n" + 
			  		"	   sum(case when status = 'ATA' then pax else 0 end) as Passenger_Carried_PAX,	\r\n" + 
			  		"	   sum(VER.scr_seats) as Total_Available_Seat from LEGS , ACTYPE_VERSIONS_MISC VER \r\n" + 
			  		"	   where legs.ACTYP = VER.actype and LEGS.VERSION = VER.version";
				   
		   
		   
		   
		   String andstring="";  //<<== THis will be used for the Airline and Operation Selection 
	   
		     
		    if(datop == null) {
		    	andstring +=  " AND DATOP='"+curent_date+"'";	  
		    }
		    else
		    {
		    	andstring +=  " AND DATOP='"+datop+"'";	  
		    }
		    
		    
		    //-------- IF  GH USER is Selected then Populate their assign Airport /  Airline  
		    boolean StobartUser         = useremail.indexOf("@stobartair.com") != -1;
		    if(!StobartUser) {		    	
	    	  
		      String eligibleAirportlist ="";  
		      String eligibleAirlinelist ="";
		      if(airline.equals("ALL")) {
		    	 eligibleAirlinelist = gopsobj.getAllEligibleAirlineforGH(useremail);  
		      }
		      else
		      {
		    	  eligibleAirlinelist = "'"+airline+"'";
		      }
		      
		      if(airportcode.equals("ALL")){
		         eligibleAirportlist = gopsobj.getAllEligibleAirportforGH(useremail);  
		      }
		      else
		      {
		    	  eligibleAirportlist = "'"+airportcode+"'";
		      }
		      andstring += "AND SUBSTRING(LEGS.FLTID,1,3) in ("+eligibleAirlinelist+") AND LEGS.DEPSTN in ("+eligibleAirportlist+")";
		      sqlstrkpi = sqlstrkpi + andstring; 
		    }
		   
		    
		    
		   if(StobartUser) {
			  if(!airline.equals("ALL"))     {andstring += " AND SUBSTRING(LEGS.FLTID,1,3)='"+airline+"'";}
			  if(!airportcode.equals("ALL")) { andstring += " AND LEGS.DEPSTN='"+airportcode+"'";}
  		      sqlstrkpi = sqlstrkpi + andstring;
		    }
		    
		    
		  
			
		   //System.out.println(sqlstrkpi);
		
		   Connection connection = dataSourcesqlserver.getConnection();
		   Statement stac = connection.createStatement();
		   ResultSet rsc = stac.executeQuery(sqlstrkpi);		   

	   	      if(rsc.next()){
				
		   		   if(rsc.getString("totalflights") != null) {
		   			  
		   			   
		   			     totalflights         = Integer.parseInt(rsc.getString("totalflights"));
		   			     NumFlown             = Integer.parseInt(rsc.getString("NumFlown"));
		   			     NumCancelled         = Integer.parseInt(rsc.getString("NumCancelled"));
		   			     ontimealldepart        = Integer.parseInt(rsc.getString("ontimealldepart"));		   
		   			     alldelay = Integer.parseInt(rsc.getString("alldelay"));
		   			     NumAirborn           = Integer.parseInt(rsc.getString("NumAirborn"));
		   			     ontimeallarival= Integer.parseInt(rsc.getString("ontimeallarival"));
		   			    // Late_morethen15Minute= Integer.parseInt(rsc.getString("Late_morethen15Minute"));
		   			    // Late_morethen30Minute   = Integer.parseInt(rsc.getString("Late_morethen30Minute"));	
		   			     
		   			   
		   			    Gson gsonObj = new Gson();
		   			 


		   			    
		   			    
		   			    Map<Object,Object> map1 = null;
		   			    List<Map<Object,Object>> list = new ArrayList<Map<Object,Object>>();
		   			     
		   			    map1 = new HashMap<Object,Object>(); 
		   			    map1.put("label", "Schedule"); 
		   			    map1.put("y", totalflights); 
		   			    list.add(map1);

		   			    
		   			   if(NumCancelled > 0) {   
			   			    map1 = new HashMap<Object,Object>(); 
			   			    map1.put("label", "Canc"); 
			   			    map1.put("y",NumCancelled); 
			   			    list.add(map1);
			   			}  
		   			   
		   			   
		   			   if(alldelay > 0) {  
			   			    map1 = new HashMap<Object,Object>(); 
			   			    map1.put("label", "All Delay"); 
			   			    map1.put("y", alldelay); 
			   			    list.add(map1);
			   		   } 
		 			    
		   			    
		   			    if(NumFlown > 0) {
			   			    map1 = new HashMap<Object,Object>(); 
			   			    map1.put("label", "Landed"); 
			   			    map1.put("y", NumFlown); 
			   			    list.add(map1);
		   			    }
		   			    
		   			    
		   			   if(NumAirborn > 0) {
		   			    map1 = new HashMap<Object,Object>(); 
		   			    map1.put("label", "Airborn"); 
		   			    map1.put("y", NumAirborn); 
		   			    list.add(map1);
		   			   }   

		   			    //System.out.println("Cancelled Count:"+NumCancelled); 
		   			    
		   			   if(ontimealldepart > 0) { 
		   			    map1 = new HashMap<Object,Object>(); 
		   			    map1.put("label", "OT Dep"); 
		   			    map1.put("y", ontimealldepart); 
		   			    list.add(map1);
		   			   }    

		   			   if(ontimeallarival > 0) { 
			   			    map1 = new HashMap<Object,Object>(); 
			   			    map1.put("label", "OT Arr"); 
			   			    map1.put("y", ontimeallarival); 
			   			    list.add(map1);
			   			   }    
		   			  
		   			   
		   			    
		    		    graphstring = gsonObj.toJson(list);
		   		   			
		   		   }
	   	     
	   	      } 
	   	      
	   	   totalflights=0;
		   NumFlown=0;
		   NumCancelled=0;
		   ontimeallarival=0;		
		   ontimealldepart=0;
		   alldelay=0;
		   Late_morethen15Minute=0;
		   Late_morethen30Minute=0;	
   
	   	   sqlstrkpi=null;   
	   	   rsc.close();	
	   	   stac.close();   
	   	   connection.close();
	   	  
		return graphstring;
	}




	@Override
	public String createBarchartForHomePage() throws Exception {
		
		   DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		   Date date = new Date();
		   String curent_date=dateFormat.format(date);
		
	  	
		
		   String graphstring="[0]";
		
		   //------------ REPORT ITEMS -------------------
		   int totalflights=0;
		   int NumFlown=0;
		   int NumCancelled=0;
		   int ontimeflights=0;		   
		   int Late_morethen5minute=0;
		   int Late_morethen15Minute=0;
		   int Late_morethen30Minute=0;	
    
	       		    
		  
		
		 String sqlstrkpi="select sum(case when status != 'RTR' then 1 else 0 end ) as totalflights,\r\n" + 
		  		"	   sum(case when status = 'ATA' then 1 else 0 end ) as NumFlown, \r\n" + 
		  		"	   sum(case when status = 'CNL' then 1 else 0 end) as NumCancelled,\r\n" + 
		  		"	   sum(case when status = 'ATA' and (datediff(minute, convert(datetime, REPLACE(LEGS.STD, '.', ':'), 120), convert(datetime, REPLACE(LEGS.ATD, '.', ':'), 120)) = 0) then 1 else 0 end) as ontimeflights, \r\n" + 
		  		"	   sum(case when status = 'ATA' and DUR1+DUR2+DUR3+DUR4 > 5 then 1 else 0 end) as Late_morethen5minute,\r\n" + 
		  		"	   sum(case when status = 'ATA' and DUR1+DUR2+DUR3+DUR4 > 15 then 1 else 0 end)  as Late_morethen15Minute,\r\n" + 
		  		"	   sum(case when status = 'ATA' and DUR1+DUR2+DUR3+DUR4 > 30 then 1 else 0 end) as Late_morethen30Minute, \r\n" + 
		  		"	   sum(case when status = 'ATA' then pax else 0 end) as Passenger_Carried_PAX,	\r\n" + 
		  		"	   sum(VER.scr_seats) as Total_Available_Seat from LEGS , ACTYPE_VERSIONS_MISC VER \r\n" + 
		  		"	   where legs.ACTYP = VER.actype and LEGS.VERSION = VER.version  and  DATOP='"+curent_date+"'";
			 
		   //System.out.println(sqlstrkpi);	  
		   Connection connection = dataSourcesqlserver.getConnection();
		   Statement stac = connection.createStatement();
		   ResultSet rsc = stac.executeQuery(sqlstrkpi);		   

	   	      if(rsc.next()){
				
		   		   if(rsc.getString("totalflights") != null) {
		   			  
		   			   
		   			     totalflights         = Integer.parseInt(rsc.getString("totalflights"));
		   			     NumFlown             = Integer.parseInt(rsc.getString("NumFlown"));
		   			     NumCancelled         = Integer.parseInt(rsc.getString("NumCancelled"));
		   			     ontimeflights        = Integer.parseInt(rsc.getString("ontimeflights"));		   
		   			     Late_morethen5minute = Integer.parseInt(rsc.getString("Late_morethen5minute"));
		   			     Late_morethen15Minute= Integer.parseInt(rsc.getString("Late_morethen15Minute"));
		   			     Late_morethen30Minute   = Integer.parseInt(rsc.getString("Late_morethen30Minute"));	
		   	
		   		   }
	   	     
	   	      } 
	   	      
	   	   totalflights=0;
		   NumFlown=0;
		   NumCancelled=0;
		   ontimeflights=0;		   
		   Late_morethen5minute=0;
		   Late_morethen15Minute=0;
		   Late_morethen30Minute=0;	

	   	   sqlstrkpi=null;   
	   	   rsc.close();	
	   	   stac.close();   
	   	   connection.close();
	   	   
	   	   
	   	  Gson gsonObj = new Gson();
		  Map<Object,Object> map = null;
		  List<Map<Object,Object>> list = new ArrayList<Map<Object,Object>>();
		   
		  map = new HashMap<Object,Object>(); map.put("label", "1 Star"); map.put("y", 8889513); list.add(map);
		  map = new HashMap<Object,Object>(); map.put("label", "2 Star"); map.put("y", 3168220); list.add(map);
		  map = new HashMap<Object,Object>(); map.put("label", "3 Star"); map.put("y", 6611718); list.add(map);

		   
		  String dataPoints = gsonObj.toJson(list);
	   	   
		return dataPoints;
	}




	@Override 
	public String createPieChart_For_OTP_Flight_Report(String airline, String airportcode, String fromDate,
			String toDate, String delyCode) throws Exception {
		
		   DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		   Date date = new Date();
		   String curent_date=dateFormat.format(date);
		
	  	
		
		   String graphstring="[0]";
		
		   //------------ REPORT ITEMS -------------------
		   int totaldelay=0;
		   int groundopsdelay=0;
		   int stobartairdelay=0;
		   int nonstobartairdelay=0;		   
		
		   //------------ SQL TO PULL OFF DETAIL FROM PDC -------------
			
			 String sqlstrkpi="select sum(case when legs.DELAY1+legs.DELAY2+legs.DELAY3+legs.DELAY4 > 0 then 1 else 0 end ) as totaldelay, \r\n" + 
			 		"	   sum(case when legs.DELAY1+legs.DELAY2+legs.DELAY3+legs.DELAY4 in ("+ groundOpsDelayCodeGroup +") then 1 else 0 end) as groundopsdelay,\r\n" + 
			 		"	   sum(case when legs.DELAY1+legs.DELAY2+legs.DELAY3+legs.DELAY4 in ("+ stobartAirDelayCodeGroup+") then 1 else 0 end) as stobartairdelay,\r\n" + 
			 		"	   sum(case when legs.DELAY1+legs.DELAY2+legs.DELAY3+legs.DELAY4 in ("+ nonStobartAirDelayCodeGroup+") then 1 else 0 end) as nonstobartairdelay\r\n" + 
			 		"	   from LEGS  where DATOP between '" + fromDate + "' AND '"+toDate+"' AND  legs.DELAY1+legs.DELAY2+legs.DELAY3+legs.DELAY4 > 0";
				   
		   

        if(!airline.equalsIgnoreCase("ALL")) {	sqlstrkpi = sqlstrkpi + " and SUBSTRING(LEGS.FLTID,1,3) in ('"+airline+"')";  } 
		

		Connection connection = dataSourcesqlserver.getConnection();
		Statement stac = connection.createStatement();
		ResultSet rsc = stac.executeQuery(sqlstrkpi);

		if (rsc.next()) {

			if (rsc.getString("totaldelay") != null) {

				totaldelay          = Integer.parseInt(rsc.getString("totaldelay"));
				groundopsdelay         = Integer.parseInt(rsc.getString("groundopsdelay"));
				stobartairdelay     = Integer.parseInt(rsc.getString("stobartairdelay"));
				nonstobartairdelay  = Integer.parseInt(rsc.getString("nonstobartairdelay"));
		
				Gson gsonObj = new Gson();
				Map<Object, Object> map1 = null;
				List<Map<Object, Object>> list = new ArrayList<Map<Object, Object>>();

				map1 = new HashMap<Object, Object>();
				map1.put("label", "All Delay");
				map1.put("y", totaldelay);
				list.add(map1);

				if (groundopsdelay > 0) {
					map1 = new HashMap<Object, Object>();
					map1.put("label", "Ground Ops");
					map1.put("y", groundopsdelay);
					list.add(map1);
				}

				if (stobartairdelay > 0) {
					map1 = new HashMap<Object, Object>();
					map1.put("label", "Stobart Air Attrib.");
					map1.put("y", stobartairdelay);
					list.add(map1);
				}

				if (nonstobartairdelay > 0) {
					map1 = new HashMap<Object, Object>();
					map1.put("label", "Non Stobart");
					map1.put("y", nonstobartairdelay);
					list.add(map1);
				}
		
				graphstring = gsonObj.toJson(list);

			}

		}


		sqlstrkpi = null;
		rsc.close();
		stac.close();
		connection.close();

		return graphstring;

	}



	
	

}//------- End Of Main Class ----------
