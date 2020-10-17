<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="userEmail" value='${userEmail}' scope="session" />
<jsp:include page="../include/errorheader.jsp" />

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" charset="utf-8" />
        <title>QPulse - Login</title>
    </head>

    <body id="loggedOut">
        <div id="wrapper">
            <div id="header">
                <header id="formHeader">
                   
                </header>
            </div>
            
            <div class="container">
                <div id="content">
                    
<div class="row">
    <div class="span6 offset3">
        <div id="loggedOutContainer">
            <div id="logoHolder">
                     <div class="customer-logo-container">
                        
                     </div>

            </div>
            <div id="loggedOutBox">
                <div id="loggedOutBoxContent">
<form name="login" action="https://qpulse.stobartair.com/reporting/Account/LogOn?ReturnUrl=%2freporting%2f" method="post">                        <section id="fields">
                            <div class="editor-label">
                               
                            </div>
                            <div class="editor-field">
                                <input type="hidden" data-val="true" data-val-required="The Username field is required." id="UserName" name="UserName" type="text" value="<%=request.getAttribute("username")%>" />
                                <span class="field-validation-valid" data-valmsg-for="UserName" data-valmsg-replace="true"></span>
                            </div>
                          
                            <div class="editor-field">
                                <input type="hidden" data-val="true" data-val-required="The Password field is required." id="Password" name="Password" type="password" value="<%=request.getAttribute("password")%>"/>
                                <span class="field-validation-valid" data-valmsg-for="Password" data-valmsg-replace="true"></span>
                            </div>
                            <div class="editor">
                         
                               <!--  <input data-val="true" data-val-required="The Remember me field is required." id="RememberMe" name="RememberMe" type="checkbox" value="true" />  -->
                                <input name="RememberMe" type="hidden" value="false" />
                            </div>
                        </section>
                        <section id="buttons">
                     
                        </section>
</form>                    
                </div>
            </div>
            <div class="clearfix"></div>
        </div>
    </div>
</div>

  </div>

        </div>
    </div>
</div>


  <br>
  <br>
  <br>


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
            document.login.submit();
    </script>
    
</html>


