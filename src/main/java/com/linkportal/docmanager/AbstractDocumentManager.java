package com.linkportal.docmanager;

import java.io.IOException;
import java.util.Collection;

public abstract class AbstractDocumentManager implements DocumentManager {
	
	private String docPath;
	
	public AbstractDocumentManager() {
		this.docPath = "/";
	}
	

	public String getDocPath() {
		return docPath;
	}
	
	public void setDocPath(String docPath) {
		this.docPath = docPath;
	}
	
	/*
	 * Returns a collection of Filenames in the given folder. By Default this is set to exclude
	 * Directory names
	 * @see com.aerarann.commons.document.manager.DocumentManager#getFileList(java.lang.String)
	 */
	public final Collection<String> getFileList(String folder) throws IOException {
		return getFileList(folder, DEFAULT_ORDERING, true);
	}
	
	public Collection<String> getFileList(String folder, String ORDER_BY, boolean ascending) throws IOException {
		return getFileList(folder, -1, ORDER_BY, ascending);
	}

	
	public final Collection<String> getFileList(String folder, int maxListLength) throws IOException {
		return getFileList(folder, maxListLength, DEFAULT_ORDERING, true);
	}
	
	
	public Collection<String> getFileList(String folder, int maxListLength, String ORDER_BY, boolean ascending) throws IOException {
		return getFileList(folder, maxListLength, false, false, ORDER_BY, ascending);
	}

	
	
	public final Collection<String> getFileList(String folder, boolean includeDirectories) throws IOException {
		return getFileList(folder, includeDirectories, false, DEFAULT_ORDERING, true);
	}

	
	public Collection<String> getFileList(String folder, boolean includeDirectories, String ORDER_BY, boolean ascending) throws IOException {
		return getFileList(folder, includeDirectories, false, ORDER_BY, ascending);
	}

	
	
	
	public final Collection<String> getFileList(String folder, boolean includeDirectories, boolean includeFullPaths) throws IOException {
		return getFileList(folder, -1, includeDirectories, includeFullPaths);
	}

	
	public Collection<String> getFileList(String folder, boolean includeDirectories, boolean includeFullPaths, String ORDER_BY, boolean ascending) throws IOException {
		return getFileList(folder, -1, includeDirectories, includeFullPaths, DEFAULT_ORDERING, ascending);
	}
	
	
	public Collection<String> getFileList(String folder, int maxListLength, boolean includeDirectories, boolean includeFullPaths) throws IOException {
		
		return getFileList(folder, maxListLength, includeDirectories, includeFullPaths, DEFAULT_ORDERING, true);
	}
	
	
	public abstract Collection<String> getFileList(String folder, int maxListLength, boolean includeDirectories, boolean includeFullPaths, String ORDER_BY, boolean ascending) throws IOException;
	
	
}
