package com.linkportal.docmanager;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;



public class DocumentEntity {
        
	
	
	   
	
		private int     docId;
		private String  docName;
	    private String  docDescription;
		private String  docType;
		private String  docPath;	    
	    private String  docDepartment;
	    private String  docCategory;	    
		private String  docAddedDate;
		private String  docAddedbyName;

		
		   
	    public DocumentEntity(int docId, String docName, String docDescription, String docType, String docPath,
				String docDepartment, String docCategory, String docAddedDate, String docAddedbyName) {
			super();
			this.docId = docId;
			this.docName = docName;
			this.docDescription = docDescription;
			this.docType = docType;
			this.docPath = docPath;
			this.docDepartment = docDepartment;
			this.docCategory = docCategory;
			this.docAddedDate = docAddedDate;
			this.docAddedbyName = docAddedbyName;
		}
	  
		public int getDocId() {
		       return docId;
	    }

		public void setDocId(int docId) {
			this.docId = docId;
		}


	    
	    public String getDocName() {
			return docName;
		}

		public void setDocName(String docName) {
			this.docName = docName;
		}

		public String getDocDescription() {
			return docDescription;
		}

		public void setDocDescription(String docDescription) {
			this.docDescription = docDescription;
		}

		public String getDocType() {
			return docType;
		}

		public void setDocType(String docType) {
			this.docType = docType;
		}

		public String getDocPath() {
			return docPath;
		}

		public void setDocPath(String docPath) {
			this.docPath = docPath;
		}

		public String getDocDepartment() {
			return docDepartment;
		}

		public void setDocDepartment(String docDepartment) {
			this.docDepartment = docDepartment;
		}

		

	   public String getDocCategory() {
			return docCategory;
		}

		public void setDocCategory(String docCategory) {
			this.docCategory = docCategory;
		}



		public String getDocAddedDate() {
			return docAddedDate;
		}

		public void setDocAddedDate(String docAddedDate) {
			this.docAddedDate = docAddedDate;
		}

		public String getDocAddedbyName() {
			return docAddedbyName;
		}

		public void setDocAddedbyName(String docAddedbyName) {
			this.docAddedbyName = docAddedbyName;
		}

		
		
		@Override
		public String toString() {
			return "DocumentEntity [docId=" + docId + ", docName=" + docName + ", docDescription=" + docDescription
					+ ", docType=" + docType + ", docPath=" + docPath + ", docDepartment=" + docDepartment
					+ ", docCategory=" + docCategory + ", docAddedDate=" + docAddedDate + ", docAddedbyName="
					+ docAddedbyName + "]";
		}

		
		
		
   
}