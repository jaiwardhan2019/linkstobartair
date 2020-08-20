package com.linkportal.batchjob;

import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.file.FileVisitResult;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.SimpleFileVisitor;
import java.nio.file.attribute.BasicFileAttributes;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import javax.sql.DataSource;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.support.rowset.SqlRowSet;
import org.springframework.stereotype.Repository;

import com.linkportal.contractmanager.stobartContract;
import com.linkportal.contractmanager.stobartContractRowmapper;
import com.linkportal.email.linkPortalEmail;

@Repository
public class linkBatchJobImp implements linkBatchJob {

	private static final Logger LOGGER = Logger.getLogger(linkBatchJobImp.class);

	private static final DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");

	private static final String SqlForContarctExpireyin180days = "SELECT CONTRACT_DEPT_SUBDET.DEPARTMENT , CONTRACT_DEPT_SUBDET.SUBDEPARTMENT, CONTRACT_DEPT_SUBDET.DEPARTMENT_CODE , CONTRACT_DEPT_SUBDET.SUBDEPARTMENT_CODE , CONTRACT_MASTER.DEPT_SUB_CODE "
			+ " , CONTRACT_MASTER.contractor_name , CONTRACT_MASTER.contractor_contact_detail,CONTRACT_MASTER.refrence_no, "
			+ "   CONTRACT_MASTER.description,CONTRACT_MASTER.status,CONTRACT_MASTER.start_date,CONTRACT_MASTER.end_date,CONTRACT_MASTER.entered_by_email , CONTRACT_ACCESS.is_admin  "
			+ "   FROM CONTRACT_DEPT_SUBDET,CONTRACT_MASTER , CONTRACT_ACCESS  WHERE CONTRACT_MASTER.DEPT_SUB_CODE = CONTRACT_DEPT_SUBDET.ID "
			+ "   AND  CONTRACT_MASTER.DEPT_SUB_CODE = CONTRACT_ACCESS.dept_sub_code  AND  CONTRACT_MASTER.entered_by_email=CONTRACT_ACCESS.user_email AND CONTRACT_MASTER.STATUS in ('Active','Dactive')";

	@Autowired
	linkPortalEmail emailinst;

	// -------------- reading application.properties file -----------------
	@Value("${mail.host}")
	String mailhostserver;
	@Value("${mail.From}")
	String emailfrom;
	@Value("${mail.subject.contract}")
	String emailsubject;
	@Value("${mail.body.contractRenew}")
	String emailBodyRenew1;
	@Value("${mail.body.contractExpiry}")
	String emailBodyExpired1;
	@Value("${stobart.contract.folder}")
	String contractpath;

	@Autowired
	DataSource dataSourcesqlservercp;

	JdbcTemplate jdbcTempBatch;

	public linkBatchJobImp(DataSource dataSourcesqlservercp) {
		jdbcTempBatch = new JdbcTemplate(dataSourcesqlservercp);
	}

	@Override
	public void notify_Contarct_Admin_About_ContractExpiry() {
		try {

			// -------- SEARCH FOR THE CONTRACT WHO IS GOING TO EXPIRE IN 180 DAYS
			// -----------
			List<stobartContract> contractlist = jdbcTempBatch.query(SqlForContarctExpireyin180days,
					new stobartContractRowmapper());

			Iterator it = contractlist.iterator();
			while (it.hasNext()) {

				stobartContract contr = (stobartContract) it.next();
				int noofDaysToExpire = contr.noofDaysToExpire(contr.getEnd_date());
				String emailBodyRenew = emailBodyRenew1;
				String emailBodyExpired = emailBodyExpired1;

				// -- Formatting End Date ---
				String enddate = contr.getEnd_date();
				SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd");
				SimpleDateFormat sdf2 = new SimpleDateFormat("dd-MM-yyyy");
				String dateString = sdf2.format(sdf1.parse(enddate));
				Date date = sdf2.parse(dateString);
				dateString = date.toString();

				// ---- FOR ABOUT TO EXPIRE IN 180 DAYS
				if ((noofDaysToExpire > 0) && (noofDaysToExpire <= 180)) {
					compressFolderMakeZip(contr.getRefrence_no());
					emailBodyRenew = emailBodyRenew.replaceAll("CONTRACTNO", contr.getRefrence_no());
					emailBodyRenew = emailBodyRenew.replaceAll("NDAYS", Integer.toString(noofDaysToExpire));
					emailBodyRenew = emailBodyRenew.replaceAll("EXDT", dateString);
					emailinst.sendTextHtmlEmail(mailhostserver, emailfrom,
							collectAdminEmailList(contr.getRefrence_no()), (emailsubject + contr.getRefrence_no()),
							emailBodyRenew, contractpath + "stobart_contract/" + contr.getRefrence_no() + ".zip");

				}

				// ---- FOR FULLY EXPIRED CONTRACT
				if (noofDaysToExpire <= 0) {
					// -- This part will change the status to Dactive ---
					jdbcTempBatch
							.update("UPDATE CORPORATE_PORTAL.CONTRACT_MASTER SET STATUS='Dactive' where refrence_no='"
									+ contr.getRefrence_no() + "'");

					// --- Make zip folder to the contract
					compressFolderMakeZip(contr.getRefrence_no());

					// --- Send email notification to all Admin and Qualified User
					emailBodyExpired = emailBodyExpired.replaceAll("CONTRACTNO", contr.getRefrence_no());
					emailBodyExpired = emailBodyExpired.replaceAll("EXDT", dateString);
					emailinst.sendTextHtmlEmail(mailhostserver, emailfrom,
							collectAdminEmailList(contr.getRefrence_no()), (emailsubject + contr.getRefrence_no()),
							emailBodyExpired, contractpath + "stobart_contract/" + contr.getRefrence_no() + ".zip");

				}

				emailBodyRenew = "";
				emailBodyExpired = "";

			} // ------ END OF WHILE LOOP

		} catch (Exception exc) {

			LOGGER.error("Issue in Method :=> linkbatch.notify_Contarct_Admin_About_ContractExpiry() @:"
					+ dateTimeFormatter.format(LocalDateTime.now()) + exc.toString());
			// emailinst.sendTextHtmlEmail(mailhostserver,
			// emailfrom,"jai.wardhan@stobartair.com","Contract Notification batch job is
			// failing",exc.toString(),null);
		}

	}// ---------- END OF FUNCTION ---------------

	// --- WILL TAKE INPUT AS REFNO AND RETRUN EMAIL LIST OF ALL ADMIN USER AND
	// OTHERS WHO QUALIFY FOR EMAIL
	private String collectAdminEmailList(String refNo) {
		String adminEmailList = null;
		String sqlforemail = "SELECT  distinct user_email FROM CORPORATE_PORTAL.CONTRACT_ACCESS where is_admin='Y' or eligible_for_email_notification='Y' and "
				+ " dept_sub_code in(SELECT dept_sub_code FROM CORPORATE_PORTAL.CONTRACT_MASTER where   refrence_no='"
				+ refNo + "')";

		SqlRowSet rs = jdbcTempBatch.queryForRowSet(sqlforemail);
		while (rs.next()) {
			if (adminEmailList != null) {
				adminEmailList = adminEmailList + "," + rs.getString("user_email");
			} else {
				adminEmailList = rs.getString("user_email");
			}
		} // --- End Of While loop

		// System.out.println("List of admin to be notified:"+adminEmailList);

		return adminEmailList;
	}

	// -- THIS FUNCTION WILL CHANGE THE CONTRACT FOLDER TO THE .ZIP FILE
	private void compressFolderMakeZip(String refNo) {

		String dirPath = contractpath + "stobart_contract/" + refNo;

		final Path sourceDir = Paths.get(dirPath);
		String zipFileName = dirPath.concat(".zip");
		try {
			final ZipOutputStream outputStream = new ZipOutputStream(new FileOutputStream(zipFileName));
			Files.walkFileTree(sourceDir, new SimpleFileVisitor<Path>() {
				@Override
				public FileVisitResult visitFile(Path file, BasicFileAttributes attributes) {
					try {
						Path targetFile = sourceDir.relativize(file);
						outputStream.putNextEntry(new ZipEntry(targetFile.toString()));
						byte[] bytes = Files.readAllBytes(file);
						outputStream.write(bytes, 0, bytes.length);
						outputStream.closeEntry();
					} catch (IOException e) {
						LOGGER.error("While zipping Contract no ::" + refNo + "::" + e.toString());
					}
					return FileVisitResult.CONTINUE;
				}
			});
			outputStream.close();

		} catch (IOException e) {
			LOGGER.error("While zipping Contract no ::" + refNo + "::" + e.toString());
		}

		LOGGER.info("Contract no :" + refNo + " Been Zipped and Downloaded on:" + new Date());

	}

}// ---------END OF CLASS FILE
