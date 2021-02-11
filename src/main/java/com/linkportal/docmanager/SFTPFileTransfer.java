package com.linkportal.docmanager;
import java.util.Collection;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Value;

import com.google.common.base.Splitter;
import com.google.common.base.Strings;
import com.jcraft.jsch.*;


//https://mkyong.com/java/jsch-unknownhostkey-exception/  
public class SFTPFileTransfer {

	
    private String REMOTE_HOST; 
    private String USERNAME;
    private String PASSWORD; 
    private int REMOTE_PORT;
    private String KNOWN_HOST;

    
	
	SFTPFileTransfer(String REMOTE_HOST , String USERNAME ,  String PASSWORD , int REMOTE_PORT , String KNOWN_HOST){
		
		this.REMOTE_HOST=REMOTE_HOST;
		this.USERNAME=USERNAME;
		this.PASSWORD=PASSWORD;
		this.REMOTE_PORT=REMOTE_PORT;
		this.KNOWN_HOST=KNOWN_HOST;
		
		
	}

	
	
	
	//---------------- LOGGER------------------------------
	private static final Logger logger = Logger.getLogger(SFTPFileTransfer.class);

    void transferFileFromLocalToRemote(String localFileFullPath , String targetFolder ,String fileName ) {

        Session jschSession = null;

        try {

            //--- Steup Connection and Open Channel With the Remote Server
        	JSch jsch = new JSch();
            jsch.setKnownHosts(KNOWN_HOST);
            jschSession = jsch.getSession(USERNAME, REMOTE_HOST, REMOTE_PORT);
            jschSession.setPassword(PASSWORD);
            jschSession.connect();
            Channel sftp = jschSession.openChannel("sftp");
            sftp.connect();
            ChannelSftp channelSftp = (ChannelSftp) sftp;
            
            // download file from remote server to local
            // channelSftp.get(remoteFile, localFile);  
            
            //-- Empty  Folder Content 
            DeleteAllFileFromTargetFolder(channelSftp, targetFolder);
            
           if(!Strings.isNullOrEmpty(fileName)) {
            //-- Copy file from local to remote location
            channelSftp.put(localFileFullPath, targetFolder+fileName); 
            channelSftp.exit();
           }
            
            

        } catch (JSchException | SftpException e) {logger.error("While Movig File from Local to flightops2 box :"+e);} 
          finally {if (jschSession != null) {jschSession.disconnect();}}
       
    }//------ End Of Method 
    
    
    
    
    
    
    
    
    @SuppressWarnings("unchecked")
    private static void DeleteAllFileFromTargetFolder(ChannelSftp channelSftp, String path) throws SftpException {
        // List source directory structure.
        Collection<ChannelSftp.LsEntry> fileAndFolderList = channelSftp.ls(path);

        // Iterate objects in the list to get file/folder names.
        for (ChannelSftp.LsEntry item : fileAndFolderList) {
            if (!item.getAttrs().isDir()) {
                channelSftp.rm(path + "/" + item.getFilename()); // Remove file.
            } 
        }
        
    }
    
    
    
    
    
    
    
    
    @SuppressWarnings("unchecked") // Removing Directory Content and their subdirectory
    private static void recursiveFolderDelete(ChannelSftp channelSftp, String path) throws SftpException {

        // List source directory structure.
        Collection<ChannelSftp.LsEntry> fileAndFolderList = channelSftp.ls(path);

        // Iterate objects in the list to get file/folder names.
        for (ChannelSftp.LsEntry item : fileAndFolderList) {
            if (!item.getAttrs().isDir()) {
                channelSftp.rm(path + "/" + item.getFilename()); // Remove file.
            } else if (!(".".equals(item.getFilename()) || "..".equals(item.getFilename()))) { // If it is a subdir.
                try {
                    // removing sub directory.
                    channelSftp.rmdir(path + "/" + item.getFilename());
                } catch (Exception e) { // If subdir is not empty and error occurs.
                    // Do lsFolderRemove on this subdir to enter it and clear its contents.
                    recursiveFolderDelete(channelSftp, path + "/" + item.getFilename());
                }
            }
        }
        channelSftp.rmdir(path); // delete the parent directory after empty
    }
    
    
    
   
    
      
    
    

} //---- End Of Class 