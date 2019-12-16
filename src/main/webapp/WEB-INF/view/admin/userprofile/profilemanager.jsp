<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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


function show_contract_user_Profile(useremail){

		  document.linkuser.method="POST"
		  document.linkuser.action="showcontractaccessprofile?emailid="+useremail;
		  document.linkuser.submit();
		  return true;

	
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
					         &nbsp;&nbsp;&nbsp; 
					         
					         
					         			         
					         <span onClick="searchUser();" id="buttonDemo1" class="btn btn-primary" ><i class="fa fa-search" aria-hidden="true"></i>&nbsp;&nbsp;Search </span> 
					 
					           
	  
						
				           
					      </td>
				     
				     </tr>
				     
				     
	
	           </tbody>
	
	
	
	
  </table>	
  
 </form>
  	 
	<br><br>
 		 
  <table >
  <tr align="left"> 
   <td align="left"> 
      <button  class="btn btn-secondary btn-lg btn-block">${fn:length(linkuserlist)} - Users Found</button>
   </td>
  </tr>	
  </table>
  <br>
   		 
 
 		 
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
					      Manage Link Profile 	
					     </b></span>					 
					 </td>
				     
				     <td bgcolor="#0070BA">
					   <span style="color:white;"> <b> 
					      Stobart Contract 	
					     </b></span>					 
					 </td>
          </tr>
           <%int ctr=1;%>
           <c:forEach var="linkusers" items="${linkuserlist}"> 
           
		               
		          <tr>
		          
		          <td><%=ctr%></td>
		          
		          <td><i class="fa fa-user-circle-o" aria-hidden="true"></i> &nbsp; <a href="updatelinkuserprofile?emailid=${emailid}&id=${linkusers.emailId}"> ${linkusers.firstName}&nbsp;${linkusers.lastName} </a></td>
		          <td><a href="updatelinkuserprofile?emailid=${emailid}&id=${linkusers.emailId}">${linkusers.emailId}</a></td>
		          <td align="center"> 
		          
		             
	            	    <c:if test="${linkusers.activeStatus == 'Active'}">
		                     <i class="fa fa-check-circle  fa-lg" aria-hidden="true"></i>&nbsp; <span style="color:green;font-weight:bold;"> Enable</span>
		                </c:if>
		          
		          
		            	<c:if test="${linkusers.activeStatus == 'Dactive'}">
		                    <i class="fa fa-times  fa-lg" aria-hidden="true"></i>&nbsp;  <span style="color:red;font-weight:bold;"> Disable  </span>
		                </c:if>
		          
		          
		          </td>
		          <td align="center"> 
		          
		           <span style="font-weight:bold;" onClick="update_user_Profile('${linkusers.emailId}');"  class="btn btn-light btn-sm"><i class="fa fa-pencil-square-o  fa-lg" aria-hidden="true"></i>&nbsp; Update </span>
		            
		            <!-- 
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
	                 -->
		          </td>
		           
		           <td align="center">  
		               
		               <button type="button" onClick="show_contract_user_Profile('${linkusers.emailId}');" class="btn btn-success btn-sm"> <span style="font-weight:bold;"> Add Access</span>&nbsp;&nbsp;<i class="fa fa-plus  fa-lg" aria-hidden="true"></i></button> 
		                       
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
<%@include file="../../include/footer.jsp" %>
