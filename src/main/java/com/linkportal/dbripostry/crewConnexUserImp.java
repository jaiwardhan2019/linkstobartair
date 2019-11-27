package com.linkportal.dbripostry;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

//https://examples.javacodegeeks.com/enterprise-java/spring/jdbc/spring-jdbctemplate-example/
//https://www.mkyong.com/spring/spring-jdbctemplate-querying-examples/

@Repository
public class crewConnexUserImp implements crewConnexUser{

	
	public String userinitial,userpassword;
	
  	@Autowired
	DataSource dataSourcesqlserver;
	

	
	
	@Override
	public String getCrewUserInitialPassword(String emailid) {		   
		 		
		   String[] FirstName_LastName=emailid.split("[@._]"); 
		   String sql ="select Initials,WebPassword  from CrewMember where  Namefirst like UPPER('"+FirstName_LastName[0]+"%')  and Namelast like UPPER('%"+FirstName_LastName[1]+"')";
			   
		   try {
			   
			    Connection conn = dataSourcesqlserver.getConnection();
	            PreparedStatement ps = conn.prepareStatement(sql);
	            ResultSet rs = ps.executeQuery();
	            if (rs.next()) {
	            	userinitial  = rs.getString("Initials").trim();
	            	userpassword = rs.getString("WebPassword").trim();
	               
	            }
	            else
	            {
	            	userinitial="NA";
	            	userpassword="NA";
	            }
	            conn.close();
	            rs.close();
	            ps.close();
	            
		   } catch(SQLException sq){throw new RuntimeException(sq);}
		   
		   return userinitial;
		
	}// End of  Function 
	
	
	
	
	public String getCrewUserInitial() {		
		 return userinitial;
	}
	
	
	public String getCrewUserWebpasswor() {
	   return userpassword;	
	}
	

}//--------------- End Of Main Class ----------------------
