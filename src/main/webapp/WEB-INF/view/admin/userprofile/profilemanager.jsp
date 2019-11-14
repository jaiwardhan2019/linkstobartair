<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="../../include/adminheader.jsp" />

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Link | Users  Profile Managment </title>
</head>



<script type="text/javascript">
	


function searchUser(){


	  var userid = document.getElementById("user").value.trim();
      if(userid == ''){
	      alert("Please Enter User First Name , Last Name or Anything you remember.");
	      document.getElementById("user").focus();
	      return false;
	  }
      else
      {

    	  document.linkuser.method="POST"
		  document.linkuser.action="profilemanager?emailid=${emailid}";
	      document.linkuser.submit();
		  return true;

       }
          
             

}



</script>



<body>



<br>


 <div  style="margin-top:60px;" align="center">	
	
		<div class="col-md-12 col-sm-12 col-xs-12"  align="left">
			<i class="fa fa-users" aria-hidden="true"></i>&ensp;<span style="font-weight:600;font-size:13pt;">Manage Link Users Profile  </span></a>
	   </div>	
  
  </div>		
	
<br>

<!-- Body Banner -->
<div class="container" align="center" >
	  	
<!----------------- RIGHT CONTENT -------------------->
<div class="col-md-12 col-sm-12 col-xs-12" align="center">

<form method="post" name="linkuser" onSubmit="return searchUser()";>
   
    <table  border="0" style="width: 50%;" align="center"> 
    			
				<tbody>	
		                       				     

		    		  
		   		  <tr>
		
				      <td align="right">
									<input autofocus  type="text" name="user"  id="user"  class="form-control"    placeholder="Enter First Name or Last Name"/>
								      
				
					      </td>
					      <td align="left">
					         &nbsp;&nbsp;&nbsp;  <input type="button"   class="btn btn-primary" value="Search" id="buttonDemo1" onClick="searchUser();" />   
					           
						
				           
					      </td>
				     
				     </tr>
				     
				     
	
	           </tbody>
	
	
	
	
  </table>	
  
 </form>
  	 
	<br><br>
 		 
  <table class="table table-striped table-bordered" border="1" style="width: 80%;" align="center">	
		
	     <tr align="center">
				    
				    <td bgcolor="#0070BA">
					   <span style="color:white;" > <b> 
					    No.	
					     </b></span>					 
					 </td>
					  
					 <td bgcolor="#0070BA">
					   <span style="color:white;"> <b> 
					      Name 	
					     </b></span>					 
					 </td>
					 <td bgcolor="#0070BA">
					   <span style="color:white;"> <b> 
					    Email 	
					     </b></span>					 
					 </td>
					 <td bgcolor="#0070BA">
					   <span style="color:white;"> <b> 
					      Active Status 	
					     </b></span>					 
					 </td>
					
					 <td bgcolor="#0070BA">
					   <span style="color:white;"> <b> 
					      Stobart / External 	
					     </b></span>					 
					 </td>
				     
				     <td bgcolor="#0070BA">
					   <span style="color:white;"> <b> 
					      Last Login Date and Time 	
					     </b></span>					 
					 </td>
          </tr>
           <%int ctr=1;%>
           <c:forEach var="linkusers" items="${linkuserlist}"> 
           
		               
		          <tr>
		          
		          <td><%=ctr%></td>
		          
		          <td><a href="updatelinkuserprofile?emailid=${emailid}&id=${linkusers.emailId}"> ${linkusers.firstName}&nbsp;${linkusers.lastName} </a></td>
		          <td><a href="updatelinkuserprofile?emailid=${emailid}&id=${linkusers.emailId}">${linkusers.emailId}</a></td>
		          <td> ${linkusers.activeStatus} </td>
		          <td> 
	
					<c:choose>
					    <c:when test="${linkusers.stobart_external_user == 'I'}">
					             <span style="color:black;"> <c:out value = "Stobart User "/></span>
					        <br />
					    </c:when>    
					    <c:otherwise>
					           <b> <span style="color:blue;"> <c:out value = "External User "/></span></b>
					        <br />
					    </c:otherwise>
					</c:choose> 
	                 
		          </td>
		           
		           <td>  
		             
		                ${linkusers.lastLoginDateTime}
		           
		           </td>
		          
		          </tr>
		         
		           <%
		           ctr++;
		           %>
           
           </c:forEach>
          
       
          <tr>
            <td colspan="6"> <p id="result1"></p>	 </td>
          </tr>
          
          
         </table> 

        </div>
        
        
        
      </div>  

<script>

	$("#user").keyup(function(event){
		if(event.keyCode == 13){
			//$("#buttonDemo1").click();
			 
		}
	});
</script>

</body>
</html>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>

