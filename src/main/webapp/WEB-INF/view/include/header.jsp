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
	<link rel="stylesheet" href="<c:url value="css/font-awesome.min.css"/>">
	
	<link rel="stylesheet" href="<c:url value="css/custom-style.css"/>">
	
	
	<!-- Bootstrap Datetime Picker CSS --> 
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datetimepicker/4.7.14/css/bootstrap-datetimepicker.min.css">
	
	
	
	
	<!-- Offline GOOGLE Fonts -->
	
	<link href="<c:url value="google-front/google-font-montserrat-400-700.css"/>" rel="stylesheet" type="text/css">
	<link href="<c:url value="google-front/google-font-400-700.css"/>" rel="stylesheet" type="text/css">
	
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



function calFlightReport(reportname){
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
   
	

    <div class="navbar-header"  >
         
		<a href="javascript:void();" onClick="calHomePage();"  class="navbar-brand" data-toggle="tooltip" data-placement="right" title="Link Home Page" style="margin-left:3px;margin-top:04px;padding:0px;" >
			<img src="images/logo-menu-new.png" alt="Link Home Page" class="img-responsive" style="margin-top:-px;" />
			
		</a>	
    </div>
  
    

 <!-- Collect the nav links, forms, and other content for toggling -->
  <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
    
		<ul class="nav navbar-nav navbar-right">
		
			
		 <li class="dropdown">
	 
	  	    <a  href="javascript:void();" onClick="calHomePage();" style="font-size:9pt;font-weight:600;color:#FDFEFE;" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false" title="Link Home Page"><i class="fa fa-home fa-lg" aria-hidden="true"></i>&nbsp;&nbsp;Link Home </a>
		  
					  
		</li>

	
	
		
         <!-- FIRST MENU -->		
	     <li class="dropdown">
		 
			  <a href="adminhome" style="font-size:09pt;font-weight:600;color:#FDFEFE;" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"> <i class="fa fa-plane" aria-hidden="true"></i> &nbsp;&nbsp;Reports <span class="caret"></span></a>
			  
				  <ul class="dropdown-menu">
				        
				        <c:if test="${profilelist.Flight_Report  == 'Y'}">   
				            <li style="margin-top:3px;margin-bottom:3px;"><a href="javascript:void();" onClick="calFlightReport('flight_mayFly_report?airportcode=ALL&airlineCode=ALL');"  style="font-size:09pt;"><i class="fa fa-database" aria-hidden="true"></i>&nbsp;&nbsp;Flight Report (MayFly)</a></li>
					    </c:if>
					    <c:if test="${profilelist.Reliablity  == 'Y'}"> 
					         <li style="margin-top:3px;margin-bottom:3px;"><a href="javascript:void();" onClick="calFlightReport('reliabilityReportForm');"  style="font-size:09pt;"><i class="fa fa-database" aria-hidden="true"></i>&nbsp;&nbsp;Reliability Report</a></li>
					    </c:if> 
					    
					    <c:if test="${profilelist.ReliablityAction  == 'Y'}"> 
					         <li style="margin-top:3px;margin-bottom:3px;"><a href="javascript:void();" onClick="calFlightReport('reliabilityAction');"  style="font-size:09pt;"><i class="fa fa-database" aria-hidden="true"></i>&nbsp;&nbsp;Reliability Action</a></li>
					    </c:if> 
					    
					     <c:if test="${profilelist.Daily_Summary  == 'Y'}"> 					     
					        <li style="margin-top:3px;margin-bottom:3px;"><a href="javascript:void();" onClick="calFlightReport('flight_daily_summary_report_form?airlineCode=ALL');"   style="font-size:09pt;"><i class="fa fa-database" aria-hidden="true"></i>&nbsp;&nbsp;Daily Summary Report</a></li>
					     </c:if> 
					     
					 
					     <c:if test="${profilelist.Voyager  == 'Y'}">  
					        <li style="margin-top:3px;margin-bottom:3px;"><a href="javascript:void();" onClick="calFlightReport('voyagerReport?airlineCode=ALL');" style="font-size:09pt;"><i class="fa fa-database" aria-hidden="true"></i>&nbsp;&nbsp;Voyager Report</a></li>
				         </c:if> 
				         
					     <c:if test="${profilelist.Flybe_Today  == 'Y'}">  
							  <li style="margin-top:3px;margin-bottom:3px;"><a href="http://www.stobartair.com/flight-status/" target="_new"  style="font-size:09pt;"><i class="fa fa-database" ></i> &nbsp;Flybe Today Flight Status &nbsp;&nbsp;</a></li>
			    		 </c:if> 
						 
			   		  
			     </ul>	 
			     
			     
			      
		</li>
		
		
	 		
	    <!-- SECOND  MENU -->	
			<li class="dropdown">
					  <a href="#" style="font-size:09pt;font-weight:600;color:#FDFEFE;" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"> <i class="fa fa-user-circle"></i>&nbsp;&nbsp;<%=user_login_id %>&nbsp;<span class="caret"></span></a>
					  <ul class="dropdown-menu">
					  
					   <c:if test="${profilelist.ADMIN  == 'Y'}">   
		                       <li style="margin-top:3px;margin-bottom:3px;"><a href="adminhome?emailid=<%=fullemail%>" target="_new"  style="font-size:09pt;"><i class="fa fa-address-card" aria-hidden="true"></i>&nbsp;&nbsp;Admin</a></li>
                        </c:if> 
			                 
						  <li style="margin-top:3px;margin-bottom:3px;"><a href="logout" style="font-size:09pt;"><i class="fa fa-sign-out" aria-hidden="true"></i>&nbsp;&nbsp;Logout</a></li>
					  
					  </ul>
			 </li>	
			 
				
		</ul>
    </div>


</div>	<!-- /.container-fluid -->
	
</nav>


<!-- End of  Menu  --->	 



<!-- jQuery -->
   <script src="js/jquery.min.js"></script>
  

   <!-- Bootstrap Core JavaScript -->
   <script src="js/bootstrap.min.js"></script>
   <script src="js/bootstrap-datepicker.js"></script>

   