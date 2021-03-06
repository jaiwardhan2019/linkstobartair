package com.linkportal;

// Bulk Upload 
//https://www.codejava.net/frameworks/spring/how-to-execute-batch-update-using-spring-jdbc
//https://javabydeveloper.com/spring-jdbctemplate-batch-update-with-maxperformance/  
//https://stackoverflow.com/questions/20360574/why-springs-jdbctemplate-batchupdate-so-slow  <<-- Good One Must Do Once 

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStreamReader;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.StringTokenizer;

import javax.sql.DataSource;
import org.springframework.jdbc.support.rowset.SqlRowSet;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.jdbc.core.JdbcTemplate;

import com.linkportal.crewripostry.crewReport;

public class loadTokenFromTextFileToDataBase {
	
	@Autowired
	static DataSource dataSourcestafftravel;

	@Autowired
	static DataSource dataSourcesqlservercp;
	
	
	
	
	public static void main(String[] args) throws IOException,NullPointerException,SQLException,ClassNotFoundException  {
		

			String addedByemailid ="jai.wardhan@stobartair.com";
			Date today                     = new Date();
			SimpleDateFormat formattedDate = new SimpleDateFormat("yyyy-MM-dd");
			Calendar c = Calendar.getInstance();
			String addedDate               = formattedDate.format(c.getTime());
	
			
		    /*  Load from Text File 
		     
		    File file = new File("src/main/resources/ppstoken.txt");			
			// Creating Streaming Pipe line
			FileInputStream fis = new FileInputStream(file);
			InputStreamReader isr = new InputStreamReader(fis);
			BufferedReader br = new BufferedReader(isr);			
			String TempStr = "";
			int counter = 1; // counter for number of lines in the file
			StringTokenizer st; // declare the String Tokenizer here
			TempStr = br.readLine(); // read the first line of the file

			final int batchSize = 10;
			
			// Loop for line reading
			while (TempStr != null) { // for each line of the File...
				st = new StringTokenizer(TempStr, ","); // separate based on a #
				// Loop for parshing line
				while (st.hasMoreTokens()) { // for each token in the line					
					st.nextToken();
					++counter;
					
					if(counter % batchSize == 0 || counter == st.countTokens()) {
				        //ps.executeBatch();
				        //ps.clearBatch(); 
						System.out.println("Inside Batch Update");    
				    }
					
					
					
				}
				
				System.out.println("new Line -");
				TempStr = br.readLine(); // read the next line of the File

			}	
  
			*/ 
			
			//System.out.println("Total no of record:"+counter);
			


			JdbcTemplate jdbcTemplateMysql = new JdbcTemplate(dataSourcestafftravel);
			JdbcTemplate  jdbcTemplateCorPortal = new JdbcTemplate(dataSourcesqlservercp);


			
			
			
			
			
			
			
			

			SqlRowSet rw = jdbcTemplateMysql.queryForRowSet("SELECT count(*) as noOfRow FROM flightops_crewing.flight_planning_token");
		    if(rw.next()) {System.out.println(rw.getInt("noOfRow"));}
			
			
			String sql = "insert into Gops_Crew_Planning_Token (Flight_Planing_Token ,Created_By_Email ,Created_Date) values (?, ?, ?)";
	
			

	
		
		
		

	}

}
