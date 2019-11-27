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
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.linkportal.datamodel.Users;
import com.linkportal.datamodel.UsersRowmapper;




@Repository
public class LinkUsersImp implements linkUsers{
       
	  @Autowired
	  DataSource dataSourcemysql;
	  
	  
	  JdbcTemplate jdbcTemplateMysql;	

	  

	  LinkUsersImp(DataSource dataSourcemysql){ 			
	
		    jdbcTemplateMysql = new JdbcTemplate(dataSourcemysql);
	  
	  }


	    //---------- Logger Initializer------------------------------- 
		private Logger logger = Logger.getLogger(LinkUsersImp.class);
	
	

	@Override
	public void updateUser_detail_LastLoginDateTime(String useremail) {
		
		   DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");
		   LocalDateTime now = LocalDateTime.now();
		   
	 		
		   String[] FirstName_LastName=useremail.split("[@._]"); 
		   String sql="SELECT * FROM CORPORATE_PORTAL.LINK_USER_MASTER where EMAIL_ID='"+useremail+"'";
		   try {
			    Connection conn = dataSourcemysql.getConnection();
	            PreparedStatement ps = conn.prepareStatement(sql);
	            ResultSet rs = ps.executeQuery();
	            if(rs.next()) {	            	
	            	//----------  This Part Will execute Only When User login to the site next time on----------------- 
	            	 ps.executeUpdate("UPDATE CORPORATE_PORTAL.LINK_USER_MASTER SET LAST_LOGIN_DATE_TIME='"+now+"' , LOGIN_COUNT='"+(rs.getInt("LOGIN_COUNT")+1)+"' WHERE EMAIL_ID='"+useremail+"'");
	            }
	            else
	            {
                     //----------  This Part Will execute Only When User Comes First Time -----------------   
	            	 sql="INSERT INTO CORPORATE_PORTAL.LINK_USER_MASTER (FIRST_NAME,LAST_NAME,EMAIL_ID,ADMIN_STATUS,LOGIN_COUNT,LAST_LOGIN_DATE_TIME,ACTIVE_STATUS,INTERNAL_EXTERNAL_USER) "
	            	 		+ "VALUES ('"+FirstName_LastName[0]+"', '"+FirstName_LastName[1]+"','"+useremail+"', 'N', '1','"+now+"','Active','I')";
	            	 ps.executeUpdate(sql);
	            	 
	            }
	            rs.close();
	            ps.close();	   
	            conn.close();
		   } catch(SQLException sq){throw new RuntimeException(sq);}
		
	}//---------- End of Function updateUser_detail_LastLoginDateTime



	
	
	
	

	@Override
	public Map getUser_Profile_List_From_DataBase(String useremail) {
		   
		   String profilesql= "SELECT LINK_PROFILE_MASTER.PROFILE_ID , MAIN_PROFILE, SUB_PROFILE ,USER_EMAIL,LINK_USER_PROFILE_LIST.ACTIVE_STATUS\r\n" + 
					   		  "FROM CORPORATE_PORTAL.LINK_PROFILE_MASTER, CORPORATE_PORTAL.LINK_USER_PROFILE_LIST\r\n" + 
					   		  "WHERE CORPORATE_PORTAL.LINK_PROFILE_MASTER.PROFILE_ID =  CORPORATE_PORTAL.LINK_USER_PROFILE_LIST.PROFILE_ID \r\n" + 
					   		  "AND  LINK_USER_PROFILE_LIST.USER_EMAIL='"+useremail+"' AND CORPORATE_PORTAL.LINK_USER_PROFILE_LIST.ACTIVE_STATUS='Y'";
	
		   //System.out.println(profilesql);
		   
		   //---------- THIS PART WILL COLLECT ALL USER PROFILE INTO A MAP WITH THE KEY AND VALUE----------
	       Map<String, String> map = new HashMap<String, String>();
		   
		   try {
			    
			    Connection conn = dataSourcemysql.getConnection();
	            PreparedStatement ps = conn.prepareStatement(profilesql);
	            ResultSet rs = ps.executeQuery();
	            
	            while(rs.next()){
	            	
	            	if(rs.getString("MAIN_PROFILE").equals("Reports")) {map.put("Reports","Y");} 
	            	if(rs.getString("SUB_PROFILE").equals("Flight_Report")) {map.put("Flight_Report", rs.getString("ACTIVE_STATUS"));} 
	            	if(rs.getString("SUB_PROFILE").equals("Reliablity")) {map.put("Reliablity", rs.getString("ACTIVE_STATUS"));}
	            	if(rs.getString("SUB_PROFILE").equals("ReliablityAction")) {map.put("ReliablityAction", rs.getString("ACTIVE_STATUS"));}
	            	if(rs.getString("SUB_PROFILE").equals("Daily_Summary")) {map.put("Daily_Summary", rs.getString("ACTIVE_STATUS"));}
	            	if(rs.getString("SUB_PROFILE").equals("Flybe_Today")) {map.put("Flybe_Today", rs.getString("ACTIVE_STATUS"));}
	            	if(rs.getString("SUB_PROFILE").equals("Voyager")) {map.put("Voyager", rs.getString("ACTIVE_STATUS"));}
	            	if(rs.getString("SUB_PROFILE").equals("Cascade")) {map.put("Cascade", rs.getString("ACTIVE_STATUS"));}
	            	if(rs.getString("SUB_PROFILE").equals("StaffTravel")) {map.put("StaffTravel", rs.getString("ACTIVE_STATUS"));}
  
	            }// ----------- END OF DO WHILE ------------ 
	       
	            
	            
	            //--------- THIS PART WILL DECIDE WETHER USER IS ADMIN USER OR NOT -----------------
	            PreparedStatement ps1 = conn.prepareStatement("select ADMIN_STATUS FROM CORPORATE_PORTAL.LINK_USER_MASTER WHERE EMAIL_ID='"+useremail+"'");
	            ResultSet rs1 = ps1.executeQuery();	            
	            while(rs1.next()){
	            
	            	if(rs1.getString("ADMIN_STATUS").equals("Y")) {map.put("ADMIN","Y");}
	            
	            }
	            rs.close();
	            ps.close();	
	            rs1.close();
	            ps1.close();
	            conn.close();
			   } catch(SQLException sq){throw new RuntimeException(sq);}
		   
		return map;
	}










	@Override //-------- Display FULL LIST OF LINK USER FROM  DATABASE / BASED ON SEARCH QUERY   
	public List<Users> getLinkUserListFromDatabase(String usersname) {   
		
		String sqlstr="";
		
		
		 
		   if(usersname == null) {
			   
			   sqlstr="SELECT * FROM CORPORATE_PORTAL.LINK_USER_MASTER  order by FIRST_NAME";
			   
		   }
		   else
		   {

				sqlstr="SELECT * FROM CORPORATE_PORTAL.LINK_USER_MASTER where FIRST_NAME like '"+usersname.trim()+"%'  or  LAST_NAME like '"+usersname.trim()+"%' order by FIRST_NAME";
				
		   }
		   
		   List  linkusers = jdbcTemplateMysql.query(sqlstr,new UsersRowmapper());
	
		   return linkusers;
		
	}




	@Override //-------- DISPLAY INDIVISUAL USER DETAIL AFTER SELECTION OF USER   
	public Users getLinkUserDetails(String emailid) {	
		String sql = "SELECT * FROM CORPORATE_PORTAL.LINK_USER_MASTER where EMAIL_ID = ?";
		Users linkusersdetail =  jdbcTemplateMysql.queryForObject(sql, new Object[]{emailid}, new UsersRowmapper());
		return linkusersdetail;
		
	
	}



	@Override //-------- DISPLAY INDIVISUAL USER PROFILE AND  ALL LINKPROFILE     
	public  String[] getUserpProfileAndLinkProfile(String emailid) {	
		
		   String sqlforuserprofile="SELECT LINK_USER_PROFILE_LIST.PROFILE_ID , MAIN_PROFILE, SUB_PROFILE ,USER_EMAIL,LINK_USER_PROFILE_LIST.ACTIVE_STATUS\r\n" + 
			   		"FROM CORPORATE_PORTAL.LINK_PROFILE_MASTER, CORPORATE_PORTAL.LINK_USER_PROFILE_LIST\r\n" + 
			   		"WHERE CORPORATE_PORTAL.LINK_PROFILE_MASTER.PROFILE_ID =  CORPORATE_PORTAL.LINK_USER_PROFILE_LIST.PROFILE_ID \r\n" + 
			   		"AND  LINK_USER_PROFILE_LIST.USER_EMAIL='"+emailid+"' AND CORPORATE_PORTAL.LINK_USER_PROFILE_LIST.ACTIVE_STATUS='Y' order by LINK_PROFILE_MASTER.MAIN_PROFILE, LINK_PROFILE_MASTER.SUB_PROFILE";
				
	
		   
		   String sqlforlinkprofile="SELECT * FROM CORPORATE_PORTAL.LINK_PROFILE_MASTER order by MAIN_PROFILE,SUB_PROFILE";
			 
		   
		   
		   String stringuserprofile="";
		   String stringAllLinkProfile="";
		   
		   
		   try {
				
				    Connection conn = dataSourcemysql.getConnection();				
					PreparedStatement ps = conn.prepareStatement(sqlforuserprofile);
		            ResultSet rs = ps.executeQuery();
		         
		            while(rs.next()){
		            	stringuserprofile=stringuserprofile+"<tr> <td width='85%' align='left'>&nbsp;&nbsp;"+rs.getString("SUB_PROFILE")+"</td> <td width='15%' align='left'>"
		            			+ " <input type='checkbox'  id='userprofile' name='userprofile' Value='"+rs.getString("PROFILE_ID")+"'>  </td></tr>";	            	
	                }//------- End Of While Loop
		            
		            
		            ps=null;
		            rs=null;
		            ps = conn.prepareStatement(sqlforlinkprofile);
		            rs = ps.executeQuery();
		            
		            while(rs.next()){
		            	stringAllLinkProfile=stringAllLinkProfile+"<tr> <td width='85%' align='left'>&nbsp;&nbsp;"+rs.getString("MAIN_PROFILE")+"&nbsp;&nbsp;&nbsp;:=>&nbsp;"+rs.getString("SUB_PROFILE")+"</td> <td width='15%' align='left'>"
		            			+ " <input type='checkbox'  id='linkprofile' name='linkprofile' Value='"+rs.getString("PROFILE_ID")+"'>  </td></tr>";	            	
	                }//------- End Of While Loop
	
				
			}catch (SQLException e) {System.out.println(e.toString());logger.error(e.toString());}
			
		   String[] result = new String[2];
		   result[0]=stringuserprofile;
		   result[1]=stringAllLinkProfile;
		   
						
		  return result;
		
	
	}//---- END OF Function ---------

	
	
	
	
	
	
	
	
	



	
	@Override // THIS FUNCTION WILL UPDATE USER ACTIVE STATUS AND ADMIN STATUS 	
	public void UpdateUserpProfileAndActiveStatustoDataBase(String emailid,String activestatus,String adminstatus) {		
		   int status=jdbcTemplateMysql.update("UPDATE CORPORATE_PORTAL.LINK_USER_MASTER SET ACTIVE_STATUS='"+activestatus+"' , ADMIN_STATUS='"+adminstatus+"' WHERE CORPORATE_PORTAL.LINK_USER_MASTER.EMAIL_ID='"+emailid+"'");
	}
	
	
	

	@Override  //  THIS FUNCTION WILL ADD NEW PROFILE TO THE USER AFTER CHECKING IN THE DATABASE IF EXIST SKIP IF NOT THEN ADD
	public void UpdateLinkProfiletoDataBase(String emailid,String activestatus,String adminstatus, List linkallprof){
	
		   
		   try{
			
			   for(int i = 0; i < linkallprof.size(); i++) {
					  String sql = "SELECT COUNT(*) FROM CORPORATE_PORTAL.LINK_USER_PROFILE_LIST WHERE PROFILE_ID="+linkallprof.get(i)+" AND USER_EMAIL='"+emailid+"'";	
				
					  long foundstatus = jdbcTemplateMysql.queryForObject(sql,Long.class);
					   if(foundstatus == 0) {				   
						   int statstatus=jdbcTemplateMysql.update("INSERT INTO CORPORATE_PORTAL.LINK_USER_PROFILE_LIST (USER_EMAIL, PROFILE_ID,ACTIVE_STATUS) VALUES ('"+emailid+"',"+linkallprof.get(i)+",'Y')");					  
						    
					   } // End of if--  	   			
							
						   
				 }// End of For Loop --- 

		   }catch(Exception updateerror) {logger.error("While Updating  User Profile:"+updateerror.toString());}

		
		
	}//-------- END OF FUNCTION ------------------


	



	@Override
	public void RemoveUserpProfileAndLinkProfiletoDataBase(String emailid,List Userprofile){
	
		   
		   try{
			   
			   for(int j = 0; j < Userprofile.size(); j++) {
				   
				   String sql = "DELETE  FROM CORPORATE_PORTAL.LINK_USER_PROFILE_LIST WHERE PROFILE_ID="+Userprofile.get(j)+" AND USER_EMAIL='"+emailid+"'";	
				   int stats=jdbcTemplateMysql.update(sql);					  
				   //System.out.println(sql);	
			   
			   }//----- End Of For Loop.
			   
			   
		  
		  }catch(Exception updateerror) {
			  System.out.println(updateerror.toString());
			  logger.error("While Updating  User Profile:"+updateerror.toString());
		  }

		
		
	}//-------- END OF FUNCTION ------------------









	
	
	
	
	
	
	
}//------------ End of Class LinkUsersImp 
