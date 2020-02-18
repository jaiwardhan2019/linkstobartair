package com.linkportal.dbripostry;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import javax.sql.DataSource;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;




@Repository
public class businessAreaContentImp implements businessAreaContent {
	
	    //---------- Logger Initializer------------------------------- 
		private Logger logger = Logger.getLogger(businessAreaContentImp.class);
	
	    DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");
	    LocalDateTime now = LocalDateTime.now();
	   
	
    @Autowired
    DataSource dataSourcesqlservercp;
    
	
	JdbcTemplate jdbcTemplate;
	
	
	public businessAreaContentImp(DataSource dataSourcesqlservercp) {
		this.jdbcTemplate = new JdbcTemplate(dataSourcesqlservercp);
	}

	
	
	

	@Override
	public String Show_Content(int bcid){	
		
		try{
		
		    String sql = "SELECT CONTENT_DETAIL FROM  Business_Area_Content_Master where Bc_Id=?";	  
		    String content = jdbcTemplate.queryForObject(sql, new Object[] { bcid }, String.class);
		    return content;
			    
		 } catch(Exception ee) {
			logger.error("While Reading Content Master DB:"+ee); 
			
			return null;
		}
		
		
	}//--------- End Of Function -----------
	

	

	@Override
	public boolean Update_Content(String content, int bcid, String emailid) {
		try{
			 
			 Connection conn= dataSourcesqlservercp.getConnection();	
			
			 String sqlUpdateContent = "UPDATE Business_Area_Content_Master SET Content_Detail=?, Updated_Date_Time=?, User_Email=?  WHERE Bc_Id=?";
		     PreparedStatement pstm = conn.prepareStatement(sqlUpdateContent);
					   pstm.setString(1,content);
					   pstm.setString(2,now.toString());
					   pstm.setString(3,emailid);
					   pstm.setInt(4,bcid);
				   int rows = pstm.executeUpdate();
				   pstm=null;   
				
			return (rows > 0);
		
	  }catch(SQLException updateerror) {System.out.println(updateerror);  logger.error("While Updating  Content Master:"+updateerror.toString());return false;}
		
	}
	
	

	@Override
	public void Remove_Content(String bcid) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void Add_Content(String bcid) {
		// TODO Auto-generated method stub
		
	}
    
	
}
