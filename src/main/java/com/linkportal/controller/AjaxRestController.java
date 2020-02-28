package com.linkportal.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.util.MimeTypeUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.linkportal.datamodel.Product;
import com.linkportal.datamodel.ProductModel;
import com.linkportal.groundops.gopsAllapi;

import com.linkportal.datamodel.flightDelayComment;

@RestController
@RequestMapping("ajaxrest")
public class AjaxRestController {

	
	
	@Autowired
	gopsAllapi gopsobj;
    	
	
	@RequestMapping(value = "test", method = RequestMethod.GET, produces = { MimeTypeUtils.TEXT_PLAIN_VALUE })
	public ResponseEntity<String> test() {
		try {
			ResponseEntity<String> responseEntity = new ResponseEntity<String>("Hi this is Test From JAI WARDHAN", HttpStatus.OK);
			return responseEntity;
		} catch (Exception e) {
			return new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
		}
	}
	
	
	
	@RequestMapping(value = "demo1", method = RequestMethod.GET, produces = { MimeTypeUtils.TEXT_PLAIN_VALUE })
	public ResponseEntity<String> demo1() {
		try {
			ResponseEntity<String> responseEntity = new ResponseEntity<String>("Hi this is one String Display From Rest Controler ", HttpStatus.OK);
			return responseEntity;
		} catch (Exception e) {
			return new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
		}
	}

	
	
	
	
	@RequestMapping(value = "demo2/{fullName}", method = RequestMethod.GET, produces = {MimeTypeUtils.TEXT_PLAIN_VALUE })
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
			ResponseEntity<List<Product>> responseEntity = new ResponseEntity<List<Product>>(productModel.findAll(),HttpStatus.OK);
			return responseEntity;
		
		} catch (Exception e) {
			return new ResponseEntity<List<Product>>(HttpStatus.BAD_REQUEST);
		}
	}
	
	
	
	
	

	//---  FOR DELAY REPORT FETCH FLIGHT COMMENT DATE FROM DB 
	@RequestMapping(value = "getflightcomment", method = {RequestMethod.POST,RequestMethod.GET}, produces = { MimeTypeUtils.APPLICATION_JSON_VALUE })
	public ResponseEntity<List<flightDelayComment>> getflightcomment(HttpServletRequest req) {
		try {	
			ResponseEntity<List<flightDelayComment>> responseEntity = new ResponseEntity<List<flightDelayComment>>(gopsobj.showAllComment(req),HttpStatus.OK);
			return responseEntity;	
		} catch (Exception e) {return new ResponseEntity<List<flightDelayComment>>(HttpStatus.BAD_REQUEST);}
	
	}
	
	
	
	
	
	
	
	

}
