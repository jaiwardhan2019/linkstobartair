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
String fullemail            = request.getParameter("emailid");
if(fullemail.trim().length() < 2){response.sendRedirect("index");System.out.println(fullemail);}
String[] FirstName_LastName = fullemail.split("@");
String user_login_id        = FirstName_LastName[0];
%>


   
<script type="text/javascript">


function Logout_Admin(){

        if(confirm("Are you sure ??")){
        	window.close(this); 
            return true;
        }
        else
        {
            return false;
        }	 
	    
}


</script>




<!-- Menu --->	 
<nav class="navbar navbar-default navbar-fixed-top panel-shadow">

	<div class="container-fluid" style="background:#0071ba;" >
   
	<!-- Brand and toggle get grouped for better mobile display -->

 <div class="navbar-header" >

		<a class="navbar-brand" data-toggle="tooltip" data-placement="right" title="Stobart Air" style="margin-left:3px;margin-top:04px;padding:0px;" href="adminhome?emailid=<%=fullemail%>" >
			<img src="<c:url value="images/logo-menu-new.png"/>" alt="Admin Home" class="img-responsive" style="margin-top:-px;" />
		</a>
  </div>




    <!-- Collect the nav links, forms, and other content for toggling -->
    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
    
		<ul class="nav navbar-nav navbar-right">
     
        
        
        
          <li class="dropdown">		 
			  <a href="profilemanager?emailid=<%=fullemail%>" style="font-size:9pt;font-weight:600;color:#FDFEFE;" aria-expanded="false"><i class="fa fa-users" aria-hidden="true"></i>&nbsp;Manage Link Users Profile<span class="caret"></span></a>			  
								  
	       </li>
        
        
	
		<li class="dropdown">		 
			  <a href="#" style="font-size:9pt;font-weight:600;color:#FDFEFE;" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"><i class="fa fa-pencil-square-o" aria-hidden="true"></i>&nbsp;Content Managment<span class="caret"></span></a>			  
				  <ul class="dropdown-menu">
					 <li style="margin-top:3px;margin-bottom:3px;"><a href="businessareahome?emailid=<%=fullemail%>"  style="font-size:9pt;"><i class="fa fa-suitcase" aria-hidden="true"></i>&nbsp;Business Area</a></li>
					 
                  </ul>						  
	     </li>
	
			
		<li class="dropdown">
			  <a href="#" style="font-size:9pt;font-weight:600;color:#FDFEFE;" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"><i class="fa fa-user-circle"></i> <%=user_login_id%><span class="caret"></span></a>
			  <ul class="dropdown-menu">				
				<li style="margin-top:3px;margin-bottom:3px;"><a href="" onClick="Logout_Admin();" style="font-size:9pt;"><i class="fa fa-sign-out" aria-hidden="true"></i>&nbsp;Logout Admin</a></li>
			  </ul>
		</li>	
			
	
		<!-- 
		 <li class="dropdown">
		 
			  <a href="adminhome" style="font-size:9pt;font-weight:600;color:#FDFEFE;" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"> <i class="fa fa-address-card" aria-hidden="true"></i>&nbsp;Administration <span class="caret"></span></a>
			  
				  <ul class="dropdown-menu">
			       		<li style="margin-top:3px;margin-bottom:3px;"><a href="adminhome" target="_new"  style="font-size:9pt;"> <i class="fa fa-tachometer" aria-hidden="true"></i> Home</a></li>
			       </ul>
						  
			</li>
	 
	     -->
	
			
		
		</ul>
    </div>
	<!-- /.navbar-collapse -->
	


  </div>
  
</div>	<!-- /.container-fluid -->
	
</nav>


<!-- End of  Menu  --->	 




<script src="js/nicEdit-latest.js"></script>
 <script type="text/javascript">
        bkLib.onDomLoaded(function() { nicEditors.allTextAreas() });
</script>   
  
<link href="<c:url value="css/businessarea.css"/>" rel="stylesheet">


	<!-- jQuery -->
    <script src="js/jquery.min.js"></script>
   

    <!-- Bootstrap Core JavaScript -->
    <script src="js/bootstrap.min.js"></script>
