package com.linkportal.controller;


import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.IOException;
import java.io.OutputStream;
import java.io.StringReader;
import java.io.StringWriter;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collection;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.velocity.Template;
import org.apache.velocity.VelocityContext;
import org.apache.velocity.app.VelocityEngine;
import org.apache.velocity.runtime.RuntimeConstants;
import org.apache.velocity.runtime.resource.loader.ClasspathResourceLoader;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.core.io.ClassPathResource;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;


import com.itextpdf.text.Document;
import com.itextpdf.text.PageSize;
import com.itextpdf.text.pdf.PdfWriter;
import com.itextpdf.tool.xml.XMLWorkerHelper;
import com.linkportal.crewripostry.PDFTemplateUtil;
import com.linkportal.crewripostry.crewReport;
import com.linkportal.dbripostry.linkUsers;







@Controller
public class crewReportsControler{

    


	@Autowired
	crewReport crewInfo;
	

   public static final SimpleDateFormat dateFormat_yyy_MM_dd = new SimpleDateFormat("yyyy-MM-dd");
	
	//-- Todate Date
	private String getTodaysDateString() {
		return dateFormat_yyy_MM_dd.format(new Date());
	}

	//-- Tomorrow Date
	private String getTomorrowDateString() {
		Calendar c = Calendar.getInstance();  
		String todaydate = dateFormat_yyy_MM_dd.format(c.getTime());
		c.add(Calendar.DATE, 1);  // number of days to add      
		return dateFormat_yyy_MM_dd.format(c.getTime());
	}




	
    //---------- Logger Initializer------------------------------- 
	private final Logger logger = Logger.getLogger(crewReportsControler.class);
	
	boolean Inline = false;
	

	
	//-------THis Will be Called When Daily Summary REPORT link Is Called ---------------- 
	@RequestMapping(value = "/voyagerReport",method = {RequestMethod.POST,RequestMethod.GET}) 
	public String voyagerReport(HttpServletRequest req, ModelMap model) throws Exception {	

		
		  String[] userEmailId   =  req.getParameter("profilelist").toString().split("#");
	      model.addAttribute("profilelist",req.getParameter("profilelist"));	


		
		   String selectoptionString ="";
		   String todayselection     ="";
		   String tomorrowselection  ="";
		   ArrayList<String> rankList =new ArrayList<String>();
		   rankList.add("CAPT");
		   //rankList.add("FO");
		   //rankList.add("CC");
		   
		   
			
			
			//************ THIS PART WILL TAKE CARE OF DATE SELECTION AND CAPTION LIST POPULATION *************
			if(req.getParameter("flightdate") != null) {
				 
				 if(req.getParameter("flightdate").equalsIgnoreCase(getTodaysDateString()))
				 {todayselection="selected";}else{tomorrowselection="selected";}
				 //------ ONCE DATE IS SELECTED -----------------------------------------------
				 model.put("captionlist", crewInfo.showCrewList(req.getParameter("flightdate"),req.getParameter("flightdate"),rankList));
				 selectoptionString="<option value='"+getTodaysDateString()+"'"+todayselection+">TODAY&nbsp;&nbsp;("+getTodaysDateString()+")</option>\r\n"+ 
		 		                    "<option value='"+getTomorrowDateString()+"'"+tomorrowselection+">TOMORROW&nbsp;&nbsp;( "+getTomorrowDateString()+")</option>";
		 
			 }
			 else
			 {
				//------  DATE IS NOT SELECTED -----------------------------------------------
				 model.put("captionlist", crewInfo.showCrewList(getTodaysDateString(),getTodaysDateString(),rankList));
				 selectoptionString="<option value="+getTodaysDateString()+">TODAY&nbsp;&nbsp;("+getTodaysDateString()+")</option>\r\n"+ 
		 		                    "<option value="+getTomorrowDateString()+">TOMORROW&nbsp;&nbsp;( "+getTomorrowDateString()+")</option>";
		 
			 }
			 model.put("selectoption", selectoptionString);

				 
			 /** THIS PART WILL TAKE CARE OF CAPTION SCHEDULE REPORT**/
			 if((req.getParameter("flightdate") != null) && (req.getParameter("crewcode") != null)) {				 
				 model.put("selectedcaption", req.getParameter("crewcode")); 
				 
				 System.out.println("Crew Date;"+req.getParameter("flightdate"));
				 System.out.println("Crew Code;"+req.getParameter("crewcode"));
					 
			 }
			 
		 return "crewreport/voyagereport";
	}
	
	
	
	

     //--- Using Velocity Engien 
	@RequestMapping(value = "/voyagerReportblankpdfWithVelocityTemplet",method = {RequestMethod.POST,RequestMethod.GET})
	public HttpEntity<byte[]> voyagerReportblankpdfWithVelocityTemplet( HttpServletRequest request, HttpServletResponse response ) throws Exception {		        
		        return crewInfo.createPdfWithVelocityTemplet("testjai.pdf");		

	}
	
	
	

	// --- Using FreeMaker FTL Templet 
	@RequestMapping(value = "/voyagerReportblankpdfWithFLTTemplet", method = { RequestMethod.POST, RequestMethod.GET })
	public void voyagerReportblankpdfWithFLTTemplet(HttpServletRequest reqObj, HttpServletResponse resObj)
			throws Exception {	
		crewInfo.createVoyagerReportWithFreeMakerTemplet(reqObj, resObj);

	} // End of Method	
	
	
		
	
}//----------- End Of Main Controller --------------------
