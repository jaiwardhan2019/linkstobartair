package com.linkportal.contractmanager;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.Part;
import javax.sql.DataSource;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.support.rowset.SqlRowSet;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.microsoft.sqlserver.jdbc.SQLServerException;

@Repository
public class manageStobartContractImp implements manageStobartContract {

	@Autowired
	DataSource dataSourcesqlservercp;

	JdbcTemplate jdbcTemplateRefis;

	private Logger logger = Logger.getLogger(manageStobartContractImp.class);

	public manageStobartContractImp(DataSource dataSourcesqlservercp) {

		jdbcTemplateRefis = new JdbcTemplate(dataSourcesqlservercp);

	}

	// ------------- THIS WILL SHOW THE LIST OF CONTRACT ---------------
	@Override
	public List<stobartContract> showAllContract(String emailid, String dept, String subdept, String cdetail,
			String status) {

		String sqlListContract = "SELECT CONTRACT_DEPT_SUBDET.DEPARTMENT , CONTRACT_DEPT_SUBDET.SUBDEPARTMENT, CONTRACT_DEPT_SUBDET.DEPARTMENT_CODE , CONTRACT_DEPT_SUBDET.SUBDEPARTMENT_CODE , CONTRACT_MASTER.DEPT_SUB_CODE \r\n"
				+ " , CONTRACT_MASTER.contractor_name , CONTRACT_MASTER.contractor_contact_detail,CONTRACT_MASTER.refrence_no,\r\n"
				+ "   CONTRACT_MASTER.description,CONTRACT_MASTER.status,CONTRACT_MASTER.start_date,CONTRACT_MASTER.end_date,CONTRACT_MASTER.entered_by_email , CONTRACT_ACCESS.is_admin \r\n"
				+ "   FROM CONTRACT_DEPT_SUBDET,CONTRACT_MASTER , CONTRACT_ACCESS \r\n"
				+ "   WHERE CONTRACT_MASTER.DEPT_SUB_CODE = CONTRACT_DEPT_SUBDET.ID "
				+ " AND  CONTRACT_MASTER.DEPT_SUB_CODE = CONTRACT_ACCESS.dept_sub_code  AND CONTRACT_ACCESS.user_email='"
				+ emailid + "'";

		String andSql = " ";

		if (!dept.equals("ALL")) {
			andSql = andSql
					+ "and CONTRACT_MASTER.dept_sub_code in (SELECT id FROM  CONTRACT_DEPT_SUBDET where department_code='"
					+ dept + "')";
			if (!subdept.equals("ALL")) {
				andSql = andSql
						+ "and CONTRACT_MASTER.dept_sub_code in (SELECT id FROM  CONTRACT_DEPT_SUBDET where department_code='"
						+ dept + "' and subdepartment_code='" + subdept + "')";

			}

		}

		// --- Only when Sub Department is selected and click Search Button ---
		if (!subdept.equals("ALL") && dept.equals("ALL")) {
			andSql = andSql
					+ "and CONTRACT_MASTER.dept_sub_code in (SELECT id FROM  CONTRACT_DEPT_SUBDET where subdepartment_code='"
					+ subdept + "')";

		}

		if (cdetail != null) {
			andSql = andSql + "and CONTRACT_MASTER.description like '%" + cdetail.trim() + "%'";
		}

		if ((status != null) && (status != "")) {
			andSql = andSql + "and CONTRACT_MASTER.STATUS in (" + status + ")";

		} else {
			andSql = andSql + "and CONTRACT_MASTER.STATUS='Active'";
		}

		sqlListContract = sqlListContract + andSql;
		sqlListContract = sqlListContract + " order by  CONTRACT_MASTER.start_date desc ";

		// System.out.println(sqlListContract);

		List Contract = jdbcTemplateRefis.query(sqlListContract, new stobartContractRowmapper());

		return Contract;
	}

	// ------------- THIS WILL SHOW ONE CONTRACT ---------------
	@Override
	public stobartContract viewContract(String crefno, String loginuseremailid) {

		String viewsql = "SELECT CONTRACT_DEPT_SUBDET.DEPARTMENT , CONTRACT_DEPT_SUBDET.SUBDEPARTMENT, CONTRACT_DEPT_SUBDET.DEPARTMENT_CODE , CONTRACT_DEPT_SUBDET.SUBDEPARTMENT_CODE , CONTRACT_MASTER.DEPT_SUB_CODE \r\n"
				+ " , CONTRACT_MASTER.contractor_name , CONTRACT_MASTER.contractor_contact_detail,CONTRACT_MASTER.refrence_no,\r\n"
				+ "   CONTRACT_MASTER.description,CONTRACT_MASTER.status,CONTRACT_MASTER.start_date,CONTRACT_MASTER.end_date,CONTRACT_MASTER.entered_by_email , CONTRACT_ACCESS.is_admin \r\n"
				+ "   FROM CONTRACT_DEPT_SUBDET,CONTRACT_MASTER , CONTRACT_ACCESS \r\n"
				+ "   WHERE CONTRACT_MASTER.DEPT_SUB_CODE = CONTRACT_DEPT_SUBDET.ID "
				+ " AND  CONTRACT_MASTER.DEPT_SUB_CODE = CONTRACT_ACCESS.dept_sub_code  AND CONTRACT_ACCESS.user_email='"
				+ loginuseremailid + "' AND " + " CONTRACT_MASTER.refrence_no=?";
		// System.out.println(viewsql);

		return jdbcTemplateRefis.queryForObject(viewsql, new Object[] { crefno }, new stobartContractRowmapper());

	}

	// ------------- THIS WILL RENEW CONTRACT ---------------
	@Override
	public stobartContract renewContract(String crefno, String emailid) throws SQLException {

		String oldrefno = crefno;
		String newrefrenceno = "";

		stobartContract stbc = null;
		try {

			// Step 1 Creating New Refrence No with the REN and _01 _02 _03.

			if (crefno.contains("R")) {
				String[] crefno1 = crefno.split("_");
				crefno = crefno1[0] + "_" + crefno1[1];

			}

			String viewsql = "SELECT max(renew_count) as renno  FROM  CONTRACT_MASTER where refrence_no like '%"
					+ crefno + "%'";
			int renew_count = jdbcTemplateRefis.queryForObject(viewsql, Integer.class);

			if (!crefno.contains("R")) {
				// First time Renew
				newrefrenceno = crefno + "_REN_" + (++renew_count);
			} else {
				// Second Time On Ward
				String[] refnoarray = crefno.split("_");
				newrefrenceno = "CS_" + refnoarray[1] + "_REN_" + (++renew_count);
			}

			// Step 2 Copying Contract and Create new Entry in the DataBase
			viewsql = "SELECT * FROM  Contract_Master where refrence_no like '" + oldrefno + "'";
			SqlRowSet rs = jdbcTemplateRefis.queryForRowSet(viewsql);
			rs.next();

			DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");
			LocalDateTime currentdateandtime = LocalDateTime.now();

			Connection con2 = dataSourcesqlservercp.getConnection();
			String SQL_ADD = "INSERT INTO  Contract_Master (refrence_no,renew_count,description ,dept_sub_code  , start_date  "
					+ ", end_date  , contractor_name ,contractor_contact_detail  , status  , entered_by_email  , entry_date_time)"
					+ "values (? , ? , ? , ?, ?, ? , ? , ? , ? , ? , ? )";

			PreparedStatement pstm = con2.prepareStatement(SQL_ADD);

			pstm.setString(1, newrefrenceno);
			pstm.setInt(2, renew_count);
			pstm.setString(3, rs.getString("description"));
			pstm.setInt(4, rs.getInt("dept_sub_code"));
			pstm.setString(5, rs.getString("start_date"));
			pstm.setString(6, rs.getString("end_date"));
			pstm.setString(7, rs.getString("contractor_name"));
			pstm.setString(8, rs.getString("contractor_contact_detail"));
			pstm.setString(9, "Active");
			pstm.setString(10, rs.getString("entered_by_email"));
			pstm.setString(11, currentdateandtime.toString());
			int rows = pstm.executeUpdate();
			pstm.close();

			pstm = null;
			con2.close();

			// Step 3 Update Contract Status to Expired
			jdbcTemplateRefis
					.execute("UPDATE  Contract_Master SET   CONTRACT_MASTER.STATUS='Dactive'  where refrence_no='"
							+ crefno + "'");

			// Step 4 View New Contract No
			viewsql = "SELECT CONTRACT_DEPT_SUBDET.DEPARTMENT , CONTRACT_DEPT_SUBDET.SUBDEPARTMENT, CONTRACT_DEPT_SUBDET.DEPARTMENT_CODE , CONTRACT_DEPT_SUBDET.SUBDEPARTMENT_CODE , CONTRACT_MASTER.DEPT_SUB_CODE \r\n"
					+ " , CONTRACT_MASTER.contractor_name , CONTRACT_MASTER.contractor_contact_detail,CONTRACT_MASTER.refrence_no,\r\n"
					+ "   CONTRACT_MASTER.description,CONTRACT_MASTER.status,CONTRACT_MASTER.start_date,CONTRACT_MASTER.end_date,CONTRACT_MASTER.entered_by_email , CONTRACT_ACCESS.is_admin \r\n"
					+ "   FROM CONTRACT_DEPT_SUBDET,CONTRACT_MASTER , CONTRACT_ACCESS \r\n"
					+ "   WHERE CONTRACT_MASTER.DEPT_SUB_CODE = CONTRACT_DEPT_SUBDET.ID "
					+ " AND  CONTRACT_MASTER.DEPT_SUB_CODE = CONTRACT_ACCESS.dept_sub_code  AND CONTRACT_ACCESS.user_email='"
					+ emailid + "' AND " + " CONTRACT_MASTER.refrence_no=?";

			stbc = jdbcTemplateRefis.queryForObject(viewsql, new Object[] { newrefrenceno },
					new stobartContractRowmapper());

		} catch (Exception ex) {
			logger.error("While Renuing Contratc :" + ex.toString());
		}

		return stbc;

	}

	// --------- THIS FUNCTION WILL ADD CONTRACT DETAIL INTO THE DATABASE
	// -----------
	@Override
	public int addNewContract(HttpServletRequest req) throws SQLException {
		int rows = 0;
		try {
			DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");
			LocalDateTime currentdateandtime = LocalDateTime.now();

			String sqlforid = "SELECT id FROM  CONTRACT_DEPT_SUBDET where department_code= ? and subdepartment_code= ?";
			int deptcode = jdbcTemplateRefis.queryForObject(sqlforid, Integer.class, req.getParameter("department"),
					req.getParameter("subdepartment"));

			Connection con1 = dataSourcesqlservercp.getConnection();
			String SQL_ADD = " INSERT INTO  Contract_Master (refrence_no , description ,dept_sub_code  , start_date , end_date  , "
					+ " contractor_name , contractor_contact_detail  , status  , entered_by_email  , updated_by_email , entry_date_time) "
					+ " values (?, ?, ?, ?, ? , ? , ? , ? , ? , ?, ? )";

			PreparedStatement pstm = con1.prepareStatement(SQL_ADD);

			pstm.setString(1, req.getParameter("refno"));
			pstm.setString(2, req.getParameter("cdescription"));
			pstm.setInt(3, deptcode);
			pstm.setString(4, req.getParameter("startDate"));
			pstm.setString(5, req.getParameter("endDate"));
			pstm.setString(6, req.getParameter("ccompany"));
			pstm.setString(7, req.getParameter("ccontract"));
			pstm.setString(8, "Active");
			pstm.setString(9, req.getParameter("emailid"));
			pstm.setString(10, req.getParameter("emailid"));
			pstm.setString(11, currentdateandtime.toString());

			rows = pstm.executeUpdate();

			pstm = null;
			con1.close();

		} catch (Exception ex) {
			logger.error("While Adding Contract :" + ex.toString());
		}

		return rows;
	}

	@Override
	public int updateNewContract(HttpServletRequest req) throws SQLException {

		int rows = 0;
		try {

			DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");
			LocalDateTime currentdateandtime = LocalDateTime.now();
			Connection conn = dataSourcesqlservercp.getConnection();

			// -- FIND DEPT - SUBDEPT CODE
			String sqlfind = "SELECT id FROM  CONTRACT_DEPT_SUBDET where department_code= ? and subdepartment_code= ?";
			int depsubid = jdbcTemplateRefis.queryForObject(sqlfind, Integer.class, req.getParameter("department"),
					req.getParameter("subdepartment"));

			String SQL_UPDATE = "UPDATE  CONTRACT_MASTER SET description=? , dept_sub_code=? , start_date=? "
					+ ", end_date=? , contractor_name=?, contractor_contact_detail=? , status=? , updated_by_email=? , entry_date_time=? WHERE refrence_no=?";

			PreparedStatement pstm = conn.prepareStatement(SQL_UPDATE);
			pstm.setString(1, req.getParameter("cdescription"));
			pstm.setInt(2, depsubid);
			pstm.setString(3, req.getParameter("startDate"));
			pstm.setString(4, req.getParameter("endDate"));
			pstm.setString(5, req.getParameter("ccompany"));
			pstm.setString(6, req.getParameter("ccontract"));
			pstm.setString(7, req.getParameter("status"));
			pstm.setString(8, req.getParameter("emailid"));
			pstm.setString(9, currentdateandtime.toString());
			pstm.setString(10, req.getParameter("refno"));
			rows = pstm.executeUpdate();
			pstm = null;
			conn.close();

		} catch (Exception ex) {
			logger.error("While Updating Contract :" + ex.toString());
		}

		return rows;

	}// ----------- END OF FUNCTION UPDATE NEW CONTRACT

	@Override
	public void removeContract(String refrenceno) {
		try {
			jdbcTemplateRefis.execute("delete from  CONTRACT_MASTER  where refrence_no='" + refrenceno + "'");
		} catch (Exception ex) {
			logger.error("While Deleting Contract :" + ex.toString());
		}
	}

	// ----------- THIS FUNCTION WILL TAKE FOLDER NAME AS INPUT AND RETURN LIST
	// STRING AS FILE NAME IN THERE
	@Value("${stobart.contract.folder}")
	String CONTRACT_DIRECTORY;

	@Override
	public List<String> showFilesFromFolder(String foname) {
		List<String> CfileList = new ArrayList<String>();
		File foldername = new File(CONTRACT_DIRECTORY + "stobart_contract/" + foname + "/");
		if (foldername.isDirectory()) {
			String[] fileList = foldername.list();
			for (String filename : fileList) {
				CfileList.add(filename);
			}
			return CfileList;
		} else {
			return null;
		}

	}// --------- END OF FUNCTION --------------

	// -------- TAKE DIRECTORY AS INPUT AND REMOVE ALL FILE FROM THERE
	@Override
	public boolean removeFolderWithallFile(File dir) {

		if (dir.isDirectory()) {
			File[] children = dir.listFiles();
			for (int i = 0; i < children.length; i++) {
				boolean success = removeFolderWithallFile(children[i]);
				if (!success) {
					return false;
				}
			}
		} // either file or an empty directory

		return dir.delete();
	}

	@Override
	public String populate_Department(String usremail, String dept) throws SQLException {

		String deptSql = null;
		String departmentlistwithcode = null;
		deptSql = "SELECT DISTINCT department_code , department FROM  CONTRACT_DEPT_SUBDET order by department";
		SqlRowSet rs = jdbcTemplateRefis.queryForRowSet(deptSql);
		while (rs.next()) {
			if (dept.equals(rs.getString("department_code").trim())) {
				departmentlistwithcode = departmentlistwithcode + "<option value=" + rs.getString("department_code")
						+ " selected>" + rs.getString("department").trim() + "</option>";
			} else {
				departmentlistwithcode = departmentlistwithcode + "<option value=" + rs.getString("department_code")
						+ ">" + rs.getString("department").trim() + "</option>";
			}

		} // ---------- End Of While Loop

		rs = null;

		return departmentlistwithcode;
	}

	@Override
	public String populate_SubDepartment(String usremail, String dept, String subdept) throws SQLException {

		String subdeptSql = null;
		String subdepartmentlistwithcode = null;
		subdeptSql = "SELECT * FROM  CONTRACT_DEPT_SUBDET  order by subdepartment";

		if (!dept.equals("ALL")) {
			subdeptSql = "SELECT * FROM  CONTRACT_DEPT_SUBDET where department_code='" + dept
					+ "' order by subdepartment";
		}

		SqlRowSet rs = jdbcTemplateRefis.queryForRowSet(subdeptSql);
		while (rs.next()) {

			if (subdept.equals(rs.getString("subdepartment_code").trim())) {
				subdepartmentlistwithcode = subdepartmentlistwithcode + "<option value="
						+ rs.getString("subdepartment_code") + " selected>" + rs.getString("subdepartment").trim()
						+ "</option>";
			} else {
				subdepartmentlistwithcode = subdepartmentlistwithcode + "<option value="
						+ rs.getString("subdepartment_code") + ">" + rs.getString("subdepartment").trim() + "</option>";
			}

		} // ---------- End Of While Loop

		rs = null;

		return subdepartmentlistwithcode;
	}

	@Override
	public List<contractProfile> showProfileListOfUser(String useremailid) {

		String sqlListContract = "SELECT CONTRACT_ACCESS.dept_sub_code, CONTRACT_DEPT_SUBDET.department ,  CONTRACT_DEPT_SUBDET.subdepartment ,  CONTRACT_ACCESS.is_admin ,  \r\n"
				+ "CONTRACT_ACCESS.eligible_for_email_notification  FROM  CONTRACT_ACCESS , CONTRACT_DEPT_SUBDET \r\n"
				+ "where CONTRACT_DEPT_SUBDET.id=CONTRACT_ACCESS.dept_sub_code and CONTRACT_ACCESS.user_email='"
				+ useremailid + "' order by CONTRACT_DEPT_SUBDET.department";
		List profilelist = jdbcTemplateRefis.query(sqlListContract, new contractProfileRowmapper());

		return profilelist;
	}

	@Override
	public int addNewContractProfiletoUser(HttpServletRequest req) throws SQLException {

		int profileid = 0;
		int rows = 0;
		Connection con2 = dataSourcesqlservercp.getConnection();
		Statement sta2 = con2.createStatement();
		ResultSet rs2 = sta2.executeQuery(
				"SELECT id FROM  CONTRACT_DEPT_SUBDET where department_code='" + req.getParameter("department")
						+ "' and subdepartment_code='" + req.getParameter("subdepartment") + "'");
		if (rs2.next()) {
			profileid = rs2.getInt("id");
		}

		rs2 = sta2.executeQuery("SELECT id FROM  CONTRACT_ACCESS where dept_sub_code=" + profileid + " and user_email='"
				+ req.getParameter("userid") + "'");

		// ------- Check if this profile allReady exist ----------
		if (rs2.next()) {
			rows = 0;
		} else {

			String SQL_ADD = "INSERT INTO  CONTRACT_ACCESS(dept_sub_code,user_email,is_admin,eligible_for_email_notification)"
					+ "values (?, ?,?,?)";
			PreparedStatement pstm = con2.prepareStatement(SQL_ADD);
			pstm.setInt(1, profileid);
			pstm.setString(2, req.getParameter("userid"));
			pstm.setString(3, req.getParameter("admin"));
			pstm.setString(4, req.getParameter("eligible_for_email_notification"));
			rows = pstm.executeUpdate();

		}

		con2.close();
		return rows;

	}

	@Override
	public void removeContractProfileofUser(int profileid, String useremailid) throws SQLException {

		jdbcTemplateRefis.execute(
				"delete from  CONTRACT_ACCESS where user_email='" + useremailid + "' and dept_sub_code=" + profileid);
	}

	// ---- This function will add file to the database -------------------------
	@Override
	public void appenFiletoDataBase(HttpServletRequest req, @RequestParam("photo") MultipartFile file)
			throws IOException, ServletException, SQLException {
		// TODO Auto-generated method stub
		Connection conn = null;
		try {
			conn = dataSourcesqlservercp.getConnection();

			String firstName = req.getParameter("firstName");
			String lastName = req.getParameter("lastName");

			InputStream inputStream = null; // input stream of the upload file

			// obtains the upload file part in this multipart request
			Part filePart = req.getPart("photo");
			if (file != null) {
				// prints out some information for debugging
				System.out.println(file.getOriginalFilename());
				System.out.println(file.getSize());
				System.out.println(file.getContentType());

				// obtains input stream of the upload file
				inputStream = file.getInputStream();
			}

			// constructs SQL statement
			String sql = "INSERT INTO contacts (first_name, last_name, photo) values (?, ?, ?)";
			PreparedStatement statement = conn.prepareStatement(sql);
			statement.setString(1, firstName);
			statement.setString(2, lastName);
			statement.setBlob(3, inputStream);

			// sends the statement to the database server
			int row = statement.executeUpdate();
			if (row > 0) {
				String message = "File uploaded and saved into database";
				System.out.println(message);
			}

		} catch (SQLException e) {
			logger.error(e.toString());
		} finally {
			conn.close();
		}

	}// --------- END OF MAIN FUNCTION -----------

}// --- END OF MAIN CLASS ------------------
