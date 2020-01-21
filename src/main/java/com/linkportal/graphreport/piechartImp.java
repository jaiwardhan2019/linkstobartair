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
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;


import com.linkportal.datamodel.delaycodeGroupMasterRowmapper;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonObject;


@Repository
public class piechartImp implements piechart{
	
    @Autowired
    DataSource dataSourcesqlserver;
    
  

    
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
		  
		  
		   
          System.out.println(sqlstrkpi);
		   
		   
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
	public String createPieChart_For_Flight_Report(String airline, String airportcode, String datop) throws Exception {
		   
		
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

		   //------------ SQL TO PULL OFF DETAIL FROM PDC -------------
		   
		   String andstring="";  //<<== THis will be used for the Airline and Operation Selection 
		   if((!airline.equals("ALL"))){ 
		    	
	    			andstring += " AND SUBSTRING(LEGS.FLTID,1,3)='"+airline+"'"; 
	    	
           }//----------- End Of If -------------- 
	       
		  
		   
		   if((!airportcode.equals("ALL"))){ 
		    	
   			      andstring += " AND LEGS.DEPSTN='"+airportcode+"'"; 
   	
           }//----------- End Of If -------------- 
      
  
	   
		     
		    if(datop == null) {
				
		    	andstring +=  " AND DATOP='"+curent_date+"'";	  
	
		    }else
		    {
				//sql +=  " WHERE legs.datop=DATEADD(DAY,"+num+",'"+curent_date+"')";	
		    	andstring +=  " AND DATOP='"+datop+"'";	  
	
		    }
		    
		  
		
		 String sqlstrkpi="select sum(case when status != 'RTR' then 1 else 0 end ) as totalflights,\r\n" + 
		  		"	   sum(case when status = 'ATA' then 1 else 0 end ) as NumFlown, \r\n" + 
		  		"	   sum(case when status = 'CNL' then 1 else 0 end) as NumCancelled,\r\n" + 
		  		"	   sum(case when status = 'ATA' and (datediff(minute, convert(datetime, REPLACE(LEGS.STD, '.', ':'), 120), convert(datetime, REPLACE(LEGS.ATD, '.', ':'), 120)) = 0) then 1 else 0 end) as ontimeflights, \r\n" + 
		  		"	   sum(case when status = 'ATA' and (datediff(minute, convert(datetime, REPLACE(LEGS.STD, '.', ':'), 120), convert(datetime, REPLACE(LEGS.ATD, '.', ':'), 120)) > 0) then 1 else 0 end) as alldelay,\r\n" + 
		  		"	   sum(case when status = 'ATA' then pax else 0 end) as Passenger_Carried_PAX,	\r\n" + 
		  		"	   sum(VER.scr_seats) as Total_Available_Seat from LEGS , ACTYPE_VERSIONS_MISC VER \r\n" + 
		  		"	   where legs.ACTYP = VER.actype and LEGS.VERSION = VER.version "+andstring;
			
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
		   			     Late_morethen5minute = Integer.parseInt(rsc.getString("alldelay"));
		   			    // Late_morethen15Minute= Integer.parseInt(rsc.getString("Late_morethen15Minute"));
		   			    // Late_morethen30Minute   = Integer.parseInt(rsc.getString("Late_morethen30Minute"));	
		   			     
		   			   
		   			    Gson gsonObj = new Gson();
		   			 


		   			    
		   			    
		   			    Map<Object,Object> map1 = null;
		   			    List<Map<Object,Object>> list = new ArrayList<Map<Object,Object>>();
		   			     
		   			    map1 = new HashMap<Object,Object>(); 
		   			    map1.put("label", "Total Flights"); 
		   			    map1.put("y", totalflights); 
		   			    list.add(map1);
		   			    
		   			    map1 = new HashMap<Object,Object>(); 
		   			    map1.put("label", "Total Flown"); 
		   			    map1.put("y", NumFlown); 
		   			    list.add(map1);
		   			    
		   			    map1 = new HashMap<Object,Object>(); 
		   			    map1.put("label", "Cancelled"); 
		   			    map1.put("y",NumCancelled); 
		   			    list.add(map1);

		   			    //System.out.println("Cancelled Count:"+NumCancelled); 
		   			    
		   			    
		   			    map1 = new HashMap<Object,Object>(); 
		   			    map1.put("label", "On Time"); 
		   			    map1.put("y", ontimeflights); 
		   			    list.add(map1);
		   			    
		   			    
		   			    map1 = new HashMap<Object,Object>(); 
		   			    map1.put("label", "All Delay"); 
		   			    map1.put("y", Late_morethen5minute); 
		   			    list.add(map1);
		   			    
		   			    
		   			    /*
		   			    map1 = new HashMap<Object,Object>(); 
		   			    map1.put("label", "Delay More Then 5 Minutes"); 
		   			    map1.put("y", Late_morethen5minute); 
		   			    list.add(map1);
		   			    
		   			    
		   			    map1 = new HashMap<Object,Object>(); 
		   			    map1.put("label", "Delay More Then 15 Minute"); 
		   			    map1.put("y", Late_morethen15Minute); 
		   			    list.add(map1);
		   			    */
		   			    
		   			    
		    		    graphstring = gsonObj.toJson(list);
		   		   			
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
		   			     
		   		        
		   		         
		   			    /*
		   			    
		   			    Map<Object,Object> map1 = null;
		   			    List<Map<Object,Object>> list = new ArrayList<Map<Object,Object>>();
		   			     
		   			    map1 = new HashMap<Object,Object>(); 
		   			    map1.put("label", "Total Flights"); 
		   			    map1.put("Total Flights", totalflights); 
		   			    list.add(map1);
		   			    
		   			    map1 = new HashMap<Object,Object>(); 
		   			    map1.put("label", "Total Flown"); 
		   			    map1.put("y", NumFlown); 
		   			    list.add(map1);
		   			    
		   			    map1 = new HashMap<Object,Object>(); 
		   			    map1.put("label", "Cancelled"); 
		   			    map1.put("y", NumCancelled); 
		   			    list.add(map1);

		   			    
		   			    
		   			    
		   			    map1 = new HashMap<Object,Object>(); 
		   			    map1.put("label", "On Time"); 
		   			    map1.put("y", ontimeflights); 
		   			    list.add(map1);
		   			    
		   			    
		   			    
		   			    map1 = new HashMap<Object,Object>(); 
		   			    map1.put("label", "Delay More Then 5 Minutes"); 
		   			    map1.put("y", Late_morethen5minute); 
		   			    list.add(map1);
		   			    
		   			    
		   			    map1 = new HashMap<Object,Object>(); 
		   			    map1.put("label", "Delay More Then 15 Minute"); 
		   			    map1.put("y", Late_morethen15Minute); 
		   			    list.add(map1);
		   			    
		   			    
		   			    
		    		    graphstring = gsonObj.toJson(list);
		   		   		*/	
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




	
	

}//------- End Of Main Class ----------
