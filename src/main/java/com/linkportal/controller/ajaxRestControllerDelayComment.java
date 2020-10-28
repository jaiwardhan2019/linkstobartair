package com.linkportal.controller;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.StringTokenizer;

import javax.servlet.http.HttpServletRequest;
import javax.sql.DataSource;
import javax.xml.parsers.ParserConfigurationException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.util.MimeTypeUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.xml.sax.SAXException;

import com.linkportal.crewripostry.crewReport;
import com.linkportal.datamodel.Product;
import com.linkportal.datamodel.ProductModel;
import com.linkportal.groundops.gopsAllapi;

import com.linkportal.datamodel.flightDelayComment;

@RestController
@RequestMapping("ajaxrest")
public class ajaxRestControllerDelayComment {

	@Autowired
	gopsAllapi gopsobj;

	@Autowired
	crewReport crewRep;
	
	
	@Autowired
	DataSource dataSourcesqlservercp;
		 

	
	@RequestMapping(value = "test", method = RequestMethod.GET, produces = { MimeTypeUtils.TEXT_PLAIN_VALUE })
	public ResponseEntity<String> test() {
		try {
			ResponseEntity<String> responseEntity = new ResponseEntity<String>("Hi this is Test From JAI WARDHAN",
					HttpStatus.OK);
			return responseEntity;
		} catch (Exception e) {
			return new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
		}
	}

	@RequestMapping(value = "demo1", method = RequestMethod.GET, produces = { MimeTypeUtils.TEXT_PLAIN_VALUE })
	public ResponseEntity<String> demo1() {
		try {
			ResponseEntity<String> responseEntity = new ResponseEntity<String>(
					"Hi this is one String Display From Rest Controler ", HttpStatus.OK);
			return responseEntity;
		} catch (Exception e) {
			return new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
		}
	}

	@RequestMapping(value = "demo2/{fullName}", method = RequestMethod.GET, produces = {
			MimeTypeUtils.TEXT_PLAIN_VALUE })
	public ResponseEntity<String> demo2(@PathVariable("fullName") String fullName) {
		try {

			ResponseEntity<String> responseEntity = new ResponseEntity<String>("Hi " + fullName, HttpStatus.OK);
			System.out.println(HttpStatus.IM_USED);

			return responseEntity;

		} catch (Exception e) {
			return new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
		}
	}

	@RequestMapping(value = "demo3", method = RequestMethod.GET, produces = { MimeTypeUtils.APPLICATION_JSON_VALUE })
	public ResponseEntity<Product> demo3() {
		try {

			ProductModel productModel = new ProductModel();
			ResponseEntity<Product> responseEntity = new ResponseEntity<Product>(productModel.find(), HttpStatus.OK);
			return responseEntity;

		} catch (Exception e) {
			return new ResponseEntity<Product>(HttpStatus.BAD_REQUEST);
		}
	}

	@RequestMapping(value = "demo4", method = RequestMethod.GET, produces = { MimeTypeUtils.APPLICATION_JSON_VALUE })
	public ResponseEntity<List<Product>> demo4() {
		try {

			ProductModel productModel = new ProductModel();
			ResponseEntity<List<Product>> responseEntity = new ResponseEntity<List<Product>>(productModel.findAll(),
					HttpStatus.OK);
			return responseEntity;

		} catch (Exception e) {
			return new ResponseEntity<List<Product>>(HttpStatus.BAD_REQUEST);
		}
	}

	// --- FOR DELAY REPORT FETCH FLIGHT COMMENT DATE FROM DB
	@RequestMapping(value = "getflightcomment", method = { RequestMethod.POST, RequestMethod.GET }, produces = {
			MimeTypeUtils.APPLICATION_JSON_VALUE })
	public ResponseEntity<List<flightDelayComment>> getflightcomment(HttpServletRequest req) {
		try {
			ResponseEntity<List<flightDelayComment>> responseEntity = new ResponseEntity<List<flightDelayComment>>(
					gopsobj.showAllComment(req), HttpStatus.OK);
			return responseEntity;
		} catch (Exception e) {
			return new ResponseEntity<List<flightDelayComment>>(HttpStatus.BAD_REQUEST);
		}

	}

	// --- FOR DELAY REPORT FETCH FLIGHT COMMENT DATE FROM DB
	@RequestMapping(value = "delayflightreport", method = { RequestMethod.POST, RequestMethod.GET }, produces = {
			MimeTypeUtils.APPLICATION_JSON_VALUE })
	public ResponseEntity<List<flightDelayComment>> getdelayflightreport(HttpServletRequest req) {

		try {

			ResponseEntity<List<flightDelayComment>> responseEntity = new ResponseEntity<List<flightDelayComment>>(
					gopsobj.showAllComment(req), HttpStatus.OK);

			return responseEntity;

		} catch (Exception e) {
			return new ResponseEntity<List<flightDelayComment>>(HttpStatus.BAD_REQUEST);
		}

	}


	
	
	//-- Will return a token to the jsp page for logon 
	@RequestMapping(value = "getCrewToken", method = RequestMethod.GET, produces = { MimeTypeUtils.TEXT_PLAIN_VALUE })
	public ResponseEntity<String> getCrewToken() {
		try {
			
			ResponseEntity<String> responseEntity = new ResponseEntity<String>(crewRep.getLoginToken(), HttpStatus.OK);
			return responseEntity;
	
		} catch (Exception e) {return new ResponseEntity<String>(HttpStatus.BAD_REQUEST);}
	}




	//-- This will Load the PPS Token to the Database 
	//http://www2.hawaii.edu/~tp_212/fall2004/StringTok3.java
	@RequestMapping(value = "loadtokentodatabase",method = { RequestMethod.POST, RequestMethod.GET }, produces = { MimeTypeUtils.TEXT_PLAIN_VALUE })
	public ResponseEntity<String> loadTokentoDatabase(@RequestParam("cfile") MultipartFile files,HttpServletRequest req) {

		String addedByemailid = req.getParameter("emailid");
		Date today                     = new Date();
		SimpleDateFormat formattedDate = new SimpleDateFormat("yyyy-MM-dd");
		Calendar c = Calendar.getInstance();
		String addedDate               = formattedDate.format(c.getTime());


		try {
			
			
			if(files.isEmpty()) {
				ResponseEntity<String> responseEntity = new ResponseEntity<String>("File Added there is Empty # ", HttpStatus.OK);
				return responseEntity;
			}

			// Converting MultipartFile to file
			File fileName = new File("src/main/resources/targetFile.txt");
			files.transferTo(fileName);
			
			
			//-------- Reading File and Uploading to the database
			int noOfTokenLoaded=crewRep.readTokenFromFileAndInsertToDatabase(fileName, addedByemailid, addedDate);
			
			
			//------ Removing the "src/main/resources/targetFile.txt" file from folder 
			fileName.delete();
			
			
			ResponseEntity<String> responseEntity = new ResponseEntity<String>(String.valueOf(crewRep.getTokenBalance()), HttpStatus.OK);
			return responseEntity;
	
		} catch (Exception  e) {return new ResponseEntity<String>(HttpStatus.BAD_REQUEST);}
	}


	
	
	


}
