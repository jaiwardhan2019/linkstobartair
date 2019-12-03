<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="../include/refisheader.jsp" />

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Manage REFIS User Account </title>
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

    	  document.refieUser.method="POST"
		  document.refieUser.action="managerefisuser";
	      document.refieUser.submit();
		  return true;

       }
          
             

}




function remove_user_Profile(accountid){
			
		if(confirm("Are you sure about Removing This User ??")){
		      //document.refieUser.method="POST"
			  //document.refieUser.action="stafflist?account="+accountid;
		      //document.refieUser.submit();
			  //return true;
		
		}

		alert("Under Construction..");

} //-------- End Of Function 




function update_user_Profile(accountid){
			
		if(confirm("Are you sure about Removing This User ??")){
		      //document.refieUser.method="POST"
			  //document.refieUser.action="stafflist?account="+accountid;
		      //document.refieUser.submit();
			  //return true;		
		}
		alert("Under Construction.."+accountid);

} //-------- End Of Function 




function view_user_Profile(accountid){
		      //document.refieUser.method="POST"
			  //document.refieUser.action="stafflist?account="+accountid;
		      //document.refieUser.submit();
			  //return true;		
		alert("View User Profile Under  Construction.."+accountid);

} //-------- End Of Function 





function add_new_user(){
		      //document.refieUser.method="POST"
			  //document.refieUser.action="stafflist?account="+accountid;
		      //document.refieUser.submit();
			  //return true;		
		alert("Under Construction..");

} //-------- End Of Function 








</script>



<body>



<br>


 <div  style="margin-top:60px;" align="center">	
	
		<div class="col-md-12 col-sm-12 col-xs-12"  align="left">
			<i class="fa fa-users" aria-hidden="true"></i>&ensp;<span style="font-weight:600;font-size:13pt;">Manage Ground Ops  Users.</span></a>
	   </div>	
  
  </div>		
	
<br>

<!-- Body Banner -->
<div class="container" align="center" >
	  	
<!----------------- RIGHT CONTENT -------------------->
<div class="col-md-12 col-sm-12 col-xs-12" align="center">

<form method="post" name="refieUser" onSubmit="return searchUser()";>

  <input type="hidden" id="emailid" name="emailid" value="<%=request.getAttribute("emailid")%>">
  <input type="hidden" id="password" name="password" value="<%=request.getAttribute("password")%>">
   <br>
    <table  border="0" style="width: 50%;" align="center"> 
    			
				<tbody>	
			    		  
		   		  <tr>
				      <td align="right">
								<input autofocus  type="text" name="user"  id="user"  class="form-control"    placeholder="Enter First Name or Last Name"/>
					      </td>
					      <td align="left">
					         &nbsp;&nbsp;&nbsp;   
					          <span onClick="searchUser();" id="buttonDemo1" class="btn btn-primary" ><i class="fa fa-search" aria-hidden="true"></i>&nbsp;Search </span> 
						
				           
					      </td>
				     
				     </tr>
				     
				     <tr>
				        <td align="center"><br>
				              <span style="color:red;"> <b> ${deletestatus}    </b></span>	 
				               
				       </td>
				     </tr>
				     
				    
	
	           </tbody>
	
	
	
	
  </table>	
	<br><br>
	 		 
  <table  style="width: 80%;" align="center">
	  <tr>
		  <td align="right"> 
        		<span onClick="add_new_user();" id="addnew" class="btn btn-primary" ><i class="fa fa-user-plus" aria-hidden="true"></i>&nbsp;Add New User  </span> 
		 
		  </td>

	   </tr>	
			
 </table>	
	
 	<br>	 
  <table class="table table-striped table-bordered" border="1" style="width: 80%;" align="center">	
		
	     <tr align="center">
				    
				    <td bgcolor="#0070BA">
					   <span style="color:white;" > <b> 
					    User Name 	
					     </b></span>					 
					 </td>
					  
					 <td bgcolor="#0070BA">
					   <span style="color:white;"> <b> 
					      Account Description
					     </b></span>					 
					 </td>
	
					 <td bgcolor="#0070BA">
					   <span style="color:white;"> <b> 
					      Status					     
					      </b></span>					 
					 </td>
	
					 <td bgcolor="#0070BA">
					   <span style="color:white;"> <b> 
					    Permissions	
					     </b></span>					 
					 </td>
					
					     
				     <td bgcolor="#0070BA">
					   <span style="color:white;"> <b> 
					      Manage (Update /  Remove )	
					     </b></span>					 
					 </td>
          </tr>
           <%int ctr=1;%>
           <c:forEach var="refisAccount" items="${refisAccountlist}">          
		               
		          <tr>
		          
		          <td><i class="fa fa-user-circle-o  fa-lg" aria-hidden="true"></i> &nbsp;${refisAccount.username}</td>
		          
		          <td>${refisAccount.description} </td>
		         
		          <td>
		          
		            	<c:if test="${refisAccount.enabled == 1}">
		                     <i class="fa fa-check-circle  fa-lg" aria-hidden="true"></i>&nbsp; <span style="color:green;font-weight:bold;"> Enable</span>
		                </c:if>
		          
		          
		            	<c:if test="${refisAccount.enabled == 0}">
		                    <i class="fa fa-times  fa-lg" aria-hidden="true"></i>&nbsp;  <span style="color:red;font-weight:bold;"> Disable  </span>
		                </c:if>
		          

		                    
		          
		          </td>
	
		          <td> &nbsp;&nbsp; <span style="font-weight:bold;" onClick="view_user_Profile('${refisAccount.username}');"  class="btn btn-info btn-sm"><i class="fa fa-eye fa-lg" aria-hidden="true"></i> View  </span></td>
		         
		         
		           
		           <td align="center"> 
		                <span style="font-weight:bold;" onClick="update_user_Profile('${refisAccount.username}');"  class="btn btn-primary btn-sm"><i class="fa fa-pencil-square-o  fa-lg" aria-hidden="true"></i>&nbsp; Update </span>
		                &nbsp;&nbsp;&nbsp;&nbsp; 
		                <span style="font-weight:bold;" onClick="remove_user_Profile('${refisAccount.username}');" class="btn btn-danger btn-sm"><i class="fa fa-trash-o fa-fw  fa-lg"></i>&nbsp;Delete</span>
		           
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
  
 </form>
  	 

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

