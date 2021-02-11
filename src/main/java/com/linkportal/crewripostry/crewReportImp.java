package com.linkportal.crewripostry;

import java.io.BufferedReader;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.StringReader;
import java.io.StringWriter;
import java.net.URLEncoder;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collection;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.StringTokenizer;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

import org.apache.commons.collections.CollectionUtils;
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
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.jdbc.support.rowset.SqlRowSet;
import org.springframework.stereotype.Repository;


import com.google.common.base.Strings;
import com.itextpdf.text.Document;
import com.itextpdf.text.PageSize;
import com.itextpdf.text.pdf.PdfWriter;
import com.itextpdf.tool.xml.XMLWorkerHelper;
import com.linkportal.datamodel.crewDetail;
import com.linkportal.datamodel.crewDetailForDateFlight;
import com.linkportal.datamodel.crewDetailForDateFlightRowmapper;
import com.linkportal.datamodel.crewDetailRowmapper;
import com.linkportal.datamodel.flightSectorLogRowmapper;
import com.linkportal.datamodel.fligthSectorLog;
import com.linkportal.dbripostry.businessAreaContentImp;

@Repository
public class crewReportImp implements crewReport{

	
	
	private static final String CREW_INFO_QUERY = "Select DISTINCT BASE_RANK.Rank as POSITION, CrewMember.Namefirst as CREW_FIRSTNAME , CREWMember.Namelast as CREW_LASTNAME, CREWMember.Initials as CREW_NO, BASE_RANK.STN, Crew_Email.Addr, CrewMember.EmploymentEndDate, CrewMember.Gender, CrewMember.DateOfBirth"
			+ " from "
			+ "(select CREW_employment.CrewSeqno, BASE.stn, CrewPos_Rank.Rank from CREW_employment,BASE,CrewPos_Rank,\n"
			+ "(select max(validFrom) as validFrom, CrewSeqno from CREW_employment where CREW_employment.validFrom<=:TODAYS_DATE group by CrewSeqno) as \"LATEST_EMPLOYMENT\"\n"
			+ "where CREW_employment.BaseSeqno=BASE.Seqno and CREW_employment.RankSeqno=CrewPos_Rank.RankSeqno\n"
			+ " and LATEST_EMPLOYMENT.validFrom=CREW_employment.ValidFrom and LATEST_EMPLOYMENT.CrewSeqno=CREW_employment.CrewSeqno) as BASE_RANK, CrewMember left join Crew_Email\n"
			+ "on CrewMember.CrewSeqno=Crew_Email.crewSeqno and Crew_Email.type='BUIS', CREWINFO \n"
			+ "where BASE_RANK.CrewSeqno=CrewMember.CrewSeqno";
	

	
	
	private static final String FLIGHT_SECTOR_LIST_QUERY ="select  (select top 1 CREW_NO from crewinfo where legs.fltid = crewinfo.fltid and legs.datop = crewinfo.datop and legs.legno = crewinfo.legno and crewinfo.inCommand=1) as Captain ,\r\n"
			+ "(select top 1 CREW_NO from crewinfo where legs.fltid = crewinfo.fltid and legs.datop = crewinfo.datop and legs.legno = crewinfo.legno and crewinfo.position like 'F%') as FirstOfficer \r\n"
			+ ", AIRCRAFT_V.SHORT_REG, STUFF(AIRCRAFT_V.LONG_REG,3,0,'-') as 'LONG_REG', AIRCRAFT_V.DESCRIPTION, LEGS.ACTYP, AIRCRAFT_V.SCR_SEATS, AIRCRAFT_V.AIRCRAFT_OWNER_CODE,\r\n"
			+ " LEGS.DEPSTN, LEGS.ARRSTN, SUBSTRING(LEGS.DATOP,0,12) as \"FLIGHT_DATE\", LEGS.AC, REPLACE(LEGS.FLTID, ' ', '') as FLTID, LEGS.LEGNO, LEGS.DEPSTN, LEGS.ARRSTN,\r\n"
			+ " REPLACE(SUBSTRING(LEGS.ETD,11,6),'.', ':')  as \"ETD_DATE_TIME\",  REPLACE(SUBSTRING(LEGS.ETA,11,6),'.', ':')  as \"ETA_DATE_TIME\",\r\n"
			+ " REPLACE(SUBSTRING(LEGS.STD,11,6),'.', ':') as \"STD_DATE_TIME\",   REPLACE(SUBSTRING(LEGS.STA,11,6),'.', ':')  as \"STA_DATE_TIME\",\r\n"
			+ " REPLACE(SUBSTRING(LEGS.ATD,11,6),'.', ':') as \"ATD_DATE_TIME\",   REPLACE(SUBSTRING(LEGS.ATA,11,6),'.', ':')  as \"ATA_DATE_TIME\",\r\n"
			+ " REPLACE(SUBSTRING(LEGS.TOFF,11,6),'.', ':') as \"TOFF_DATE_TIME\", REPLACE(SUBSTRING(LEGS.TDWN,11,6),'.', ':')  as \"TDWN_DATE_TIME\",\r\n"
			+ " datediff(minute, convert(datetime, REPLACE(Legs.atd, '.', ':'), 120), convert(datetime, REPLACE(Legs.ata, '.', ':'), 120)) as ATA_ATD, "
			+ " datediff(minute, convert(datetime, REPLACE(Legs.std, '.', ':'), 120), convert(datetime, REPLACE(Legs.sta, '.', ':'), 120)) as STA_STD, "
			+ " LEGS.BOOK, PBI.BOOKED, LEGS.PAX, LEGS.STC, LEGS.STATUS,\r\n"
			+ " DELAYCODE1.NumCode AS DELAY_CODE_1, DELAYCODE1.Description AS DELAY_CODE_1_DESCRIPTION, LEGS.DUR1,\r\n"
			+ " DELAYCODE2.NumCode AS DELAY_CODE_2, DELAYCODE2.Description AS DELAY_CODE_2_DESCRIPTION, LEGS.DUR2,\r\n"
			+ " DELAYCODE3.NumCode AS DELAY_CODE_3, DELAYCODE3.Description AS DELAY_CODE_3_DESCRIPTION, LEGS.DUR3,\r\n"
			+ " DELAYCODE4.NumCode AS DELAY_CODE_4, DELAYCODE4.Description AS DELAY_CODE_4_DESCRIPTION, LEGS.DUR4,\r\n"
			+ " fuel.beginningfuel, fuel.BURN, fuel.DEPFOB, fuel.ARRFOB, fuel.uplift1, fuel.uplift2, fuel.uplift3,\r\n"
			+ " legs3.ADULTS, legs3.MALES, legs3.FEMALES, legs3.CHILDREN, legs3.INFANTS,\r\n"
			+ " flight_note.note , flight_note.note1,flight_note.note2,flight_note.note3,flight_note.note4 \r\n"
			+ " FROM Legs left join fuel on  fuel.FLTID=legs.FLTID and fuel.datop=legs.datop and fuel.LEGNO=legs.LEGNO \r\n"
			+ " left join legs3 on  legs3.FLTID=legs.FLTID and legs3.datop=legs.datop and legs3.LEGNO=legs.LEGNO \r\n"
			+ " left join PBI on  pbi.FLTID=legs.FLTID and pbi.datop=legs.datop and pbi.LEGNO=legs.LEGNO \r\n"
			+ " left join DelayCode as DelayCode1 on  DelayCode1.NumCode=legs.DELAY1 or DelayCode1.AlphaCode=legs.DELAY1 \r\n"
			+ " left join DelayCode as DelayCode2 on  DelayCode2.NumCode=legs.DELAY2 or DelayCode2.AlphaCode=legs.DELAY2 \r\n"
			+ " left join DelayCode as DelayCode3 on  DelayCode3.NumCode=legs.DELAY3 or DelayCode3.AlphaCode=legs.DELAY3\r\n"
			+ " left join DelayCode as DelayCode4 on  DelayCode4.NumCode=legs.DELAY4 or DelayCode4.AlphaCode=legs.DELAY4\r\n"
			+ " left join flight_note on  flight_note.fltid=legs.fltid and flight_note.datop=legs.datop  and flight_note.depstn=legs.depstn and flight_note.arrstn=legs.arrstn\r\n"
			+ " left join ( \r\n"
			+ " select Distinct rtrim(AC_MISC.SHORT_REG) as \"SHORT_REG\", AC_MISC.LONG_REG, AC_MISC.DESCRIPTION, actype_versions_misc.actype, actype_Versions_misc.scr_seats, acreg_unit_map.acown as \"AIRCRAFT_OWNER_CODE\" from acreg_unit_map,ac_misc,ac_versions,actype_versions_misc where acreg_unit_map.acreg=ac_misc.ac and acreg_unit_map.actyp=actype_versions_misc.actype\r\n"
			+ " and actype_versions_misc.version=ac_Versions.version and ac_versions.ac=ac_misc.ac\r\n"
			+ " )as \"AIRCRAFT_V\" on legs.ac=(CONCAT (AIRCRAFT_V.AIRCRAFT_OWNER_CODE, AIRCRAFT_V.actype, AIRCRAFT_V.SHORT_REG))  \r\n";
		
	
	
	
	
	
	public static final SimpleDateFormat dateFormat_yyy_MM_dd = new SimpleDateFormat("yyyy-MM-dd");

	
	// -- Todate Date
	private String getTodaysDateString() {
		return dateFormat_yyy_MM_dd.format(new Date());
	}

	
	
	// -- Tomorrow Date
	private String getTomorrowDateString() {
		Calendar c = Calendar.getInstance();
		String todaydate = dateFormat_yyy_MM_dd.format(c.getTime());
		c.add(Calendar.DATE, 1); // number of days to add
		return formattedDate.format(c.getTime());
	}


	
	// ---------- Logger Initializer-------------------------------
	private final Logger logger = Logger.getLogger(businessAreaContentImp.class);

	@Autowired
	DataSource dataSourcesqlserver;

	@Autowired
	DataSource dataSourcesqlservercp;

	
	@Autowired
	DataSource dataSourceopswebsys;
	
	
	
	
	JdbcTemplate jdbcTemplatePdc;

	JdbcTemplate jdbcTemplateCorPortal;		

	JdbcTemplate jdbcTemplateMySqlDb;		

	
	crewReportImp(DataSource dataSourcesqlserver, DataSource dataSourcesqlservercp , DataSource dataSourceopswebsys) {

		jdbcTemplatePdc = new JdbcTemplate(dataSourcesqlserver);
		jdbcTemplateCorPortal = new JdbcTemplate(dataSourcesqlservercp);
		jdbcTemplateMySqlDb = new JdbcTemplate(dataSourceopswebsys);

	}

	
	
	@Override
	public List<crewDetail> showCrewList(String crewCode, String startDate, String endDate, List<String> rankList) {

		String query = CREW_INFO_QUERY;

		query += " and CREWINFO.CREW_NO=CrewMember.Initials";
		query += " and ((CREWINFO.DATOP >= :START_DATE) AND (CREWINFO.DATOP <= :END_DATE))";
		
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("START_DATE", startDate);
		parameters.put("END_DATE", endDate);
		parameters.put("TODAYS_DATE", getTodaysDateString());
		
		
		
		
		if (CollectionUtils.isNotEmpty(rankList)) {
			parameters.put("RANK_LIST", rankList);
			query += " and BASE_RANK.Rank in (:RANK_LIST)";
		}

		if ((!Strings.isNullOrEmpty(crewCode)) && (!crewCode.equalsIgnoreCase("ALL"))) {
			parameters.put("CREW_CODE", crewCode);
			query += " and CREWMember.Initials = :CREW_CODE";
		}


		//logger.debug("Running Crewing Query Parameters(" + parameters + ") " + query);		
		//System.out.println(parameters);
		//System.out.println(query);
		
		NamedParameterJdbcTemplate template = new NamedParameterJdbcTemplate(dataSourcesqlserver);		
		return template.query(query, parameters, new crewDetailRowmapper());
		
	}
	
	
	
	
	@Override
	public List<crewDetail> showScheduledCrewListForSelectedDate(String crewid, String datop) {
		return showCrewList(null, datop, datop, null);
	}

	
	
	@Override
	public List<crewDetail> showCrewCaptionFirstOfficer() {
		return showCrewList(null, getTodaysDateString(), getTomorrowDateString(), null);
	}

	
	
	
	
	@Override
	public List<fligthSectorLog> getFlightSectorListForDateCrew(String dateOfOperation, String crewId)
			throws Exception {


		if (Strings.isNullOrEmpty(dateOfOperation)) {
			throw new Exception("Date of Flight Report is Missing.");
		}

		if (Strings.isNullOrEmpty(crewId)) {
			throw new Exception("Crew Id is not selected.");
		}
		
		
		String sqlStr = FLIGHT_SECTOR_LIST_QUERY + " WHERE legs.status !='CNL' AND legs.datop='" + dateOfOperation + "' order by Captain";
		

		
		if((!Strings.isNullOrEmpty(crewId)) && (!crewId.equalsIgnoreCase("ALL"))) { 
			sqlStr = FLIGHT_SECTOR_LIST_QUERY + " left join crewinfo on crewinfo.DATOP=LEGS.DATOP  and  crewinfo.fltid=legs.fltid  WHERE legs.status !='CNL' AND legs.datop in ('"+dateOfOperation +"') and crewinfo.CREW_NO='"+crewId+"' order by Captain";
		    //sqlStr = FLIGHT_SECTOR_LIST_QUERY + " left join crewinfo on crewinfo.DATOP=LEGS.DATOP  and  crewinfo.fltid=legs.fltid  WHERE legs.status !='CNL' AND legs.datop in ('2021-02-21','2021-02-22') and crewinfo.CREW_NO='"+crewId+"' order by Captain";
	     }
		
		//System.out.println(sqlStr);
		
	    /* *******************************************************************
	     * - Create List of all Crew For the Selected Date
	     * - Pass this list to a method along with the sector log list 
	     * - Create a String Array of the crew list for that flight id 
	     * - Return String to the calling method
	     * - Attached Crew List to the Sector Log List 
	     * 
	     * ********************************************************************
		*/
		
		String sqlStrForCrew = "SELECT  REPLACE(FLTID, ' ', '') as FLTID ,DATOP , CREW_NO , CREW_NAME , POSITION "
				+ "	  ,P_OR_C  FROM crewinfo where DATOP='"+dateOfOperation+"'";		
		
		List<crewDetailForDateFlight> crewDetailForDateFlight = jdbcTemplatePdc.query(sqlStrForCrew, new crewDetailForDateFlightRowmapper());
		
		
		
		//System.out.println(sqlStr);
		
		//-- Blank One to have all detail and return  from this method
		List<fligthSectorLog> flitSectorForDateWithAllCrew = new ArrayList<fligthSectorLog>();
		
		//------ Get the List without any Crew List
		List<fligthSectorLog> flitSectorForDate = jdbcTemplatePdc.query(sqlStr, new flightSectorLogRowmapper());
		
		//------- Attaching the Crew list to the each row of the sector 
		for (Iterator iterator = flitSectorForDate.iterator(); iterator.hasNext();) {
			fligthSectorLog fligthSectorLog = (fligthSectorLog) iterator.next();
			fligthSectorLog.setAllCrewOfThisFlight(attachAllCrewMemberTotheFlightRow(crewDetailForDateFlight , fligthSectorLog.getFlightNo()));
			flitSectorForDateWithAllCrew.add(fligthSectorLog);
		}
		

		//if() crew is selected then filter the List with a new Function and return List
		return flitSectorForDateWithAllCrew;

	}
	
	
	
	
	private List<String> attachAllCrewMemberTotheFlightRow(List<crewDetailForDateFlight> crewDetail , String flightId ) {
		
			List<String> listCrew = new ArrayList<String>(); 
			
			for (Iterator iterator = crewDetail.iterator(); iterator.hasNext();) {
				crewDetailForDateFlight crewDetailForDateFlight = (crewDetailForDateFlight) iterator.next();
				if(crewDetailForDateFlight.getFltId().equalsIgnoreCase(flightId)) {					
					listCrew.add(crewDetailForDateFlight.getCrewName());
				}
				
			}
			return listCrew;
	}
	
	
	
	
	
		
	@Override
	public String getLoginToken() {
		String sql = "  select TOP(1) Flight_Planing_Token from Gops_Crew_Planning_Token";
		String tokenName = (String) jdbcTemplateCorPortal.queryForObject(sql, new Object[0], String.class);
		jdbcTemplateCorPortal
				.execute("delete from Gops_Crew_Planning_Token where Flight_Planing_Token='" + tokenName + "'");
		return tokenName;
	}

	@Override
	public Integer getTokenBalance() {
		String sqlFortoken = "select count(flight_Planing_Token) as TotalNo  FROM Gops_Crew_Planning_Token";
		return jdbcTemplateCorPortal.queryForObject(sqlFortoken, new Object[0], Integer.class);
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
		public void trasferDataFromMYSqlToSqlServer() throws SQLException {

            int tokenCounter = 1;
	    	JdbcTemplate jdbcTemplateCorPortal = new JdbcTemplate(dataSourcesqlservercp);
			DataSource ds = jdbcTemplateCorPortal.getDataSource();
			Connection connection = ds.getConnection();
			//jdbcTemplateCorPortal.execute("delete from Gops_Crew_Planning_Token");
			connection.setAutoCommit(false);
			String sql = "insert into Gops_Crew_Planning_Token (Flight_Planing_Token ,Created_By_Email ,Created_Date) values (?, ?, ?)";
		 	
	    	PreparedStatement ps = connection.prepareStatement(sql);			
			final int batchSize = 1000;
		
			
			SqlRowSet rw = jdbcTemplateMySqlDb.queryForRowSet("SELECT * FROM flightops_crewing.flight_planning_token LIMIT 251114,160000");
		    while(rw.next()) {
		           
		    	ps.setString(1, rw.getString("token"));
			    ps.setString(2, "jai.wardhan@stobartair.com");
				ps.setString(3, "2021-02-16");
				ps.addBatch();
				++tokenCounter;
						
				if((tokenCounter % batchSize == 0) || (!rw.next())) {							
					        ps.executeBatch();
					        ps.clearBatch();
					        connection.commit();
					        System.out.println(tokenCounter+"#Updates");
				}


		    }//-------- End of Outer While loop  For Line Reading 
				
				connection.commit();
				ps.close();
				connection.setAutoCommit(true);
				connection.close();

		    	
		   }
		
		
	
	
		
		
		
		
		
		
		
		
		
		

		@Override
		public HttpEntity<byte[]> createPdfWithVelocityTemplet(String fileName) throws IOException {

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


		
		
        //https://www.programmersought.com/article/3267527859/
		@SuppressWarnings("unchecked")
		@Override
		public void createVoyagerReportWithFreeMakerTemplet(HttpServletRequest request,HttpServletResponse response) throws Exception {
			
			//---Input Parameter Validation 
			if(Strings.isNullOrEmpty(request.getParameter("crewcode"))) {throw new Exception("Missing Crew Code");}
			
			if(Strings.isNullOrEmpty(request.getParameter("flightdate"))) {throw new Exception("Missing Flight Date");}
			
			
			
			ByteArrayOutputStream baos = null;
			
			String fileName = null;			
			
			Map<String,Object> data = new HashMap<>();
						
			//---Cal Blank Report  
			if(request.getParameter("crewcode").equalsIgnoreCase("BLANK")) {
				baos = PDFTemplateUtil.createSinglePagePDF(data, "blankVoyagerReportTemplet.ftl");
				fileName = URLEncoder.encode("BlankVaoygerReport.pdf", "UTF-8"); 
				System.out.println("Cal Blank Templet / Report");
				downLoadFile(request,response,baos,fileName);
				logger.info("Blank Voyager Report Downloaded by : "+request.getParameter("emailid"));
			}
			
			
			
			
			
			//---Cal All Crew Members Report 
			if(request.getParameter("crewcode").equalsIgnoreCase("ALL")) {	
				System.out.println("Cal All Schedule Templet / Report");
				fileName = URLEncoder.encode(request.getParameter("crewcode")+"-"+request.getParameter("flightdate")+"-VaoygerReport.pdf", "UTF-8"); 
				
				//-- Create List Of Map Obj
				List<Map<String, Object>> mapArray = new ArrayList<Map<String, Object>>();	
				
				//--- Create Single Map Obj
				Map<String,Object> mapObj = new HashMap<String, Object>();
				
				
				ArrayList<String> rankList =new ArrayList<String>();
				rankList.add("CAPT");
				
			
				List<crewDetail> captOfDate =  showCrewList("ALL", request.getParameter("flightdate") , request.getParameter("flightdate") ,rankList);
				for (Iterator iterator = captOfDate.iterator(); iterator.hasNext();) {
					crewDetail crewDetail = (crewDetail) iterator.next();
					mapObj.put("detailList", getFlightSectorListForDateCrew(request.getParameter("flightdate"),crewDetail.getCrewid()));	
					mapArray.add(mapObj);
					mapObj = new HashMap<String, Object>();
					
				}
								
				baos = PDFTemplateUtil.createMultiplePagePDF(mapArray , "crewVoyagerReportTemplet.ftl");	
				downLoadFile(request,response,baos,fileName);
				logger.info("Voyager Report Downloaded by : "+request.getParameter("emailid"));
	
			}
			
			
			
			
			//---Cal Single Crew Members Report 
			if((!request.getParameter("crewcode").equalsIgnoreCase("ALL")) && (!request.getParameter("crewcode").equalsIgnoreCase("BLANK"))){
				fileName = URLEncoder.encode(request.getParameter("crewcode")+"-"+request.getParameter("flightdate")+"-VaoygerReport.pdf", "UTF-8"); 
				List<fligthSectorLog> detailList =  getFlightSectorListForDateCrew(request.getParameter("flightdate"), request.getParameter("crewcode"));
				data.put("detailList", detailList);				
				baos = PDFTemplateUtil.createSinglePagePDF(data, "crewVoyagerReportTemplet.ftl");
				System.out.println("Cal Single Crew Templet / Report");
				downLoadFile(request,response,baos,fileName);
				logger.info("Voyager Report Downloaded by : "+request.getParameter("emailid"));
			}
			
			
			
			
			
			
		} // End of Method  createVoyagerReportWithFreeMakerTemplet()


		
		

		//--- Download File on new browser 
		private void downLoadFile(HttpServletRequest request,HttpServletResponse response , ByteArrayOutputStream baos , String fileName) throws Exception {
			
			OutputStream out = null;
			//------- This Part will Download The File --------
			try {
				
				// Set the response message header to tell the browser that the current respo
				response.setContentType( "application/pdf");
				// Tell the browser that the current response data requires user intervention to save to the file, and what the file name is. If the file name has Chinese, it must be URL encoded. 
				
				//response.setHeader( "Content-Disposition", "attachment;filename=" + fileName);    <<-- For Download
				response.setHeader( "Content-Disposition", "inline; filename=" + fileName);       //<<-- For View   
				out = response.getOutputStream();
				baos.writeTo(out);
				out.flush();
				//baos.close();
				
			} catch (Exception e) {logger.error(e); throw new Exception("Export failed:" + e.getMessage());} 
			    //finally{if(baos != null){ baos.close();}if(out != null){ out.close();}}//End of finally 
			

			
		}
		
		
		
		

		//------ BUILTING TODAY AND TOMORROW VARRIABLE ------------
	    Date today = new Date();               
		SimpleDateFormat formattedDate = new SimpleDateFormat("yyyy-MM-dd");


		
		
		
		
		
}
