<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="en">
<head>
 
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

	document.stobart_home_page.method="POST";
	document.stobart_home_page.action="HomePage";
    document.stobart_home_page.submit();
	return true;
}



function calRefisReport(reportname){
	document.stobart_home_page.method="POST";
	document.stobart_home_page.action=reportname;
    document.stobart_home_page.submit();
	return true;
}




</script>



<form name="stobart_home_page" id="stobart_home_page">

  <input type="hidden" id="emailid" name="emailid" value="<%=fullemail%>">
  <input type="hidden" id="password" name="password" value="<%=password%>">

</form>


<!-- Menu --->	 
<nav class="navbar navbar-default navbar-fixed-top panel-shadow">

<div class="container-fluid" style="background:#0071ba;" >
   
	
    <div class="navbar-header">
         
		<a href="javascript:void();" onClick="calHomePage();"  class="navbar-brand" data-toggle="tooltip" data-placement="right" title="Link Home Page" style="margin-left:3px;margin-top:04px;padding:0px;" >
			<img src="images/logo-menu-new.png" alt="Link Home Page" class="img-responsive" style="margin-top:-px;" />
	    </a>
	
    </div>
  


 <!-- Collect the nav links, forms, and other content for toggling -->
  <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1" >
    
		<ul class="nav navbar-nav navbar-right">
		
<!-- 			
		 <li class="dropdown">
	 
	  	    <a href="javascript:void();" onClick="calHomePage();" style="font-size:9pt;font-weight:600;color:#FDFEFE;" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"><i class="fa fa-home fa-lg" aria-hidden="true"></i>&nbsp;&nbsp;Link Home</a>
					  
		</li>
 -->
 
         <!-- FIRST MENU -->		
	     <li class="dropdown">
		 
			  <a href="adminhome" style="font-size:09pt;font-weight:600;color:#FDFEFE;" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"> <i class="fa fa-plane" aria-hidden="true"></i> &nbsp;Reports <span class="caret"></span></a>
			  
				  <ul class="dropdown-menu">
				        
				        <c:if test="${profilelist.Flight_Report  == 'Y'}">   
				            <li style="margin-top:3px;margin-bottom:3px;"><a href="javascript:void();" onClick="calFlightReport('flight_mayFly_report?airportcode=ALL&airlineCode=ALL');"  style="font-size:09pt;"><img src="images/database.png">&nbsp;&nbsp;Flight Report (MayFly)</a></li>
					    </c:if>
					    <c:if test="${profilelist.Reliablity  == 'Y'}"> 
					         <li style="margin-top:3px;margin-bottom:3px;"><a href="javascript:void();" onClick="calFlightReport('reliabilityReportForm');"  style="font-size:09pt;"><img src="images/database.png">&nbsp;&nbsp;Reliability Report</a></li>
					    </c:if> 
					    
					    <c:if test="${profilelist.ReliablityAction  == 'Y'}"> 
					         <li style="margin-top:3px;margin-bottom:3px;"><a href="javascript:void();" onClick="calFlightReport('reliabilityAction');"  style="font-size:09pt;"><img src="images/database.png">&nbsp;&nbsp;Reliability Action</a></li>
					    </c:if> 
					    
					     <c:if test="${profilelist.Daily_Summary  == 'Y'}"> 					     
					        <li style="margin-top:3px;margin-bottom:3px;"><a href="javascript:void();" onClick="calFlightReport('flight_daily_summary_report_form?airlineCode=ALL');"   style="font-size:09pt;"><img src="images/database.png">&nbsp;&nbsp;Daily Summary Report</a></li>
					     </c:if> 
					     
					     <!-- 
					 
					     <c:if test="${profilelist.Voyager  == 'Y'}">  
					        <li style="margin-top:3px;margin-bottom:3px;"><a href="javascript:void();" onClick="calFlightReport('voyagerReport?airlineCode=ALL');" style="font-size:09pt;"><i class="fa fa-database" aria-hidden="true"></i>&nbsp;&nbsp;Voyager Report</a></li>
				         </c:if> 
					      -->
			     </ul>	 
			      
		</li>
	    
	    <li class="dropdown">
	 
	  	    <a href="javascript:void();" onClick="calHomePage();" style="font-size:9pt;font-weight:600;color:#FDFEFE;" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"><i class="fa fa-file-text-o" aria-hidden="true"></i>&nbsp;GCI / GCM /GCR</a>
					  
		</li>
		
		
	    <li class="dropdown">
	 
	  	    <a href="javascript:void();" onClick="calHomePage();" style="font-size:9pt;font-weight:600;color:#FDFEFE;" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"><i class="fa fa-file-text-o" aria-hidden="true"></i>&nbsp;Manuals</a>
					  
		</li>
	
		
	    <li class="dropdown">
	 
	  	    <a href="javascript:void();" onClick="calHomePage();" style="font-size:9pt;font-weight:600;color:#FDFEFE;" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"><i class="fa fa-file-text-o" aria-hidden="true"></i>&nbsp;Safety/Comp.</a>
					  
		</li>

	
	    <li class="dropdown">
	 
	  	    <a href="javascript:void();" onClick="calHomePage();" style="font-size:9pt;font-weight:600;color:#FDFEFE;" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"><i class="fa fa-file-text-o" aria-hidden="true"></i>&nbsp;Training.</a>
					  
		</li>
		
	    <li class="dropdown">
	 
	  	    <a href="javascript:void();" onClick="calHomePage();" style="font-size:9pt;font-weight:600;color:#FDFEFE;" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"><i class="fa fa-file-text-o" aria-hidden="true"></i>&nbsp;Daily OTP Report.</a>
					  
		</li>
		
		
	    <li class="dropdown">
	 
		  <a href="" style="font-size:9pt;font-weight:600;color:#FDFEFE;" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"><i class="fa fa-file-text-o" aria-hidden="true"></i>&nbsp;Weight Statement</a>
		  
					  
		</li>
	
	

	 <li class="dropdown">
	 
		  <a href="adminhome" style="font-size:9pt;font-weight:600;color:#FDFEFE;" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"><i class="fa fa-file-text-o" aria-hidden="true"></i>&nbsp;Documentation&nbsp;<span class="caret"></span></a>
		  
			   <ul class="dropdown-menu">

 		    	<li style="margin-top:3px;margin-bottom:3px;"><a href="adminhome"  style="font-size:9pt;"><img src="images/folder.png"> &nbsp;Catering - HAACP Manual</a></li>
		    	<li style="margin-top:3px;margin-bottom:3px;"><a href="adminhome"  style="font-size:9pt;"><img src="images/folder.png"> &nbsp;Cleaning </a></li>
		    	<li style="margin-top:3px;margin-bottom:3px;"><a href="adminhome"  style="font-size:9pt;"><img src="images/folder.png"> &nbsp;Compliance Monitoring</a></li>
		    	<li style="margin-top:3px;margin-bottom:3px;"><a href="adminhome"  style="font-size:9pt;"><img src="images/folder.png"> &nbsp;De-Icing Manuals</a></li>
		    	<li style="margin-top:3px;margin-bottom:3px;"><a href="adminhome"  style="font-size:9pt;"><img src="images/folder.png"> &nbsp;Catering - HAACP Manual</a></li>
		    	<li style="margin-top:3px;margin-bottom:3px;"><a href="adminhome"  style="font-size:9pt;"><img src="images/folder.png"> &nbsp;Catering - HAACP Manual</a></li>
		    	<li style="margin-top:3px;margin-bottom:3px;"><a href="adminhome"  style="font-size:9pt;"><img src="images/folder.png"> &nbsp;Catering - HAACP Manual</a></li>
		    	<li style="margin-top:3px;margin-bottom:3px;"><a href="adminhome"  style="font-size:9pt;"><img src="images/folder.png"> &nbsp;Catering - HAACP Manual</a></li>
		    	<li style="margin-top:3px;margin-bottom:3px;"><a href="adminhome"  style="font-size:9pt;"><img src="images/folder.png"> &nbsp;Catering - HAACP Manual</a></li>
		    	<li style="margin-top:3px;margin-bottom:3px;"><a href="adminhome"  style="font-size:9pt;"><img src="images/folder.png"> &nbsp;Catering - HAACP Manual</a></li>
 		    	

		       </ul>
					  
		</li>
		
	  		
		 <li class="dropdown">
	 
		  <a href="forms" style="font-size:9pt;font-weight:600;color:#FDFEFE;" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"><i class="fa fa-file-text-o" aria-hidden="true"></i>&nbsp;&nbsp;Forms&nbsp;<span class="caret"></span></a>
		  
			   <ul class="dropdown-menu">
			    
			    	<li style="margin-top:3px;margin-bottom:3px;"><a href="adminhome"  style="font-size:9pt;"><img src="images/folder.png"> &nbsp;Aer Lingus</a></li>
			    	<li style="margin-top:3px;margin-bottom:3px;"><a href="adminhome"  style="font-size:9pt;"><img src="images/folder.png"> &nbsp;FlyBe</a></li>
			    	<li style="margin-top:3px;margin-bottom:3px;"><a href="adminhome"  style="font-size:9pt;"><img src="images/folder.png"> &nbsp;Stobart Air</a></li>
			    	<li style="margin-top:3px;margin-bottom:3px;"><a href="adminhome"  style="font-size:9pt;"><img src="images/folder.png"> &nbsp;Disruption Notices</a></li>
			    
			    </ul>
					  
		</li>
 


	
		
		
	  <c:set var="userid" value="<%=user_login_id %>"/>
			

		
				 <li class="dropdown">
				 
					  <a href="refisadmin" style="font-size:9pt;font-weight:600;color:#FDFEFE;" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"><i class="fa fa-user-md" aria-hidden="true"></i>&nbsp;&nbsp;Admin <span class="caret"></span></a>
					  
						  <ul class="dropdown-menu">
					       		<li style="margin-top:3px;margin-bottom:3px;"><a href="javascript:void();" onClick="calRefisReport('managerefisuser');" style="font-size:9pt;"><img src="images/folder.png"> &nbsp;REFIS User</a></li>
					       		<li style="margin-top:3px;margin-bottom:3px;"><a href="adminhome"  style="font-size:9pt;"><img src="images/folder.png"> &nbsp;SMS Contacts Manager</a></li>
					       		<li style="margin-top:3px;margin-bottom:3px;"><a href="adminhome"  style="font-size:9pt;"><img src="images/folder.png"> &nbsp;Airline Data Manager</a></li>
					       		<li style="margin-top:3px;margin-bottom:3px;"><a href="adminhome"  style="font-size:9pt;"><img src="images/folder.png"> &nbsp;Crew Briefing Manager </a></li>
					       		<li style="margin-top:3px;margin-bottom:3px;"><a href="adminhome"  style="font-size:9pt;"><img src="images/folder.png"> &nbsp;Crew Flight Reports</a></li>
					      </ul>
								  
					</li>
         
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
	<i class="fa fa-road fa-2x pull-left"></i>&ensp;<span style="font-weight:600;font-size:13pt;color:black;">Ground Operations </span>
 </div>
 
<div  class="col-md-7 col-sm-7 col-xs-12" align="right">
	<span style="font-weight:300;font-size:12pt;color:black;align:right">	  
	<!-- 
	  <span class="label label-default">Menu 1</span>
      <span class="label label-primary">Menu 2</span>
      <span class="label label-success">Menu 3</span>
       -->
      <a href=""><span class="label label-success"><i class="fa fa-pencil-square-o" aria-hidden="true"></i>&nbsp;File A Report</span></a>&nbsp;&nbsp;&nbsp;
      <a href=""><span class="label label-danger"><i class="fa fa-volume-control-phone" aria-hidden="true"></i>&nbsp;Emergency Response</span></a>&nbsp;&nbsp;&nbsp;
      <a href=""><span class="label label-info"><i class="fa fa-envelope-o" aria-hidden="true"></i>&nbsp;Key Contacts</span></a> &nbsp;&nbsp;&nbsp;
      <a href=""><span class="label label-warning"><i class="fa fa-globe" aria-hidden="true"></i>&nbsp;Links</span></a>&nbsp;&nbsp;&nbsp;
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
	  if (event.keyCode === 13) {
	   event.preventDefault();
	   document.getElementById("myBtn").click();
	  }
	});
</script>

<!-- jQuery -->
   <script src="js/jquery.min.js"></script>  
   <script src="js/bootstrap.min.js"></script>




   