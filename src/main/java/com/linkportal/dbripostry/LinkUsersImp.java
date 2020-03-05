package com.linkportal.dbripostry;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.sql.DataSource;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.ResultSetExtractor;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.support.rowset.SqlRowSet;
import org.springframework.stereotype.Repository;

import com.linkportal.datamodel.Users;
import com.linkportal.datamodel.UsersRowmapper;
import com.linkportal.security.EncryptDecrypt;




@Repository
public class LinkUsersImp implements linkUsers{
       
	
	  @Autowired  
	  EncryptDecrypt encdec;
	  
	  @Autowired
	  DataSource dataSourcesqlservercp;
	  
	  
	  JdbcTemplate jdbcTemplatSqlserver;	

	  

	  LinkUsersImp(DataSource dataSourcesqlservercp){
	
		    jdbcTemplatSqlserver = new JdbcTemplate(dataSourcesqlservercp);   // <<-- New SQLSERVER 
	  
	  }


	    //---------- Logger Initializer------------------------------- 
		private Logger logger = Logger.getLogger(LinkUsersImp.class);
	
	

	@Override
	public void updateUser_detail_LastLoginDateTime(String useremail) {
		
		   DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");
		   LocalDateTime now = LocalDateTime.now();
		 
		   String[] FirstName_LastName=useremail.split("[@._]"); 
		   String sql="SELECT login_count FROM  link_user_master where email_id='"+useremail+"' or first_name='"+useremail+"'";		   
		   SqlRowSet logincount = jdbcTemplatSqlserver.queryForRowSet(sql);
		   
		   if(logincount.next()) {
			  jdbcTemplatSqlserver.execute("UPDATE LINK_USER_MASTER SET LAST_LOGIN_DATE_TIME='"+now+"' , LOGIN_COUNT='"+(logincount.getInt(1)+1)+"' WHERE EMAIL_ID='"+useremail+"' or first_name='"+useremail+"'");
			   
		   }
		   else
		   {
          	   sql="INSERT INTO LINK_USER_MASTER (FIRST_NAME,LAST_NAME,EMAIL_ID,ADMIN_STATUS,LOGIN_COUNT,LAST_LOGIN_DATE_TIME,ACTIVE_STATUS,INTERNAL_EXTERNAL_USER,gops_user_creation_date,created_by) "
         	 		+ "VALUES ('"+FirstName_LastName[0]+"', '"+FirstName_LastName[1]+"','"+useremail+"', 'N', '1','"+now+"','Active','I','"+now+"','LDAP')";
          	    jdbcTemplatSqlserver.execute(sql);
		   }
		   

		
	}//---------- End of Function updateUser_detail_LastLoginDateTime



	
	
	
	

	@Override
	public Map getUser_Profile_List_From_DataBase(String useremail) {
		   
		   String profilesql= "SELECT    LINK_USER_MASTER.ADMIN_STATUS, LINK_PROFILE_MASTER.PROFILE_ID , LINK_PROFILE_MASTER.MAIN_PROFILE, LINK_PROFILE_MASTER.SUB_PROFILE ,USER_EMAIL,LINK_USER_PROFILE_LIST.ACTIVE_STATUS\r\n" + 
					   		  "FROM  LINK_PROFILE_MASTER,  LINK_USER_PROFILE_LIST ,  LINK_USER_MASTER\r\n" + 
					   		  "WHERE  LINK_PROFILE_MASTER.PROFILE_ID =   LINK_USER_PROFILE_LIST.PROFILE_ID "
					   		  + "and  LINK_USER_MASTER.EMAIL_ID= LINK_USER_PROFILE_LIST.USER_EMAIL  \r\n" + 
					   		  "AND  LINK_USER_PROFILE_LIST.USER_EMAIL='"+useremail+"' AND  LINK_USER_PROFILE_LIST.ACTIVE_STATUS='Y'  order by LINK_PROFILE_MASTER.MAIN_PROFILE";
	
		   //System.out.println(profilesql);
		   
		   //---------- THIS PART WILL COLLECT ALL USER PROFILE INTO A MAP WITH THE KEY AND VALUE----------
	       Map<String, String> profileMap = new HashMap<String, String>();
	       
	    
	    

	    	    
	       profileMap = jdbcTemplatSqlserver.query(profilesql, new ResultSetExtractor<Map>(){
	    	   
	    	        @Override
	    	        public Map extractData(ResultSet rs) {
	    	        	
	    	      
	    	            HashMap<String,String> mapRet= new HashMap<String,String>();
	    	            try {
							while(rs.next()){
							    
								if(rs.getString("MAIN_PROFILE").equals("Reports")) {mapRet.put("Reports","Y");} 
							 	if(rs.getString("SUB_PROFILE").equals("Flight_Report")) {mapRet.put("Flight_Report", rs.getString("ACTIVE_STATUS"));} 
								if(rs.getString("SUB_PROFILE").equals("Reliablity")) {mapRet.put("Reliablity", rs.getString("ACTIVE_STATUS"));}
								if(rs.getString("SUB_PROFILE").equals("DelayReport")) {mapRet.put("DelayReport", rs.getString("ACTIVE_STATUS"));}
								if(rs.getString("SUB_PROFILE").equals("OtpReport")) {mapRet.put("OtpReport", rs.getString("ACTIVE_STATUS"));}

								
								if(rs.getString("SUB_PROFILE").equals("Daily_Summary")) {mapRet.put("Daily_Summary", rs.getString("ACTIVE_STATUS"));}
								if(rs.getString("SUB_PROFILE").equals("Flybe_Today")) {mapRet.put("Flybe_Today", rs.getString("ACTIVE_STATUS"));}
								if(rs.getString("SUB_PROFILE").equals("Voyager")) {mapRet.put("Voyager", rs.getString("ACTIVE_STATUS"));}
								if(rs.getString("SUB_PROFILE").equals("GCIGCMGCR")) {mapRet.put("GCIGCMGCR", rs.getString("ACTIVE_STATUS"));}
								if(rs.getString("SUB_PROFILE").equals("Manuals")) {mapRet.put("Manuals", rs.getString("ACTIVE_STATUS"));}
								if(rs.getString("SUB_PROFILE").equals("safetycompliance")) {mapRet.put("safetycompliance", rs.getString("ACTIVE_STATUS"));}
								if(rs.getString("SUB_PROFILE").equals("traning")) {mapRet.put("traning", rs.getString("ACTIVE_STATUS"));}
								if(rs.getString("SUB_PROFILE").equals("weightstatement")) {mapRet.put("weightstatement", rs.getString("ACTIVE_STATUS"));}
								if(rs.getString("SUB_PROFILE").equals("documentation")) {mapRet.put("documentation", rs.getString("ACTIVE_STATUS"));}
								if(rs.getString("SUB_PROFILE").equals("forms")) {mapRet.put("forms", rs.getString("ACTIVE_STATUS"));}
								
								if(rs.getString("SUB_PROFILE").equals("gopsadmin")) {mapRet.put("gopsadmin", rs.getString("ACTIVE_STATUS"));}
								if(rs.getString("SUB_PROFILE").equals("ManageUsers")) {mapRet.put("ManageUsers", rs.getString("ACTIVE_STATUS"));}
								if(rs.getString("SUB_PROFILE").equals("ManageSmscontact")) {mapRet.put("ManageSmscontact", rs.getString("ACTIVE_STATUS"));}
								if(rs.getString("SUB_PROFILE").equals("AirlineDataManager")) {mapRet.put("AirlineDataManager", rs.getString("ACTIVE_STATUS"));}
								if(rs.getString("SUB_PROFILE").equals("CrewBrifingManager")) {mapRet.put("CrewBrifingManager", rs.getString("ACTIVE_STATUS"));}
							
								
								
								
								if(rs.getString("SUB_PROFILE").equals("Cascade")) {mapRet.put("Cascade", rs.getString("ACTIVE_STATUS"));}
								if(rs.getString("SUB_PROFILE").equals("StaffTravel")) {mapRet.put("StaffTravel", rs.getString("ACTIVE_STATUS"));}
								if(rs.getString("SUB_PROFILE").equals("Contract")) {mapRet.put("Contract", rs.getString("ACTIVE_STATUS"));}
								if(rs.getString("SUB_PROFILE").equals("Refis")) {mapRet.put("Refis", rs.getString("ACTIVE_STATUS"));}
								if(rs.getString("ADMIN_STATUS").equals("Y")) {mapRet.put("admin","Y");}	 
								if(rs.getString("SUB_PROFILE").equals("docmanager")) {mapRet.put("docmanager", rs.getString("ACTIVE_STATUS"));}
								
							    
							    
							}//------ End of While 
							
							
						} catch (SQLException sqlex) {logger.error("Reported from the Profile Generation:"+sqlex.toString());}
	    	     
					
	    	        return mapRet;
	    	            
	    	        }
	    	    });	    
	       
	       
		   
		   
		return profileMap;
	}










	@Override //-------- Display FULL LIST OF LINK USER FROM  DATABASE / BASED ON SEARCH QUERY   
	public List<Users> getLinkUserListFromDatabase(String usersname) {   
		
		String sqlstr="";
		
		
		 
		   if(usersname == null) {
			   
			   sqlstr="SELECT * FROM  LINK_USER_MASTER  order by FIRST_NAME";
			   
		   }
		   else
		   {

				sqlstr="SELECT * FROM  LINK_USER_MASTER where FIRST_NAME like '"+usersname.trim()+"%'  or  LAST_NAME like '"+usersname.trim()+"%' order by FIRST_NAME";
				
		   }
		   
		   List  linkusers = jdbcTemplatSqlserver.query(sqlstr,new UsersRowmapper());
	
		   return linkusers;
		
	}




	@Override //-------- DISPLAY INDIVISUAL USER DETAIL AFTER SELECTION OF USER   
	public Users getLinkUserDetails(String emailid) {	
		String sql = "SELECT * FROM  LINK_USER_MASTER where EMAIL_ID = ?";
		Users linkusersdetail =  jdbcTemplatSqlserver.queryForObject(sql, new Object[]{emailid}, new UsersRowmapper());
		return linkusersdetail;
		
	
	}



	@Override //-------- DISPLAY INDIVISUAL USER PROFILE AND  ALL LINKPROFILE     
	public  String[] getUserpProfileAndLinkProfile(String emailid) {	
		
		   String sqlforuserprofile="SELECT LINK_USER_PROFILE_LIST.PROFILE_ID , MAIN_PROFILE, SUB_PROFILE ,USER_EMAIL,LINK_USER_PROFILE_LIST.ACTIVE_STATUS\r\n" + 
			   		"FROM  LINK_PROFILE_MASTER,  LINK_USER_PROFILE_LIST\r\n" + 
			   		"WHERE  LINK_PROFILE_MASTER.PROFILE_ID =   LINK_USER_PROFILE_LIST.PROFILE_ID \r\n" + 
			   		"AND LINK_PROFILE_MASTER.application='link'  AND LINK_USER_PROFILE_LIST.USER_EMAIL='"+emailid+"' AND  LINK_USER_PROFILE_LIST.ACTIVE_STATUS='Y' order by LINK_PROFILE_MASTER.MAIN_PROFILE, LINK_PROFILE_MASTER.SUB_PROFILE";
				
	
		   
		   String sqlforlinkprofile="SELECT * FROM  LINK_PROFILE_MASTER where application='link' order by MAIN_PROFILE,SUB_PROFILE";
			 
		   
		   
		   String stringuserprofile="";
		   String stringAllLinkProfile="";
		   
		   
		   try {
				
				    Connection conn = dataSourcesqlservercp.getConnection();				
					PreparedStatement ps = conn.prepareStatement(sqlforuserprofile);
		            ResultSet rs = ps.executeQuery();
		         
		            while(rs.next()){
		            	stringuserprofile=stringuserprofile+"<tr> <td width='85%' align='left'>&nbsp;&nbsp;"+rs.getString("SUB_PROFILE")+"</td> <td width='15%' align='center'>"
		            			+ " <input type='checkbox'  id='userprofile' name='userprofile' Value='"+rs.getString("PROFILE_ID")+"'>  </td></tr>";	            	
	                }//------- End Of While Loop
		            
		            
		            ps=null;
		            rs=null;
		            ps = conn.prepareStatement(sqlforlinkprofile);
		            rs = ps.executeQuery();
		            
		            while(rs.next()){
		            	stringAllLinkProfile=stringAllLinkProfile+"<tr> <td width='85%' align='left'>&nbsp;&nbsp;"+rs.getString("MAIN_PROFILE")+"&nbsp;&nbsp;&nbsp;:=>&nbsp;"+rs.getString("SUB_PROFILE")+"</td> <td width='15%' align='center'>"
		            			+ " <input type='checkbox'  id='linkprofile' name='linkprofile' Value='"+rs.getString("PROFILE_ID")+"'>  </td></tr>";	            	
	                }//------- End Of While Loop
		            conn.close();
				
			}catch (SQLException e) {logger.error("Error in GetUserpProfileAndLinkProfile Fucntion :"+e.toString());}
			
		   String[] result = new String[2];
		   result[0]=stringuserprofile;
		   result[1]=stringAllLinkProfile;
		   
						
		  return result;
		
	
	}//---- END OF Function ---------

	
	
	
	
	
	
	
	
	



	
	@Override // THIS FUNCTION WILL UPDATE USER ACTIVE STATUS AND ADMIN STATUS 	
	public void UpdateUserpProfileAndActiveStatustoDataBase(String emailid,String activestatus,String adminstatus) {		
		   int status=jdbcTemplatSqlserver.update("UPDATE  LINK_USER_MASTER SET ACTIVE_STATUS='"+activestatus+"' , ADMIN_STATUS='"+adminstatus+"' WHERE  LINK_USER_MASTER.EMAIL_ID='"+emailid+"'");
	}
	
	
	

	@Override  //  THIS FUNCTION WILL ADD NEW PROFILE TO THE USER AFTER CHECKING IN THE DATABASE IF EXIST SKIP IF NOT THEN ADD
	public void UpdateLinkProfiletoDataBase(String emailid,String activestatus,String adminstatus, List linkallprof){
	
		   
		   try{
			
			   for(int i = 0; i < linkallprof.size(); i++) {
					  String sql = "SELECT COUNT(*) FROM  LINK_USER_PROFILE_LIST WHERE PROFILE_ID="+linkallprof.get(i)+" AND USER_EMAIL='"+emailid+"'";	
				
					  long foundstatus = jdbcTemplatSqlserver.queryForObject(sql,Long.class);
					   if(foundstatus == 0) {				   
						   int statstatus=jdbcTemplatSqlserver.update("INSERT INTO  LINK_USER_PROFILE_LIST (USER_EMAIL, PROFILE_ID,ACTIVE_STATUS) VALUES ('"+emailid+"',"+linkallprof.get(i)+",'Y')");					  
						    
					   } // End of if--  	   			
							
						   
				 }// End of For Loop --- 

		   }catch(Exception updateerror) {logger.error("While Updating  User Profile:"+updateerror.toString());}

		
		
	}//-------- END OF FUNCTION ------------------


	



	@Override
	public void RemoveUserpProfileAndLinkProfiletoDataBase(String emailid,List Userprofile){
	
		   
		   try{
			   
			   for(int j = 0; j < Userprofile.size(); j++) {
				   
				   String sql = "DELETE  FROM  LINK_USER_PROFILE_LIST WHERE PROFILE_ID="+Userprofile.get(j)+" AND USER_EMAIL='"+emailid+"'";	
				   int stats=jdbcTemplatSqlserver.update(sql);		
			   
			   }//----- End Of For Loop.
			   
			   
		  
		  }catch(Exception updateerror) {
			 
			  logger.error("Error while Updating  User Profile:"+updateerror.toString());
		  }

		
		
	}//-------- END OF FUNCTION ------------------








	@Override
	public boolean Validate_External_User(String username, String ghpassword) {		 
		  try {
			  
		  String sqlForUser = "SELECT gh_password FROM  LINK_USER_MASTER where FIRST_NAME=?"; 		  
		  String password   = (String) jdbcTemplatSqlserver.queryForObject(sqlForUser, new Object[] { username }, String.class);			  
		  String decrypted  = encdec.decrypt(password);
		  if(decrypted.equals(ghpassword)) {return true;} else {return false;}
		  
		  }catch(Exception dbex) {					  
			  logger.error("Ground Handler User Id:"+username+" is Not Validated:"+dbex.toString());
			  return false;
		  }
		
	}







    ////////  GET ALL GROUND OPS PROFILE AND GROUND OPS USER PROFILE 
	@Override
	public String[] getUserpProfileandAllgroundopsProfile(String emailid) {
		   String sqlforuserprofile="SELECT LINK_USER_PROFILE_LIST.PROFILE_ID , MAIN_PROFILE, SUB_PROFILE ,USER_EMAIL,LINK_USER_PROFILE_LIST.ACTIVE_STATUS\r\n" + 
			   		"FROM  LINK_PROFILE_MASTER,  LINK_USER_PROFILE_LIST\r\n" + 
			   		"WHERE  LINK_PROFILE_MASTER.PROFILE_ID =   LINK_USER_PROFILE_LIST.PROFILE_ID \r\n" + 
			   		"AND  LINK_USER_PROFILE_LIST.USER_EMAIL='"+emailid+"'  AND  LINK_USER_PROFILE_LIST.ACTIVE_STATUS='Y' and LINK_PROFILE_MASTER.application='gops' order by LINK_PROFILE_MASTER.MAIN_PROFILE, LINK_PROFILE_MASTER.SUB_PROFILE";
				
	
		
		   
		   String sqlforlinkprofile="SELECT * FROM  LINK_PROFILE_MASTER where  application='gops' order by MAIN_PROFILE,SUB_PROFILE";
			 
		   
		   
		   String stringuserprofile    ="";
		   String stringAllGopsProfile ="";
		   
		   
		   try {
				
				    Connection conn = dataSourcesqlservercp.getConnection();				
					PreparedStatement ps = conn.prepareStatement(sqlforuserprofile);
		            ResultSet rs = ps.executeQuery();
		         
		            while(rs.next()){
		            	stringuserprofile=stringuserprofile+"<tr> <td width='85%' align='left'>&nbsp;&nbsp;<b>"+rs.getString("MAIN_PROFILE")+"&nbsp;&nbsp;&nbsp;:=>&nbsp;"+rs.getString("SUB_PROFILE")+"</b></td> "
		            			+ "<td width='15%' align='center'> <input type='checkbox'  id='userprofile' name='userprofile' Value='"+rs.getString("PROFILE_ID")+"'>  </td></tr>";	            	
	      		            
		            }//------- End Of While Loop
		            
		            
		            ps=null;
		            rs=null;
		            ps = conn.prepareStatement(sqlforlinkprofile);
		            rs = ps.executeQuery();
		            
		            while(rs.next()){
		            	stringAllGopsProfile=stringAllGopsProfile+"<tr> <td width='85%' align='left'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>"+rs.getString("MAIN_PROFILE")+"&nbsp;&nbsp;&nbsp;:=>&nbsp;"+rs.getString("SUB_PROFILE")+"</b></td> "
		            			+ " <td width='15%' align='center'><input type='checkbox'  id='gopsprofile' name='gopsprofile' Value='"+rs.getString("PROFILE_ID")+"'> </td></tr>";	            	
	                }//------- End Of While Loop
		            conn.close();
				
			}catch (SQLException e) {logger.error("Error in GetUserpProfileAndLinkProfile Fucntion :"+e.toString());}
			
		   String[] result = new String[2];
		   result[0]=stringuserprofile;
		   result[1]=stringAllGopsProfile;
		 
						
		  return result;
		
	  }








    ////////  UPDATE GROUND OPS USER PROFILE TO THE DATABASE 
	@Override
	public void UpdateGopsProfiletoDataBase(String emailid, List linkallprof) {
		   
		   try{
			
			   for(int i = 0; i < linkallprof.size(); i++) {
					  String sql = "SELECT COUNT(*) FROM  LINK_USER_PROFILE_LIST WHERE PROFILE_ID="+linkallprof.get(i)+" AND USER_EMAIL='"+emailid+"'";	
					  //System.out.println(sql); 
					  
					  long foundstatus = jdbcTemplatSqlserver.queryForObject(sql,Long.class);
					   if(foundstatus == 0) {				   
						   int statstatus=jdbcTemplatSqlserver.update("INSERT INTO  LINK_USER_PROFILE_LIST (USER_EMAIL, PROFILE_ID,ACTIVE_STATUS) VALUES ('"+emailid+"',"+linkallprof.get(i)+",'Y')");					  
						   //System.out.println("Added to database "+linkallprof.get(i));  
					   } // End of if--  	   			
							
						   
				 }// End of For Loop --- 

		   }catch(Exception updateerror) {logger.error("While Updating Ground Ops User Profile:"+updateerror.toString());}

	
		
	}

















	
	
	
	
	
	
	
}//------------ End of Class LinkUsersImp 
