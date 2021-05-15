<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="../include/gopsheader.jsp" />

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Touch Point Demo </title>
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




function update_user(accountid){
	
	   document.smsUser.method="POST"
	   document.smsUser.operation.value="updateexisting";
	   document.smsUser.userinsubject.value=accountid;
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

  <input type="hidden" id="profilelist" name="profilelist" value="${profilelist}">
 
   <table  style="width: 80%;" align="center">
	  <tr>
			  <td> <font size="4"><b>Touch Point Demo </b></font></td>
	   </tr>
			
 </table>	
	
  
<br>

						
							<video width="80%" controls>
							  <source src="TOUCHPOINTOVERVIEW/touchpoint.mp4" type="video/mp4">
							  Your browser does not support HTML5 video.
							</video>
			 

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
 <%@include file="../include/gopsfooter.jsp" %>
