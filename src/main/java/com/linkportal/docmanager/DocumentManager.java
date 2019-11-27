package com.linkportal.docmanager;

import java.util.Collection;
import java.io.InputStream;
import java.io.IOException;

public interface DocumentManager {
	
	public static final String ORDER_BY_FILENAME      = "FILE_NAME"; 
	public static final String ORDER_BY_CREATED_DATE  = "CREATED_DATE";
	public static final String ORDER_BY_MODIFIED_DATE = "MODIFIED_DATE";
	
	public static final String DEFAULT_ORDERING = ORDER_BY_FILENAME;
	

	/*
	 *  Get List of files in given folder. 
	 */
	public Collection<String> getFileList(String folder) throws IOException;
	
	public Collection<String> getFileList(String folder, int maxFileListLength) throws IOException;
	
	public Collection<String> getFileList(String folder, boolean includeDirectories) throws IOException;
	
	public Collection<String> getFileList(String folder, boolean includeDirectories, boolean includeFullPaths) throws IOException;
	
	public Collection<String> getFileList(String folder, int maxFileListLength, boolean includeDirectories, boolean includeFullPaths) throws IOException;
		
	
	public Collection<String> getFileList(String folder, String ORDER_BY, boolean ascending) throws IOException;
	
	public Collection<String> getFileList(String folder, int maxFileListLength, String ORDER_BY, boolean ascending) throws IOException;
	
	public Collection<String> getFileList(String folder, boolean includeDirectories, String ORDER_BY, boolean ascending) throws IOException;
	
	public Collection<String> getFileList(String folder, boolean includeDirectories, boolean includeFullPaths, String ORDER_BY, boolean ascending) throws IOException;
	
	public Collection<String> getFileList(String folder, int maxFileListLength, boolean includeDirectories, boolean includeFullPaths, String ORDER_BY, boolean ascending) throws IOException;
	
	
	
	public boolean isFilePathExisting(String filePath);
	
	public boolean isFile(String filePath) throws IOException;
		
	public boolean isDirectory(String filePath) throws IOException;
	
	//public String getFileNameFromPath(String filePath);
	
	public InputStream getFile(String filePath) throws IOException;
	
	
	public String getDocPath();
	
	public void setDocPath(String docPath);
	
	
}
