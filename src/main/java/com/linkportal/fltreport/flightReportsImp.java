package com.linkportal.fltreport;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.sql.DataSource;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowCallbackHandler;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.support.rowset.SqlRowSet;
import org.springframework.stereotype.Repository;

import com.linkportal.datamodel.AirLineNameCode;
import com.linkportal.datamodel.AirLineNameCodeRowmapper;
import com.linkportal.datamodel.delaycodeGroupMaster;
import com.linkportal.datamodel.delaycodeGroupMasterRowmapper;
import com.linkportal.datamodel.flightSectorLogRowmapper;
import com.linkportal.datamodel.fligthSectorLog;
import com.linkportal.groundops.gopsAllapi;
import com.linkportal.sql.GroundOpsSqlBuilder;
import com.linkportal.sql.dailySummarySqlBuilder;
import com.linkportal.sql.linkPortalSqlBuilder;

@Repository
public class flightReportsImp implements flightReports{
   
	
    @Autowired
    DataSource dataSourcesqlserver;
    
    @Autowired
    DataSource dataSourcesqlservercp;
    
    @Autowired
    DataSource dataSourcemysql;
    
    
    @Autowired
    gopsAllapi gopsobj;
    

    //---------- Logger Initializer------------------------------- 
	private Logger logger = Logger.getLogger(flightReportsImp.class);
	


    
	JdbcTemplate jdbcTemplateSqlServer;	
	JdbcTemplate jdbcTemplateCorp;	

	
	
	flightReportsImp(DataSource dataSourcesqlserver,DataSource dataSourcesqlservercp){ 
		jdbcTemplateSqlServer      = new JdbcTemplate(dataSourcesqlserver);
		jdbcTemplateCorp           = new JdbcTemplate(dataSourcesqlservercp);
	}


	

	
	//--------------- This will Generate All Operational Airline For Select Combobox-------------------------
	@Override
	public String Populate_Operational_Airline(String airlinecode, String useremail){
		
		   boolean isStobartUser           = useremail.indexOf("@stobartair.com") !=-1? true: false;		 
		   String airlinelistwithcode      = null;
		   String sqlforoperationalairline = "SELECT AirlineMaster.iata_code , AirlineMaster.airline_name  ,AirlineMaster.icao_code    \r\n" + 
		   		"  FROM  AirlineMaster , Gops_Airline_Station_Access \r\n" + 
		   		"  where Gops_Airline_Station_Access.airline_code=AirlineMaster.icao_code and  AirlineMaster.status='Enable'\r\n" + 
		   		"  and Gops_Airline_Station_Access.user_name='"+useremail+"'";
		   
		   airlinelistwithcode=airlinelistwithcode+"<option value='ALL' selected> All Airlines </option>";
		   if(isStobartUser) {
			   sqlforoperationalairline="SELECT * FROM AirlineMaster where status='Enable' order  by airline_name";
		   }
		   
		   List<AirLineNameCode>  airlinelist = jdbcTemplateCorp.query(sqlforoperationalairline,new AirLineNameCodeRowmapper());
		   for (AirLineNameCode namecode : airlinelist) {			   
			   
			     if(airlinecode.trim().equals(namecode.getAirlineiatacode().trim())) {			    	
			    	 airlinelistwithcode=airlinelistwithcode+"<option value='"+namecode.getAirlineiatacode()+"' selected>"+namecode.getAirlineiatacode().trim()+"&nbsp;&nbsp;-&nbsp;&nbsp;"+namecode.getAirlinename()+"</option>";
			     }
			     else
			     {
			    	 airlinelistwithcode=airlinelistwithcode+"<option value='"+namecode.getAirlineiatacode()+"'>"+namecode.getAirlineiatacode().trim()+"&nbsp;&nbsp;-&nbsp;&nbsp;"+namecode.getAirlinename()+"</option>";				
			 	 }		
				
			}//---------- End Of  For Loop ------------   
		   
			   
		return airlinelistwithcode;
	       
	}


	
	
	
	//--------------- This will Generate All Operational Airport For Select Combo Box-------------------------
	@Override
	public String Populate_Operational_Airport(String airportcode,String useremail) throws Exception,NullPointerException {
		
		   boolean isStobartUser = useremail.indexOf("@stobartair.com") !=-1? true: false;	
		   DateFormat dateFormat = new SimpleDateFormat("yyyy");
		   Date date             = new Date();
		   String curent_year    = dateFormat.format(date);		   
		   
		   	
		  
		   String sqlforoperationalairport="";
		  
		   if(isStobartUser) {
			  sqlforoperationalairport="select STN, NAME from PDCStobart.dbo.STATION where STN in(select distinct(DEPSTN) from pdcstobart.dbo.LEGS where DATOP like '"+curent_year+"%') order by STN";			  
		   }
		   else
		   {
			   
			   //-- For Ground Handler Externale Pull list of assigned airport 
			   String eligibleairportlist="";
			   SqlRowSet rowst =  jdbcTemplateCorp.queryForRowSet("SELECT distinct station_code FROM Gops_Airline_Station_Access where user_name='"+useremail+"' and station_code != 'NA'");
			   int counter=0;
			   while(rowst.next()) {
				   				   
				   if(counter == 0) 
				   {eligibleairportlist = "'"+rowst.getString("station_code")+"'";}
				   else
				   {eligibleairportlist = eligibleairportlist +",'"+ rowst.getString("station_code")+"'";}
				   counter++;
			   }
			   sqlforoperationalairport ="select STN, NAME from PDCStobart.dbo.STATION where STN in("+eligibleairportlist+") order by STN"; 
			   
		   }
			   
		   
		   
		   String stationlistwithcode ="<option value='ALL' selected>All Airport</option>"; 
		   SqlRowSet rowst =  jdbcTemplateSqlServer.queryForRowSet(sqlforoperationalairport);
		   while (rowst.next()) {
		 		 if(airportcode.trim().equals(rowst.getString("STN").trim())) {			    	
					    stationlistwithcode=stationlistwithcode+"<option value="+rowst.getString("STN")+" selected>"+rowst.getString("STN").trim()+"&nbsp;&nbsp;-&nbsp;&nbsp;"+rowst.getString("NAME").trim()+"</option>";
				 }
				  else
				 {
				       stationlistwithcode=stationlistwithcode+"<option value="+rowst.getString("STN")+">"+rowst.getString("STN").trim()+"&nbsp;&nbsp;-&nbsp;&nbsp;"+rowst.getString("NAME").trim()+"</option>";				
				 }
		         
		   }//----------- END OF WHILE ---------- 

		   rowst=null;		   
		   
		   return stationlistwithcode;
	       
	}//---------- End Of Function -----------------------
	
	




	@Override
	public String Populate_Operational_AirlineReg(String aircraftreg, String useremail) throws Exception {
		
		   boolean isStobartUser = useremail.indexOf("@stobartair.com") !=-1? true: false;	
		   DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		   Date date             = new Date();
		   String curent_year    = dateFormat.format(date);		   
		   	
		  
		   String sqlforoperationalaircraftreg="select Distinct rtrim(AC_MISC.SHORT_REG) as \"SHORT_REG\", \r\n" + 
		   		" STUFF(AC_MISC.LONG_REG,3,0,'-') as long_reg , \r\n" + 
		   		" actype_versions_misc.actype, \r\n" + 
		   		" actype_Versions_misc.scr_seats, \r\n" + 
		   		" acreg_unit_map.acown as \"AIRCRAFT_OWNER_CODE\" \r\n" + 
		   		" from acreg_unit_map,ac_misc,ac_versions,actype_versions_misc \r\n" + 
		   		" where acreg_unit_map.acreg     = ac_misc.ac \r\n" + 
		   		"      and acreg_unit_map.actyp = actype_versions_misc.actype\r\n" + 
		   		"      and actype_versions_misc.version = ac_Versions.version \r\n" + 
		   		"	   and ac_versions.ac    =  ac_misc.ac\r\n" + 
		   		"      and acreg_unit_map.acown in(select ACOWN from LEGS where  DATOP='"+curent_year+"')  \r\n" + 
		   		"	   and ac_Versions.version in(select VERSION from LEGS where DATOP='"+curent_year+"') \r\n" + 
		   		"      and acreg_unit_map.actyp in(select ACTYPE from LEGS where DATOP='"+curent_year+"') ";

		   if(!isStobartUser){
			   
			   //-- For Ground Handler Externale Pull list of assigned airport 
			   String eligibleairportlist="";
			   SqlRowSet rowst =  jdbcTemplateCorp.queryForRowSet("SELECT distinct station_code FROM Gops_Airline_Station_Access where user_name='"+useremail+"' and station_code != 'NA'");
			   int counter=0;
			   while(rowst.next()) {
				   				   
				   if(counter == 0) 
				   {eligibleairportlist = "'"+rowst.getString("station_code")+"'";}
				   else
				   {eligibleairportlist = eligibleairportlist +",'"+ rowst.getString("station_code")+"'";}
				   counter++;
			   }
	
			   sqlforoperationalaircraftreg="select Distinct rtrim(AC_MISC.SHORT_REG) as \"SHORT_REG\", \r\n" + 
				   		" STUFF(AC_MISC.LONG_REG,3,0,'-') as long_reg , \r\n" + 
				   		" actype_versions_misc.actype, \r\n" + 
				   		" actype_Versions_misc.scr_seats, \r\n" + 
				   		" acreg_unit_map.acown as \"AIRCRAFT_OWNER_CODE\" \r\n" + 
				   		" from acreg_unit_map,ac_misc,ac_versions,actype_versions_misc \r\n" + 
				   		" where acreg_unit_map.acreg     = ac_misc.ac \r\n" + 
				   		"      and acreg_unit_map.actyp = actype_versions_misc.actype\r\n" + 
				   		"      and actype_versions_misc.version = ac_Versions.version \r\n" + 
				   		"	   and ac_versions.ac    =  ac_misc.ac\r\n" + 
				   		"      and acreg_unit_map.acown in(select ACOWN from LEGS where  DATOP='"+curent_year+"' and LEGS.DEPSTN in("+eligibleairportlist+"))  " + 
				   		"	   and ac_Versions.version in(select VERSION from LEGS where DATOP='"+curent_year+"' and LEGS.DEPSTN in("+eligibleairportlist+")) " + 
				   		"      and acreg_unit_map.actyp in(select ACTYPE from LEGS where DATOP='"+curent_year+"' and LEGS.DEPSTN in("+eligibleairportlist+"))";
			
		   }	   
		   
		  
		   String stationlistwithcode ="<option value='ALL' selected> Select Aircraft REG </option>"; 
		   SqlRowSet rowst =  jdbcTemplateSqlServer.queryForRowSet(sqlforoperationalaircraftreg);
		   while(rowst.next()){
			   if(aircraftreg.trim().equals(rowst.getString("long_reg").trim())) {	
				 stationlistwithcode=stationlistwithcode+"<option value="+rowst.getString("long_reg")+" selected>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+rowst.getString("long_reg").trim()+"</option>";				
			   }
			   else
			   {
				  stationlistwithcode=stationlistwithcode+"<option value="+rowst.getString("long_reg")+">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+rowst.getString("long_reg").trim()+"</option>";				
				   
			   }
		   }//----------- END OF WHILE ---------- 

		   rowst=null;		   
		   
		   return stationlistwithcode;
	}






	
	
	
	
	
	
	
	

	//--------------- GROUND OPS Flight Report  -------------------------
	 
	@Override
	public List<fligthSectorLog> PopulateFlightReport(String airline, String airport, String shortby, String dateofoperation, String flightno, String useremail) {

		   boolean StobartUser         = useremail.indexOf("@stobartair.com") !=-1? true: false;	
		   GroundOpsSqlBuilder gopssql = new GroundOpsSqlBuilder();
		   String builtsql             = null;
		   
		 //---- FOR STOBART USER----
		   if(StobartUser) {
			  builtsql= gopssql.builtFlightReportSql(airline,airport,shortby,dateofoperation,flightno);
		   }
		   
		   //---- FOR GH ----
		   if(!StobartUser) {
			 //System.out.println("Not a stobart user please built Air line and airport code");
			 
			   //-- For Ground Handler External Pull list of assigned airport 
			   String eligibleairportlist = gopsobj.getAllEligibleAirportforGH(useremail);
			   String eligibleairlinelist = gopsobj.getAllEligibleAirlineforGH(useremail);
			   
			   
			 if(airline.equals("ALL")) {   	        	 
				//--- When Search button click for the GH User -- 
				airline=eligibleairlinelist;
   	         }
			 
			 if(airport.equals("ALL")) {   	        	 
				//--- When Search button click for the GH User --
			    airport=eligibleairportlist;
	   	     }	
			 
			 if(airport.equals("ALL") && airline.equals("ALL")) {
				 airport=eligibleairportlist;
				 airline=eligibleairlinelist;
			 }
			 
			 builtsql = gopssql.builtFlightReportSql(airline,airport,shortby,dateofoperation,flightno);	
				 
		   }//end of if  FOR GH ----   
			
		   
		   
		   
		   List<fligthSectorLog>  flightseclog = jdbcTemplateSqlServer.query(builtsql,new flightSectorLogRowmapper());
		   gopssql   = null;
		   builtsql  = null;
		   
		return flightseclog;

	}


   	   @Override  //jai  Will be Called for the delay Flight Report 
	   public List<fligthSectorLog> PopulateDelayFlightReport(String airline, String airport, String fltdate ,String todate,String flightno, String useremail){
		   boolean StobartUser         = useremail.indexOf("@stobartair.com") !=-1? true: false;	
		   GroundOpsSqlBuilder gopssql = new GroundOpsSqlBuilder();
		   String builtsql             = null;
		   
		 //---- FOR STOBART USER----
		   if(StobartUser) {
			  builtsql= gopssql.builtDelayFlightReportSql(airline,airport,null,fltdate,todate,flightno);
		   }
		   
		   //---- FOR GH ----
		   if(!StobartUser) {
			 //System.out.println("Not a stobart user please built Air line and airport code");
			 
			   //-- For Ground Handler External Pull list of assigned airport 
			   String eligibleairportlist = gopsobj.getAllEligibleAirportforGH(useremail);
			   String eligibleairlinelist = gopsobj.getAllEligibleAirlineforGH(useremail);
			   
			   
			 if(airline.equals("ALL")) {   	        	 
				//--- When Search button click for the GH User -- 
				airline=eligibleairlinelist;
   	         }
			 
			 if(airport.equals("ALL")) {   	        	 
				//--- When Search button click for the GH User --
			    airport=eligibleairportlist;
	   	     }	
			 
			 if(airport.equals("ALL") && airline.equals("ALL")) {
				 airport=eligibleairportlist;
				 airline=eligibleairlinelist;
			 }
			 
			 builtsql = gopssql.builtDelayFlightReportSql(airline,airport,null,fltdate,todate,flightno);	
				 
		   }//end of if  FOR GH ---- jai  
		   
		   
		   List<fligthSectorLog>  flightseclog1 = jdbcTemplateSqlServer.query(builtsql,new flightSectorLogRowmapper());
		   gopssql   = null;
		   builtsql  = null;
	
		   
		   return flightseclog1;	 
		   
		   
	
	   }//  End of Function 
		
		

	
	
	
	
	
	
	
	
	
	
	
	
	

	
	
	

	   //--------------- May Fly Report Body Generator Functions -------------------------
	   
		@Override //-------- Display For Today Tomorrow and Yesterday  and Cancel flight 0 
		public List<fligthSectorLog> Populate_MayFly_Report_body(String airline,String airport,String shortby,String dateofoperation,int num,String emailid){		
			   linkPortalSqlBuilder sqlb = new linkPortalSqlBuilder();		   
			   String builtsql = sqlb.builtMayFlightReportSql(airline,airport,shortby,dateofoperation,num);			   
			   List<fligthSectorLog>  flightseclog = jdbcTemplateSqlServer.query(builtsql,new flightSectorLogRowmapper());
			   sqlb=null;
			   builtsql=null;
			return flightseclog;
		}

		
        
		@Override //-------- Display For One date	  
		public List<fligthSectorLog> Populate_MayFly_Report_body(String airline,String airport,String shortby,String dateofoperation,String emailid){		
			   linkPortalSqlBuilder sqlb = new linkPortalSqlBuilder();		   
			   String builtsql = sqlb.builtMayFlightReportSql(airline,airport,shortby,dateofoperation);			
			   List<fligthSectorLog>  flightseclog = jdbcTemplateSqlServer.query(builtsql,new flightSectorLogRowmapper());
			   sqlb=null;
			   builtsql=null;
			   
			return flightseclog;
		}
	
	
	
		
		
		
	
	
	
	
	
	//--------------- Reliablity Report Body Generator Functions -------------------------

	@Override
	public List<fligthSectorLog> Populate_Reliablity_Report_body(String airline, String airport,
		   String startDate, String endDate, String tolerance, String delayCodeGroupCode) {	
		   linkPortalSqlBuilder sqlb = new linkPortalSqlBuilder();
		   String sql=sqlb.builtReliabilityReportSQL(airline,airport,startDate,endDate,tolerance,delayCodeGroupCode);
		   List<fligthSectorLog>  flightseclog = jdbcTemplateSqlServer.query(sql,new flightSectorLogRowmapper());		
		   sql=null;
		   sqlb=null;
		return flightseclog;
	}

	


	//--------------- Reliablity Report Body For CANCEL FLIGHT Generator Functions -------------------------

	@Override
	public List Populate_Reliablity_Report_body_Cancle_Flights(String airline, String airport, String startDate,
			String endDate, String tolerance) throws Exception {
		
		    linkPortalSqlBuilder sqlb1 = new linkPortalSqlBuilder();		    
		    String sql = sqlb1.builtReliabilityReportSQL_For_Calcle_Flights(airline, airport, startDate, endDate,tolerance);		    
		    
		    List<fligthSectorLog>  flightseclog_C = jdbcTemplateSqlServer.query(sql,new flightSectorLogRowmapper());		
		    sql=null;
		    sqlb1=null;
		    return flightseclog_C;
	}


	
	
	
	
	
	
	
	
	
	///////////////////------------ THIS PART IS FOR DAILY SUMMARY REPORT ------------------////////////////////////	
    


	@Override
	public String CompletionKPI_Pax_KPI(String airline, String operation, String dateofoperation) throws NumberFormatException, ParseException,ArithmeticException {
		
		
		   String CompletionKPIPaxKPI="";
		
		   //------------ REPORT ITEMS -------------------
		   int TotalNumberofFlightsScheduled=0;
		   int NoofFlightsDelayed15Mins=0;
		   int FlightsCompleted=0;
		   int CompletionRate=0;		   
		   int PXTotalPax=0;
		   int PXtotalloadfactor=0;
		   int PXNoPaxDelayed15Mins=0;		   
		   int PXCanx=0;		   
		   int PXMaxdelay=0;
		   int PXAvgDelayMins=0;
		   int maximumDelay=0;
		   int averageDelay=0;
		   
		   //------------ SQL TO PULL OFF DETAIL FROM PDC -------------
		   
		   String andstring="";  //<<== THis will be used for the Airline and Operation Selection 
		   if((!airline.equals("ALL"))){ 
		    	
	    		if((airline.equals("BE"))){
	    			
		      		   if(operation.equals("All Operation")) { andstring += " AND SUBSTRING(LEGS.FLTID,1,3)='"+airline+"'"; } 
		    		   if(operation.equals("CPA")) { andstring += " AND SUBSTRING(LEGS.FLTID,1,3)='BE' and legs.FLTID not like 'BE 6%'"; }
		    		   if(operation.equals("Franchise")) { andstring += " AND LEGS.FLTID like 'BE 6%'"; } 
		   		}
	    		else
	    		{	
	    			andstring += " AND SUBSTRING(LEGS.FLTID,1,3)='"+airline+"'"; 
	    		}
           }//----------- End Of If -------------- 
	
		   
		   
		   
		  String sqlstrkpi="select sum(case when status != 'RTR' then 1 else 0 end )  as totalflights,\r\n" + 
		  		"	   sum(case when status = 'ATA' then 1 else 0 end ) as NumFlown, \r\n" + 
		  		"	   sum(case when status = 'CNL' then 1 else 0 end) as NumCancelled,\r\n" + 
		  		"	   sum(case when status = 'ATA' and DUR1+DUR2+DUR3+DUR4 > 0 then 1 else 0 end) as NoofDelayFlights, \r\n" + 
		  		"	   sum(case when status = 'ATA' and DUR1+DUR2+DUR3+DUR4 < 5 then 1 else 0 end) as Late_Lessthen5minute,\r\n" + 
		  		"	   sum(case when status = 'ATA' and DUR1+DUR2+DUR3+DUR4 < 15 then 1 else 0 end)  as Late_Lessthen15Minute,\r\n" + 
		  		"	   sum(case when status = 'ATA' and DUR1+DUR2+DUR3+DUR4 > 15 then 1 else 0 end)  as Late_MoreThen15Minute,\r\n" + 
		  		"	   sum(case when status = 'ATA' and DUR1+DUR2+DUR3+DUR4 > 15 then 1 else 0 end) as Late_Above15Minute, 	   \r\n" + 
		  		"	   MAX(DUR1) as maxDur1,  MAX(DUR2) as maxDur2,  MAX(DUR3) as maxDur3,  MAX(DUR4) as maxDur4,		   \r\n" + 
		  		"	   SUM(DUR1) as TotalDur1,  SUM(DUR2) as TotalDur2,  SUM(DUR3) as TotalDur3,  SUM(DUR4) as TotalDur4,\r\n" + 
		  		"	   sum(case when status = 'ATA' then pax else 0 end) as Passenger_Carried_PAX,	\r\n" + 
		  		"	   sum(case when status = 'ATA' AND DUR1+DUR2+DUR3+DUR4 > 15 then pax else 0 end) as PAX_DELAY_MORETHEN_15MINUTES,\r\n" + 
		  		"	   sum(case when status = 'CNL' then CAST(pbi.booked AS int) else 0 end) as TOTAL_CANX_PASSENGER,	\r\n" + 
		  		"	   sum(VER.scr_seats) as Total_Available_Seat  from PBI,LEGS , ACTYPE_VERSIONS_MISC VER	 " +
		  		
		  		"	   where legs.ACTYP = VER.actype and LEGS.VERSION = VER.version  and LEGS.FLTID=PBI.FLTID and PBI.DATOP=LEGS.DATOP and  LEGS.DATOP = '"+dateofoperation+"'"+andstring;
		
		  try{
				
					  
		   Connection connection;
		   connection = dataSourcesqlserver.getConnection();
		   Statement stac = connection.createStatement();
		   ResultSet rsc = stac.executeQuery(sqlstrkpi);
		   
           if(rsc.next()){
				
		   		   if(rsc.getString("totalflights") != null) {
					
			   			TotalNumberofFlightsScheduled = Integer.parseInt(rsc.getString("totalflights")); 
			   			NoofFlightsDelayed15Mins      = Integer.parseInt(rsc.getString("Late_Above15Minute"));
			   			FlightsCompleted              = Integer.parseInt(rsc.getString("NumFlown"));
			   			CompletionRate                = (Integer.parseInt(rsc.getString("NumFlown")) * 100)/Integer.parseInt(rsc.getString("totalflights"));
			   			PXTotalPax                    = Integer.parseInt(rsc.getString("Passenger_Carried_PAX")); 
			   			PXtotalloadfactor             = (Integer.parseInt(rsc.getString("Passenger_Carried_PAX")) * 100)/Integer.parseInt(rsc.getString("Total_Available_Seat"));
			   			PXNoPaxDelayed15Mins          = Integer.parseInt(rsc.getString("PAX_DELAY_MORETHEN_15MINUTES")); 
			   			PXCanx                        = rsc.getInt("TOTAL_CANX_PASSENGER"); 
			   			
                         try {
                        	 
                        	 
			   			//----------- Calculate Average Delay -----------------
			   			averageDelay                  = (Integer.parseInt(rsc.getString("TotalDur1"))+Integer.parseInt(rsc.getString("TotalDur2"))
			   			+Integer.parseInt(rsc.getString("TotalDur3"))+Integer.parseInt(rsc.getString("TotalDur4"))) / Integer.parseInt(rsc.getString("NoofDelayFlights"));
                      
                         
                         }catch(ArithmeticException ee) {}
			   			
			   			
			   			// Convert Minutes to HH:MM Format 
						SimpleDateFormat ad = new SimpleDateFormat("mm");
						Date adt = ad.parse(Integer.toString(averageDelay));
						ad = new SimpleDateFormat("HH:mm");		
						
			   			
			   			
			   			
			   			
			   			// --------- Calculating Max Delay -------------------
			   			maximumDelay=Integer.parseInt(rsc.getString("maxDur1"));
			   			if(Integer.parseInt(rsc.getString("maxDur2")) > maximumDelay){
			   				maximumDelay= Integer.parseInt(rsc.getString("maxDur2")); 	
			   			}
			   			
			   			if(Integer.parseInt(rsc.getString("maxDur3")) > maximumDelay){
			   				maximumDelay= Integer.parseInt(rsc.getString("maxDur3")); 	
			   			}
			   			
			   			if(Integer.parseInt(rsc.getString("maxDur4")) > maximumDelay){
			   				maximumDelay= Integer.parseInt(rsc.getString("maxDur4")); 	
			   			}
			   			
			   			
			   			//------- Convert Minutes to HH:MM Format 
						SimpleDateFormat sd = new SimpleDateFormat("mm");
						Date dt = sd.parse(Integer.toString(maximumDelay));
						sd = new SimpleDateFormat("HH:mm");		
						
			   			
			   			
			   			
			   			
			   			CompletionKPIPaxKPI=CompletionKPIPaxKPI+"<tr>" + 
			   					"						<td width='35%'> Total Number of Flights Scheduled</td>"+ 
			   					"				        <td width='10%'><b>"+TotalNumberofFlightsScheduled+"</b></td>" + 
			   					"				        <td width='35%'>Total Pax & Load Factor %</td>"+ 
			   					"						<td width='20%'><b>"+PXTotalPax+" - "+PXtotalloadfactor+"%<b></td>" + 
			   					"					</tr>"; 			
		
			   			
			   			CompletionKPIPaxKPI=CompletionKPIPaxKPI+"<tr>" + 
			   					"						<td width='35%'> # Flights Completed</td>"+ 
			   					"				        <td width='10%'><b>"+FlightsCompleted+"</b></td>" + 
			   					"				        <td width='35%'>PAX Delayed > 15 Minutes && Canx</td>"+ 
			   					"						<td width='20%'><b>"+PXNoPaxDelayed15Mins+"</b>&nbsp;Pax<b>- "+ PXCanx+"</b>&nbsp;Pax</td>" + 
			   					"					</tr>"; 			
			   			
			   			CompletionKPIPaxKPI=CompletionKPIPaxKPI+"<tr>" + 
			   					"						<td width='35%'> No. of Flights Delayed > 15 Minutes</td>"+ 
			   					"				        <td width='10%'><b>"+NoofFlightsDelayed15Mins+"</b></td>" + 
			   					"				        <td width='35%'>Max Delay</td>"+ 
			   					"						<td width='20%'><b>"+sd.format(dt)+"</b></td>" + 
			   					"					</tr>"; 			
		
	
			   			CompletionKPIPaxKPI=CompletionKPIPaxKPI+"<tr>" + 
			   					"						<td width='35%'>Completion Rate (%) Target: 99.5%</td>"+ 
			   					"				        <td width='10%'><b>"+CompletionRate+"%</b></td>" + 
			   					"				        <td width='35%'>Avg. Delay Mins</td>"+ 
			   					"						<td width='20%'><b>"+ad.format(adt)+"</b></td>" + 
			   					"					</tr>"; 			
			
				   			
		   		   }
	   	     
	   	      } 
	   	      
	   	   rsc.close();	
	   	   stac.close();   
	   	   connection.close();
	   	   
		} catch (SQLException e) {e.printStackTrace(); logger.error("In the Function CompletionKPI_Pax_KPI:"+e.toString());}
		
	  
		return CompletionKPIPaxKPI;
	}
	
	


	
	
	
	
	@Override
	public  HashMap<String ,Integer>  PunctualityTargetPerCent(String airline, String operation, String dateofoperation) {
		    
		   String andstring="";
		   
		   int flightflown=0;
		   int lessthen5minut=0;					   
		   int lessthen15minut=0;					   
  
		   HashMap<String, Integer> map1 = new HashMap<String, Integer>();
		   map1.put("title",5);  
		   
		   if((airline.equals("ALL"))){
		         map1.put("lessthen5minut",70);
		         map1.put("lessthen15minut", 85);
			   
		   }else
		   {
		         map1.put("lessthen5minut",70);
		         map1.put("lessthen15minut", 85);
		   }
		   
		   
		   
		   if((airline.equals("BE"))){
			 
		      map1.put("lessthen5minut",65);
		      map1.put("lessthen15minut",85);
		   }
		   
		   if((airline.equals("EI"))){
			  map1.put("title",3); 
		      map1.put("lessthen5minut",70);
		      map1.put("lessthen15minut",85);
		   }
		  
			   
		
	  
		return map1;
	     
	     
	} 
	//************ END OF FUNCTION PunctualityTargetPerCent 




	
	
	@Override
	public String PunctualityStatistics(String airline, String operation, String dateofoperation) throws NumberFormatException {
         
		
		 
		   String andstring="";  //<<== THis will be used for the Airline and Operation Selection 
		   
		   
		   String sqlstr="select sum(case when status = 'ATA' then 1 else 0 end) as NumFlown,      \r\n" + 
		   		"	   sum(case when status = 'ATA' and (datediff(minute, convert(datetime, REPLACE(LEGS.STD, '.', ':'), 120), convert(datetime, REPLACE(LEGS.ATD, '.', ':'), 120)) <= 0) then 1 else 0 end) as OnTime,\r\n" + 
		   		"	   sum(case when status = 'ATA' and (datediff(minute, convert(datetime, REPLACE(LEGS.STD, '.', ':'), 120), convert(datetime, REPLACE(LEGS.ATD, '.', ':'), 120)) <= 3) then 1 else 0 end)  as LessthenEqual3Minute,\r\n" + 
		   		"	   sum(case when status = 'ATA' and (datediff(minute, convert(datetime, REPLACE(LEGS.STD, '.', ':'), 120), convert(datetime, REPLACE(LEGS.ATD, '.', ':'), 120)) <= 5) then 1 else 0 end)  as LessthenEqual5Minute,\r\n" +
		   		"	   sum(case when status = 'ATA' and (datediff(minute, convert(datetime, REPLACE(LEGS.STD, '.', ':'), 120), convert(datetime, REPLACE(LEGS.ATD, '.', ':'), 120)) <= 15) then 1 else 0 end) as LessthenEqual15Minute,\r\n" + 
		   		"	   sum(case when status = 'ATA' and DUR1+DUR2+DUR3+DUR4 <= 30 then 1 else 0 end) as LessthenEqual30Minute\r\n" + 
		   		"	   from LEGS    where DATOP = '"+dateofoperation+"'";
		   

 		   
		   
		 //*********************** THIS PART IS FOR ALL DEPARTURE*******************************
		   if((!airline.equals("ALL"))){ 
		    	
	    		if((airline.equals("BE"))){
	    			
		      		   if(operation.equals("All Operation")) { andstring += " AND SUBSTRING(LEGS.FLTID,1,3)='"+airline+"'"; } 
		    		   if(operation.equals("CPA")) { 
		    			   andstring += " AND SUBSTRING(LEGS.FLTID,1,3)='BE' and legs.FLTID not like 'BE 6%'";
	    			   
		    		   }
		    		   
		    		   if(operation.equals("Franchise")) { andstring += " AND LEGS.FLTID like 'BE 6%'"; }
		    		   
		   		}
	    		else
	    		{	
	    			andstring += " AND SUBSTRING(LEGS.FLTID,1,3)='"+airline+"'"; 
	    		}
           }//----------- End Of If -------------- 
		
			   
		   sqlstr = sqlstr+andstring;
		   
		   String flybeatrsql     = sqlstr + "and legs.ACTYP='A76'";
		   String flyembrarrersql = sqlstr + "and legs.ACTYP='E90'";				 

		   
		   
		   
		  
		   
		   int noofflightflown=0;
		   int ontime=0;
		   int lessthen3minutes=0;
		   int lessthen5minutes=0;
		   int lessthen15minutes=0;
		   int lessthen30minutes=0;
      
		   String reportbody="";
		   
				

		   SqlRowSet rsc  = jdbcTemplateSqlServer.queryForRowSet(sqlstr);  		   

		   
		   
		 
    	   if(rsc.next()){
			
    		   
    		   if(rsc.getString("NumFlown") != null) {
    			   
				   noofflightflown=Integer.parseInt(rsc.getString("NumFlown"));
				   ontime=Integer.parseInt(rsc.getString("OnTime"));
				   lessthen3minutes=Integer.parseInt(rsc.getString("LessthenEqual3Minute"));
				   lessthen5minutes=Integer.parseInt(rsc.getString("LessthenEqual5Minute"));
				   lessthen15minutes=Integer.parseInt(rsc.getString("LessthenEqual15Minute"));
				   lessthen30minutes=Integer.parseInt(rsc.getString("LessthenEqual30Minute"));
				   
		           try {
				   
			           ontime = (ontime * 100)/noofflightflown;
			           lessthen3minutes= (lessthen3minutes * 100)/noofflightflown;
			           lessthen5minutes= (lessthen5minutes * 100)/noofflightflown;
					   lessthen15minutes= (lessthen15minutes * 100)/noofflightflown;
					   lessthen30minutes= (lessthen30minutes * 100)/noofflightflown;
					   
		           }catch (ArithmeticException er) {er.printStackTrace(); logger.error("In the Function PunctualityStatistics:"+er.toString());}
				   
			
				   reportbody =reportbody+"<tr><td>ALL</td><td>DEPARTURE</td><td>"+noofflightflown+"</td>";
				   reportbody =reportbody+"<td>"+ontime+"%</td>";
				   
				   if((airline.equals("EI"))){
					   reportbody =reportbody+"<td>"+lessthen3minutes+"%</td>";  
				   }
				   else
				   {
				      reportbody =reportbody+"<td>"+lessthen5minutes+"%</td>";
				   }
				   
				   reportbody =reportbody+"<td>"+lessthen15minutes+"%</td>";
				   reportbody =reportbody+"<td>-</td></tr>";
			   
			   
    		   } 
		   }
    	   
    	   
    	  
    	   //--------------- THIS PART IS FOR ALL ARRIVALE -----------------------------------------
    	   
		   String sqlstr1="select sum(case when status = 'ATA' then 1 else 0 end) as NumFlown,      \r\n" + 
		   		"	   sum(case when status = 'ATA' and (datediff(minute, convert(datetime, REPLACE(LEGS.STA, '.', ':'), 120), convert(datetime, REPLACE(LEGS.ATA, '.', ':'), 120)) <= 0) then 1 else 0 end) as OnTimeArrival,\r\n" + 
		   		"	   sum(case when status = 'ATA' and (datediff(minute, convert(datetime, REPLACE(Legs.STA, '.', ':'), 120), convert(datetime, REPLACE(Legs.ATA, '.', ':'), 120)) <= 5) then 1 else 0 end)  as LessthenEqual5Minute,\r\n" + 
		   		"	   sum(case when status = 'ATA' and (datediff(minute, convert(datetime, REPLACE(Legs.STA, '.', ':'), 120), convert(datetime, REPLACE(Legs.ATA, '.', ':'), 120)) <= 15) then 1 else 0 end)  as LessthenEqual15Minute,\r\n" + 
		   		"	   sum(case when status = 'ATA' and (datediff(minute, convert(datetime, REPLACE(Legs.STA, '.', ':'), 120), convert(datetime, REPLACE(Legs.ATA, '.', ':'), 120)) <= 30) then 1 else 0 end) as LessthenEqual30Minute\r\n" + 
		   		"	   from LEGS    where DATOP = '"+dateofoperation+"'"+andstring+
                "       ";	

    	   
    	   
		  
		   
		   	
		   
		   rsc =  jdbcTemplateSqlServer.queryForRowSet(sqlstr1);  
		   if(rsc.next()){				
	    		   
	    		   if(rsc.getString("NumFlown") != null) {
	    	
	    			   noofflightflown=Integer.parseInt(rsc.getString("NumFlown"));
					   ontime=Integer.parseInt(rsc.getString("OnTimeArrival"));
					   lessthen5minutes=Integer.parseInt(rsc.getString("LessthenEqual5Minute"));
					   lessthen15minutes=Integer.parseInt(rsc.getString("LessthenEqual15Minute"));
					   lessthen30minutes=Integer.parseInt(rsc.getString("LessthenEqual30Minute"));
					   
			           try {
			        	   
						   ontime = (ontime * 100)/noofflightflown;
						   lessthen5minutes= (lessthen5minutes * 100)/noofflightflown;
						   lessthen15minutes= (lessthen15minutes * 100)/noofflightflown;
						   lessthen30minutes= (lessthen30minutes * 100)/noofflightflown;
			           
			           }catch (ArithmeticException er) {er.printStackTrace(); logger.error("PunctualityStatistics:"+er.toString());}
					   
				
					   reportbody =reportbody+"<tr><td>ALL</td><td>ARRIVAL</td><td>"+noofflightflown+"</td>";
					   reportbody =reportbody+"<td>"+ontime+"%</td>";
					   reportbody =reportbody+"<td>"+lessthen5minutes+"%</td>";
					   reportbody =reportbody+"<td>"+lessthen15minutes+"%</td>";
					   reportbody =reportbody+"<td>-</td></tr>";
						   
	    			   
	    		   }          
		      }	   
		     
    	   rsc = null;
    	   
	   
    	   
    	   
    	   
    	   //---  THIS PART IS FOR  FLYBE CPA - ATR - EMBERRAR -----------------------
    	   if(operation.equals("CPA")) {
    		    
     		   SqlRowSet row =  jdbcTemplateSqlServer.queryForRowSet(flybeatrsql);  
    		   if(row.next()) {
    			   
    			   
        		   if(row.getString("NumFlown") != null) {
        		    	
	    			   noofflightflown=Integer.parseInt(row.getString("NumFlown"));
					   ontime=Integer.parseInt(row.getString("OnTime"));
					   lessthen5minutes=Integer.parseInt(row.getString("LessthenEqual5Minute"));
					   lessthen15minutes=Integer.parseInt(row.getString("LessthenEqual15Minute"));
					   lessthen30minutes=Integer.parseInt(row.getString("LessthenEqual30Minute"));
					   
			           try {
			        	   
						   ontime = (ontime * 100)/noofflightflown;
						   lessthen5minutes= (lessthen5minutes * 100)/noofflightflown;
						   lessthen15minutes= (lessthen15minutes * 100)/noofflightflown;
						   lessthen30minutes= (lessthen30minutes * 100)/noofflightflown;
			           
			           }catch (ArithmeticException er) {er.printStackTrace(); logger.error("PunctualityStatistics:"+er.toString());}
					   
				
					   reportbody =reportbody+"<tr><td>ALL</td><td><b>ATR</b></td><td>"+noofflightflown+"</td>";
					   reportbody =reportbody+"<td>"+ontime+"%</td>";
					   reportbody =reportbody+"<td>"+lessthen5minutes+"%</td>";
					   reportbody =reportbody+"<td>"+lessthen15minutes+"%</td>";
					   reportbody =reportbody+"<td>-</td></tr>";
						   
	    			   
	    		   }          
		
    			   
    		   }
    		   row = null;
    		   row =  jdbcTemplateSqlServer.queryForRowSet(flyembrarrersql);  
    		   if(row.next()) {
    			   
    			   
        		   if(row.getString("NumFlown") != null) {
        		    	
	    			   noofflightflown=Integer.parseInt(row.getString("NumFlown"));
					   ontime=Integer.parseInt(row.getString("OnTime"));
					   lessthen5minutes=Integer.parseInt(row.getString("LessthenEqual5Minute"));
					   lessthen15minutes=Integer.parseInt(row.getString("LessthenEqual15Minute"));
					   lessthen30minutes=Integer.parseInt(row.getString("LessthenEqual30Minute"));
					   
			           try {
			        	   
						   ontime = (ontime * 100)/noofflightflown;
						   lessthen5minutes= (lessthen5minutes * 100)/noofflightflown;
						   lessthen15minutes= (lessthen15minutes * 100)/noofflightflown;
						   lessthen30minutes= (lessthen30minutes * 100)/noofflightflown;
			           
			           }catch (ArithmeticException er) {er.printStackTrace(); logger.error("PunctualityStatistics:"+er.toString());}
					   
				
					   reportbody =reportbody+"<tr><td>ALL</td><td><b>EMBRAER</b></td><td>"+noofflightflown+"</td>";
					   reportbody =reportbody+"<td>"+ontime+"%</td>";
					   reportbody =reportbody+"<td>"+lessthen5minutes+"%</td>";
					   reportbody =reportbody+"<td>"+lessthen15minutes+"%</td>";
					   reportbody =reportbody+"<td>-</td></tr>";
						   
	    			   
	    		   }          
		
    			   
    		   }
    		   row = null;
    		
    		   
    		   
    		   
    		   
    	   }//--- END OF THIS PART IS FOR  FLYBE CPA - ATR - EMBERRAR -----------------------
    	 
    	   
    
    		
	   		
	   		//********************** IF AIR- LINGUS IS SELECTED THEN  NEED TO POPULATE ALL MAZOR STATION *************************** 
	   		if(airline.equals("EI")) {
	   			
	   			//------ FOR DUBLIN DEPARTURE ----
	   		   String alldublindepartureSql = sqlstr+" and DEPSTN='DUB'";
	 		   rsc =  jdbcTemplateSqlServer.queryForRowSet(alldublindepartureSql);  
	 		   if(rsc.next()){				
	 	    		   
	 	    		   if(rsc.getString("NumFlown") != null) {
	 	    	
	 	    			   noofflightflown=Integer.parseInt(rsc.getString("NumFlown"));
	 					   ontime=Integer.parseInt(rsc.getString("OnTime"));
	 					   lessthen5minutes=Integer.parseInt(rsc.getString("LessthenEqual5Minute"));
	 					   lessthen15minutes=Integer.parseInt(rsc.getString("LessthenEqual15Minute"));
	 					   lessthen30minutes=Integer.parseInt(rsc.getString("LessthenEqual30Minute"));
	 					   
	 			           try {
	 			        	   
		 					   ontime = (ontime * 100)/noofflightflown;
		 					   lessthen5minutes= (lessthen5minutes * 100)/noofflightflown;
		 					   lessthen15minutes= (lessthen15minutes * 100)/noofflightflown;
		 					   lessthen30minutes= (lessthen30minutes * 100)/noofflightflown;
	 			           
	 			           }catch (ArithmeticException er) {er.printStackTrace(); logger.error("PunctualityStatistics:"+er.toString());}
	 					   
	 				
	 					   reportbody =reportbody+"<tr><td>DUB</td><td>DEPARTURE</td><td>"+noofflightflown+"</td>";
	 					   reportbody =reportbody+"<td>"+ontime+"%</td>";
	 					   reportbody =reportbody+"<td>"+lessthen5minutes+"%</td>";
	 					   reportbody =reportbody+"<td>"+lessthen15minutes+"%</td>";
	 					   reportbody =reportbody+"<td>-</td></tr>";
	 						   
	 	    			   
	 	    		   }          
	 		      }	   
	 		   
	    	   
	     	   rsc = null;
	     	   	   			
	   			
	   			
	   			
	   			
	   			
	   		   //------ FOR DUBLIN ARRIVAL ----
	   	       String alldublinarrivalSql   = sqlstr1+" and ARRSTN='DUB'"; 
	   	     
  					
	 	
	 		   rsc =  jdbcTemplateSqlServer.queryForRowSet(alldublinarrivalSql);  
	 		   if(rsc.next()){				
	 	    		   
	 	    		   if(rsc.getString("NumFlown") != null) {
	 	    	
	 	    			   noofflightflown=Integer.parseInt(rsc.getString("NumFlown"));
	 					   ontime=Integer.parseInt(rsc.getString("OnTimeArrival"));
	 					   lessthen5minutes=Integer.parseInt(rsc.getString("LessthenEqual5Minute"));
	 					   lessthen15minutes=Integer.parseInt(rsc.getString("LessthenEqual15Minute"));
	 					   lessthen30minutes=Integer.parseInt(rsc.getString("LessthenEqual30Minute"));
	 					   
	 			           try {
	 			        	   
		 					   ontime = (ontime * 100)/noofflightflown;
		 					   lessthen5minutes= (lessthen5minutes * 100)/noofflightflown;
		 					   lessthen15minutes= (lessthen15minutes * 100)/noofflightflown;
		 					   lessthen30minutes= (lessthen30minutes * 100)/noofflightflown;
	 			           
	 			           }catch (ArithmeticException er) {er.printStackTrace(); logger.error("PunctualityStatistics:"+er.toString());}
	 					   
	 				
	 					   reportbody =reportbody+"<tr><td>DUB</td><td>ARRIVAL</td><td>"+noofflightflown+"</td>";
	 					   reportbody =reportbody+"<td>"+ontime+"%</td>";
	 					   reportbody =reportbody+"<td>"+lessthen5minutes+"%</td>";
	 					   reportbody =reportbody+"<td>"+lessthen15minutes+"%</td>";
	 					   reportbody =reportbody+"<td>-</td></tr>";
	 						   
	 	    			   
	 	    		   }          
	 		      }	   
	 		   
	    	   
	     	   rsc = null;
		   			
	     
	     	   //------ FOR CORK DEPARTURE ----
	   		   alldublindepartureSql = sqlstr+" and DEPSTN='ORK'";	   			
	   			
	   
		 		
		 		  rsc =  jdbcTemplateSqlServer.queryForRowSet(alldublindepartureSql); 
		 		  if(rsc.next()){				
		 	    		   
		 	    		   if(rsc.getString("NumFlown") != null) {
		 	    	
		 	    			   noofflightflown=Integer.parseInt(rsc.getString("NumFlown"));
		 					   ontime=Integer.parseInt(rsc.getString("OnTime"));
		 					   lessthen5minutes=Integer.parseInt(rsc.getString("LessthenEqual5Minute"));
		 					   lessthen15minutes=Integer.parseInt(rsc.getString("LessthenEqual15Minute"));
		 					   lessthen30minutes=Integer.parseInt(rsc.getString("LessthenEqual30Minute"));
		 					   
		 			           try {
			 			        	   
			 					   ontime = (ontime * 100)/noofflightflown;
			 					   lessthen5minutes= (lessthen5minutes * 100)/noofflightflown;
			 					   lessthen15minutes= (lessthen15minutes * 100)/noofflightflown;
			 					   lessthen30minutes= (lessthen30minutes * 100)/noofflightflown;
			 			           
		 			           }catch (ArithmeticException er) {er.printStackTrace(); logger.error("PunctualityStatistics:"+er.toString());}
		 					   
		 				
		 					   reportbody =reportbody+"<tr><td>ORK</td><td>DEPARTURE</td><td>"+noofflightflown+"</td>";
		 					   reportbody =reportbody+"<td>"+ontime+"%</td>";
		 					   reportbody =reportbody+"<td>"+lessthen5minutes+"%</td>";
		 					   reportbody =reportbody+"<td>"+lessthen15minutes+"%</td>";
		 					   reportbody =reportbody+"<td>-</td></tr>";
		 						   
		 	    			   
		 	    		   }          
		 		      }	   
		 		   
		    	   
		     	   rsc = null;
		     	   	   			
		   			
		   			
	   			
	   			
	   			
	   		   //------ FOR CORK ARRIVAL ----
	   	       alldublinarrivalSql   = sqlstr1+" and ARRSTN='ORK'"; 
	   	     
	
	 		
	 		  rsc =  jdbcTemplateSqlServer.queryForRowSet(alldublinarrivalSql); 
	 		   if(rsc.next()){				
	 	    		   
	 	    		   if(rsc.getString("NumFlown") != null) {
	 	    	
	 	    			   noofflightflown=Integer.parseInt(rsc.getString("NumFlown"));
	 					   ontime=Integer.parseInt(rsc.getString("OnTimeArrival"));
	 					   lessthen5minutes=Integer.parseInt(rsc.getString("LessthenEqual5Minute"));
	 					   lessthen15minutes=Integer.parseInt(rsc.getString("LessthenEqual15Minute"));
	 					   lessthen30minutes=Integer.parseInt(rsc.getString("LessthenEqual30Minute"));
	 					   
	 			           try {
	 			        	   
		 					   ontime = (ontime * 100)/noofflightflown;
		 					   lessthen5minutes= (lessthen5minutes * 100)/noofflightflown;
		 					   lessthen15minutes= (lessthen15minutes * 100)/noofflightflown;
		 					   lessthen30minutes= (lessthen30minutes * 100)/noofflightflown;
	 			           
	 			           }catch (ArithmeticException er) {er.printStackTrace(); logger.error("PunctualityStatistics:"+er.toString());}
	 					   
	 				
	 					   reportbody =reportbody+"<tr><td>ORK</td><td>ARRIVAL</td><td>"+noofflightflown+"</td>";
	 					   reportbody =reportbody+"<td>"+ontime+"%</td>";
	 					   reportbody =reportbody+"<td>"+lessthen5minutes+"%</td>";
	 					   reportbody =reportbody+"<td>"+lessthen15minutes+"%</td>";
	 					   reportbody =reportbody+"<td>-</td></tr>";
	 						   
	 	    			   
	 	    		   }          
	 		      }	   
	 		   
	    	   
	     	   rsc = null;
	     	   
	     	   //------ FOR SHANON  DEPARTURE ----
	   		   alldublindepartureSql = sqlstr+" and DEPSTN='SNN'";	   			
	   			
	   		   
	 		  
	 		  rsc =  jdbcTemplateSqlServer.queryForRowSet(alldublindepartureSql); 
	 		   if(rsc.next()){				
	 	    		   
	 	    		   if(rsc.getString("NumFlown") != null) {
	 	    	
	 	    			   noofflightflown=Integer.parseInt(rsc.getString("NumFlown"));
	 					   ontime=Integer.parseInt(rsc.getString("OnTime"));
	 					   lessthen5minutes=Integer.parseInt(rsc.getString("LessthenEqual5Minute"));
	 					   lessthen15minutes=Integer.parseInt(rsc.getString("LessthenEqual15Minute"));
	 					   lessthen30minutes=Integer.parseInt(rsc.getString("LessthenEqual30Minute"));
	 					   
	 			           try {
		 			        	   
		 					   ontime = (ontime * 100)/noofflightflown;
		 					   lessthen5minutes= (lessthen5minutes * 100)/noofflightflown;
		 					   lessthen15minutes= (lessthen15minutes * 100)/noofflightflown;
		 					   lessthen30minutes= (lessthen30minutes * 100)/noofflightflown;
	 			           
	 			           }catch (ArithmeticException er) {er.printStackTrace(); logger.error("PunctualityStatistics:"+er.toString());}
	 					   
	 				
	 					   reportbody =reportbody+"<tr><td>SNN</td><td>DEPARTURE</td><td>"+noofflightflown+"</td>";
	 					   reportbody =reportbody+"<td>"+ontime+"%</td>";
	 					   reportbody =reportbody+"<td>"+lessthen5minutes+"%</td>";
	 					   reportbody =reportbody+"<td>"+lessthen15minutes+"%</td>";
	 					   reportbody =reportbody+"<td>-</td></tr>";
	 						   
	 	    			   
	 	    		   }          
	 		      }	   
	 		   
	    	   
	     	   rsc = null;
	     	   	   		
	     	   
	     	   
	  		   //------ FOR SHANNON ARRIVAL ----
	   	       alldublinarrivalSql   = sqlstr1+" and ARRSTN='SNN'"; 
	   	  
 					
	 		 
	 		  rsc =  jdbcTemplateSqlServer.queryForRowSet(alldublinarrivalSql); 
	 		   
	 		   if(rsc.next()){				
	 	    		   
	 	    		   if(rsc.getString("NumFlown") != null) {
	 	    	
	 	    			   noofflightflown=Integer.parseInt(rsc.getString("NumFlown"));
	 					   ontime=Integer.parseInt(rsc.getString("OnTimeArrival"));
	 					   lessthen5minutes=Integer.parseInt(rsc.getString("LessthenEqual5Minute"));
	 					   lessthen15minutes=Integer.parseInt(rsc.getString("LessthenEqual15Minute"));
	 					   lessthen30minutes=Integer.parseInt(rsc.getString("LessthenEqual30Minute"));
	 					   
	 			           try {
		 			        	   
		 					   ontime = (ontime * 100)/noofflightflown;
		 					   lessthen5minutes= (lessthen5minutes * 100)/noofflightflown;
		 					   lessthen15minutes= (lessthen15minutes * 100)/noofflightflown;
		 					   lessthen30minutes= (lessthen30minutes * 100)/noofflightflown;
	 			           
	 			           }catch (ArithmeticException er) {er.printStackTrace(); logger.error("PunctualityStatistics:"+er.toString());}
	 					   
	 				
	 					   reportbody =reportbody+"<tr><td>SNN</td><td>ARRIVAL</td><td>"+noofflightflown+"</td>";
	 					   reportbody =reportbody+"<td>"+ontime+"%</td>";
	 					   reportbody =reportbody+"<td>"+lessthen5minutes+"%</td>";
	 					   reportbody =reportbody+"<td>"+lessthen15minutes+"%</td>";
	 					   reportbody =reportbody+"<td>-</td></tr>";
	 						   
	 	    			   
	 	    		   }          
	 		      }	   
	 		   
	    	   
	     	   rsc = null;	     	   
	     	   
	   
	   			
	   			
	   			
	   		} //------ END OF AIR LINGUS SELECTION ---------- 		
	   	//********************** IF AIR- LINGUS IS SELECTED THEN  NEED TO POPULATE ALL MAZOR STATION ***************************
	   		 
  		   
    	   
    	   
    	   
    
	   		return reportbody;
		
	}
	//**************** END OF FUNCTION ************************************




	
	

	
	
	
	
	/*-----------------No. Of Departure Delays By IATA Delay Code Category  ---------------------*/
	@Override
	public String NoOfDepartureDelaysByIATADelayCodeCategory(String Airline, String Operation, String dateofoperation) {
		 
		   dailySummarySqlBuilder sqlb = new dailySummarySqlBuilder();		   
		   String sql=sqlb.NoOfDepartureDelaysByIATADelaycodeCategory(Airline, Operation, dateofoperation);	
		   List<delaycodeGroupMaster>  delaycodecat = jdbcTemplateSqlServer.query(sql,new delaycodeGroupMasterRowmapper());
		   sql=null;
		   sqlb=null;
		   
		   
		   int ACDamageandEDPProbs=0;
		   int AirTrafficControl=0;
		   int AircraftAndRampHandling=0;
		   int CargoAndMail=0;
		   int FlightOperationsandCrewing=0;
		   int GroundOps=0;       
		   int Internal=0;
		   int Miscellaneous=0;
		   int NonStobartDelays=0;
		   int PassengerandBaggage=0;
		   int Technical=0;
		   int StobartAttributableDelays=0;
		   int Weather=0;
		   
		   
		   
		   
		   //---------- Loopoing from Resultset --------------------- 	
		   for(delaycodeGroupMaster code:delaycodecat){
			   
			   if(code.getDelaycodegroupname().trim().equalsIgnoreCase("A/C Damage and EDP Probs")) {
				   ACDamageandEDPProbs=ACDamageandEDPProbs+Integer.parseInt(code.getTotaldelaycount());
				  
			   }
		
			   if(code.getDelaycodegroupname().trim().equalsIgnoreCase("Air Traffic Control")) {
				   AirTrafficControl=AirTrafficControl+Integer.parseInt(code.getTotaldelaycount());
			
			   }
		
			  
			   if(code.getDelaycodegroupname().trim().equalsIgnoreCase("Aircraft And Ramp Handling")) {
				   AircraftAndRampHandling=AircraftAndRampHandling+Integer.parseInt(code.getTotaldelaycount());
				   
			   }
			   
               		
			   if(code.getDelaycodegroupname().trim().equalsIgnoreCase("Cargo And Mail")) {
				   CargoAndMail=CargoAndMail+Integer.parseInt(code.getTotaldelaycount());
				   
			   }
		
			   if(code.getDelaycodegroupname().trim().equalsIgnoreCase("Flight Operations and Crewing")) {
				   FlightOperationsandCrewing=FlightOperationsandCrewing+Integer.parseInt(code.getTotaldelaycount());
				  
			   }
            
       	 
			   if(code.getDelaycodegroupname().trim().equalsIgnoreCase("Ground Ops")) {
				   GroundOps=GroundOps+Integer.parseInt(code.getTotaldelaycount());
				   
			   }
		
			   if(code.getDelaycodegroupname().trim().equalsIgnoreCase("Internal")) {
				   Internal=Internal+Integer.parseInt(code.getTotaldelaycount());
				   
			   }
		       
			   
		
			   if(code.getDelaycodegroupname().trim().equalsIgnoreCase("Miscellaneous")) {
				   Miscellaneous=Miscellaneous+Integer.parseInt(code.getTotaldelaycount());
				   
			   }
		
			   if(code.getDelaycodegroupname().trim().equalsIgnoreCase("Non Stobart Delays")) {
				   NonStobartDelays=NonStobartDelays+Integer.parseInt(code.getTotaldelaycount());
				 
			   }
		
			   
			   
			   
			   if(code.getDelaycodegroupname().trim().equalsIgnoreCase("Passenger and Baggage")) {
				   PassengerandBaggage=PassengerandBaggage+Integer.parseInt(code.getTotaldelaycount());
				
			   }
			   
			   if(code.getDelaycodegroupname().trim().equalsIgnoreCase("Stobart Attributable Delays")) {
				   StobartAttributableDelays=StobartAttributableDelays+Integer.parseInt(code.getTotaldelaycount());
				   
			   }
			   
			   
			   
			   if(code.getDelaycodegroupname().trim().equalsIgnoreCase("Technical")) {
				   Technical=Technical+Integer.parseInt(code.getTotaldelaycount());
				   
			   }
		
			   
			   if(code.getDelaycodegroupname().trim().equalsIgnoreCase("Weather")) {
				   Weather=Weather+Integer.parseInt(code.getTotaldelaycount());
				   
			   }
		
			   
			   
			   
		   }
		  
		   //---------- BUILTING REPORT BODY AS STRING ---------------
		   String body="<tr><td width='45%'>A/C Damage and EDP Probs</td> <td width='5%'><b>"+ACDamageandEDPProbs+"</b></td> <td width='45%'>Air Traffic Control</td> <td width='5%'><b>"+AirTrafficControl+"</b></td></tr>";
		   body=body+"<tr><td width='45%'>Cargo And Mail</td> <td width='5%'><b>"+CargoAndMail+"</b></td> <td width='45%'>Flight Operations and Crewing</td> <td width='5%'><b>"+FlightOperationsandCrewing+"</b></td></tr>";
		   body=body+"<tr><td width='45%'>Ground Ops</td> <td width='5%'><b>"+GroundOps+"</b></td> <td width='45%'>Internal</td> <td width='5%'><b>"+Internal+"</b></td></tr>";
		   body=body+"<tr><td width='45%'>Miscellaneous</td> <td width='5%'><b>"+Miscellaneous+"</b></td> <td width='45%'>Non Stobart Delays </td> <td width='5%'><b>"+NonStobartDelays+"</b></td></tr>";
   	       body=body+"<tr><td width='45%'>Passenger and Baggage</td> <td width='5%'><b>"+PassengerandBaggage+"</b></td> <td width='45%'>Stobart Attributable Delays</td> <td width='5%'><b>"+StobartAttributableDelays+"</b></td></tr>";
		   body=body+"<tr><td width='45%'>Technical</td> <td width='5%'><b>"+Technical+"</b></td> <td width='45%'>Weather</td> <td width='5%'><b>"+Weather+"</b></td></tr>";
		   body=body+"<tr><td width='45%'>Aircraft And Ramp Handling</td> <td width='5%'><b>"+AircraftAndRampHandling+"</b></td> <td width='45%'></td> <td width='5%'><b></b></td></tr>";
	
		return body;
	
	}


	
	
	
	/*-------------------Narrative Summary of Root Delays:--------------------------------------------*/
	@Override
	public List getNarrativeSummaryofRootDelays(String Airline,String Operation,String dateofoperation){
	   	  
		   dailySummarySqlBuilder sqlb = new dailySummarySqlBuilder();
		   String sql=sqlb.getSqlforNarrativeSummaryofRootDelays(Airline, Operation, dateofoperation);
		   List<fligthSectorLog>  rootdelaylist = jdbcTemplateSqlServer.query(sql,new flightSectorLogRowmapper());
		   sql=null;
		   sqlb=null;
		return rootdelaylist;
	}

	
	
	/*-------------------Summary Of Cancel Flights :--------------------------------------------*/
	@Override
	public String getSummaryofCancelledFlights(String Airline, String Operation, String dateofoperation) throws SQLException{
		
		  String cancelflights=""; 
		  dailySummarySqlBuilder sqlb = new dailySummarySqlBuilder();
		  String sql=sqlb.getSqlFortheCancelledFlights(Airline, Operation, dateofoperation);
		  Connection connection = dataSourcesqlserver.getConnection();
		   Statement stac = connection.createStatement();
		   ResultSet rsc = stac.executeQuery(sql);
		   String bookedpax=null;      
		   while(rsc.next()){
			   bookedpax=rsc.getString("BOOKED");
			   if(bookedpax == null) {bookedpax="0";}
			   cancelflights=cancelflights+"<tr><td>"+rsc.getString("FLTID")+"</td> <td> "+bookedpax+" </td> <td> "+rsc.getString("NOTE")+"</td></tr>";				
			 	
		   }//---------- End Of While Loop 
			
		   sqlb=null;
		   rsc.close();
		   stac.close();
		   connection.close();		  
		
		return cancelflights;
	}





	@Override //----- THIS FUNCTION WILL POPULATE FLYBE LIST OF FLIGHTS 
	public List<String> Populate_Flybe_FligtList(String Airline, String Operation, String dateofoperation) {
		   
		   String sqlforflightlist="";
		   if(Operation.equals("Franchise")) {
			   sqlforflightlist="select REPLACE(FLTID, ' ', '') as FLTID FROM legs where FLTID like '"+Airline+" 6%' and DATOP='"+dateofoperation+"'"; 
		   }
	
		   if(Operation.equals("CPA")) {
			   sqlforflightlist="select REPLACE(FLTID, ' ', '') as FLTID FROM legs where FLTID like  'BE%' and fltid not like 'BE 6%' and DATOP='"+dateofoperation+"'"; 
		   }		   
		   
		   if(Operation.equals("All Operation")) { 
		   
			   sqlforflightlist="select REPLACE(FLTID, ' ', '') as FLTID from legs where FLTID like '"+Airline+"%' and DATOP='"+dateofoperation+"'"; 
		   }
		   
		

		   List<String> flightList = jdbcTemplateSqlServer.query(sqlforflightlist, new RowMapper<String>() {
			      public String mapRow(ResultSet resultSet, int i) throws SQLException {
			        return resultSet.getString("FLTID");
			      }
			    });
		   
			    
		    
		return flightList;
	}




	

}//------- End Of Main Class ----------