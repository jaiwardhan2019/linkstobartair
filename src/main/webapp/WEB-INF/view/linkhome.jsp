<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<jsp:include page="include/header.jsp"></jsp:include>
<% 
//----------- Reading Data From Previous Controller Page-----------------

String[] userProfileList   =  request.getAttribute("profilelist").toString().split("#");
String userFullEmailid     =  userProfileList[0];
String userPassword        =  userProfileList[1];
if(userFullEmailid.length() < 2){response.sendRedirect("index");}

String[] userFirstLastName  = userFullEmailid.split("@");
String userLoginId          = userFirstLastName[0];
//https://stackoverflow.com/questions/5053975/how-to-encode-a-string-representing-url-path-with-jstl

%>


<html lang="en">
<head>
    <meta charset="utf-8">
    <title> Dashboard | StobartAir | Link 1.1 </title>    
</head>


<body  style="font-family: 'Lato', 'Helvetica Neue', Helvetica, Arial, sans-serif;">

<!-- 
<body onLoad="autopopupModal();" style="font-family: 'Lato', 'Helvetica Neue', Helvetica, Arial, sans-serif;">

https://developers-dot-devsite-v2-prod.appspot.com/chart/interactive/docs/gallery/barchart   <<-- Google

https://www.roytuts.com/google-chart-using-spring/  <<--  sample Implimentation

http://googlechart.blogspot.com/  <<--- JSP / AJAX 

-->

<!-- https://canvasjs.com/jsp-charts/  -->




<script type="text/javascript">

function CalCrewebsite(){	
	
	document.logonForm.action="https://flightops.stobartair.com/login";
	document.logonForm.method="POST";
	document.logonForm.target="_blank"
	document.logonForm.submit();
	
}

function CalGroundops(){	
	document.loginForm.action="https://ops.stobartair.com/login";
	document.loginForm.method="POST";
	document.loginForm.target="_blank"
	document.loginForm.submit();
}


function CalAerodocsLogin(){
	
	  var xhr = new XMLHttpRequest();	  
	  xhr.open("POST", "https://aerodocs.stobartair.com/accounts/api/auth/token", true);
	  xhr.setRequestHeader('Content-Type','application/vnd.arconics.acs.v1.0+json');
	  xhr.send('{"email":"<%=userFirstLastName[0]%>","password":"<%=userPassword%>","oneTimePassword":"","captchaResponse":null}');
	  xhr.onloadend = function () {		
	  window.open('https://aerodocs.stobartair.com','_blank');		  
	  };	
	  
}



function CalStaffTravel(){	

	document.staff.action="stafftravelloginprocess";
	document.staff.method="POST";
	document.staff.target="_blank"
	document.staff.submit();
	
	
}


function CalHrManagement(){	
	
	document.loginFormHR.action="loginhrmanagment";
	document.loginFormHR.method="POST";
	document.loginFormHR.target="_blank"
	document.loginFormHR.submit();
	
}



function CalFuelreport(){
	
	//document.loginForm.action="logonalfresco.jsp";
	//document.loginForm.target="_blank"
    //document.loginForm.submit();
	alert("Under construction");
	return false;
}


function CalCrewconexx(){	
	
	
    document.crewconnex.action="logincrewconnex"
	document.crewconnex.method="POST";
	document.crewconnex.target="_blank"
	document.crewconnex.submit();
	
}// End of function 


function Calqpulse(){		
	
	document.qpulse.action="loginqpulse"
	document.qpulse.method="POST";
	document.qpulse.target="_blank"
	document.qpulse.submit();
	
}// End of function


function CalFlightboard_PDC(){
	
	document.loginForm.action="https://norwincrew.aerarann.com/flightboard";
	document.loginForm.target="_blank"
    return false;
}

function CalCrewbriefing(){

	document.logonForm4.action="http://www.crewbriefing.com/Login.aspx?username=XXX&Code=YYY&format=http";
	document.logonForm4.target="_blank"
	return false;
}



function CalAlfresco(){
	
	document.alfresco.action="logonalfresco";
	document.alfresco.target="_blank"
    document.alfresco.submit();
	return true;
}


function calBusinessArea(){
	document.businessupdate.method="POST";
	document.businessupdate.action="businesarea";
	//document.businessupdate.target="_blank"
    document.businessupdate.submit();
	return true;
}


function calBusinessUpdates(){
	document.connectair.action="businessupdates?businessupdates=yes&news=Latest";
	//document.connectair.target="_blank"
    document.connectair.submit();
	return true;
}


function calEmployee_discount(){
	document.employee_discount.action="employeediscount";
	//document.employee_discount.target="_blank"
    document.employee_discount.submit();
	return true;
}


function callive_well(){
	document.callive_well1.action="livewell";
	//document.callive_well1.target="_blank"
    document.callive_well1.submit();
	return true;
}




function calNewRefis(){
	document.refis.action="groundopsHomePage?usertype=I&cat=home";
	document.refis.method="POST";
	//document.callive_well1.target="_blank"
    document.refis.submit();
	return true;
}



function cal_manage_contract(){
	
	document.contract.action="contractManager";
	//document.callive_well1.target="_blank"
    document.contract.submit();
	return true;
	
}



setTimeout(function(){window.location.href="index"},60000000);	
  
  
  


</script>












<!-- Body Banner -->
<div class="container-fluid" style="margin-top:80px;">	
	
 <div class="row" style="margin-bottom:40px;">


	<a href="https://mail.office365.com/" target="_new">	
      	<div class="col-md-2 col-sm-3 col-xs-6" style="cursor:pointer;">
			<div class="panel panel-info btn-default panel-shadow">
				<div class="panel-body" style="color:#ea0404;">
					<i class="fa fa-envelope fa-2x pull-left"></i> <span class="pull-right" style="font-size:11pt;font-weight:600;color:#0071BA;"> Email</span>
				</div>
			</div>
		</div>
	</a>	
		

   <c:if test = "${fn:contains(profilelist, 'Cascade')}"> 
							
			 
			 <form name="loginFormHR"  id="loginFormHR" >
			 
			    <input style="display: none;" name="COMPANY" id="COMPANY" tabindex="1" value="STOBART">
			 	<input type="hidden" name="USERID" id="USERID" tabindex="2" value="<%=userLoginId%>">
			 	<input type="hidden" name="PWD" id="PWD" tabindex="3" value="<%=userPassword%>">
			 	
			  <a  title="HR Management System." onClick="CalHrManagement();" >
			 		<div class="col-md-2 col-sm-3 col-xs-6" style="cursor:pointer;">
						<div class="panel panel-info btn-default panel-shadow">
							<div class="panel-body"  style="color:green">
							<i class="fa fa-handshake-o fa-2x pull-left"></i> <span class="pull-right" style="font-size:11pt;font-weight:600;color:#0071BA;">Cascade</span>
							
							</div>
						</div>
					</div>
					</a>
			</form>				

</c:if> 
			

	<form name="logonForm" id="logonForm">	
	 <input id="username" type="hidden" name="username" value="<%=userFirstLastName[0]%>">
     <input id="password" type="hidden"  name="password" value="<%=userPassword%>">		
		<a onClick="CalCrewebsite();">	
			<div class="col-md-2 col-sm-3 col-xs-6" style="cursor:pointer;">
				<div class="panel panel-info btn-default panel-shadow">
					<div class="panel-body" style="color:#0071BA;">
						 <i class="fa fa-globe fa-2x pull-left"></i> <span class="pull-right" style="font-size:11pt;font-weight:600;color:#0071BA;">Crew Website</span>
					</div>
				</div>
			</div>
		</a>	
		
	</form>
	
	
		

	<form name="crewconnex" id="crewconnex">
	   <input type="hidden" name="emailid" id="emailid" value="<%=userFullEmailid%>" >
	    <input  type="hidden" name="password" id="password" value="<%=userPassword%>">
	    <input type="hidden" id="profilelist" name="profilelist" value="${profilelist}">
		<a onclick="CalCrewconexx()">
		<div class="col-md-2 col-sm-3 col-xs-6" style="cursor:pointer;">
			<div class="panel panel-info btn-default panel-shadow">
				<div class="panel-body" style="color:#0071BA;">
					<i class="fa fa-users fa-2x pull-left"></i> <span class="pull-right" style="font-size:11pt;font-weight:600;color:#0071BA;">Crew Connex</span>
				</div>
			</div>
		</div>
		</a>
	</form>


	<form name="qpulse" id="qpulse">
	 <input id="username" type="hidden" name="username" value="<%=userFirstLastName[0]%>">
     <input id="password" type="hidden"  name="password" value="<%=userPassword%>">
     <input type="hidden" name="emailid" id="emailid" value="<%=userFullEmailid%>" >
       <input type="hidden" id="profilelist" name="profilelist" value="${profilelist}">
     
	 <a onclick="Calqpulse()" title="Safety Reporting System.">
	
		<div class="col-md-2 col-sm-3 col-xs-6" style="cursor:pointer;">
			<div class="panel panel-info btn-default panel-shadow">
				<div class="panel-body" style="color:#0071BA;">
				   <i class="fa fa-pencil-square-o fa-2x pull-left"></i> <span class="pull-right" style="font-size:11pt;font-weight:600;color:#0071BA;">   Q -  Pulse</span>
				</div>
			</div>
		</div>
	</a>
	</form>	
	
	
	    
	<a href="https://stobartair.pelesys.com/SSO.aspx?userid=<%=userFullEmailid%>" target="_new">
 		<div class="col-md-2 col-sm-3 col-xs-6" style="cursor:pointer;">
			<div class="panel panel-info btn-default panel-shadow">
				<div class="panel-body" style="color:#0071BA;">
					<i class="fa fa-mortar-board fa-2x pull-left" area-hidden="true"></i> <span class="pull-right" style="font-size:11pt;font-weight:600;color:#0071BA;">Pelesys Training</span>
				</div>
			</div>
		</div>
    </a>
 

    
 	<form name="staff" id="staff">
	 
	 <input id="j_username" type="hidden" name="j_username" value="<%=userFirstLastName[0]%>">
     <input id="j_password" type="hidden"  name="j_password" value="<%=userPassword%>">   
     <input id="emailid" type="hidden"  name="emailid" value="<%=userFullEmailid%>"> 
      <input type="hidden" id="profilelist" name="profilelist" value="${profilelist}">
     <a onClick="CalStaffTravel();" title="Staff Travel Booking.">
		<div class="col-md-2 col-sm-3 col-xs-6" style="cursor:pointer;">
			<div class="panel panel-info btn-default panel-shadow">
				<div class="panel-body" style="color:#0071BA;">
					<i class="fa fa-plane fa-2x pull-left"></i> <span class="pull-right" style="font-size:11pt;font-weight:600;color:#0071BA;">Staff Travel</span>
				</div>
			</div>
		</div>
	  </a>
   
   </form>
   
			<!-- 	
		     <form name="logonForm4" id="logonForm4">	
		     
		     <a href="crewbriefinglogin.jsp" target="_new">
		    	<div class="col-md-2 col-sm-3 col-xs-6" style="cursor:pointer;">
					<div class="panel panel-info btn-default panel-shadow">
						<div class="panel-body" style="color:#0071BA;">
							<i class="fa fa-users fa-2x pull-left"></i> <span class="pull-right" style="font-size:11pt;font-weight:600;color:#0071BA;">Crew Briefing</span>
						</div>
					</div>
				</div>
			</a>
			</form>
			
		<a href="https://norwincrew.aerarann.com/flightboard" target="_new">
			<div class="col-md-2 col-sm-3 col-xs-6" style="cursor:pointer;">
				<div class="panel panel-info btn-default panel-shadow">
					<div class="panel-body" style="color:#0071BA;">
						<i class="fa fa-dashboard fa-2x pull-left"></i> <span class="pull-right" style="font-size:11pt;font-weight:600;color:#0071BA;"> Flight Board-PDC </span>
					</div>
				</div>
			</div>
		 </a>
			
		
			
			
		<form name="loginForm" id="loginForm">	
		 <input id="username" type="hidden" name="username" value="<%=userFirstLastName[0]%>">
	     <input id="password" type="hidden"  name="password" value="<%=userPassword %>">
		  <input type="hidden"  name="j_username" id="username" value="<%=userFirstLastName[0]%>"> 
	      <input type="hidden"  name="j_password" id="password" value="<%=userPassword%>">	
		<a onClick="CalGroundops();">
			<div class="col-md-2 col-sm-3 col-xs-6" style="cursor:pointer;">
				<div class="panel panel-info btn-default panel-shadow">
					<div class="panel-body" style="color:#0071BA;">
						<i class="fa fa-road fa-2x pull-left"></i> <span class="pull-right" style="font-size:11pt;font-weight:600;color:#0071BA;">Ground Operations</span>
					</div>
				</div>
			</div>
		 </a>	
		</form>
	       
	    -->
		
		
		
		<!-- <a title="Document Management System." target="_new" href="https://aerodocs.stobartair.com/"> -->
		
		<a onClick="CalAerodocsLogin();">	
		
				<div class="col-md-2 col-sm-3 col-xs-6" style="cursor:pointer;">
					<div class="panel panel-info btn-default panel-shadow">
						<div class="panel-body" style="color:#0071BA;">
							<i class="fa fa-book fa-2x pull-left"></i> <span class="pull-right" style="font-size:11pt;font-weight:600;color:#0071BA;">Aerodocs Mgmt</span>
						</div>
					</div>
				</div>
		</a>		


			
		<!-- 	
		
				<div class="col-md-2 col-sm-3 col-xs-6" style="cursor:pointer;">
					<div class="panel panel-info btn-default panel-shadow">
						<div class="panel-body" style="color:#0071BA;">
							<i class="fa fa-users fa-2x pull-left"></i> <span class="pull-right" style="font-size:11pt;font-weight:600;color:#0071BA;"><a href="https://stobartair.providentcrm.com" target="_blank">Customer Relation</a></span>
						</div>
					</div>
				</div>
		   -->
				
			<form name="alfresco" id="alfresco" method="POST">
				 
				 <input  type="hidden" name="loginid_a" value="<%=userFirstLastName[0]%>">
			     <input  type="hidden"  name="pass_a" value="<%=userPassword%>">  
			     
			     	
				<a title="Document Managment System." onClick="CalAlfresco();">
					<div class="col-md-2 col-sm-3 col-xs-6" style="cursor:pointer;">
						<div class="panel panel-info btn-default panel-shadow">
							<div class="panel-body" style="color:#0071BA;">
								<i class="fa fa-book fa-2x pull-left"></i> <span class="pull-right" style="font-size:11pt;font-size:10pt;font-weight:600;color:#0071BA;">Alfresco Document</span>
							</div>
						</div>
					</div>
				</a>	
			</form>	
	
	 <form name="businessupdate" id="businessupdate" method="POST" >
	       <input  type="hidden" name="user" value="<%=userFirstLastName[0]%>">
	       <input  type="hidden" name="cat" value="00">
	       <input  type="hidden" name="emailid" id="emailid" value="<%=userFullEmailid%>" >
	       <input  type="hidden" name="password" id="password" value="<%=userPassword%>" >
	       <input type="hidden" id="profilelist" name="profilelist" value="${profilelist}">
	       
	   <a title="View Org Charts and Department Information." onClick="calBusinessArea();">
	   	<div class="col-md-2 col-sm-3 col-xs-6" style="cursor:pointer;">
				<div class="panel panel-info btn-default panel-shadow">
					<div class="panel-body" style="color:#0071BA;">
					   <i class="fa fa-sitemap fa-2x pull-left"></i> <span class="pull-right" style="font-size:11pt;font-weight:600;">Business Areas </span>
					</div>
				</div>
			</div>	
	   </a>
	 </form>	 

	<!--	 
 <form name="connectair" method="POST">
     <input  type="hidden" name="emailid" id="emailid" value="<%=userFullEmailid%>" >
     <input  type="hidden" name="password" id="password" value="<%=userPassword%>" >
   <a title="View Org Charts and Department Information."  onClick="calBusinessUpdates();">
		<div class="col-md-2 col-sm-3 col-xs-6" style="cursor:pointer;">
			<div class="panel panel-info btn-default panel-shadow">
				<div class="panel-body" style="color:#0071BA;">
				   <i class="fa fa-info-circle fa-2x pull-left"></i> <span class="pull-right" style="font-size:11pt;font-weight:600;">Business Updates </span>
				</div>
			</div>
		</div>	
   </a>
</form>
		
  
	<a href="BENIFITS/company_benifit.jsp" target="_new">
		<div class="col-md-2 col-sm-3 col-xs-6" style="cursor:pointer;">
			<div class="panel panel-info btn-default panel-shadow">
				<div class="panel-body" style="color:#0071BA;">
					 <i class="fa fa-signal fa-2x pull-left"></i> <span class="pull-right" style="font-size:11pt;font-weight:600;">Benefits/Handbook </span>
				</div>
			</div>
		</div>	
	</a>	
	-->	
		
 <form name="employee_discount" method="POST">  
        <input  type="hidden" name="emailid" id="emailid" value="<%=userFullEmailid%>" >	
         <input  type="hidden" name="password" id="password" value="<%=userPassword%>" >
         <input type="hidden" id="profilelist" name="profilelist" value="${profilelist}">	
		<a title="Employee Benifit Programme."  onClick="calEmployee_discount();">
		<div class="col-md-2 col-sm-3 col-xs-6" style="cursor:pointer;">
			<div class="panel panel-info btn-default panel-shadow">
				<div class="panel-body" style="color:#0071BA;">
					<i class="fa fa-cart-plus fa-2x pull-left"></i> <span class="pull-right" style="font-size:11pt;font-weight:600;">Employ. Discounts </span>
				</div>
			</div>
		</div>	
		</a>
</form>	

 <form name="callive_well1" method="POST">  	
       <input  type="hidden" name="emailid" id="emailid" value="<%=userFullEmailid%>" >
        <input  type="hidden" name="password" id="password" value="<%=userPassword%>" >
        <input type="hidden" id="profilelist" name="profilelist" value="${profilelist}">
       <a title="Employee Assistance Programme." onClick="callive_well();">
        <div class="col-md-2 col-sm-3 col-xs-6" style="cursor:pointer;">
			<div class="panel panel-info btn-default panel-shadow">
				<div class="panel-body" style="color:#0071BA;">
				 	<i class="fa fa-heartbeat fa-2x pull-left"></i> <span class="pull-right" style="font-size:11pt;font-weight:600;">Live Well / EAP </span> 
				</div>
			</div>
	    </div>	
         </a>
</form>	


<c:if test = "${fn:contains(profilelist, 'Refis')}"> </c:if>	
 
	
 <form name="refis" method="POST">  	
       <input  type="hidden" name="emailid" id="emailid" value="<%=userFullEmailid%>" >
        <input  type="hidden" name="password" id="password" value="<%=userPassword%>" >
          <input type="hidden" id="profilelist" name="profilelist" value="${profilelist}">
       <a title="New Ground Operations" onClick="calNewRefis();">
        <div class="col-md-2 col-sm-3 col-xs-6" style="cursor:pointer;">
			<div class="panel panel-info btn-default panel-shadow">
				<div class="panel-body" style="color:green">
				 	<i class="fa fa-road fa-2x pull-left"></i> <span class="pull-right" style="font-size:11pt;font-weight:600;color:#0071BA;">Ground Ops Website.</span> 
				</div>
			</div>
	    </div>	
         </a>
</form>	


	
<c:if test = "${fn:contains(profilelist, 'Contract')}"> 
		
	 <form name="contract"  id="contract" method="POST">  	
	       <input  type="hidden" name="emailid" id="emailid" value="<%=userFullEmailid%>" >
	        <input  type="hidden" name="password" id="password" value="<%=userPassword%>" >
	        <input type="hidden" id="profilelist" name="profilelist" value="${profilelist}">
	       <a title="Manage Contract." onClick="cal_manage_contract();">
	        <div class="col-md-2 col-sm-3 col-xs-6" style="cursor:pointer;">
				<div class="panel panel-info btn-default panel-shadow">
					<div class="panel-body" style="color:green">
					 <i class="fa fa-suitcase fa-2x pull-left" aria-hidden="true"></i><span class="pull-right" style="font-size:11pt;font-weight:600;color:#0071BA;">Contract Database</span> 
					</div>
				</div>
		    </div>	
	         </a>
	</form>	

</c:if>



<!-- 
     <a title="Employee Assistance Programme."  href="ajaxtest" target="_new"> 

	     <a title="Employee Assistance Programme."  href="test" target="_new">
	
	
        <div class="col-md-2 col-sm-3 col-xs-6" style="cursor:pointer;">
			<div class="panel panel-info btn-default panel-shadow">
				<div class="panel-body" style="color:#0071BA;">
				 	<i class="fa fa-lightbulb-o fa-2x pull-left"></i> <span class="pull-right" style="font-size:11pt;font-weight:600;"> Test BOX /  AJAX /  GRAPH </span> 
				</div>
			</div>
	    </div>	
         </a>




 
	<a title="Employee Assistance Programme." href="BENIFITS/idea_at_work.jsp" target="_new">
        <div class="col-md-2 col-sm-3 col-xs-6" style="cursor:pointer;">
			<div class="panel panel-info btn-default panel-shadow">
				<div class="panel-body" style="color:#0071BA;">
				 	<i class="fa fa-lightbulb-o fa-2x pull-left"></i> <span class="pull-right" style="font-size:11pt;font-weight:600;">Idea At Work </span> 
				</div>
			</div>
	    </div>	
         </a>

	-->			




<!--Updated Area  For the Video Display ON Left side

<div class="container-fluid" align="left">
	

	<div class="row">	
	
		
		<div class="col-lg-3 col-md-3 col-sm-3 col-xs-12"  >
			        <h6 class="post_title" ><b>A message from Mark Anderson, CEO Connect Airways</b></h6>
					<video width="100%" controls controlsList="nodownload">
					  <source src="mark.mp4">  type="video/mp4">
					  Your browser does not support HTML5 video.
					</video>
				
		</div>
		
	
		
		<div class="col-lg-3 col-md-3 col-sm-3 col-xs-12" style="margin-left:10px;" >
				   <h6 class="post_title" ><b>Mark Anderson, @ Dublin Townhall 9th July 2019</b></h6>
					<video width="100%" controls controlsList="nodownload">
					  <source src="markdublin2019.mp4" type="video/mp4">
					  Your browser does not support HTML5 video.
					</video>
				
		</div>
		
		
       <div class="col-lg-3 col-md-3 col-sm-3 col-xs-12" style="margin-left:10px;">
		       <h6 class="post_title" ><b>Today Flight Status</b></h6>
		       <p id="top_x_div"> </p>
	    </div>
	  
	  </div>
	
</div>	

 -->
 
 
 
 	<!--Covid 
	<div class="col-lg-5 col-md-5 col-sm-5 col-xs-12" >
			
			<div class="panel pane-default panel-shadow">
				<div class="panel-body" >
				
				<table class="table bordered" style="border-color:black;">	 
				
				
				
				 <thead>
				 <tr align="center">
				 <td align="center" style="background:#F1C40F"> 
				            <span style="color:black;font-size:15px;font-weight:600;">Corona Virus Latest Update</span>  
				 </td>
				 </tr>
				 </thead>
				 
				    <tr>
				          <td>
				              <i class="fa fa-chevron-circle-right"></i>&nbsp;&nbsp;<a href="AllStaffCoronavirusInformation12Feb002.pdf"  target="_blank">&nbsp; <b> General info for All Staff.</b> 
                          &nbsp;</a> <img  src="images/page_white_acrobat.png"> 
  
				          </td>
				    
				    </tr>
				
				
				   <tr>
				          <td>
				          					  <i class="fa fa-chevron-circle-right"></i>&nbsp;&nbsp;<a href="GuidanceonCOVID19forworkers.pdf"  target="_blank">&nbsp; <b>  HSE Guidance on COVID-19.</b> 
                          &nbsp;</a> <img  src="images/page_white_acrobat.png"> 
  
				          </td>
				    
				    </tr>
				    
				    <tr>
				          <td>
				          	  <i class="fa fa-chevron-circle-right"></i>&nbsp;&nbsp;<a href="https://www.dfa.ie/travel/travel-advice/coronavirus/"  target="_blank">&nbsp; <b> Travel Advise.</b> 
                          &nbsp;</a> <img  src="images/page_white_acrobat.png"> 
  
				          </td>
				    
				    </tr>
				
				
				
				</table>

	
				</div>
			</div>
			
		</div>
  --> 
 
 


				<!--Full Width text  		
				<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">		
						     <marquee>
									<span class="label label-warning"  style="font-weight:600;font-size:22pt;color:black;">
									    
									       <b> Hi this is Test message please confirm if this is OK ??  </b>					        
									</span>
								</marquee>
				    
				</div>
	
              -->

        <div class="col-md-6 col-sm-3 col-xs-6" style="cursor:pointer;">
			<div class="panel">
				<div class="panel-body" style="color:#0071BA;">
	              	  <img src="pdf.png">&nbsp;&nbsp;<a href="Pandemic Guide/Organisational Pandemic Guidance Manual Revision 1.1.0.pdf" target="_new"> 
		  	              <b>Organisational Pandemic Guide - OPG.</b>
		  	          </a>
		  	          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		  	          <img src="pdf.png">&nbsp;&nbsp; <a href="Pandemic Guide/OperationalGuidance.pdf" target="_new"> <b> Pandemic Operational Guide - POG. </b>  </a>
				</div>
			</div>
	    </div>	



	
	</div>		
</div>


		

			
	    <div class="col-md-6 col-md-offset-3 col-sm-12 col-xs-12">		     

			          			
		</div>


		 	





<!--END OF  Updated Area  For the Video Display -->

	
	<!--Full Width text-->
	<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
		
		<div class="panel pane-default panel-shadow">
			<div class="panel-body">

				<p align="justify" class="my_discription">
					<b>Welcome to Stobart Air Link </b>, our internal information portal for Stobart Air employees. The primary purpose of this site is to provide ease of access to Company information and systems.  By logging in just once and then clicking through on the tiles below you can access your work email,  our existing crew website and staff travel.  In addition, through this single entry point you can click into various other information systems which you may use for work purposes, including Q-Pulse and Pelesys Training.  We have also populated the site with links to our Company policies and benefit information, updates to which will be communicated here.
					Stobart Air Link is our platform to share Company news and developments with you.  Please visit Link regularly to ensure you keep up to date on news, developments, and opportunities.  
				</p>
			</div>
		</div>
		
	</div>

	



<div class="container-fluid" align="left">
	
	<div class="row">
	
	<!--  
		<div class="col-lg-3 col-md-3 col-sm-3 col-xs-12">
	
			<div class="panel panel-default panel-shadow" onClick="alert('Under Construction');"> 
				<div class="panel-body" style="height:200px;background:url('<c:url value="images/policy.jpg"/>') no-repeat 50% 50%; background-size:cover;cursor:pointer;"></div>
				
				<div class="panel-footer">
					<h5 class="post_title"><b>Company Policy and Procedures</b></h5>				
					<p align="justify" class="my_discription">
						Here you can  access HR policy  documents which supplement the  terms outlined  in your contract  of employment.  These policy documents provide guidance in relation to company standards,  policies and procedures.
					</p>
						<br />
						<a href="BENIFITS/benifits-management.jsp" target="_new" id="p1">Read More</a> &nbsp; &nbsp;
				</div>
			</div>
		</div>
		-->
		
	  <div class="col-lg-3 col-md-3 col-sm-3 col-xs-12">
	
			<div class="panel panel-default panel-shadow"> 
				<div class="panel-body" style="height:200px;background:url('<c:url value="images/greenawards.png"/>') no-repeat 50% 100%; background-size:cover;cursor:pointer;"></div>
				
				<div class="panel-footer">
					<h5 class="post_title"><b>2020 Green Award </b></h5>				
					<p align="justify" class="my_discription">
						Stobart Air has been shortlisted for the Green Awards 2020 in the Green Transport category. This award recognises organisations which demonstrate a comprehensive programme of actions which promote sustainable transport.  
                        Stobart Air are the only airline shortlisted in these awards with the overall winner being announced on Tuesday, 25 February 2020.
						
					</p>
						<br />
						
				</div>
			</div>
		</div>
		
		
		
		
		
		
		<div class="col-lg-3 col-md-3 col-sm-3 col-xs-12">
			<div class="panel panel-default panel-shadow">
				<div class="panel-body" style="height:200px;background:url('<c:url value="images/careers.jpg"/>') no-repeat 50% 50%; background-size:cover;">
					<!--Leave it blank-->
				</div>
				
				<div class="panel-footer">
					<h5 class="post_title"><b>About Us</b></h5>
					<p align="justify"  class="my_discription">Stobart Air, the regional franchise flying partner to leading airlines, operates up to 940 flights weekly across 43 routes throughout 11 European countries from bases in the UK & Ireland. Today, Stobart Air is one of Europe's leading franchise.</p>
					<br>
					<br><br>
					<a href="https://www.stobartair.com/about/" target="_new" id="p2" >Read More</a>
				</div>
			</div>
		</div>
		
		<!-- 
		<div class="col-lg-3 col-md-3 col-sm-3 col-xs-12">
			<div class="panel panel-default panel-shadow">
				<div class="panel-body" style="height:200px;background:url('image/focus.jpg') no-repeat 50% 50%; background-size:cover;">  
			
				</div>
				
				<div class="panel-footer">
					<h5 class="post_title"><b>Aircraft Operator Award 2019</b></h5>				
					<p align="justify"  class="my_discription">				
						Stobart Air is future-focused. We believe strongly in our ability to compete internationally and provide best-in-class service to passengers flying with our franchise partners.
						We have also partnered with the Atlantic Flight Training Academy. 
					</p><br>
					
				</div>
			</div>
		</div>
		
		 -->
		
		
		<div class="col-lg-3 col-md-3 col-sm-3 col-xs-12">
			<div class="panel panel-default panel-shadow">
					<div class="panel-body" style="height:200px;background:url('<c:url value="images/award.png"/>') no-repeat 50% 50%; background-size:cover;">
				</div>
				
				<div class="panel-footer">
					<h5 class="post_title"><b>Aircraft Operator Award 2019</b></h5>				
					<p align="justify"  class="my_discription">				
						Stobart Air have won this years Aviation Industry Awards in the Aircraft Operator category! This category aims to recognise an airline who displays excellence consistently through their business including operational excellence, innovation, safety and environment. 
					</p><br>
					<br><br>
					<!-- <a href="javascript:alert('Under Construction')" id="p3">Read More</a> -->
				</div>
			</div>
		</div>
		
		
		
		<div class="col-lg-3 col-md-3 col-sm-3 col-xs-12">
			<div class="panel panel-default panel-shadow">
				<div class="panel-body" style="height:200px;background:url('<c:url value="images/aboutus.png"/>') no-repeat 50% 100%; background-size:cover;">
				
				</div>
				
				<div class="panel-footer">
					<h5 class="post_title"><b>Careers</b></h5>
					<p align="justify" class="my_discription">Our people are our key assets. Stobart Air is always looking for motivated, competent and responsible employees who are ready to give our customers the best service possible in the air and on the ground. We are always looking for.</p>
										<br>
					<br><br><a href="https://stobartair.com/careers/#open-positions" target="_new" id="p3">Read More</a>
				</div>
			</div>
		</div>
	</div>
</div>

<br>
<br>
<br>
<br>
<br>
<br>

	
	
	<!----------- Tooltip & popover initialization ------->
<script>
	$(document).ready(function(){
		$('[data-toggle="tooltip"]').tooltip(); 
		$('[data-toggle="popover"]').popover();
	});


</script>

	<!------------/-------------->
</body>



    	
<script>
	$(document).ready(function() {
		$(".my_close").click(function(){
			$(".my_popup").addClass("my_popup_closed");
		});
	});
</script>


<jsp:include page="include/footer.jsp" flush="true"></jsp:include>



</html>











