<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="userEmail" value='${userEmail}' scope="session" />
<jsp:include page="../include/header.jsp" />

<br>
<br>
<br>

<!-- <body  onload="document.forms[0].submit();">  --> 
<body  >       
       <form id="crewconnex" name="crewconnex" accept-charset="UTF-8" method="post" action="https://crewconnex.aerarann.com/sso.aspx" class="form-fields">
          <div class="form-field">
             <input type="hidden" id="page_x002e_components_x002e_slingshot-login_x0023_default-username" name="userid" maxlength="255" value="<%=request.getAttribute("userinitial")%>" />
          </div>
          <div class="form-field">
             <input type="hidden" id="page_x002e_components_x002e_slingshot-login_x0023_default-password" name="password" value="<%=request.getAttribute("userpassword")%>" maxlength="255" />
          </div>
          <div class="form-field">
             
          </div>
       </form>
       
  </body>


<!-- Body Banner -->
<div class="container-fluid" style="margin-top:70px;">
	
	<div class="row" style="margin-bottom:100px;">
	
		<div class="col-lg-6 col-lg-offset-3 col-md-6 col-md-offset-3 col-sm-8 col-sm-offset-2 col-xs-12 text-center">
		
			<img  src="<c:url value="images/loading.gif"/>"  width="40%">
		
		</div>
		

	</div>
	
 </div> 
    </body>
<jsp:include page="../include/footer.jsp" /> 
  
    <script type="text/javascript">
            document.crewconnex.submit();
    </script>
    
</html>




