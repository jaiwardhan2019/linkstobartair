<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="../include/header.jsp" />

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Manage Staff Travel Account </title>
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

    	  document.staffTravel.method="POST"
		  document.staffTravel.action="stafflist";
	      document.staffTravel.submit();
		  return true;

       }
          
             

}




function remove_user_Profile(accountid){
			
		if(confirm("Are you sure about Removing This User ??")){
		      document.staffTravel.method="POST"
			  document.staffTravel.action="stafflist?account="+accountid;
		      document.staffTravel.submit();
			  return true;
		
		}
		

} //-------- End Of Function 




</script>



<body>



<br>


 <div  style="margin-top:60px;" align="center">	
	
		<div class="col-md-12 col-sm-12 col-xs-12"  align="left">
			<i class="fa fa-users" aria-hidden="true"></i>&ensp;<span style="font-weight:600;font-size:13pt;">Manage Staff Travel Users.</span></a>
	   </div>	
  
  </div>		
	
<br>

<!-- Body Banner -->
<div class="container" align="center" >
	  	
<!----------------- RIGHT CONTENT -------------------->
<div class="col-md-12 col-sm-12 col-xs-12" align="center">

<form method="post" name="staffTravel" onSubmit="return searchUser()";>

  <input type="hidden" id="emailid" name="emailid" value="<%=request.getAttribute("emailid")%>">
  <input type="hidden" id="password" name="password" value="<%=request.getAttribute("password")%>">
   
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
				     
				     <tr>
				        <td align="center"><br>
				              <span style="color:red;"> <b> ${deletestatus}    </b></span>	 
				               
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
					      Account Holder Name 	
					     </b></span>					 
					 </td>
					 <td bgcolor="#0070BA">
					   <span style="color:white;"> <b> 
					    Email 	
					     </b></span>					 
					 </td>
					 <td bgcolor="#0070BA">
					   <span style="color:white;"> <b> 
					      Department 	
					     </b></span>					 
					 </td>
					
					 <td bgcolor="#0070BA">
					   <span style="color:white;"> <b> 
					      Status 	
					     </b></span>					 
					 </td>
				     
				     <td bgcolor="#0070BA">
					   <span style="color:white;"> <b> 
					      Remove. 	
					     </b></span>					 
					 </td>
          </tr>
           <%int ctr=1;%>
           <c:forEach var="staffTravels" items="${staffAccountlist}"> 
           
		               
		          <tr>
		          
		          <td><%=ctr%></td>
		          
		          <td> ${staffTravels.first_name}&nbsp;&nbsp;${staffTravels.surname} </td>
		          <td> ${staffTravels.email}</td>
		          <td> ${staffTravels.department} </td>
		          <td> 
	
			          ${staffTravels.status}
	
	                 
		          </td>
		           
		           <td>  
		             
		                
		                <span onClick="remove_user_Profile('${staffTravels.id}');" class="btn btn-danger"><i class="fa fa-trash-o fa-fw"></i>Remove</span>
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

