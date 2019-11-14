              
    <body onload="document.forms[0].submit();">       
         
         <form id="page_x002e_components_x002e_slingshot-login_x0023_default-form" accept-charset="UTF-8" method="post" action="https://docs.aerarann.com/share/page/dologin" class="form-fields">
            <input type="hidden" id="page_x002e_components_x002e_slingshot-login_x0023_default-success" name="success" value="/share"/>
            <input type="hidden" name="failure" value="/share/page/type/login?error=true"/>
            <div class="form-field">
               <input type="hidden" id="page_x002e_components_x002e_slingshot-login_x0023_default-username" name="username" maxlength="255" value="<%=request.getAttribute("username")%>" />
            </div>
            <div class="form-field">
               <input type="hidden" id="page_x002e_components_x002e_slingshot-login_x0023_default-password" name="password" value="<%=request.getAttribute("password")%>" maxlength="255" />
            </div>
            <div class="form-field">
               
            </div>
         </form>
         
    </body>
   