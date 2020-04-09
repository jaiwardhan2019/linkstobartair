package com.linkportal.datamodel;

import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.io.Serializable;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Properties;

import org.springframework.context.annotation.Scope;
import org.springframework.web.context.WebApplicationContext;




@Scope(WebApplicationContext.SCOPE_REQUEST)
public class delayReportParentPojo implements Serializable{
	
       private fligthSectorLog sect;
       
       private flightDelayComment comment;


       public delayReportParentPojo(fligthSectorLog sect, flightDelayComment comment) {
		      super();
		      this.sect = sect;
		      this.comment = comment;
	   }
	
		public fligthSectorLog getSect() {
			return sect;
		}
	
		public void setSect(fligthSectorLog sect) {
			this.sect = sect;
		}
	
		public flightDelayComment getComment() {
			return comment;
		}
	
		public void setComment(flightDelayComment comment) {
			this.comment = comment;
		}
		
		
	
		@Override
		public String toString() {
			return "delayReportParentPojo [sect=" + sect + ", comment=" + comment + "]";
		}
	       
       
		
	
}// --------------- End Of Main PoJo Class --------------------
