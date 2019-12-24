package com.linkportal;


import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;





@SpringBootApplication
public class LinkstobartairApplication {

	public static void main(String[] args){
		SpringApplication.run(LinkstobartairApplication.class, args);
		
	}
	
	
	//-------- This Part is for uploading big Size of File to the Tomcat Server ---------
	@Bean(name = "multipartResolver")
    public CommonsMultipartResolver multipartResolver() {
        CommonsMultipartResolver multipartResolver = new CommonsMultipartResolver();
        multipartResolver.setMaxUploadSize(-1);
        return multipartResolver;
    }
	

	
}//----- End of LinkstobartairApplication class
