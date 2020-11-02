<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>



<jsp:include page="../include/header.jsp" />

<html>
<head>
    
    <title>Staff Travel - Login </title>

<script type="text/javascript">

function Cancle_Login(){	
	
	if(confirm("Are you sure you dont want to \nGo ahead with the Staff Travel Booking.##??")){
	  window.close();
	}
	else
		{return false;}
	
	
	
}


function CalStaffTravel1(){	
	document.loginForm.action="stafftravellogin";
	document.loginForm.method="POST";
	document.loginForm.submit();
}







</script>


<body >
<br>
<br>
<br>

<!-- Body Banner -->
<div class="container-fluid" style="margin-top:70px;" align="center">		
 <div class="row" style="margin-bottom:100px;">


<form id="loginForm" name="loginForm">
 
      <input type="hidden" class="text_" name="emailid" id="emailid" value="<%=request.getParameter("emailid")%>"/>
 
      <input type="hidden" class="text_" name="j_username" id="j_username" value="<%=request.getParameter("j_username")%>"/>

	  <input type="hidden" class="text_" name="j_password" id="j_password" value="<%=request.getParameter("j_password")%>"/>
	  
	  <input type="hidden" id="profilelist" name="profilelist" value="<%=request.getParameter("profilelist")%>">
	  
	  
   
            	<table class="table table-bordered table-condensed" style="width:50%">
      	
      	     
				    <tr>
						<td align="Left" colspan="2">
						<b>DATA PRIVACY POLICY</b>
						</td>						
					</tr>	
				    <tr>
						<td align="justify" colspan="2">

						  In consideration of my participation in the Staff Travel Portal I represent and warrant that the Personal Data of any person (Data Subject) other than myself has only been provided by me on the basis that I have:
                            <br> <br>
                            - Made a copy of the Stobart Air Data Privacy Notice available to the Data Subject.<br>
                            - Informed the Data Subject that I am providing Stobart Air with the Personal Data concerned.<br>
                            - (Only if applicable) Obtained the consent of the Parent/Guardian of any Data Subject under 16 years of age to providing the Personal Data concerned.
						  <br><br>
						 
						</td>						
					</tr>
									
					
	                <tr>
	                    <td class="text-center" colspan="2" >
						  <input type="button" name="back"  class="btn btn-primary" value=" Not Agree "  onclick="Cancle_Login();">&nbsp;&nbsp;&nbsp;&nbsp;
						  <input type="button" id="create" name="back"  class="btn btn-primary" value=" I Agree " onclick="CalStaffTravel1();">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							
						</td>				
					</tr>
                
        </table>
        
      
        <input type="hidden"  name="ready_to_go" id="ready_to_go" value="YES"> 

</form>
		
			
			</div>				
	</div>	
	


</body>



</html>


<jsp:include page="../include/footer.jsp" />

