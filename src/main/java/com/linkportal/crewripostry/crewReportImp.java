package com.linkportal.crewripostry;

import java.io.BufferedReader;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.StringReader;
import java.io.StringWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Properties;
import java.util.StringTokenizer;

import javax.sql.DataSource;

import org.apache.log4j.Logger;
import org.apache.velocity.Template;
import org.apache.velocity.VelocityContext;
import org.apache.velocity.app.VelocityEngine;
import org.apache.velocity.runtime.RuntimeConstants;
import org.apache.velocity.runtime.resource.loader.ClasspathResourceLoader;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.itextpdf.text.Document;
import com.itextpdf.text.PageSize;
import com.itextpdf.text.pdf.PdfWriter;
import com.itextpdf.tool.xml.XMLWorkerHelper;
import com.linkportal.datamodel.crewDetail;
import com.linkportal.datamodel.crewDetailRowmapper;
import com.linkportal.datamodel.crewFlightRoster;
import com.linkportal.dbripostry.businessAreaContentImp;

@Repository
public class crewReportImp implements crewReport{

	
	private static final String CREW_INFO_QUERY = "Select BASE_RANK.Rank, CrewMember.Namefirst, CREWMember.Namelast, CREWMember.Initials, BASE_RANK.stn, Crew_Email.Addr, CrewMember.EmploymentEndDate, CrewMember.Gender, CrewMember.DateOfBirth"
				+ " from (select CREW_employment.CrewSeqno, BASE.stn, CrewPos_Rank.Rank from CREW_employment,BASE,CrewPos_Rank,\n"
				+ "(select max(validFrom) as validFrom, CrewSeqno from CREW_employment where CREW_employment.validFrom<=:TODAYS_DATE group by CrewSeqno) as \"LATEST_EMPLOYMENT\"\n"
				+ "where CREW_employment.BaseSeqno=BASE.Seqno and CREW_employment.RankSeqno=CrewPos_Rank.RankSeqno\n"
				+ " and LATEST_EMPLOYMENT.validFrom=CREW_employment.ValidFrom and LATEST_EMPLOYMENT.CrewSeqno=CREW_employment.CrewSeqno) as BASE_RANK, CrewMember left join Crew_Email\n" 
				+ "on CrewMember.CrewSeqno=Crew_Email.crewSeqno and Crew_Email.type='BUIS' where BASE_RANK.CrewSeqno=CrewMember.CrewSeqno and CrewMember.EmploymentEndDate < today() order by CrewMember.Namefirst";
	
	
	
	
	//------ getAllFlightCrewForDateRangeInRankList -  for the date range 
	String querySearch = "Select DISTINCT BASE_RANK.Rank, CrewMember.Namefirst, CREWMember.Namelast, CREWMember.Initials, BASE_RANK.stn, Crew_Email.Addr, CrewMember.EmploymentEndDate, CrewMember.Gender, CrewMember.DateOfBirth"
			+ " from (select CREW_employment.CrewSeqno, BASE.stn, CrewPos_Rank.Rank from CREW_employment,BASE,CrewPos_Rank,\n"
			+ "(select max(validFrom) as validFrom, CrewSeqno from CREW_employment where CREW_employment.validFrom<=:TODAYS_DATE group by CrewSeqno) as \"LATEST_EMPLOYMENT\"\n"
			+ "where CREW_employment.BaseSeqno=BASE.Seqno and CREW_employment.RankSeqno=CrewPos_Rank.RankSeqno\n"
			+ " and LATEST_EMPLOYMENT.validFrom=CREW_employment.ValidFrom and LATEST_EMPLOYMENT.CrewSeqno=CREW_employment.CrewSeqno) as BASE_RANK, CrewMember left join Crew_Email\n" 
			+ "on CrewMember.CrewSeqno=Crew_Email.crewSeqno and Crew_Email.type='BUIS', CREWINFO \n"
			+ "where BASE_RANK.CrewSeqno=CrewMember.CrewSeqno  and CREWINFO.CREW_NO=CrewMember.Initials  ";
	
			//+ "and ((CREWINFO.DATOP >= :START_DATE) AND (CREWINFO.DATOP <= :END_DATE))";
	
	String sqlstr1="select  (select top 1 CREW_NO from crewinfo where legs.fltid = crewinfo.fltid and legs.datop = crewinfo.datop and legs.legno = crewinfo.legno and position = 'CAPT') as Captain ,(select top 1 CREW_NO from crewinfo where legs.fltid = crewinfo.fltid and legs.datop = crewinfo.datop and legs.legno = crewinfo.legno and position = 'FO') as FirstOfficer,AIRCRAFT_V.SHORT_REG, STUFF(AIRCRAFT_V.LONG_REG,3,0,'-') as 'LONG_REG', AIRCRAFT_V.DESCRIPTION, LEGS.ACTYP, AIRCRAFT_V.SCR_SEATS, AIRCRAFT_V.AIRCRAFT_OWNER_CODE,\r\n" + 
			" LEGS.DEPSTN, LEGS.ARRSTN, SUBSTRING(LEGS.DATOP,0,12) as \"FLIGHT_DATE\", LEGS.AC, REPLACE(LEGS.FLTID, ' ', '') as FLTID, LEGS.LEGNO, LEGS.DEPSTN, LEGS.ARRSTN,\r\n" + 
			" REPLACE(SUBSTRING(LEGS.ETD,11,6),'.', ':')  as \"ETD_DATE_TIME\",  REPLACE(SUBSTRING(LEGS.ETA,11,6),'.', ':')  as \"ETA_DATE_TIME\",\r\n" + 
			" REPLACE(SUBSTRING(LEGS.STD,11,6),'.', ':') as \"STD_DATE_TIME\",   REPLACE(SUBSTRING(LEGS.STA,11,6),'.', ':')  as \"STA_DATE_TIME\",\r\n" + 
			" REPLACE(SUBSTRING(LEGS.ATD,11,6),'.', ':') as \"ATD_DATE_TIME\",   REPLACE(SUBSTRING(LEGS.ATA,11,6),'.', ':')  as \"ATA_DATE_TIME\",\r\n" + 
			" REPLACE(SUBSTRING(LEGS.TOFF,11,6),'.', ':') as \"TOFF_DATE_TIME\", REPLACE(SUBSTRING(LEGS.TDWN,11,6),'.', ':')  as \"TDWN_DATE_TIME\",\r\n" + 
			" datediff(minute, convert(datetime, REPLACE(Legs.atd, '.', ':'), 120), convert(datetime, REPLACE(Legs.ata, '.', ':'), 120)) as ATA_ATD, LEGS.BOOK, PBI.BOOKED, LEGS.PAX, LEGS.STC, LEGS.STATUS,\r\n" + 
			" DELAYCODE1.NumCode AS DELAY_CODE_1, DELAYCODE1.Description AS DELAY_CODE_1_DESCRIPTION, LEGS.DUR1,\r\n" + 
			" DELAYCODE2.NumCode AS DELAY_CODE_2, DELAYCODE2.Description AS DELAY_CODE_2_DESCRIPTION, LEGS.DUR2,\r\n" + 
			" DELAYCODE3.NumCode AS DELAY_CODE_3, DELAYCODE3.Description AS DELAY_CODE_3_DESCRIPTION, LEGS.DUR3,\r\n" + 
			" DELAYCODE4.NumCode AS DELAY_CODE_4, DELAYCODE4.Description AS DELAY_CODE_4_DESCRIPTION, LEGS.DUR4,\r\n" + 
			" fuel.beginningfuel, fuel.BURN, fuel.DEPFOB, fuel.ARRFOB, fuel.uplift1, fuel.uplift2, fuel.uplift3,\r\n" + 
			" legs3.ADULTS, legs3.MALES, legs3.FEMALES, legs3.CHILDREN, legs3.INFANTS,\r\n" + 
			" flight_note.note , flight_note.note1,flight_note.note2,flight_note.note3,flight_note.note4 \r\n" + 
			" FROM Legs left join fuel on  fuel.FLTID=legs.FLTID and fuel.datop=legs.datop and fuel.LEGNO=legs.LEGNO \r\n" + 
			" left join legs3 on  legs3.FLTID=legs.FLTID and legs3.datop=legs.datop and legs3.LEGNO=legs.LEGNO \r\n" + 
			" left join PBI on  pbi.FLTID=legs.FLTID and pbi.datop=legs.datop and pbi.LEGNO=legs.LEGNO \r\n" + 
			" left join DelayCode as DelayCode1 on  DelayCode1.NumCode=legs.DELAY1 or DelayCode1.AlphaCode=legs.DELAY1 \r\n" + 
			" left join DelayCode as DelayCode2 on  DelayCode2.NumCode=legs.DELAY2 or DelayCode2.AlphaCode=legs.DELAY2 \r\n" + 
			" left join DelayCode as DelayCode3 on  DelayCode3.NumCode=legs.DELAY3 or DelayCode3.AlphaCode=legs.DELAY3\r\n" + 
			" left join DelayCode as DelayCode4 on  DelayCode4.NumCode=legs.DELAY4 or DelayCode4.AlphaCode=legs.DELAY4\r\n" + 
			" left join flight_note on  flight_note.fltid=legs.fltid and flight_note.datop=legs.datop  and flight_note.depstn=legs.depstn and flight_note.arrstn=legs.arrstn\r\n" + 
			" left join ( \r\n" + 
			" select Distinct rtrim(AC_MISC.SHORT_REG) as \"SHORT_REG\", AC_MISC.LONG_REG, AC_MISC.DESCRIPTION, actype_versions_misc.actype, actype_Versions_misc.scr_seats, acreg_unit_map.acown as \"AIRCRAFT_OWNER_CODE\" from acreg_unit_map,ac_misc,ac_versions,actype_versions_misc where acreg_unit_map.acreg=ac_misc.ac and acreg_unit_map.actyp=actype_versions_misc.actype\r\n" + 
			" and actype_versions_misc.version=ac_Versions.version and ac_versions.ac=ac_misc.ac\r\n" + 
			" )as \"AIRCRAFT_V\" on legs.ac=(CONCAT (AIRCRAFT_V.AIRCRAFT_OWNER_CODE, AIRCRAFT_V.actype, AIRCRAFT_V.SHORT_REG)) WHERE LEGS.STATUS IN ('ATA') AND legs.datop  between '2019-09-30' and '2019-09-30'\r\n" + 
			" AND (datediff(minute, convert(datetime, REPLACE(Legs.std, '.', ':'), 120), convert(datetime, REPLACE(Legs.atd, '.', ':'), 120)) >= 0) order by  FLIGHT_DATE ,ETD_DATE_TIME\r\n";
	
	
	
	
	  //---------- Logger Initializer------------------------------- 
	  private final Logger logger = Logger.getLogger(businessAreaContentImp.class);
		
	 	
	    @Autowired
	    DataSource dataSourcesqlserver;

	    @Autowired
		DataSource dataSourcesqlservercp;
	    
		
		JdbcTemplate jdbcTemplatePdc;

	    JdbcTemplate jdbcTemplateCorPortal;
		
		

		crewReportImp(DataSource dataSourcesqlserver,DataSource dataSourcesqlservercp){
		
			jdbcTemplatePdc = new JdbcTemplate(dataSourcesqlserver);
			jdbcTemplateCorPortal = new JdbcTemplate(dataSourcesqlservercp);
		  
		  }

		
	
		@Override
		public List<crewDetail> showCrewList(String datop) {
			   String sqlstr="select DISTINCT CREW_NO , CREW_NAME , POSITION from crewinfo where DATOP='"+datop+"' and POSITION='CAPT' order by CREW_NAME";
			   //System.out.println(sqlstr);
			   List  linkusers = jdbcTemplatePdc.query(sqlstr,new crewDetailRowmapper());
			  return linkusers;
		}



		@Override
		public List<crewFlightRoster> showCrewFlightSchedule(String crewid, String datop) {
			   List crewflightrost =  jdbcTemplatePdc.query("",new crewDetailRowmapper());
			return null;
		}


	
	
		@Override
		public List<crewDetail> showCrewCaptionFirstOfficer() {
	
			// ------ BUILTING TODAY AND TOMORROW VARRIABLE ------------
			Date today = new Date();
			SimpleDateFormat formattedDate = new SimpleDateFormat("yyyy-MM-dd");
			Calendar cFrom = Calendar.getInstance();
			cFrom.add(Calendar.DATE, -30);
			String fromData = formattedDate.format(cFrom.getTime());
			Calendar cTo = Calendar.getInstance();
			cTo.add(Calendar.DATE, 30); // number of days to add
			String toDate = formattedDate.format(cTo.getTime());
			String sqlstr = "select DISTINCT CREW_NO , CREW_NAME , POSITION from crewinfo where  POSITION in('CAPT','FO') and DATOP between '"
					+ fromData + "' and  '" + toDate + "' order by CREW_NAME , POSITION ";
			List linkusers = jdbcTemplatePdc.query(sqlstr, new crewDetailRowmapper());
			return linkusers;	
		}
		
			
		@Override
		public String getLoginToken() {
			String sql = "  select TOP(1) Flight_Planing_Token from Gops_Crew_Planning_Token";
			String tokenName = (String) jdbcTemplateCorPortal.queryForObject( sql, new Object[0],String.class);
			jdbcTemplateCorPortal.execute("delete from Gops_Crew_Planning_Token where Flight_Planing_Token='"+tokenName+"'");
			return tokenName;
		}



		@Override
		public Integer getTokenBalance() {			
			String sqlFortoken = "select count(flight_Planing_Token) as TotalNo  FROM Gops_Crew_Planning_Token";
			return jdbcTemplateCorPortal.queryForObject( sqlFortoken, new Object[0],Integer.class);
		}

		
		
		//------ This method will read token from the File and insert into the table in a Batch process
		@Override
		public int readTokenFromFileAndInsertToDatabase(File fileName , String addedby, String addedDate) throws FileNotFoundException {
			
			int tokenCounter = 1;
			try {

				// Creating Streaming Pipe line to read the source file 
				FileInputStream fis = new FileInputStream(fileName);
				InputStreamReader isr = new InputStreamReader(fis);
				BufferedReader br = new BufferedReader(isr);			
				String TempStr = "";
				          
				StringTokenizer st;       // declare the String Tokenizer here
				TempStr = br.readLine();  // read the first line of the file
	
				
				
				//--------- Creating Connection -----------
				JdbcTemplate jdbcTemplateCorPortal = new JdbcTemplate(dataSourcesqlservercp);
				DataSource ds = jdbcTemplateCorPortal.getDataSource();
				Connection connection = ds.getConnection();
				connection.setAutoCommit(false);
				String sql = "insert into Gops_Crew_Planning_Token (Flight_Planing_Token ,Created_By_Email ,Created_Date) values (?, ?, ?)";
				PreparedStatement ps = connection.prepareStatement(sql);			
				final int batchSize = 1000;
				
				
				// Loop for line reading
				while (TempStr != null) { // for each line of the File...
					st = new StringTokenizer(TempStr, ","); // separate based on a #
					
					// Loop for parshing line
					while (st.hasMoreTokens()) { // for each token in the line
						
					    ps.setString(1, st.nextToken());
					    ps.setString(2, addedby);
					    ps.setString(3, addedDate);
					    ps.addBatch();
						++tokenCounter;
						
						if((tokenCounter % batchSize == 0) || (tokenCounter == st.countTokens()) || (!st.hasMoreTokens())) {							
					        ps.executeBatch();
					        ps.clearBatch();
					        connection.commit();
					        //System.out.println(tokenCounter+"#Updates");
					    }


					}//-- End of Line reader loop  				
					TempStr = br.readLine(); // read the next line of the File
					

				}//-------- End of Outer While loop  For Line Reading 
				
				connection.commit();
				ps.close();
				connection.setAutoCommit(true);
				connection.close();
				fis.close();
				isr.close();
				
			
			}catch(Exception e) {logger.error("Error While Uploading &&  Reading Token File :"+e.toString());}		
			
			
			
			return tokenCounter;
		}


		@Override
		public HttpEntity<byte[]> createPdf(String fileName) throws IOException {

			/* first, get and initialize an engine */

			VelocityEngine ve = new VelocityEngine();
			ve.setProperty(RuntimeConstants.RESOURCE_LOADER, "classpath");
			ve.setProperty("classpath.resource.loader.class", ClasspathResourceLoader.class.getName());

			Properties p = new java.util.Properties();
			p.setProperty("runtime.log.logsystem.class", "org.apache.velocity.runtime.log.NullLogSystem");
			ve.init(p);

			Template t = ve.getTemplate("templates/flightReportTemplate.vm");

			/* create a context and add data */
			VelocityContext context = new VelocityContext();
			context.put("name", "World");
			context.put("genDateTime", LocalDateTime.now().toString());
			context.put("addedByName", "Jai Wardhan");

			/* now render the template into a StringWriter */
			StringWriter writer = new StringWriter();
			t.merge(context, writer);

			/* show the World */
			System.out.println(writer.toString());

			ByteArrayOutputStream baos = new ByteArrayOutputStream();
			baos = generatePdf(writer.toString());
			HttpHeaders header = new HttpHeaders();
			header.setContentType(MediaType.APPLICATION_PDF);
			//header.set(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=" + fileName.replace(" ", "_")); // Download 
			header.set(HttpHeaders.CONTENT_DISPOSITION, "inline; filename=" + fileName.replace(" ", "_")); // Veiw in webpage 
			header.setContentLength(baos.toByteArray().length);

			return new HttpEntity<byte[]>(baos.toByteArray(), header);

		}		
		
		
		
		
		public ByteArrayOutputStream generatePdf(String html) {

			String pdfFilePath = "";
			PdfWriter pdfWriter = null;

			// create a new document
			Document document = new Document();
			try {

				document = new Document();
				// document header attributes
				document.addAuthor("Kinns");
				document.addAuthor("Kinns123");
				document.addCreationDate();
				document.addProducer();
				document.addCreator("Jai Wardhan");
				document.addTitle("Voyager Report");
				document.setPageSize(PageSize.A4);

				ByteArrayOutputStream baos = new ByteArrayOutputStream();
				PdfWriter.getInstance(document, baos);

				// open document
				document.open();

				XMLWorkerHelper xmlWorkerHelper = XMLWorkerHelper.getInstance();
				xmlWorkerHelper.getDefaultCssResolver(true);
				xmlWorkerHelper.parseXHtml(pdfWriter, document, new StringReader(html));
				// close the document
				document.close();
				System.out.println("PDF generated successfully");

				return baos;
			} catch (Exception e) {logger.error(e);	e.printStackTrace();return null;}

		}


		
		
		
		
		
		
		
		
		
		
		
}
