package com.linkportal.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.ModelMap;
import org.springframework.util.MimeTypeUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.linkportal.datamodel.flightDelayComment;
import com.linkportal.groundops.gopsAllapi;
import com.linkportal.security.UserSecurityLdap;

@RestController
public class ajaxRestControllerFinance {

	@Autowired
	gopsAllapi gopsobj;

	
	
	// --- FOR DELAY REPORT FETCH FLIGHT COMMENT DATE FROM DB
	@RequestMapping(value = "delayflightreport", method = { RequestMethod.POST, RequestMethod.GET }, produces = {
			MimeTypeUtils.APPLICATION_JSON_VALUE })
	
	public ResponseEntity<List<flightDelayComment>> getdelayflightreport(HttpServletRequest req) {
		try {
			
			ResponseEntity<List<flightDelayComment>> responseEntity = new ResponseEntity<List<flightDelayComment>>(gopsobj.showAllComment(req), HttpStatus.OK);
			return responseEntity;
			
		} catch (Exception e) {	return new ResponseEntity<List<flightDelayComment>>(HttpStatus.BAD_REQUEST);}

	}

	
}
