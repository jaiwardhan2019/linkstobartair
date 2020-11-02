
package com.linkportal.config;


import javax.sql.DataSource;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.boot.jdbc.DataSourceBuilder;
import org.springframework.context.annotation.Bean;

import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.context.annotation.PropertySources;
import org.springframework.ui.freemarker.FreeMarkerConfigurationFactoryBean;








/**
 * @author Jai.Wardhan 
 * 
 *
 */


@PropertySources({ @PropertySource("classpath:application.properties"),
	               @PropertySource("classpath:email.properties"),
	               @PropertySource("classpath:message.properties"),
	               @PropertySource("classpath:airportcontactemail.properties"),
	               @PropertySource("classpath:log4j.properties"),
	               @PropertySource("classpath:delaycodegroup.properties"),	             
		           @PropertySource("classpath:database.properties") })




//@ComponentScan(basePackages = { "com.linkportal.docmanager","com.linkportal.security.UserSecurityLdapDatabase","com.flightreports.dbripostry.flightReports"})
//@ComponentScan(basePackages = { "org.springframework.mail.javamail.JavaMailSender" })
//@ComponentScan(basePackages = "com.linkportal")


@Configuration
public class InfrastructureConfig{
      
		
		//------- PDC DB----------------
		@Bean(name = "dataSourcesqlserver")
		@ConfigurationProperties(prefix = "sqlserver.datasource")
		public DataSource dataSourcesqlserver() {
	 	       return DataSourceBuilder.create().build();
		}
		
	
	
		//------- LINK PORTAL----------------
		@Bean(name = "dataSourcesqlservercp")
		@ConfigurationProperties(prefix = "cpsqlserver.datasource")
		public DataSource dataSourcesqlservercp() {
	 	       return DataSourceBuilder.create().build();
		}
		
		

	  @Bean(name = "dataSourcestafftravel")	  
	  @ConfigurationProperties(prefix = "stafftravel.datasource") 
	  public DataSource dataSource_flightops() {
		     return DataSourceBuilder.create().build(); 
	  }

	  
	  
		 
	  @Bean(name = "dataSourceopswebsys")	  
	  @ConfigurationProperties(prefix = "opswebsys.datasource") 
	  public DataSource dataSource_opswebsys() {
		     return DataSourceBuilder.create().build(); 
	  }

	
	 
}
