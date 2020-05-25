package com.linkportal;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;

/*
https://www.callicoder.com/spring-boot-task-scheduling-with-scheduled-annotation/
https://www.tutorialspoint.com/spring_boot/spring_boot_scheduling.htm
*/

@SpringBootApplication
@EnableScheduling
public class LinkstobartairApplication {

	public static void main(String[] args) {
		SpringApplication.run(LinkstobartairApplication.class, args);

	}

	// -------- This Part is for uploading big Size of File to the Tomcat Server
	// ---------
	@Bean(name = "multipartResolver")
	public CommonsMultipartResolver multipartResolver() {
		CommonsMultipartResolver multipartResolver = new CommonsMultipartResolver();
		multipartResolver.setMaxUploadSize(-1);
		return multipartResolver;
	}

}// ----- End of LinkstobartairApplication class
