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
	
	
	
	
	
	
	
	
	
	public List<DocumentEntity> getAllDocuments(HttpServletRequest req, String department)
	{
		
		List<DocumentEntity> result =  repository.showAllDocumentsFromFolder(req, department);
		
       
		   
		
		/*
		List<DocumentEntity> result = (List<DocumentEntity>) repository.findAll();
		
		
		List<DocumentEntity> result = repository
		
		
		if(result.size() > 0) {
			return result;
		} else {
			return new ArrayList<DocumentEntity>();
		}
		*/
		return result;
	}

	
	
	/*
	
	public DocumentEntity getDocumentById(Long id) throws RecordNotFoundException 
	{
		Optional<DocumentEntity> employee = repository.findById(id);
		
		if(employee.isPresent()) {
			return employee.get();
		} else {
			throw new RecordNotFoundException("No document record exist for given id");
		}
		
	}
	
	*/
	
	
	
	
	
	
	
	
	public void deleteDocumentById(Long id) throws RecordNotFoundException 
	{
		/*
		Optional<DocumentEntity> employee = repository.findById(id);
		
		if(employee.isPresent()) 
		{
			repository.deleteById(id);
		} else {
			throw new RecordNotFoundException("No document record exist for given id");
		}
       */
	} 

	
	

}