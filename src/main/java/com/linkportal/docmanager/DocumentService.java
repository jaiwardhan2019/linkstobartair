package com.linkportal.docmanager;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.linkportal.exceptions.RecordNotFoundException;



@Service
public class DocumentService {
	
	@Autowired
	documentManager repository;
	
	
	public boolean addUploadFiletoDatabaseAndFolder(HttpServletRequest req,MultipartFile file) throws IOException, SQLException{
		   if(repository.addDocumentToFolder(req,file)) { return true; } else  { return false;}
	}
	
	
	public List<DocumentEntity> getAllDocuments(HttpServletRequest req, String department){		
		   List<DocumentEntity> result =  repository.showAllDocumentsFromFolder(req, department);
		   return result;
	}


	public boolean deleteDocumentById(int id) throws IOException, SQLException{	
		   return repository.removeDocumentFromFolder(id);
	} 
	
		
	

}