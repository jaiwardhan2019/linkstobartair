package com.linkportal.groundops;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.sql.DataSource;

import org.apache.commons.codec.binary.Base64;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.support.rowset.SqlRowSet;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.linkportal.security.*;



@Transactional
@Repository
public class gopsAllapiImp implements gopsAllapi  {

	 
	@Autowired
	DataSource dataSourcesqlservercp;
	
	@Autowired
	DataSource dataSourcesqlserver;
	
	@Autowired
	EncryptDecrypt encdec;
	
	
	
	JdbcTemplate jdbcTemplateRefis;
	JdbcTemplate jdbcTemplatePdc;


		
		
		
	    gopsAllapiImp(DataSource dataSourcesqlservercp,DataSource dataSourcesqlserver) {			
	    	jdbcTemplateRefis = new JdbcTemplate(dataSourcesqlservercp);
	    	jdbcTemplatePdc   = new JdbcTemplate(dataSourcesqlserver);
		}

	    
	    //---------- Logger Initializer------------------------------- 
	    private Logger logger = Logger.getLogger(gopsAllapiImp.class);

	
	 
	
	
	
	
	
	
    
	//---------- will show all Staff Travel users from the data base 
	@Override
	public List<refisUsers> showRefisUser() {			
		   String sqlListRefis="SELECT * FROM link_user_master where internal_external_user='E'  order by gops_user_creation_date desc ,first_name";			
		   List  refisUsers = jdbcTemplateRefis.query(sqlListRefis,new refisUsersRowmapper());			   
		return refisUsers;
	}
	
	
	
	
	@Override
	public List<refisUsers> searchRefisUser(String name) {
		
		   String sqlListRefis="SELECT * FROM link_user_master where internal_external_user='E' and first_name like '%"+name+"%' order by  gops_user_creation_date desc ";
		   List  refisUsers = jdbcTemplateRefis.query(sqlListRefis,new refisUsersRowmapper());			   

		return refisUsers;
	}

	
	
	
	@Override	
	@Transactional(rollbackFor=Exception.class,propagation= Propagation.REQUIRES_NEW)
	public int removeRefisUser_FromDb(String emailid) {
		   int status=1;	
		   
		   try {			   
				
			   //jdbcTemplateRefis.execute("SET FOREIGN_KEY_CHECKS=0");	           
		       status = jdbcTemplateRefis.update("DELETE FROM  link_user_master WHERE internal_external_user='E' and email_id='"+emailid+"'");
		       status = jdbcTemplateRefis.update("DELETE FROM link_user_profile_list WHERE user_email='"+emailid+"'");
		       status = jdbcTemplateRefis.update("DELETE FROM Gops_Airline_Station_Access WHERE USER_NAME='"+emailid+"'");
			   //jdbcTemplateRefis.execute("SET FOREIGN_KEY_CHECKS=1");		   
		   }catch(Exception exp) { logger.error("Error While Removing Ground Handler User:"+exp);}
		
		   return status;
	
	}


	


	@Override
	public refisUsers viewGopsUserDetail(String username) {		
		   String viewsql="SELECT * FROM link_user_master where internal_external_user='E' and first_name=?";
		   //System.out.println(viewsql);
		   return jdbcTemplateRefis.queryForObject(viewsql, new Object[]{username}, new refisUsersRowmapper());	
	}


	


	@Override	
	@Transactional(rollbackFor=Exception.class,propagation= Propagation.REQUIRES_NEW)
	public int updateGopsUserDetail(HttpServletRequest req) {
		   
		   try {
				  
			   DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");
			   LocalDateTime currentdateandtime = LocalDateTime.now();		   
			   Connection conn= dataSourcesqlservercp.getConnection();	
			   String sqlinsert=null;
			   
			   
			   String passwordencripted= encdec.encrypt(req.getParameter("userpassword"));			   
	
			 
		
			   
			   
               //--- UPDATING link_user_master 			   
			   String SQL_UPDATE = "UPDATE link_user_master SET first_name=? ,  active_status=? , gh_password=? , gops_user_creation_date=?,description=? "
				   		+ " WHERE first_name=?";
				   PreparedStatement pstm = conn.prepareStatement(SQL_UPDATE);
					   pstm.setString(1,req.getParameter("userid"));
					   pstm.setString(2,req.getParameter("status"));
					   pstm.setString(3,passwordencripted);
					   pstm.setString(4,currentdateandtime.toString());
					   pstm.setString(5,req.getParameter("description"));		
					   pstm.setString(6,req.getParameter("userid").trim());	
				   int rows = pstm.executeUpdate();
				   pstm=null;   
				   
				   
				   
				   
				   
				//--- UPDATING Gops_Airline_Station_Access   AirLine Step 1(Remove All data) Step 2(Insert Station and Insert Airline)
				
				//-- Remove all AirLine && Station for this User   
				SQL_UPDATE="DELETE FROM Gops_Airline_Station_Access WHERE USER_NAME='"+req.getParameter("userid")+"'";   
				pstm = conn.prepareStatement(SQL_UPDATE);
				rows = pstm.executeUpdate();
				
				
				  if(req.getParameterValues("airline") != null) {
						
						//-- Inserting Airline Code   
						String[] selectedprofile = req.getParameterValues("airline");
					    List profilelist = Arrays.asList(selectedprofile);
					    
					    for(int i = 0; i < profilelist.size(); i++) {
						    sqlinsert = "INSERT INTO Gops_Airline_Station_Access (user_name,airline_code,station_code)  VALUES('"+req.getParameter("userid")+"','"+profilelist.get(i)+"','NA')";	
						    int statstatus=jdbcTemplateRefis.update(sqlinsert);	
						 }// End of For Loop --- 
						 
				}
			    
				  
					  
				  if(req.getParameterValues("station") != null) {		  
				    //-- Inserting Station Code  
					String[] selectedprofile = req.getParameterValues("station");
				    List profilelist = Arrays.asList(selectedprofile);
				    for(int i = 0; i < profilelist.size(); i++) {
				    	sqlinsert = "INSERT INTO Gops_Airline_Station_Access (user_name,station_code,airline_code)  VALUES('"+req.getParameter("userid")+"','"+profilelist.get(i)+"','NA')";	
					    int statstatus=jdbcTemplateRefis.update(sqlinsert);					  
					
					 }// End of For Loop --- 
			      }
				  

			    pstm = null;
			    conn.close();
				  
			   }catch(Exception ex) {logger.error("While Updating Ground OPS USER :"+ex.toString()); return 0;}	
				
		   
		   
		   return 1;	
		
	}


	
	
	
    // return status 0 -> error ,  1->success ,  2-> Duplicate entry 
	@Override	
	@Transactional(rollbackFor=Exception.class,propagation= Propagation.REQUIRES_NEW)
	public int addnewGopsUserDetail(HttpServletRequest req) {
		   try {
				  
			   DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");
			   LocalDateTime currentdateandtime = LocalDateTime.now();		   
			   Connection conn= dataSourcesqlservercp.getConnection();	
			   String sqlinsert=null;
			   PreparedStatement pstm =null;
			   
			   
			   
			   //--- Find the duplicate entry --
			   String sqlforname="select first_name  from link_user_master where first_name='"+req.getParameter("userid").trim()+"' and internal_external_user='E'";
			   SqlRowSet row1 =  jdbcTemplateRefis.queryForRowSet(sqlforname);
			   if(row1.next()) { return 2;}
			   
			   //-- Encrypting password --
			   String passwordencripted= encdec.encrypt(req.getParameter("userpassword"));
			   //System.out.println("EncriptedPass:"+passwordencripted);
			 
			   
			   
			   String SQL_UPDATE ="INSERT INTO link_user_master (first_name ,  email_id, active_status ,admin_status, internal_external_user ,gh_password ,description, gops_user_creation_date )  VALUES " + 
	          	   		"( ?,?,?,?,?,?,?,?)";
	           pstm = conn.prepareStatement(SQL_UPDATE);
				   pstm.setString(1,req.getParameter("userid"));
				   pstm.setString(2,req.getParameter("userid"));
				   pstm.setString(3,req.getParameter("status"));
				   pstm.setString(4,"N");
				   pstm.setString(5,"E");
				   pstm.setString(6,passwordencripted);
				   pstm.setString(7,req.getParameter("description"));
				   pstm.setString(8,currentdateandtime.toString());		
				   	
			       int rows = pstm.executeUpdate();
			       pstm=null;   
						   
				   
				   
				   
				//--- UPDATING Gops_Airline_Station_Access   AirLine Step 1(Remove All data) Step 2(Insert Station and Insert Airline)
				
				//-- Remove all AirLine && Station for this User   
				SQL_UPDATE="DELETE FROM Gops_Airline_Station_Access WHERE USER_NAME='"+req.getParameter("userid")+"'";   
				pstm = conn.prepareStatement(SQL_UPDATE);
				rows = pstm.executeUpdate();
				
				
				  if(req.getParameterValues("airline") != null) {
						
						//-- Inserting Airline Code   
						String[] selectedprofile = req.getParameterValues("airline");
					    List profilelist = Arrays.asList(selectedprofile);
					    
					    for(int i = 0; i < profilelist.size(); i++) {
						    sqlinsert = "INSERT INTO Gops_Airline_Station_Access (user_name,airline_code,station_code)  VALUES('"+req.getParameter("userid")+"','"+profilelist.get(i)+"','NA')";	
						    int statstatus=jdbcTemplateRefis.update(sqlinsert);	
						 }// End of For Loop --- 
						 
				}
			    
				  
					  
				  if(req.getParameterValues("station") != null) {		  
				    //-- Inserting Station Code  
					String[] selectedprofile = req.getParameterValues("station");
				    List profilelist = Arrays.asList(selectedprofile);
				    for(int i = 0; i < profilelist.size(); i++) {
				    	sqlinsert = "INSERT INTO Gops_Airline_Station_Access (user_name,station_code,airline_code)  VALUES('"+req.getParameter("userid")+"','"+profilelist.get(i)+"','NA')";	
					    int statstatus=jdbcTemplateRefis.update(sqlinsert);					  
					
					 }// End of For Loop --- 
			      }
				  

			    pstm = null;
			    conn.close();
				  
			   }catch(Exception ex) {logger.error("While Adding Ground OPS USER :"+ex.toString()); return 0;}	
				
		   
		   
		   return 1;	
	}
	
	
	
	
	



	@Override
	public String getAllStationList(String userid) {
		
		
		   //-- Pick the list of airport which is allready selected and built a string of that 
		   String sql="SELECT station_code  FROM Gops_Airline_Station_Access where user_name='"+userid+"'";
		   String selectedstation="";
		   SqlRowSet rowst =  jdbcTemplateRefis.queryForRowSet(sql);
		   while(rowst.next()) {
			   selectedstation=selectedstation+","+rowst.getString("station_code").trim();				
		   }//----------- END OF WHILE ---------- 
		   rowst =null;
		   
		
		   
		   boolean  isFound =false;
		   String stationlistwithcode = null;
		   
		   DateFormat dateFormat = new SimpleDateFormat("yyyy");
		   Date date = new Date();
		   String curent_year=dateFormat.format(date);		   
		   sql="select STN, NAME from PDCStobart.dbo.STATION where STN in(select distinct(DEPSTN) from pdcstobart.dbo.LEGS where DATOP like '"+curent_year+"%') order by STN";	       
		   
		   
		   
		   rowst =  jdbcTemplatePdc.queryForRowSet(sql);
		   while(rowst.next()) {
			   
			   isFound = selectedstation.toUpperCase().contains(rowst.getString("STN").toUpperCase());
			   if(isFound) {
			      stationlistwithcode=stationlistwithcode+"<option value="+rowst.getString("STN")+" selected>"+rowst.getString("STN").trim()+"&nbsp;&nbsp;-&nbsp;&nbsp;"+rowst.getString("NAME").trim()+"</option>";				
			   }
			   else
			   {
  		          stationlistwithcode=stationlistwithcode+"<option value="+rowst.getString("STN")+">"+rowst.getString("STN").trim()+"&nbsp;&nbsp;-&nbsp;&nbsp;"+rowst.getString("NAME").trim()+"</option>";				
				   
			   }
			   
		   }//----------- END OF WHILE ---------- 

		   rowst=null;		   
		   
		   return stationlistwithcode;
		
		
	}




	@Override
	public String getAllAirlineList(String userid) {
   
		   String sql   ="select icao_code , iata_code , airline_name , status from AirlineMaster  where status='Enable' and  icao_code in(select airline_code from Gops_Airline_Station_Access where user_name='"+userid+"')";
		   
		   String airlinelist = null;
		   
		   SqlRowSet rowst =  jdbcTemplateRefis.queryForRowSet(sql);
		   while(rowst.next()) {
			   airlinelist=airlinelist+"<option value="+rowst.getString("icao_code")+" selected>"+rowst.getString("iata_code").trim()+"&nbsp;&nbsp;-&nbsp;&nbsp;"+rowst.getString("airline_name").trim()+"</option>";				
		   }//----------- END OF WHILE ---------- 
		   rowst =null;
		   
		   sql   ="select icao_code , iata_code , airline_name , status from AirlineMaster  where status='Enable' and  icao_code not in(select airline_code from Gops_Airline_Station_Access where user_name='"+userid+"')";
		   rowst =  jdbcTemplateRefis.queryForRowSet(sql);
		   while(rowst.next()) {
			   airlinelist=airlinelist+"<option value="+rowst.getString("icao_code")+">"+rowst.getString("iata_code").trim()+"&nbsp;&nbsp;-&nbsp;&nbsp;"+rowst.getString("airline_name").trim()+"</option>";				
		   }//----------- END OF WHILE ---------- 

		   rowst=null;		   
		   
		   return airlinelist;

	}




	@Override
	public String getAllEligibleAirlineforGH(String useremail) {
		   
		   //-- For Ground Handler External Pull list of assigned Airline 
		   String sqlforoperationalairline="SELECT AirlineMaster.iata_code , AirlineMaster.airline_name  ,AirlineMaster.icao_code    \r\n" + 
			   		"  FROM  AirlineMaster , Gops_Airline_Station_Access \r\n" + 
			   		"  where Gops_Airline_Station_Access.airline_code=AirlineMaster.icao_code and  AirlineMaster.status='Enable'\r\n" + 
			   		"  and Gops_Airline_Station_Access.user_name='"+useremail+"'";

		   String eligibleairlinelist=null;
		   SqlRowSet rowst =  jdbcTemplateRefis.queryForRowSet(sqlforoperationalairline);
		   int counter=0;
		   while(rowst.next()) {			   				   
			   if(counter == 0) 
			   {eligibleairlinelist = "'"+rowst.getString("iata_code")+"'";}
			   else
			   {eligibleairlinelist = eligibleairlinelist +",'"+ rowst.getString("iata_code")+"'";}
			   counter++;
		   }	 

		return eligibleairlinelist;
	}



	
	

	@Override
	public String getAllEligibleAirportforGH(String useremail) {
		   //-- For Ground Handler External Pull list of assigned airport 
		   String eligibleairportlist=null;;
		   SqlRowSet rowst =  jdbcTemplateRefis.queryForRowSet("SELECT distinct station_code FROM Gops_Airline_Station_Access where user_name='"+useremail+"' and station_code != 'NA'");
		   int counter=0;
		   while(rowst.next()) {			   				   
			   if(counter == 0) 
			   {eligibleairportlist = "'"+rowst.getString("station_code")+"'";}
			   else
			   {eligibleairportlist = eligibleairportlist +",'"+ rowst.getString("station_code")+"'";}
			   counter++;
		   }		   

		return eligibleairportlist;
	}



}
