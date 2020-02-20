package com.linkportal.docmanager;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;



public class DocumentEntityRowmapper implements  RowMapper<DocumentEntity> {
        
	@Override
	public DocumentEntity mapRow(ResultSet rs, int rowNum) throws SQLException {
		
		DocumentEntity docobject = new DocumentEntity(				
				rs.getInt("doc_id"),
				rs.getString("doc_name"),
				rs.getString("doc_description"),
				rs.getString("doc_type"),
				rs.getString("doc_path"),
				rs.getString("doc_department"),
				rs.getString("doc_category"),
				rs.getString("doc_added_date"),
				rs.getString("doc_addedby_name")
				);
	
		return docobject;

	    }
		
   
}