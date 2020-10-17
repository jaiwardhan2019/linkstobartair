package com.linkportal;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.attribute.BasicFileAttributes;
import java.nio.file.attribute.FileTime;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.concurrent.TimeUnit;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;

import com.linkportal.docmanager.DocumentEntity;
import com.linkportal.docmanager.documentManager;

public class listAlfrescoFileFromFolder {

	
	public static void main(String[] args) {
	
		 File file = new File("C:\\data\\groundops\\alfresco\\FlightOperations\\CCM\\HACCPMANUAL\\test.pdf");
		 Path filePath = file.toPath();
		
		  BasicFileAttributes attributes = null;
	        try
	        {
	            attributes =  Files.readAttributes(filePath, BasicFileAttributes.class);
	       	         
	            
	        }
	        catch (IOException exception){System.out.println("Exception handled when trying to get file " + "attributes: " + exception.getMessage());}

	        long milliseconds = attributes.creationTime().to(TimeUnit.MILLISECONDS);
	        if((milliseconds > Long.MIN_VALUE) && (milliseconds < Long.MAX_VALUE))
	        {
	            Date creationDate =
	                    new Date(attributes.creationTime().to(TimeUnit.MILLISECONDS));

	            System.out.println(creationDate.getDate() + "-" + (creationDate.getMonth() + 1) + "-" + (creationDate.getYear() + 1900));
	        }
	        
	        
		}

			
		
	}
	
	
