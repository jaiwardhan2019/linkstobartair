
package com.linkportal.config;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.boot.jdbc.DataSourceBuilder;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.context.annotation.PropertySources;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.annotation.EnableTransactionManagement;



/**
 * @author Jai.Wardhan 
 * 
 *
 */


@PropertySources({ @PropertySource("classpath:application.properties"),
	               @PropertySource("classpath:email.properties"),
	               @PropertySource("classpath:message.properties"),
	               @PropertySource("classpath:log4j.properties"),
	               @PropertySource("classpath:delaycodegroup.properties"),	             
		           @PropertySource("classpath:database.properties") })




//@ComponentScan(basePackages = { "com.linkportal.docmanager","com.linkportal.security.UserSecurityLdapDatabase","com.flightreports.dbripostry.flightReports"})
//@ComponentScan(basePackages = { "com.linkportal.docmanager" })
//@ComponentScan({"com.linkportal.email.linkPortalEmail"})


@Configuration
public class InfrastructureConfig{
      
	
	
	
	
	@Bean(name = "dataSourcesqlserver")
	@ConfigurationProperties(prefix = "sqlserver.datasource")
	public DataSource dataSourcesqlserver() {
 	       return DataSourceBuilder.create().build();
	}

	
	  //---  THIS IS FOR LINK - DATABASE MYSQL  
	  @Bean(name = "dataSourcemysql")	  
	  @ConfigurationProperties(prefix = "mysql.datasource") 
	  public DataSource dataSource_sqlserver() { 
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
