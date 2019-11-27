package com.linkportal.docmanager;


import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FilenameUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.http.MediaType;
import org.springframework.web.servlet.HandlerMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.AbstractController;

import com.linkportal.docmanager.DocumentManager;


public class DocumentController extends AbstractController {
	
	private static Log log = LogFactory.getLog(DocumentController.class.getName());
	
	public final static int DEFAULT_FILE_BUFFER_SIZE = 4096;
	public final static String PARENT_FILE_PATH = "parentFilePath";
	public final static String FILE_PATH = "filePath";
	
	public final static String FILES_LIST = "filesList";
	public final static String ONLY_FILES_LIST = "onlyFilesList";
	public final static String ONLY_FOLDERS_LIST = "onlyFoldersList";
	
	protected DocumentManager documentManager;
	
	protected String rootDir;
	
	protected int fileBufferSize;
	
	private String orderBy = null;
	private boolean reverseOrder; //AscendingByDefault
	
	private boolean includeFolders;
	private boolean inline;
	
	
	public DocumentController() {
		this.rootDir = "/";
		this.fileBufferSize = DEFAULT_FILE_BUFFER_SIZE;
		this.orderBy = null;
		this.reverseOrder = false; //AscendingByDefault
		this.includeFolders = false;
		this.inline = false;
	}
	
	
	public void logResponseHeaders( HttpServletResponse response) {
		
		Map<String, Collection<String>> headerMap = new HashMap<String, Collection<String>>();
		
		for (Iterator<String> it = response.getHeaderNames().iterator(); it.hasNext();){
			String headerName = it.next();
			headerMap.put(headerName, response.getHeaders( headerName));
		}
		
		logger.debug("Headers in HttpResponse: " + headerMap);
	}
	
	
	public void setDocumentManager(DocumentManager documentManager) {
		this.documentManager = documentManager;
	}
	
	
	public String getOrderBy() {
		return orderBy;
	}
	
	
	public void setOrderBy(String orderBy) {
		this.orderBy = orderBy;
	}
	
	
	public boolean isReverseOrder() {
		return reverseOrder;
	}
	
	
	public void setReverseOrder(boolean reverseOrder) {
		this.reverseOrder = reverseOrder;
	}
	
	
	/**
	 * @return the includeFolders
	 */
	public boolean isIncludeFolders() {
		return includeFolders;
	}


	/**
	 * @param includeFolders the includeFolders to set
	 */
	public void setIncludeFolders(boolean includeFolders) {
		this.includeFolders = includeFolders;
	}


	public boolean isInline() {
		return inline;
	}


	public void setInline(boolean inline) {
		this.inline = inline;
	}


	protected Collection<String> getFolderContents(String folder) throws IOException {
		
		Collection<String> files = null;

		if ((this.orderBy == null) || (this.orderBy.equals(""))) {
			files = this.documentManager.getFileList(folder, this.includeFolders);
		} else {
			files = this.documentManager.getFileList(folder, this.includeFolders);
		}
			
		return files;
	}
	
	
	protected String getParentUrl(boolean addUrlPrefix, String filePath) {
		
		String tmp_parentPath = this.rootDir;
		//if not null then set path to be input filePath
		if (filePath != null) {
			tmp_parentPath = filePath;
		}
		
		//Add UrlPrefix for virtual directories
		if (addUrlPrefix) {
			tmp_parentPath = String.valueOf(new File(this.rootDir, tmp_parentPath));
		}
		
		
		String parentPath = null;
		File parentFile = new File(tmp_parentPath).getParentFile();
		if (parentFile != null) {
			parentPath = String.valueOf(parentFile);
			parentPath = parentPath.replace("\\", "/");
		}
		
		log.debug("getParentUrl :" + parentPath);
		return parentPath;
	}
	
	
	public int getFileBufferSize() {
		return fileBufferSize;
	}
	
	
	protected void downloadFile (String filePath, HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		InputStream inputStream = this.documentManager.getFile(filePath);
		
		String fileName = FilenameUtils.getName(filePath);
		
		response.setHeader("Cache-Control", "must-revalidate, post-check=0, pre-check=0");
		response.setHeader("Pragma", "no-cache");
		response.setHeader("Expires", "0");
		
		
		String contentType = "";
		if (this.isInline()) {
			logger.debug("Content-Disposition\", \"inline; filename=\"" + fileName + "\"");
			response.setHeader("Content-Disposition", "inline; filename=\"" + fileName + "\"");
			
			contentType = request.getServletContext().getMimeType(fileName);
			
		} else {
			logger.debug("Content-Disposition\", \"attachment; filename=\"" + fileName + "\"");
			response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\"");
			
			//Content Type Set to Octet Stream will force the browser to display download prompt, even in places where there is a PDF plugin
			contentType = MediaType.APPLICATION_OCTET_STREAM_VALUE;
		}
		
		logger.debug("ContentType Set: " + contentType);
		response.setContentType( contentType );
		
		this.logResponseHeaders( response );
		
		
		copy(inputStream, response.getOutputStream());
	}

	
	/**
     * Copy bytes from an <code>InputStream</code> to an
     * <code>OutputStream</code>.
     *
     * @param input  The <code>InputStream</code> to read from.
     * @param output The <code>OutputStream</code> to write to.
     * @return the number of bytes copied
     * @throws IOException In case of an I/O problem
     */
    protected int copy(InputStream input, OutputStream output)
        throws IOException {
        byte[] buffer = new byte[this.fileBufferSize];
        int count = 0;
        int n = 0;

        while (-1 != (n = input.read(buffer))) {
            output.write(buffer, 0, n);
            count += n;
        }

        return count;
    }
	
    
    public static List<String> getFoldersFromFileList( Collection<String> fileList){
		
		List<String> folders = new ArrayList<String>();
		
		for (Iterator<String> it = fileList.iterator(); it.hasNext();) {
			String fileName = it.next();
			
			if (fileName.endsWith("/")) {
				folders.add( fileName );
			}
		}
		
		return folders;
	}
	
	

	public static List<String> getFilesFromFileList( Collection<String> fileList){
		
		List<String> files = new ArrayList<String>();
		
		for (Iterator<String> it = fileList.iterator(); it.hasNext();) {
			String fileName = it.next();
			
			if (!fileName.endsWith("/")) {
				files.add( fileName );
			}
		}
		
		
		return files;
	}
	
	
	protected ModelAndView handleRequestInternal(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String filePath = String.valueOf(request.getAttribute( HandlerMapping.PATH_WITHIN_HANDLER_MAPPING_ATTRIBUTE ));
		
		request.setAttribute("filePath", filePath);
		
		request.setAttribute("includeFolders", this.includeFolders);
		
		try {
			if (this.documentManager.isFile(filePath)){
				logger.debug("Retrieve File: " + filePath);
				downloadFile(filePath, request, response);
				return null;
			} else { 
			
				logger.debug("Retrieve Folder: " + filePath);
				Collection<String> filesList = getFolderContents(filePath);
				request.setAttribute( FILES_LIST , filesList);
				request.setAttribute( ONLY_FILES_LIST , getFilesFromFileList(filesList) );
				request.setAttribute( ONLY_FOLDERS_LIST , getFoldersFromFileList(filesList) );
			}
		} catch (Exception ex) {
			logger.debug("File/Folder Not Found: " + filePath);
		}
		
		return new ModelAndView("documentation.folderView");
    }
	
}
