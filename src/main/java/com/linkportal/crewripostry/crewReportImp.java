package com.linkportal.crewripostry;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

import javax.sql.DataSource;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.linkportal.datamodel.UsersRowmapper;
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
	  private Logger logger = Logger.getLogger(businessAreaContentImp.class);
		
	 	
	    @Autowired
	    DataSource dataSourcesqlserver;
	    
		
		JdbcTemplate jdbcTemplate;
		
		

		crewReportImp(DataSource dataSourcesqlserver){ 			
		
			jdbcTemplate = new JdbcTemplate(dataSourcesqlserver);
		  
		  }

		
	
		@Override
		public List<crewDetail> showCrewList(String datop) {
			   String sqlstr="select DISTINCT CREW_NO , CREW_NAME , POSITION from crewinfo where DATOP='"+datop+"' and POSITION='CAPT' order by CREW_NAME";
			   //System.out.println(sqlstr);
			   List  linkusers = jdbcTemplate.query(sqlstr,new crewDetailRowmapper());
			  return linkusers;
		}



		@Override
		public List<crewFlightRoster> showCrewFlightSchedule(String crewid, String datop) {
			
			   List crewflightrost =  jdbcTemplate.query("",new crewDetailRowmapper());
			   
			   
			   
			
			// TODO Auto-generated method stub
			
			
			return null;
		}

		
		
		
}
