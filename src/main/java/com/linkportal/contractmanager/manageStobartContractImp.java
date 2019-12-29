package com.linkportal.contractmanager;

import java.io.BufferedInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Connection;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import javax.servlet.http.HttpServletRequest;
import javax.sql.DataSource;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.support.rowset.SqlRowSet;
import org.springframework.stereotype.Repository;

import com.linkportal.staffTravel.manageStaffTravelUserImp;

@Repository
public class manageStobartContractImp implements manageStobartContract{
	
	@Autowired
	DataSource dataSourcemysql;
	

	JdbcTemplate jdbcTemplateRefis;	
	
	

    
	
	

	public manageStobartContractImp(DataSource dataSourcemysql) {		
		   
		   jdbcTemplateRefis = new JdbcTemplate(dataSourcemysql);
		   
		   
	}
	
	
	
     
	
	
    // -------------  THIS WILL SHOW THE LIST OF CONTRACT --------------- 
	@Override
	public List<stobartContract> showAllContract(String emailid ,String dept, String subdept) {		
		    
		
		String sqlListContract="SELECT CONTRACT_DEPT_SUBDET.DEPARTMENT , CONTRACT_DEPT_SUBDET.SUBDEPARTMENT, CONTRACT_DEPT_SUBDET.DEPARTMENT_CODE , CONTRACT_DEPT_SUBDET.SUBDEPARTMENT_CODE , CONTRACT_MASTER.DEPT_SUB_CODE \r\n" + 
				" , CONTRACT_MASTER.contractor_name , CONTRACT_MASTER.contractor_contact_detail,CONTRACT_MASTER.refrence_no,\r\n" + 
				"   CONTRACT_MASTER.description,CONTRACT_MASTER.status,CONTRACT_MASTER.start_date,CONTRACT_MASTER.end_date,CONTRACT_MASTER.entered_by_email\r\n" + 
				"   FROM CONTRACT_DEPT_SUBDET,CONTRACT_MASTER\r\n" + 
				"   WHERE CONTRACT_MASTER.DEPT_SUB_CODE=CONTRACT_DEPT_SUBDET.ID  and  CONTRACT_MASTER.entered_by_email='"+emailid+"'";
		
		String andSql=" ";
		   
		   
		   
	   if(!dept.equals("ALL")){
		   andSql = andSql + "and CONTRACT_MASTER.dept_sub_code in (SELECT id FROM CORPORATE_PORTAL.CONTRACT_DEPT_SUBDET where department_code='"+dept+"')";
		   if(!subdept.equals("ALL")){
			   andSql = andSql + "and CONTRACT_MASTER.dept_sub_code in (SELECT id FROM CORPORATE_PORTAL.CONTRACT_DEPT_SUBDET where department_code='"+dept+"' and subdepartment_code='"+subdept+"')";
			   
		   }
		   
	   }
	
		   sqlListContract=sqlListContract+andSql;
		   sqlListContract=sqlListContract+" order by CONTRACT_MASTER.entry_date_time desc ";		   
	
		   List  Contract = jdbcTemplateRefis.query(sqlListContract,new stobartContractRowmapper());
		
		return Contract;
	}
	
	
	
	
	
	


	// -------------  THIS WILL SHOW ONE CONTRACT --------------- 
	@Override
	public stobartContract viewContract(String crefno) {
			
		 String viewsql="SELECT CONTRACT_DEPT_SUBDET.DEPARTMENT , CONTRACT_DEPT_SUBDET.SUBDEPARTMENT ,CONTRACT_DEPT_SUBDET.DEPARTMENT_CODE , CONTRACT_DEPT_SUBDET.SUBDEPARTMENT_CODE ,CONTRACT_MASTER.DEPT_SUB_CODE , \r\n" + 
		 		"CONTRACT_MASTER.contractor_name , CONTRACT_MASTER.contractor_contact_detail,CONTRACT_MASTER.refrence_no, \r\n" + 
		 		"CONTRACT_MASTER.description,CONTRACT_MASTER.status,CONTRACT_MASTER.start_date,CONTRACT_MASTER.end_date,\r\n" + 
		 		"CONTRACT_MASTER.entered_by_email \r\n" + 
		 		"FROM CONTRACT_DEPT_SUBDET,CONTRACT_MASTER WHERE \r\n" + 
		 		"CONTRACT_MASTER.DEPT_SUB_CODE=CONTRACT_DEPT_SUBDET.ID and  \r\n" + 
		 		"CONTRACT_MASTER.refrence_no=?";
		
		 return jdbcTemplateRefis.queryForObject(viewsql, new Object[]{crefno}, new stobartContractRowmapper());	    
	
	}



	
	
	
	
	
	
    //--------- THIS FUNCTION WILL ADD CONTRACT DETAIL INTO THE DATABASE -----------
	@Override
	public int addNewContract(HttpServletRequest req) throws SQLException {
		
		   DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");		   
		   LocalDateTime currentdateandtime = LocalDateTime.now();
		   
		   String sqlforid="SELECT id FROM CORPORATE_PORTAL.CONTRACT_DEPT_SUBDET where department_code='"+req.getParameter("department")+"' and subdepartment_code='"+req.getParameter("subdepartment")+"'";		   
		   SqlRowSet row =  jdbcTemplateRefis.queryForRowSet(sqlforid);		   
		   row.next();	  

	
		   Connection con1= dataSourcemysql.getConnection();
		   String SQL_ADD = "INSERT INTO CORPORATE_PORTAL.CONTRACT_MASTER (refrence_no,description ,dept_sub_code  , start_date  "
			   		+ ", end_date  , contractor_name ,contractor_contact_detail  , status  , entered_by_email  , entry_date_time)"
			   		+ "value (?, ?, ?, ?, ? , ? , ? , ? , ? , ? )";
		   
		   PreparedStatement pstm = con1.prepareStatement(SQL_ADD);
		       pstm.setString(1,req.getParameter("refno"));
			   pstm.setString(2,req.getParameter("cdescription"));
			   pstm.setInt(3,row.getInt("ID"));				  
			   pstm.setString(4,req.getParameter("startDate"));
			   pstm.setString(5,req.getParameter("endDate"));
			   pstm.setString(6,req.getParameter("ccompany"));
			   pstm.setString(7,req.getParameter("ccontract"));
			   pstm.setString(8,"Active");
			   pstm.setString(9,req.getParameter("emailid"));	    
			   pstm.setString(10,currentdateandtime.toString());			
		       int rows = pstm.executeUpdate();
	       pstm=null;
	       con1.close();
	      		   
		return rows;
	}

	
	
	
	
	
	
	@Override
	public int updateNewContract(HttpServletRequest req) throws SQLException {

		   int rows = 0;
		   DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");
		   LocalDateTime currentdateandtime = LocalDateTime.now();		   
		   Connection conn= dataSourcemysql.getConnection();		   
		   
		   
		   
		   String sqlfind="SELECT id FROM CORPORATE_PORTAL.CONTRACT_DEPT_SUBDET where department_code='"+req.getParameter("department")+"' and subdepartment_code='"+req.getParameter("subdepartment")+"'";		   
		   SqlRowSet rowst =  jdbcTemplateRefis.queryForRowSet(sqlfind);		   
		   rowst.next();	  

		   String SQL_UPDATE = "UPDATE CORPORATE_PORTAL.CONTRACT_MASTER SET description=? , dept_sub_code=? , start_date=? "
		   		+ ", end_date=? , contractor_name=?, contractor_contact_detail=? , status=? , entered_by_email=? , entry_date_time=? WHERE refrence_no=?";
		   
		   PreparedStatement pstm = conn.prepareStatement(SQL_UPDATE);
			   pstm.setString(1,req.getParameter("cdescription"));
			   pstm.setInt(2,rowst.getInt("ID"));			  
			   pstm.setString(3,req.getParameter("startDate"));
			   pstm.setString(4,req.getParameter("endDate"));
			   pstm.setString(5,req.getParameter("ccompany"));
			   pstm.setString(6,req.getParameter("ccontract"));
			   pstm.setString(7,req.getParameter("status"));
			   pstm.setString(8,req.getParameter("emailid"));	    
			   pstm.setString(9,currentdateandtime.toString());
			   pstm.setString(10,req.getParameter("refno"));
		   rows = pstm.executeUpdate();
		   pstm = null;
			
		
		return rows;	
			
	}//----------- END OF FUNCTION UPDATE NEW CONTRACT 
	
	
	
	
	

	
	
	@Override
	public void removeContract(String refrenceno) {
		// TODO Auto-generated method stub		
		jdbcTemplateRefis.execute("delete from CORPORATE_PORTAL.CONTRACT_MASTER  where refrence_no='"+refrenceno+"'");
	}




    //----------- THIS FUNCTION WILL TAKE FOLDER NAME AS INPUT AND RETURN LIST STRING AS FILE NAME IN THERE  
	@Value("${stobart.contract.folder}") String CONTRACT_DIRECTORY;
	@Override
	public List<String> showFilesFromFolder(String foname) {	
		   List<String> CfileList = new ArrayList<String>();
		   File foldername = new File(CONTRACT_DIRECTORY+"stobart_contract/"+foname+"/"); 
		   if(foldername.isDirectory()) {
			   String[] fileList = foldername.list();
			   for (String filename : fileList) {
				   CfileList.add(filename);
			   }
			   return CfileList;
		   }
		   else
		   {
			   return null; 
		   }
		   

		
	}//--------- END OF FUNCTION --------------





	 //-------- TAKE DIRECTORY AS INPUT AND REMOVE ALL FILE FROM THERE 
	@Override
	public boolean removeFolderWithallFile(File dir) {
		   
	   	 if (dir.isDirectory()) { 
    		 File[] children = dir.listFiles(); 
    		 for (int i = 0; i < children.length; i++) { 
    			 boolean success = removeFolderWithallFile(children[i]); 
    			 if (!success) { return false; } 
    			 }
    		 } // either file or an empty directory 
    	   
    	    return dir.delete();
	}









	@Override
	public String populate_Department(String usremail,String dept) throws SQLException{
		
		   String deptSql=null;
		   String departmentlistwithcode=null;
		   deptSql         = "SELECT DISTINCT department_code , department FROM CORPORATE_PORTAL.CONTRACT_DEPT_SUBDET order by department";		   
		   SqlRowSet rs =  jdbcTemplateRefis.queryForRowSet(deptSql);		   			   
		   while(rs.next()){
			     if(dept.trim().equals(rs.getString("department_code").trim())) {			    	
			    	 departmentlistwithcode=departmentlistwithcode+"<option value="+rs.getString("department_code")+" selected>"+rs.getString("department").trim()+"</option>";
			     }
			     else
			     {
			    	 departmentlistwithcode=departmentlistwithcode+"<option value="+rs.getString("department_code")+">"+rs.getString("department").trim()+"</option>";
			     }
				
		   }//---------- End Of While Loop 
		
	
		   rs=null;
		   
		
		return departmentlistwithcode;
	}






	@Override
	public String populate_SubDepartment(String usremail, String dept , String subdept) throws SQLException{
		
		   String subdeptSql=null;
		   String subdepartmentlistwithcode=null;
		   subdeptSql = "SELECT * FROM CORPORATE_PORTAL.CONTRACT_DEPT_SUBDET  order by subdepartment";
		   if(!dept.equals("ALL")){	
		       subdeptSql = "SELECT * FROM CORPORATE_PORTAL.CONTRACT_DEPT_SUBDET where department_code='"+dept+"' order by subdepartment";
	       }
	
		   
		   SqlRowSet rs =  jdbcTemplateRefis.queryForRowSet(subdeptSql);
		   while(rs.next()){			     
			 
			     if(subdept.trim().equals(rs.getString("subdepartment_code").trim())) {			    	
			    	 subdepartmentlistwithcode=subdepartmentlistwithcode+"<option value="+rs.getString("subdepartment_code")+" selected>"+rs.getString("subdepartment").trim()+"</option>";
			     }
			     else
			     {
			    	 subdepartmentlistwithcode=subdepartmentlistwithcode+"<option value="+rs.getString("subdepartment_code")+">"+rs.getString("subdepartment").trim()+"</option>";
			     }
				
		   }//---------- End Of While Loop 
		   rs=null;
		   
		   
		
		return subdepartmentlistwithcode;
	}






	@Override
	public List<contractProfile> showProfileListOfUser(String useremailid) {
		
	          
	   String  sqlListContract="SELECT CONTRACT_ACCESS.dept_sub_code, CONTRACT_DEPT_SUBDET.department ,  CONTRACT_DEPT_SUBDET.subdepartment ,  CONTRACT_ACCESS.is_admin \r\n" + 
	     		"FROM CORPORATE_PORTAL.CONTRACT_ACCESS , CONTRACT_DEPT_SUBDET \r\n" + 
	     		"where CONTRACT_DEPT_SUBDET.id=CONTRACT_ACCESS.dept_sub_code and CONTRACT_ACCESS.user_email='"+useremailid+"' order by CONTRACT_DEPT_SUBDET.department";    
	 	        List  profilelist = jdbcTemplateRefis.query(sqlListContract,new contractProfileRowmapper());
		
		return profilelist;
	}






	@Override
	public int addNewContractProfiletoUser(HttpServletRequest req) throws SQLException {
		   
		   int profileid=0;
		   int rows =0;
		   Connection con2= dataSourcemysql.getConnection();
		   Statement sta2 = con2.createStatement();
		   ResultSet rs2 = sta2.executeQuery("SELECT id FROM CORPORATE_PORTAL.CONTRACT_DEPT_SUBDET where department_code='"+req.getParameter("department")+"' and subdepartment_code='"+req.getParameter("subdepartment")+"'");		   
	       if(rs2.next()) {profileid=rs2.getInt("id");}
		   
		   rs2 = sta2.executeQuery("SELECT id FROM CORPORATE_PORTAL.CONTRACT_ACCESS where dept_sub_code="+profileid+" and user_email='"+req.getParameter("userid")+"'");		   
          
		   //------- Check if this profile allReady exist ----------
		   if(rs2.next()){
			   rows=0;
		   }
		   else 
		   {
		       
			   String SQL_ADD = "INSERT INTO CORPORATE_PORTAL.CONTRACT_ACCESS(dept_sub_code,user_email,is_admin)"
				   		+ "value (?, ?, ?)";			   
			   PreparedStatement pstm = con2.prepareStatement(SQL_ADD);		       
				   pstm.setInt(1,profileid);
				   pstm.setString(2,req.getParameter("userid"));
				   pstm.setString(3,req.getParameter("admin"));
			       rows = pstm.executeUpdate();
			       
			}
		   
		con2.close();    	   
		return rows;
		
	}






	@Override
	public void removeContractProfileofUser(int profileid, String useremailid) throws SQLException {		
		
	  	   jdbcTemplateRefis.execute("delete from CORPORATE_PORTAL.CONTRACT_ACCESS where user_email='"+useremailid+"' and dept_sub_code="+profileid);
	}
   
	
   
}







