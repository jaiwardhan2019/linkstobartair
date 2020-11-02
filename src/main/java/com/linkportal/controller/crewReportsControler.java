package com.linkportal.controller;


import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.StringReader;
import java.io.StringWriter;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Calendar;
import java.util.Collection;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
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
import com.linkportal.crewripostry.crewReport;
import com.linkportal.dbripostry.linkUsers;







@Controller
public class crewReportsControler {

    
	@Autowired
	crewReport crewInfo;
	
	@Autowired
	linkUsers usrprof;
		



	
    //---------- Logger Initializer------------------------------- 
	private final Logger logger = Logger.getLogger(crewReportsControler.class);
	
	boolean Inline = false;
	

	
	//-------THis Will be Called When Daily Summary REPORT link Is Called ---------------- 
	@RequestMapping(value = "/voyagerReport",method = {RequestMethod.POST,RequestMethod.GET}) 
	public String voyagerReport(HttpServletRequest req, ModelMap model) throws Exception {	

		
		  String[] userEmailId   =  req.getParameter("profilelist").toString().split("#");
	      model.addAttribute("profilelist",req.getParameter("profilelist"));	


		
		   String selectoptionString="";
		   String todayselection    ="";
		   String tomorrowselection ="";
		   
	
			//------ BUILTING TODAY AND TOMORROW VARRIABLE ------------
		    Date today = new Date();               
			SimpleDateFormat formattedDate = new SimpleDateFormat("yyyy-MM-dd");
			Calendar c = Calendar.getInstance();  
			String todaydate = formattedDate.format(c.getTime());
			c.add(Calendar.DATE, 1);  // number of days to add      
			String tomorrow = formattedDate.format(c.getTime());
			
			
			
			
			//************ THIS PART WILL TAKE CARE OF DATE SELECTION AND CAPTION LIST POPULATION *************
			if(req.getParameter("flightdate") != null) {
				 
				 if(req.getParameter("flightdate").equalsIgnoreCase(todaydate))
				 {todayselection="selected";}else{tomorrowselection="selected";}
				 //------ ONCE DATE IS SELECTED -----------------------------------------------
				 model.put("captionlist", crewInfo.showCrewList(req.getParameter("flightdate")));
				 selectoptionString="<option value='"+todaydate+"'"+todayselection+">TODAY&nbsp;&nbsp;("+todaydate+")</option>\r\n"+ 
		 		                    "<option value='"+tomorrow+"'"+tomorrowselection+">TOMORROW&nbsp;&nbsp;( "+tomorrow+")</option>";
		 
			 }
			 else
			 {
				//------  DATE IS NOT SELECTED -----------------------------------------------
				 model.put("captionlist", crewInfo.showCrewList(todaydate));
				 selectoptionString="<option value="+todaydate+">TODAY&nbsp;&nbsp;("+todaydate+")</option>\r\n"+ 
		 		                    "<option value="+tomorrow+">TOMORROW&nbsp;&nbsp;( "+tomorrow+")</option>";
		 
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
	
	
	
	


	@RequestMapping(value = "/voyagerReportblankpdf",method = {RequestMethod.POST,RequestMethod.GET})
	public HttpEntity<byte[]> voyagerReportblankpdf( HttpServletRequest request, HttpServletResponse response ) throws Exception {		        
		        return crewInfo.createPdf("test.pdf");		
	}	
	
	
	/*
		String flightReportFileName = FlightReportPdfGenerator.generateBlankPdfFileName();
		
		logger.debug("FlightReport File Name set as: " + flightReportFileName);
		
		response.setHeader("Cache-Control", "must-revalidate, post-check=0, pre-check=0");
		response.setHeader("Pragma", "no-cache");
		response.setHeader("Expires", "0");
		
		String contentType = "";
		if (Inline) {
			//Inline
			logger.debug("Content-Disposition\", \"inline; filename=\"" + flightReportFileName +"\"");
			response.setHeader("Content-Disposition", "inline; filename=\"" + flightReportFileName + "\"");
			
			contentType = request.getServletContext().getMimeType( flightReportFileName );
			
		} else {
			//Attachment
			logger.debug("Content-Disposition\", \"attachment; filename=\"" + flightReportFileName + "\"" );
			response.setHeader("Content-Disposition", "attachment; filename=\"" + flightReportFileName + "\"");
			
			//Content Type Set to Octet Stream will force the browser to display download prompt, even in places where there is a PDF plugin
			contentType = MediaType.APPLICATION_OCTET_STREAM_VALUE;
		}
		
		logger.debug("ContentType Set: " + contentType);
		response.setContentType( contentType );
		
		this.logResponseHeaders( response );
		
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        
		
		flightReportPdfGenerator.generateBlankFlightReportToPDF(baos);
        
		response.setContentLength(baos.size());
		
		OutputStream os = response.getOutputStream();
        baos.writeTo(os);
        os.flush();
        os.close();
		
		return null;
		
	}
	

	
	public void logResponseHeaders( HttpServletResponse response) {
	
		Map<String, Collection<String>> headerMap = new HashMap<String, Collection<String>>();
		
		for (Iterator<String> it = response.getHeaderNames().iterator(); it.hasNext();){
			String headerName = it.next();
			headerMap.put(headerName, response.getHeaders( headerName));
			System.out.println(headerName);
		}
		
		logger.debug("Headers in HttpResponse: " + headerMap);
	}

*/
		
	
}//----------- End Of Main Controller --------------------
