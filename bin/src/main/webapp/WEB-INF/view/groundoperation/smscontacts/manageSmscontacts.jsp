<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="../../include/groundopsheader.jsp" />

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Manage Ground Ops User Account </title>
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

    	  document.smsUser.method="POST";
		  document.smsUser.action="managegopssuser";
	      document.smsUser.submit();
		  return true;

       }
          
             

}




function remove_user_Profile(accountid){
			
		if(confirm("Are you sure about Removing This User ??")){
			   document.smsUser.method="POST";
			   document.smsUser.operation.value="remove";
			   document.smsUser.userinsubject.value=accountid;
			   document.smsUser.action="managesmscontacts";
			   document.smsUser.submit();
			   return true;		
		 }
	

} //-------- End Of Function 




function update_user(){
	
	   document.smsUser.method="POST"
	   document.smsUser.operation.value="addnew";
	   document.smsUser.action="managesmscontacts";
	   document.smsUser.submit();
	   return true;		

} //-------- End Of Function 







function add_new_user(){
	
	   document.smsUser.method="POST"
	   document.smsUser.operation.value="addnew";
	   document.smsUser.action="managesmscontacts";
	   document.smsUser.submit();
	   return true;		

} //-------- End Of Function 







</script>



<body>


<!-- Body Banner -->
<div class="container" align="center" >
	  	
<!----------------- RIGHT CONTENT -------------------->
<div class="col-md-12 col-sm-12 col-xs-12" align="center" >

<form method="post" name="smsUser" onSubmit="return searchUser()";>

  <input type="hidden" id="emailid" name="emailid" value="<%=request.getAttribute("emailid")%>">
  <input type="hidden" id="password" name="password" value="<%=request.getAttribute("password")%>">
  <input type="hidden" name="usertype"  value="${usertype}">
  <input type="hidden" name="operation" id="operation" value="">
  <input type="hidden" name="userinsubject" id="userinsubject"  value="">
  


  <table  border="0" style="width: 50%;" align="center"> 
				     <tr>
				        <td align="center"><br>
				              <span style="color:red;"> <b> ${deletestatus}    </b></span>	 
				               
				       </td>
				     </tr>
	
  </table>	

	 		 
  <table  style="width: 80%;" align="center">
	  <tr>
		
		  <td align="right"> 
		      ${operationStatus} &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        		<span onClick="add_new_user();" id="addnew" class="btn btn-primary" ><i class="fa fa-user-plus" aria-hidden="true"></i>&nbsp;Add New</span> 
		 
		  </td>

	   </tr>
	
			
 </table>	
	
 	<br>	 
  <table class="table table-striped table-bordered" border="1" style="width: 80%;background:rgba(255,255,255,0.5);" align="center">	
		
	     <tr align="center">
				    
				    <td bgcolor="#0070BA">
					   <span style="color:white;" > <b> 
					   Group	
					     </b></span>					 
					 </td>
					  
					 <td bgcolor="#0070BA" width="20%">
					   <span style="color:white;"> <b> 
					      First Name 
					     </b></span>					 
					 </td>
	
					 <td bgcolor="#0070BA" width="20%">
					   <span style="color:white;"> <b> 
					      Last Name 				     
					      </b></span>					 
					 </td>
	
					 <td bgcolor="#0070BA" width="18%">
					   <span style="color:white;"> <b> 
					    Contact No 	
					     </b></span>					 
					 </td>
					
					     
				     <td bgcolor="#0070BA" width="20%">
					   <span style="color:white;"> <b> 
					       Update /  Remove 
					     </b></span>					 
					 </td>
          </tr>
          
          
          
      	  <tr>
		          
		          <td><i class="fa fa-user-circle-o  fa-lg" aria-hidden="true"></i> &nbsp;Managment</td>
		          
		          <td>First Name </td>
		         
		          <td>
		            &nbsp;   Last name 		     		                    
		          
		          </td>
	
		          <td align="center"> &nbsp;&nbsp; 
		          0861787398
		          </td>
		           
		           <td align="center"> 
		                <span style="font-weight:bold;" onClick="update_user();"  class="btn btn-info btn-sm"><i class="fa fa-pencil-square-o fa-lg" aria-hidden="true"></i>&nbsp;Update</span>
		          
		                &nbsp;
		                <span style="font-weight:bold;" onClick="remove_user_Profile('Test');" class="btn btn-danger btn-sm"><i class="fa fa-trash-o fa-fw  fa-lg"></i>Remove</span>
		           
		           </td>
		          
		          </tr>    
          
          
          
          
          
           <%int ctr=1;%>
           <c:forEach var="smsAccount" items="${refisAccountlist}">          
		               
		       <tr>
		          
		          <td><i class="fa fa-user-circle-o  fa-lg" aria-hidden="true"></i> &nbsp;${smsAccount.username}</td>
		          
		          <td>${smsAccount.description} </td>
		         
		          <td>
		            <i class="fa fa-times  fa-lg" aria-hidden="true"></i>&nbsp;  <span style="color:red;font-weight:bold;"> Disable  </span>
		     		                    
		          
		          </td>
	
		          <td align="center"> &nbsp;&nbsp; 
		          
		          
		          </td>
		         
		         
		           
		           <td align="center"> 
		          
		                <span style="font-weight:bold;" onClick="view_update_user_Profile('${smsAccount.username}');"  class="btn btn-info btn-sm"> <i class="fa fa-eye fa-lg" aria-hidden="true"></i>&nbsp;View&nbsp; &nbsp;<i class="fa fa-pencil-square-o fa-lg" aria-hidden="true"></i>&nbsp;Update</span>
		          
		                &nbsp;
		                <span style="font-weight:bold;" onClick="remove_user_Profile('${smsAccount.username}');" class="btn btn-danger btn-sm"><i class="fa fa-trash-o fa-fw  fa-lg"></i>&nbsp;Delete</span>
		           
		           </td>
		          
		          </tr>
		         
		           <%
		           ctr++;
		           %>
           
           </c:forEach>
          
          <tr>
            <td colspan="6" align="center">             
                
	             <% if (ctr == 1){%>
	                Sorry There is no User Found Please add new User.	
		    	<%
		    	}
		    	%>
            
            
             </td>
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
<br>
 <%@include file="../../include/gopsfooter.jsp" %>
