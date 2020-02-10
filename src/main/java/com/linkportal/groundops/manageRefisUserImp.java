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


@Transactional
@Repository
public class manageRefisUserImp implements manageRefisUser  {

	 
	@Autowired
	DataSource dataSourcesqlservercp;
	
	@Autowired
	DataSource dataSourcesqlserver;
	

	JdbcTemplate jdbcTemplateRefis;
	JdbcTemplate jdbcTemplatePdc;


		
		
		
	    manageRefisUserImp(DataSource dataSourcesqlservercp,DataSource dataSourcesqlserver) {			
	    	jdbcTemplateRefis = new JdbcTemplate(dataSourcesqlservercp);
	    	jdbcTemplatePdc = new JdbcTemplate(dataSourcesqlserver);
		}

	    
	    //---------- Logger Initializer------------------------------- 
	    private Logger logger = Logger.getLogger(manageRefisUserImp.class);

	
	 
	
	
	
	
	
	
    
	//---------- will show all Staff Travel users from the data base 
	@Override
	public List<refisUsers> showRefisUser() {			
		   String sqlListRefis="SELECT * FROM link_user_master where internal_external_user='E'  order by first_name";			
		   List  refisUsers = jdbcTemplateRefis.query(sqlListRefis,new refisUsersRowmapper());			   
		return refisUsers;
	}
	
	
	
	
	@Override
	public List<refisUsers> searchRefisUser(String name) {
		
		   String sqlListRefis="SELECT * FROM link_user_master where internal_external_user='E' and first_name like '%"+name+"%' order by first_name";
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
		  
		   
		   }catch(Exception exp) {
			   logger.error(exp);
			   System.out.println(exp.toString());   
		   
		   }
		
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
			   
               //--- UPDATING link_user_master 			   
			   String SQL_UPDATE = "UPDATE link_user_master SET first_name=? ,  active_status=? , gh_password=? , gops_user_creation_date=?,description=? "
				   		+ " WHERE first_name=?";
				   PreparedStatement pstm = conn.prepareStatement(SQL_UPDATE);
					   pstm.setString(1,req.getParameter("userid"));
					   pstm.setString(2,req.getParameter("status"));
					   pstm.setString(3,Base64.encodeBase64(req.getParameter("userpassword").getBytes()).toString());
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




	@Override
	public String getAllStationList(String userid) {
		 
		   DateFormat dateFormat = new SimpleDateFormat("yyyy");
		   Date date = new Date();
		   String curent_year=dateFormat.format(date);		   
		   String sql="select STN, NAME from PDCStobart.dbo.STATION where STN in(select distinct(DEPSTN) from pdcstobart.dbo.LEGS where DATOP like '"+curent_year+"%') order by STN";	       
		   
		   String stationlistwithcode = null;
		   
		   SqlRowSet rowst =  jdbcTemplatePdc.queryForRowSet(sql);
		   while(rowst.next()) {
				 stationlistwithcode=stationlistwithcode+"<option value="+rowst.getString("STN")+">"+rowst.getString("STN").trim()+"&nbsp;&nbsp;-&nbsp;&nbsp;"+rowst.getString("NAME").trim()+"</option>";				
		   }//----------- END OF WHILE ---------- 

		   rowst=null;		   
		   
		   return stationlistwithcode;
		
		
	}




	@Override
	public String getAllAirlineList(String userid) {
		// TODO Auto-generated method stub
		return null;
	}
	
	

}
