<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>

<script>
    //--- THIS PIECE OF CODE WILL DISABLE THE MOUSE RIGHT CLICK ------------ 
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
	
</script>


    <meta charset="utf-8">   
    <title>StobartAir| StobartAir | Link 1.1 </title>
    
    <!-- Bootstrap Core CSS --> 
    <link href="css/bootstrap.min.css" rel="stylesheet">	
	<link rel="stylesheet" href="<c:url value="css/freelancer.css"/>">
	
	<!-- FontAwesome FA FA ICONS -->
	<link rel="stylesheet" href="<c:url value="css/font-awesome.min.css"/>">
	
	<!-- Offline GOOGLE Fonts -->
	
	<link href="<c:url value="google-font/google-font-montserrat-400-700.css"/>"  >
	<link href="<c:url value="google-font/google-font-400-700.css"/>"  >
	
	<!-- Favicon -->
	<link rel="icon"   href="<c:url value="images/favicon.png"/>">
    
    
<!--Login box shadow-->

<style>
	.panel-shadow{
		-webkit-box-shadow: 3px 3px 10px 0px rgba(50, 50, 50, 0.23);
		-moz-box-shadow:    3px 3px 10px 0px rgba(50, 50, 50, 0.23);
		box-shadow:         3px 3px 10px 0px rgba(50, 50, 50, 0.23);
	}
</style>
	
</head>


<body style="font-family: 'Lato', 'Helvetica Neue', Helvetica, Arial, sans-serif;background:url('images/11.png');background-position: 50% 50%;background-size:cover;">



<script>
function myFunction(){
   
    var emailid = document.getElementById("emailid").value.trim();
    var password = document.getElementById("password").value.trim();
    if(emailid == ''){
      alert("Please enter your user id.");
      document.getElementById("emailid").focus();
      return false;
    } 
    
    if(password == ''){
       	alert("Please enter your password.");
        document.getElementById("password").focus();
        return false;
    }
    
    if(emailid != '' && password != ''){
       	document.login.method = "post"
    	document.login.action = "verifyuser";
        document.login.submit();
        return true;        
    }//----- End of if else 
      
    
}//------End of function 

</script>


<form method="post" name="login" onSubmit="return myFunction()";>
	 
<!-- Body Banner -->
<div class="container " style="margin-top:30px;">
	
	<div class="row">
        <div class="col-md-offset-2 col-md-8 col-sm-12 col-xs-12">
			
			<div class="panel panel-default" style="height:350px;background:rgba(200,210,210,6.9);">
				<div class="panel-body">
						
					<div class="row">
						<div class="col-md-5 col-sm-6 col-xs-12">
							<div class="panel panel-default panel-shadow" style="height:400px;">
								<div class="panel-body">									
									<div class="row hidden-md hidden-sm hidden-lg" style="margin-bottom:8px;">
										<div>
											
										</div>
									</div>
									
									<div class="row">
										<div class="col-md-12 col-sm-12 col-xs-12">
											<h5 class="" style="font-weight:600;color:#468499;">LOGIN TO PROCEED</h5>
											<hr />
										</div>
									</div>
									
									<div class="row" style="margin-bottom:10px;">
										<div class="col-md-12 col-sm-12 col-xs-12">
											<div class="input-group">
												<span class="input-group-addon" id="sizing-addon2" style="background:#005da8;border-color:#005da8;color:#fff;"><i class="fa fa-user fa-fw"></i></span>
												<input type="text"  autofocus name="emailid"  id="emailid" style="font-size:9pt;" class="form-control" placeholder="Email Id or User ID" aria-describedby="sizing-addon2"/>
											</div>
											<span style="font-size:10pt;" id="warning_username"></span>
										</div>
									</div>
									
									<div class="row" style="margin-bottom:10px;">
										<div class="col-md-12 col-sm-12 col-xs-12">
											<div class="input-group">
												<span class="input-group-addon" id="sizing-addon2" style="background:#005da8;border-color:#005da8;color:#fff;"><i class="fa fa-lock fa-fw"></i></span>
												<input type="password" name="password" id="password" style="font-size:9pt;" class="form-control" placeholder="Enter Password" aria-describedby="sizing-addon2" />
											</div>
											
										</div>
									</div>
								
								
									<div class="row">
										<div class="col-md-12 col-sm-12 col-xs-12 text-right">
											
											<span class="btn btn-primary" id="login_button" style="font-weight:600;font-size:9pt;" onClick="myFunction();"><i class="fa fa-lock fa-fw"></i>Login Securely</span><br/>
											
											<input type="submit" value="submit" style="display:none;" /> <br>
											<a href="https://password.stobartair.com" target="_new" style="font-size:9pt;" >Forgot your password?</a>
											
											 <br>									 
											 <span style="font-size:09pt;color:red;align:left;"  id="login_message">Please use your email id / User id and password to login</span>
											
										</div>
									</div>
								
								</div>
							</div>
						</div>
						
						<div class="col-md-6 col-md-offset-1 col-sm-5 col-sm-offset-1 hidden-xs">
							<div class="row" style="margin-bottom:8px;">
								<div class="col-md-12 col-sm-12 col-xs-12 text-center" style="padding-top:0px;">
									<img src="<c:url value="images/logo.png"/>" class="img-responsive" style="margin-top:-0px;"/>
								</div>
							</div>
							
							<div class="row">
								<div class="col-md-2 col-sm-3 col-xs-12">
									<img src="<c:url value="images/insight.png"/>" alt="StobartAir" class="img-responsive" />
								</div>
								<div class="col-md-10 col-sm-9 col-xs-12" style="color:#2C3E50;font-size:9pt;font-weight:300;">
									Manage all of the StobartAir in-house application in one place and in one login.
								</div>
							</div>
							<hr style="margin-bottom:8px;margin-top:8px;"/>
							<div class="row">
								<div class="col-md-2 col-sm-3 col-xs-12">
									<img src="<c:url value="images/documents.png"/>" alt="StobartAir" class="img-responsive" />
								</div>
								<div class="col-md-10 col-sm-9 col-xs-12" style="color:#2C3E50;font-size:9pt;font-weight:300;">
									Easy report generation.
								</div>
							</div>
							<hr style="margin-bottom:8px;margin-top:8px;"/>
							<div class="row">
								<div class="col-md-2 col-sm-3 col-xs-12">
									<img src="<c:url value="images/connections.png"/>" alt="StobartAir" class="img-responsive" />
								</div>
								<div class="col-md-10 col-sm-9 col-xs-12" style="color:#2C3E50;font-size:9pt;font-weight:300;">
									All employees who have access can login and keep track of their day to day job..
								</div>
							</div>

						</div>
					</div>
			
				</div>
			</div>
		</div>
	</div>
</div>

</form>

<!--OnClick Trigger --->

	<script>

		$("#emailid").keyup(function(event){
			if(event.keyCode == 13){
				$("#login_button").click();
			}
		});
	</script>
	
	
	
</body>
</html>

  
