package com.linkportal.docmanager;

import java.sql.Blob;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;


@Entity
@Table(name="Gops_Document_Master")
public class DocumentEntity {
        
	    @Column(name="doc_name")  
		private String  docName;
	    
	    @Column(name="doc_description")
	    private String  docDescription;
	    
	    @Column(name="doc_type")
		private String  docType;
	    
	    @Column(name="doc_path")
		private String  docPath;
		
	    @Column(name="doc_department")
	    private String  docDepartment;
	    
	    @Column(name="doc_added_date")
		private String  docAddedDate;
	    
	    @Column(name="doc_addedby_name")
		private String  docAddedbyName;

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
			return "DocumentEntity [docName=" + docName + ", docDescription=" + docDescription + ", docType=" + docType
					+ ", docPath=" + docPath + ", docDepartment=" + docDepartment + ", docAddedDate=" + docAddedDate
					+ ", docAddedbyName=" + docAddedbyName + "]";
		}


		
		
		
   
}