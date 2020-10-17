/**
 * @author Jai.Wardhan date : 01-July-2019
 *
 */
package com.linkportal.security;

import java.io.FileReader;
import java.io.IOException;
import java.net.UnknownHostException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Hashtable;
import java.util.Properties;

import javax.naming.AuthenticationException;
import javax.naming.Context;
import javax.naming.NamingException;
import javax.naming.ldap.InitialLdapContext;
import javax.naming.ldap.LdapContext;
import javax.sql.DataSource;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.context.annotation.PropertySources;
import org.springframework.core.env.Environment;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Repository;

import com.linkportal.controller.HomeController;

import java.util.Properties;





public class UserSecurityLdap{

	 //---------- Logger Initializer------------------------------- 
     private final Logger logger = Logger.getLogger(UserSecurityLdap.class);
		
		
		
	//---------- This Function will check usr in LDAP and return true /  false status to the caller
	public boolean Validate_User_With_Ldap(String useremailid,String userspassword,String ldapurl) throws NamingException,NullPointerException,IOException {
          
		try{		  
		  
		  Hashtable env = new Hashtable();
		  env.put(Context.INITIAL_CONTEXT_FACTORY,"com.sun.jndi.ldap.LdapCtxFactory");
		  env.put(Context.SECURITY_AUTHENTICATION, "Simple");
		  env.put(Context.SECURITY_PRINCIPAL,useremailid);
		  env.put(Context.SECURITY_CREDENTIALS,userspassword);
		  env.put(Context.PROVIDER_URL,ldapurl.trim());
		  //env.put(Context.PROVIDER_URL,"ldap://CORPDC01.aerarann.com:389");  <<--Will be used for the people with the old domain. 
		  LdapContext ctx = new InitialLdapContext(env,null); 
		  ctx.close();
		  
		  
		  }catch(Exception E) {
			  logger.error("While Validating LDAP For :"+useremailid+"##"+E.toString());
			  return false;
			  //--- Write Send email function   
		  }
		 
		  
		 return true;
	}// End of function Validate_User_With_Ldap
	
	
	
	
	
}//------------ End Of Class UserSecurityLdapDatabase 
