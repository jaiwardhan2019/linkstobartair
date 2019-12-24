package com.linkportal.dbripostry;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import javax.sql.DataSource;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.web.servlet.server.Session;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.linkportal.controller.HomeController;




@Repository
public class businessAreaContentImp implements businessAreaContent {
	
	    //---------- Logger Initializer------------------------------- 
		private Logger logger = Logger.getLogger(businessAreaContentImp.class);
	
	    DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");
	    LocalDateTime now = LocalDateTime.now();
	   
	
    @Autowired
    DataSource dataSourcemysql;
    
	
	JdbcTemplate jdbcTemplate;
	
	
	public businessAreaContentImp(DataSource dataSourcemysql) {
		super();
		this.jdbcTemplate = new JdbcTemplate(dataSourcemysql);
	}

	
	
	

	@Override
	public String Show_Content(int bcid){	
		
		try{
		
		    String sql = "SELECT CONTENT FROM CORPORATE_PORTAL.BUSINESS_AREA_CONTENT_MASTER where bc_id=?";	  
		    String content = jdbcTemplate.queryForObject(sql, new Object[] { bcid }, String.class);
		    return content;
			    
		 } catch(Exception ee) {
			logger.error("While Reading Content Master DB:"+ee); 
			return null;
		}
		
		
	}//--------- End Of Function -----------
	

	

	@Override
	public int Update_Content(String content, int bcid, String emailid) {
		try{
			
			 Connection conn= dataSourcemysql.getConnection();
			
			String sqlUpdateContent="UPDATE CORPORATE_PORTAL.BUSINESS_AREA_CONTENT_MASTER SET CONTENT='"+content+"' , UPDATED_DATE_TIME='"+now+"' , USER='"+emailid+"' WHERE BC_ID="+bcid;
			
			sqlUpdateContent = "UPDATE CORPORATE_PORTAL.BUSINESS_AREA_CONTENT_MASTER SET CONTENT=? , UPDATED_DATE_TIME=?, USER=?  WHERE BC_ID=?";
			
			PreparedStatement pstm = conn.prepareStatement(sqlUpdateContent);
			pstm.setString(1,content);
			pstm.setString(2,now.toString()); 
			pstm.setInt(3,bcid);
			
			
			return jdbcTemplate.update(sqlUpdateContent);
		
	  }catch(Exception updateerror) {logger.error("While Updating  Content Master:"+updateerror.toString());return 0;}
		
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
