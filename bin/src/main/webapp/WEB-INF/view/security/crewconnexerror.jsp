<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="../include/errorheader.jsp" />

<!DOCTYPE html>
<html lang="en">

<head>
    <title>StobartAir| StobartAir | Link 1.1 </title>
</head>


<body style="font-family: 'Lato', 'Helvetica Neue', Helvetica, Arial, sans-serif;">


<!-- Body Banner -->
<div class="container-fluid" style="margin-top:70px;" align="center">
	
	<div class="row" style="margin-bottom:100px;">
		<div class="col-lg-6 col-lg-offset-3 col-md-6 col-md-offset-3 col-sm-8 col-sm-offset-2 col-xs-12 text-center">
			<h1 style="color:#ff6666;"><i class="fa fa-exclamation-triangle fa-5x"></i> <br /> ERROR!</h1>
		</div>		
		<div class="col-lg-6 col-lg-offset-3 col-md-6 col-md-offset-3 col-sm-8 col-sm-offset-2 col-xs-12 text-center">
			<div class="alert alert-danger" style="color:#000;text-center:justify;font-size:10pt;">
			    <br>
				<b><%=request.getAttribute("emailid")%> </b> &nbsp;&nbsp;&nbsp;Seems Like your account is either not setup or Locked<br><br> 
				Please Contact&nbsp;&nbsp; <b> CrewConnex.Password@stobartair.com  </b> <br> <br> 
				 Ops Supervisor <b> +353-1-8447602 </b>
			</div>
		</div>
		<br>
	    
	    
	    <div class="col-lg-6 col-lg-offset-3 col-md-6 col-md-offset-3 col-sm-8 col-sm-offset-2 col-xs-12 text-center">
			<a class="btn btn-default" onClick="javascript:window.close()" style="font-weight:600;color:#005da8;border:1px solid #005da8;">Sorry ! <i class="fa fa-smile-o" aria-hidden="true"></i></a>
		</div>
	    
	    
	    
	    
	</div>
	
	<br />

</div>
<jsp:include page="../include/footer.jsp" flush="true">
    <jsp:param name="user" value=''/>
</jsp:include>

</body>
</html>