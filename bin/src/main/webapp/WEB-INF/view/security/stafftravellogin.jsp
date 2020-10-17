<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<jsp:include page="../include/header.jsp" />

<html>
<head>
    
    <title>Staff Travel - Login </title>



<body >
<br>
<br>
<br>

<!-- Body Banner -->

<form id="loginForm1" method="POST" name="loginForm1" action="https://stafftravel.stobartair.com/login/auth/j_spring_security_check">
				
      
      <input type="hidden" class="text_" name="j_username" id="j_username" value="<%=request.getParameter("j_username")%>"/>

	  <input type="hidden" class="text_" name="j_password" id="j_password" value="<%=request.getParameter("j_password")%>"/>
      
        <input type="hidden"  name="ready_to_go" id="ready_to_go" value="YES"> 

</form>
	
<!-- Body Banner -->
<div class="container-fluid" style="margin-top:70px;">
	
	<div class="row" style="margin-bottom:100px;">
	
		<div class="col-lg-6 col-lg-offset-3 col-md-6 col-md-offset-3 col-sm-8 col-sm-offset-2 col-xs-12 text-center">
		
			<img  src="<c:url value="images/loading.gif"/>"  width="40%">
		
		</div>
		

	</div>
	
 </div> 

</body>



</html>


<jsp:include page="../include/footer.jsp" />


    <script type="text/javascript">
            document.loginForm1.submit();
    </script>
