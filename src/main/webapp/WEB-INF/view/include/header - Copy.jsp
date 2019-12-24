<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
String fullemail            = (String)session.getAttribute("userEmail");
if(fullemail.trim().length() < 2){response.sendRedirect("index");System.out.println(fullemail);}
String[] FirstName_LastName = fullemail.split("@");
String user_login_id        = FirstName_LastName[0];
%>


<!-- Menu --->	 
<nav class="navbar navbar-default navbar-fixed-top panel-shadow">

	<div class="container-fluid" style="background:#0071ba;" >
   
	<!-- Brand and toggle get grouped for better mobile display -->

    <div class="navbar-header" >

		<a class="navbar-brand" data-toggle="tooltip" data-placement="right" title="Stobart Air" style="margin-left:3px;margin-top:04px;padding:0px;" >
			<img src="<c:url value="images/logo-menu-new.png"/>" alt="StobartAir" class="img-responsive" style="margin-top:-px;" />
		</a>	
    </div>
  
    

 <!-- Collect the nav links, forms, and other content for toggling -->
  <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
    
		<ul class="nav navbar-nav navbar-right">
		
		
		
         <!-- FIRST MENU -->		
	     <li class="dropdown">
		 
			  <a href="adminhome" style="font-size:9pt;font-weight:600;color:#FDFEFE;" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"> <i class="fa fa-plane" aria-hidden="true"></i> &nbsp; Flight Reports  <span class="caret"></span></a>
			  
				  <ul class="dropdown-menu">
				        
				        <c:if test="${profilelist.MAYFLY  == 'Y'}">   
				            <li style="margin-top:3px;margin-bottom:3px;"><a href="flight_mayFly_report?emailid=<%=session.getAttribute("userEmail")%>&airportcode=ALL&airlineCode=ALL" target="_new"  style="font-size:9pt;"><i class="fa fa-database" aria-hidden="true"></i>&nbsp;&nbsp;May Fly</a></li>
					    </c:if>
					    <c:if test="${profilelist.RELIABLITY  == 'Y'}"> 
					         <li style="margin-top:3px;margin-bottom:3px;"><a href="reliabilityReportForm?emailid=<%=session.getAttribute("userEmail")%>" target="_new"  style="font-size:9pt;"><i class="fa fa-database" aria-hidden="true"></i>&nbsp;&nbsp;Reliability Report</a></li>
					    </c:if> 
					     <!-- <li style="margin-top:3px;margin-bottom:3px;"><a  target="_new"  style="font-size:9pt;"><i class="fa fa-database" aria-hidden="true"></i>  Reliability Action</a></li>-->
					    
					     <c:if test="${profilelist.DAILYSUMMARY  == 'Y'}"> 					     
					        <li style="margin-top:3px;margin-bottom:3px;"><a href="flight_daily_summary_report_form?emailid=<%=session.getAttribute("userEmail")%>" target="_new"  style="font-size:9pt;"><i class="fa fa-database" aria-hidden="true"></i>&nbsp;&nbsp;Daily Summary Report</a></li>
					     </c:if> 
					     
					     <c:if test="${profilelist.FLYBETODAY  == 'Y'}">  
							  <li style="margin-top:3px;margin-bottom:3px;"><a href="http://www.stobartair.com/flight-status/" target="_new"  style="font-size:9pt;"><i class="fa fa-plane" aria-hidden="true"></i>&nbsp;&nbsp;Flybe Today Flight Status</a></li>
			    		 </c:if> 
						 
			     
			     </ul>	 
			     
			     
			      
		</li>
		
		
	
			
	    <!-- SECOND  MENU -->	
			<li class="dropdown">
					  <a href="#" style="font-size:9pt;font-weight:600;color:#FDFEFE;" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"> <i class="fa fa-user-circle"></i>&nbsp;<%=user_login_id %><span class="caret"></span></a>
					  <ul class="dropdown-menu">
					  
					   <c:if test="${profilelist.ADMIN  == 'Y'}">   
		                       <li style="margin-top:3px;margin-bottom:3px;"><a href="adminhome" target="_new"  style="font-size:9pt;"><i class="fa fa-address-card" aria-hidden="true"></i>&nbsp;&nbsp;Admin</a></li>
                        </c:if> 
			                 
						  <li style="margin-top:3px;margin-bottom:3px;"><a href="logout" style="font-size:9pt;"><i class="fa fa-sign-out" aria-hidden="true"></i>&nbsp;&nbsp;Logout</a></li>
					  
					  </ul>
			 </li>	
			 
			 <!-- THIRD MENU ----------
		
				 <li class="dropdown">
				 
					  <a href="adminhome" style="font-size:9pt;font-weight:600;color:#FDFEFE;" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"> <i class="fa fa-address-card" aria-hidden="true"></i>&nbsp;Administration <span class="caret"></span></a>
					  
						  <ul class="dropdown-menu">
					       		<li style="margin-top:3px;margin-bottom:3px;"><a href="adminhome" target="_new"  style="font-size:9pt;"> <i class="fa fa-tachometer" aria-hidden="true"></i> Home</a></li>
					       </ul>
								  
					</li>
			 
	         -->
			 
			 
			 
			 		
		
		</ul>
    </div>

	



  
</div>	<!-- /.container-fluid -->
	
</nav>


<!-- End of  Menu  --->	 



	<!-- jQuery -->
    <script src="js/jquery.min.js"></script>
   

    <!-- Bootstrap Core JavaScript -->
    <script src="js/bootstrap.min.js"></script>
