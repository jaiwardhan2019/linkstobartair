<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
 
<script>
    /*--- THIS PIECE OF CODE WILL DISABLE THE MOUSE RIGHT CLICK ------------ 
    var isNS = (navigator.appName == "Netscape") ? 1 : 0;
	if(navigator.appName == "Netscape") document.captureEvents(Event.MOUSEDOWN||Event.MOUSEUP);

	function mischandler(){
	    return false;
	}

	function mousehandler(e){
	var myevent = (isNS) ? e : event;
	var eventbutton = (isNS) ? myevent.which : myevent.button;
	if((eventbutton==2)||(eventbutton==3)) return false;
	}

	document.oncontextmenu = mischandler;
	document.onmousedown = mousehandler;
	document.onmouseup = mousehandler;
	*/
</script>


    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
 
  
    <!-- Bootstrap Core CSS --> 
    <link href="<c:url value="css/bootstrap.min.css"/>" rel="stylesheet">	
    
    
    
	<link rel="stylesheet" href="<c:url value="css/freelancer.css"/>">
	
	<!-- FontAwesome FA FA ICONS -->
	<link rel="stylesheet" href="css/font-awesome.min.css">
	
	<link rel="stylesheet" href="css/custom-style.css">
	
		
	
		
	<!-- Favicon -->
<link rel="icon"   href="<c:url value="images/favicon.png"/>">



</head>


<% 
String fullemail            = request.getAttribute("emailid").toString();
String password             = request.getAttribute("password").toString();
if(fullemail.trim().length() < 2){response.sendRedirect("index");}
String[] FirstName_LastName = fullemail.split("@");
String user_login_id        = FirstName_LastName[0];
//https://stackoverflow.com/questions/5053975/how-to-encode-a-string-representing-url-path-with-jstl

%>



<script type="text/javascript">

function calHomePage(){

	document.refisheader.method="POST";
	document.refisheader.action="HomePage";
    document.refisheader.submit();
	return true;
}



function calRefisReport(reportname){
	document.refisheader.method="POST";
	document.refisheader.action=reportname;
    document.refisheader.submit();
	return true;
}


function cal_groundops_home(usertype){	
	document.refisheader.method="POST";
	document.refisheader.action="groundopsHomePage?usertype="+usertype;	
    document.refisheader.submit();
	return true;
}



function calFlightReport(reportname){
		 document.refisheader.method="POST";
		 document.refisheader.action=reportname;
	     document.refisheader.submit();
		 return true;
}



function calDocumentReport(reportname){
		 document.refisheader.method="POST";
		 document.refisheader.action=reportname;
	     document.refisheader.submit();
		 return true;
}








</script>



<form name="refisheader" id="refisheader">
    <input type="hidden" name="emailid" value="<%=request.getParameter("emailid")%>">
    <input type="hidden" name="password" value="<%=request.getParameter("password")%>">
    <input type="hidden" name="usertype" value="${usertype}">
</form>



<!-- Menu --->	 
<nav class="navbar navbar-default navbar-fixed-top panel-shadow">

<div class="container-fluid" style="background:#0071ba;" >
   
	
    <div class="navbar-header">
    
       <c:if test="${usertype == 'I'}">   
	        
			<a href="javascript:void();" onClick="calHomePage();"  class="navbar-brand" data-toggle="tooltip" data-placement="right" title="Link Home Page" style="margin-left:3px;margin-top:04px;padding:0px;" >
				<img src="images/logo-menu-new.png" alt="Link Home Page" class="img-responsive" style="margin-top:-px;" />
		    </a>
       
       </c:if>
 	 	
 	   <c:if test="${usertype == 'E'}">
			<span class="navbar-brand" data-toggle="tooltip" data-placement="right" title="Link Home Page" style="margin-left:3px;margin-top:04px;padding:0px;" >
				<img src="images/logo-menu-new.png" alt="Link Home Page" class="img-responsive" style="margin-top:-px;" />
		    </span>
       </c:if>
 	
 	
 	
    </div>
  


 <!-- Collect the nav links, forms, and other content for toggling -->
  <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1" >
    
		<ul class="nav navbar-nav navbar-right">
		
 	<!-- 		
		 <li class="dropdown">
	 
	  	    <a href="javascript:void();" onClick="calHomePage();" style="font-size:9pt;font-weight:600;color:#FDFEFE;" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"><i class="fa fa-home fa-lg" aria-hidden="true"></i>&nbsp;&nbsp;Home</a>
					  
		</li>
 
    -->
    
         <!-- FIRST MENU -->		
	     <li class="dropdown">
		 
			  <a href="adminhome" style="font-size:09pt;font-weight:600;color:#FDFEFE;" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"> <i class="fa fa-plane" aria-hidden="true"></i> &nbsp;Reports <span class="caret"></span></a>
			  
				  <ul class="dropdown-menu">
				        
				        <c:if test="${profilelist.Flight_Report  == 'Y'}">   
				            <li style="margin-top:3px;margin-bottom:3px;"><a href="javascript:void();" onClick="calFlightReport('flightreport?airlinecode=ALL&airportcode=ALL&flightno=');"  style="font-size:09pt;"><img src="images/database.png">&nbsp;&nbsp;Flight Report (MayFly)</a></li>
					    </c:if>
					    <c:if test="${profilelist.Reliablity  == 'Y'}"> 
					         <li style="margin-top:3px;margin-bottom:3px;"><a href="javascript:void();" onClick="alert('Under Construction');"  style="font-size:09pt;"><img src="images/database.png">&nbsp;&nbsp;Reliability Report</a></li>
					    </c:if> 
					    
					    <c:if test="${profilelist.DelayReport  == 'Y'}"> 
					         <li style="margin-top:3px;margin-bottom:3px;"><a href="javascript:void();" onClick="alert('Under Construction');"  style="font-size:09pt;"><img src="images/database.png">&nbsp;&nbsp;Delay Report</a></li>
					    </c:if> 
					    
					     <c:if test="${profilelist.Daily_Summary  == 'Y'}"> 					     
					        <li style="margin-top:3px;margin-bottom:3px;"><a href="javascript:void();" onClick="alert('Under Construction');"   style="font-size:09pt;"><img src="images/database.png">&nbsp;&nbsp;Daily Summary Report</a></li>
					     </c:if> 
					     
					     <!-- 
					 
					     <c:if test="${profilelist.Voyager  == 'Y'}">  
					        <li style="margin-top:3px;margin-bottom:3px;"><a href="javascript:void();" onClick="calFlightReport('voyagerReport?airlineCode=ALL');" style="font-size:09pt;"><i class="fa fa-database" aria-hidden="true"></i>&nbsp;&nbsp;Voyager Report</a></li>
				         </c:if> 
					      -->
			     </ul>	 
			      
		</li>
	  
	   <c:if test="${profilelist.GCIGCMGCR  == 'Y'}">   
		    <li class="dropdown">		 
		  	    <a  style="font-size:9pt;font-weight:600;color:#FDFEFE;" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"><i class="fa fa-file-text-o" aria-hidden="true"></i>&nbsp;GCI /GCM /GCR&nbsp;<span class="caret"></span></a>
		  	   	   <ul class="dropdown-menu">
 		    	       <li style="margin-top:3px;margin-bottom:3px;"><a href="javascript:void();" onClick="calDocumentReport('listdocuments?cat=gci');"  style="font-size:9pt;"><img src="images/folder.png"> &nbsp;Ground Crew Instructions.</a></li>
		    	       <li style="margin-top:3px;margin-bottom:3px;"><a href="javascript:void();" onClick="calDocumentReport('listdocuments?cat=gcm');"  style="font-size:9pt;"><img src="images/folder.png"> &nbsp;Ground Crew Memo.</a></li>
		    	       <li style="margin-top:3px;margin-bottom:3px;"><a href="javascript:void();" onClick="calDocumentReport('listdocuments?cat=gcr');"  style="font-size:9pt;"><img src="images/folder.png"> &nbsp;Ground Crew Reminders.</a></li>
	             </ul>		  	   
		  	   
		  	    						  
			</li>
	    </c:if> 
	    
	    
	    
	  
	  <c:if test="${profilelist.Manuals  == 'Y'}">  	
	    <li class="dropdown">	 
	  	    <a href="javascript:void();" onClick="alert('Under Construction');" style="font-size:9pt;font-weight:600;color:#FDFEFE;" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"><i class="fa fa-file-text-o" aria-hidden="true"></i>&nbsp;Manuals</a>					  
		</li>
	</c:if>	
	
	
	  <c:if test="${profilelist.safetycompliance  == 'Y'}"> 	
	    <li class="dropdown">
	 
	  	    <a href="javascript:void();" onClick="alert('Under Construction');" style="font-size:9pt;font-weight:600;color:#FDFEFE;" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"><i class="fa fa-file-text-o" aria-hidden="true"></i>&nbsp;Safety Compliance.</a>
					  
		</li>
      </c:if>
      
      
     <c:if test="${profilelist.traning  == 'Y'}"> 	
	 
	    <li class="dropdown">
	 
	  	    <a href="javascript:void();" onClick="alert('Under Construction');" style="font-size:9pt;font-weight:600;color:#FDFEFE;" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"><i class="fa fa-file-text-o" aria-hidden="true"></i>&nbsp;Training.</a>
					  
		</li>
	</c:if>	
			
     <c:if test="${profilelist.weightstatement  == 'Y'}"> 			
	    <li class="dropdown">
	 
		  <a href="javascript:void();" onClick="alert('Under Construction');" style="font-size:9pt;font-weight:600;color:#FDFEFE;" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"><i class="fa fa-file-text-o" aria-hidden="true"></i>&nbsp;Weight Statement</a>
		  
					  
		</li>
	</c:if>
	
	
	
 <c:if test="${profilelist.documentation  == 'Y'}"> 		
	 <li class="dropdown">
	 
		  <a href="adminhome" style="font-size:9pt;font-weight:600;color:#FDFEFE;" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"><i class="fa fa-file-text-o" aria-hidden="true"></i>&nbsp;Documentation&nbsp;<span class="caret"></span></a>
		  
			   <ul class="dropdown-menu">

 		    	<li style="margin-top:3px;margin-bottom:3px;"><a href="javascript:void();" onClick="alert('Under Construction');"  style="font-size:9pt;"><img src="images/folder.png"> &nbsp;Catering - HAACP Manual</a></li>
		    	<li style="margin-top:3px;margin-bottom:3px;"><a href="javascript:void();" onClick="alert('Under Construction');"  style="font-size:9pt;"><img src="images/folder.png"> &nbsp;Cleaning </a></li>
		    	<li style="margin-top:3px;margin-bottom:3px;"><a href="javascript:void();" onClick="alert('Under Construction');"  style="font-size:9pt;"><img src="images/folder.png"> &nbsp;Compliance Monitoring</a></li>
		    	<li style="margin-top:3px;margin-bottom:3px;"><a href="javascript:void();" onClick="alert('Under Construction');"  style="font-size:9pt;"><img src="images/folder.png"> &nbsp;De-Icing Manuals</a></li>
	 		    	

		       </ul>
					  
		</li>
	</c:if>
		
	  		
 <c:if test="${profilelist.forms  == 'Y'}"> 		
	<li class="dropdown">
	 
		  <a href="forms" style="font-size:9pt;font-weight:600;color:#FDFEFE;" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"><i class="fa fa-file-text-o" aria-hidden="true"></i>&nbsp;&nbsp;Forms&nbsp;<span class="caret"></span></a>
		  
			   <ul class="dropdown-menu">
			    
			    	<li style="margin-top:3px;margin-bottom:3px;"><a href="javascript:void();" onClick="alert('Under Construction');"  style="font-size:9pt;"><img src="images/folder.png"> &nbsp;Aer Lingus</a></li>
			    	<li style="margin-top:3px;margin-bottom:3px;"><a href="javascript:void();" onClick="alert('Under Construction');"  style="font-size:9pt;"><img src="images/folder.png"> &nbsp;FlyBe</a></li>
			    	<li style="margin-top:3px;margin-bottom:3px;"><a href="javascript:void();" onClick="alert('Under Construction');"  style="font-size:9pt;"><img src="images/folder.png"> &nbsp;Stobart Air</a></li>
			    	<li style="margin-top:3px;margin-bottom:3px;"><a href="javascript:void();" onClick="alert('Under Construction');"  style="font-size:9pt;"><img src="images/folder.png"> &nbsp;Disruption Notices</a></li>
			    
			    </ul>
					  
		</li>
 </c:if>


	
		
		
	  <c:set var="userid" value="<%=user_login_id %>"/>
			

		 <c:if test="${profilelist.gopsadmin  == 'Y'}"> 	
				 <li class="dropdown">
				 
					  <a href="refisadmin" style="font-size:9pt;font-weight:600;color:#FDFEFE;" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"><i class="fa fa-user-md" aria-hidden="true"></i>&nbsp;&nbsp;Admin <span class="caret"></span></a>
					  
						  <ul class="dropdown-menu">
					       		<li style="margin-top:3px;margin-bottom:3px;"><a href="javascript:void();" onClick="calRefisReport('managegopssuser');" style="font-size:9pt;"><img src="images/folder.png"> &nbsp;REFIS User</a></li>
					       		<li style="margin-top:3px;margin-bottom:3px;"><a href="javascript:void();" onClick="alert('Under Construction');"  style="font-size:9pt;"><img src="images/folder.png"> &nbsp;SMS Contacts Manager</a></li>
					       		<li style="margin-top:3px;margin-bottom:3px;"><a href="javascript:void();" onClick="alert('Under Construction');"  style="font-size:9pt;"><img src="images/folder.png"> &nbsp;Airline Data Manager</a></li>
					       		<li style="margin-top:3px;margin-bottom:3px;"><a href="javascript:void();" onClick="alert('Under Construction');" style="font-size:9pt;"><img src="images/folder.png"> &nbsp;Crew Briefing Manager </a></li>
					       		<li style="margin-top:3px;margin-bottom:3px;"><a href="javascript:void();" onClick="alert('Under Construction');"  style="font-size:9pt;"><img src="images/folder.png"> &nbsp;Crew Flight Reports</a></li>
					      </ul>
								  
					</li>
         </c:if>
         
         
         
         
			<li class="dropdown">
					  <a href="#" style="font-size:09pt;font-weight:600;color:#FDFEFE;" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"> <i class="fa fa-user-circle"></i>&nbsp;&nbsp;${userid}&nbsp;<span class="caret"></span></a>
					  <ul class="dropdown-menu">
					      <li style="margin-top:0px;margin-bottom:0px;"><a href="logout" style="font-size:09pt;"><i class="fa fa-sign-out" aria-hidden="true"></i>&nbsp;&nbsp;Logout</a></li>
					  
					  </ul>
			 </li>	
			
		</ul>
    </div>


</div>	<!-- /.container-fluid -->


</nav>




<!-- End of  Menu  --->	 
<br>
<br>
<br>



<div class="col-md-5 col-sm-5 col-xs-12" >
  
  <c:if test="${usertype == 'I'}">
     <a onclick="cal_groundops_home('I');" href="javascript:void();"> <h5 style="font-weight:600;color:white;"><i class="fa fa-home"></i> Ground Ops</h5></a>
     
        
  </c:if>
  
  <c:if test="${usertype == 'E'}">
    <a onclick="cal_groundops_home('E');" href="javascript:void();"><h5 style="font-weight:600;color:white;"><i class="fa fa-home"></i> Ground Ops</h5></a> 
  </c:if>
  

 </div>
 
<div  class="col-md-7 col-sm-7 col-xs-12" align="right">
	<span style="font-weight:300;font-size:12pt;color:black;align:right">	  
	<!-- 
	  <span class="label label-default">Menu 1</span>
      <span class="label label-primary">Menu 2</span>
      <span class="label label-success">Menu 3</span>
       -->
      <a href=""><span class="label label-success"><i class="fa fa-commenting-o" aria-hidden="true"></i>&nbsp;File A Report</span></a>&nbsp;&nbsp;&nbsp;
      <a href=""><span class="label label-danger"><i class="fa fa-volume-control-phone" aria-hidden="true"></i>&nbsp;Emergency Response</span></a>&nbsp;&nbsp;&nbsp;
      <a href=""><span class="label label-info"><i class="fa fa-envelope-o" aria-hidden="true"></i>&nbsp;Key Contacts</span></a> &nbsp;&nbsp;&nbsp;
	</span>
	
 
      <input type="text"  id="myInput" placeholder="Search Document.." >
      <!-- <span id="searchbutton" onclick="manage_contract('search');" class="btn btn-primary btn-sm">&nbsp;&nbsp;<i class="fa fa-search  fa-lg" aria-hidden="true"></i>&nbsp;&nbsp;</span> -->
      <button type="submit"  id="myBtn" onclick="javascript:alert('Hello World!')"><i class="fa fa-search"></i></button>
	
 </div>
 
 
<br>
<br>
<br>

 
<script>
	var input = document.getElementById("myInput");
	input.addEventListener("keyup", function(event) {
	  if (event.keyCode == 13) {
	   event.preventDefault();
	   document.getElementById("myBtn").click();
	  }
	});
</script>

 
<!-- jQuery -->
   <script src="js/jquery.min.js"></script>  
   <script src="js/bootstrap.min.js"></script>


<style>
body1 {
  background-image: url('images/groundopsbackground.jpg');
  background-repeat: no-repeat;
  background-attachment: fixed;  
  background-size: cover;
}

body1 {
  background-image: url('images/refisback.jpg');
  background-repeat: no-repeat;
  background-attachment: fixed;  
  background-size: cover;
}

body1 {
  background-image: url('images/background.jpg');
  background-repeat: no-repeat;
  background-attachment: fixed;  
  background-size: cover;
}



body {
  background-image: url('images/groundopsbackground.png');
  background-repeat: no-repeat;
  background-attachment: fixed;  
  background-size: cover;
}


</style>

   