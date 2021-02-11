<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="../../include/gopsheader.jsp" />

<!DOCTYPE html>
<html>
<head>

<meta charset="ISO-8859-1">

<title>Update Ground Ops User Profile </title>
</head>




<script type="text/javascript">

// JAITODO  ---  ajax cal 
function postDataToDataBase(profileId){	
	   document.smsreportuser.method="POST"	  
	   document.smsreportuser.action="gopsusersprofilemanager?profileid="+profileId;
	   document.smsreportuser.submit();
	   return true;		
} //-------- End Of Function 



function updateUserProfileToDataBase(userEmail,profileId,operation){	

	 var callingurl  = "ajaxrest/updategroundopsuserprofile?operation="+operation+"&profileid="+profileId+"&usersemailid="+userEmail;
	
	 $.ajax({
					type : 'GET',
					url  : callingurl,
					success : function(result){
					    $('#updatestatus').text(result);
					}
			});
}			



function updateProfiletoDataBase(checkboxElem) {
	
	  if(checkboxElem.checked) {	   
	    document.getElementById("operation").checked = true;
	    document.getElementById("operation").value="ADD";
	   
	  } else {
		  document.getElementById("operation").checked = false;
		  document.getElementById("operation").value="REM";
	  }	  
	  //postDataToDataBase(checkboxElem.value);
	  updateUserProfileToDataBase(document.getElementById("user").value,checkboxElem.value,document.getElementById("operation").value);
}

</script>




<!-- For the Column Items -->
<style>	
	tableClass {
	  border-collapse: collapse;
	  width: 100%;
	}
	table.tableClass td {
	  padding: 8px;
	  text-align: left;
	  border-bottom: 1px solid #ddd;
	}
</style>



<body>


<!-- Body Banner -->
<div class="container" align="center" >
	  	
<!----------------- RIGHT CONTENT -------------------->
<div class="col-md-12 col-sm-12 col-xs-12" align="center" >

<form method="post" name="smsreportuser" id="smsreportuser"  onSubmit="return searchUser()";>

  <input type="hidden" id="profilelist" name="profilelist" value="${profilelist}">
  <input type="hidden" name="usertype" value="${usertype}">
  <input type="hidden" name="operation" id="operation" value="">
  <input type="hidden" name="user" id="user"  value="${userinsubjectdetail.emailId}">

  <table  border="0" style="width: 50%;" align="center"> 
		     <tr>
		        <td align="center"><br>
		              <span style="color:white;"> <b> ${status}    </b></span>	 
		               
		       </td>
		     </tr>
	
  </table>	
  

<table  style="width:80%;" align="center">  
		
		  <tr>	  
			   <td width="50%" align="left"> 
				   <font size="4"><b>Update Ground Ops Users Profile</b></font>
				    &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp;
				    <span id="updatestatus" style="color:white;font-size:16px;"><b> </b></span>
			   </td>
         </tr>

</table>
<br>

<table class="table table-striped table-bordered" style="width:80%;background:rgba(255,255,255,0.5);" align="center">	
       
    	     
		     <tr align="center">
					 <td  bgcolor="#0070BA" colspan="3" align="center">
					   <span style="color:white;font-size:18px;"><b>
					     &nbsp;&nbsp; ${userinsubjectdetail.firstName}&nbsp;&nbsp;${userinsubjectdetail.lastName}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;( ${userinsubjectdetail.emailId}) 
					   </b></span>
					  </td>

		     </tr>
			
			
			
			 <tr>
                  <!--First Column  -->
                  <td align="left" bgcolor="white" width="33%">	
							
						<table width="100%" class="tableClass">
							<tr>
								 <td  colspan="2" align="center" ><b> Report </b></td>
							</tr>		 
								<tr>
									 <td  align="left" width="80%">Flight Report (MayFly)</td>
									 <td  align="center" width="20%"><input type="checkbox"  id="gopsprofile" value="1" onchange="updateProfiletoDataBase(this)" <c:if test = "${fn:contains(userinsubjectgopsprofile,'Flight_Report')}">   checked  </c:if>>  </td>							 
								</tr>
								
								<tr>
									 <td align="left" width="80%">Reliability Report</td>
									 <td align="center" width="20%"><input type="checkbox"  id="gopsprofile" value="2" onchange="updateProfiletoDataBase(this)" <c:if test = "${fn:contains(userinsubjectgopsprofile,'Reliablity')}">   checked  </c:if>></td>							 
								</tr>
								
								<tr>
									 <td  align="left" width="80%">Delay Report</td>
									 <td  align="center" width="20%"><input type="checkbox"  id="gopsprofile" value="7" onchange="updateProfiletoDataBase(this)" <c:if test = "${fn:contains(userinsubjectgopsprofile,'DelayReport')}">    checked  </c:if>></td>						 
								</tr>
								
								<tr>
									 <td  align="left" width="80%">OTP Report</td>
									 <td  align="center" width="20%"><input type="checkbox"  id="gopsprofile" value="24" onchange="updateProfiletoDataBase(this)" <c:if test = "${fn:contains(userinsubjectgopsprofile,'OtpReport')}">    checked  </c:if>></td>								 
								</tr>
								
								
								<tr>
									 <td  align="left" width="80%">Weight Statements</td>
									 <td  align="center" width="20%"><input type="checkbox"  id="gopsprofile" value="15" onchange="updateProfiletoDataBase(this)" <c:if test = "${fn:contains(userinsubjectgopsprofile,'weightstatement')}">  checked  </c:if>></td>								 
								</tr>
								
								<tr>
									 <td  align="left" width="80%">Voyager / Flight  Report </td>
									 <td  align="center" width="20%"><input type="checkbox"  id="gopsprofile" value="5" onchange="updateProfiletoDataBase(this)" <c:if test = "${fn:contains(userinsubjectgopsprofile,'Voyager')}">  checked  </c:if>></td>								 
								</tr>
								
								
							</table>
											
				  </td>
	 				
                  
                  
                  <!--Second Column  -->
                  <td align="left" bgcolor="white" width="33%">					
							
						<table width="100%" class="tableClass">
							<tr>
								 <td  colspan="2" align="center" ><b> Administration </b></td>
							</tr>		 
								<tr>
									 <td  align="left" width="80%"> Admin </td>
									 <td  align="center" width="20%"><input type="checkbox"  id="gopsprofile" value="18" onchange="updateProfiletoDataBase(this)" <c:if test = "${fn:contains(userinsubjectgopsprofile,'gopsadmin')}">  checked  </c:if>>  </td>							 
								</tr>
								
								<tr>
									 <td align="left" width="80%">REFIS User Manager</td>
									 <td align="center" width="20%"><input type="checkbox"  id="gopsprofile" value="19" onchange="updateProfiletoDataBase(this)" <c:if test = "${fn:contains(userinsubjectgopsprofile,'ManageUsers')}">  checked  </c:if>></td>							 
								</tr>
								
								<tr>
									 <td  align="left" width="80%">User Profile Manager</td>
									 <td  align="center" width="20%"><input type="checkbox"  id="gopsprofile" value="27" onchange="updateProfiletoDataBase(this)" <c:if test = "${fn:contains(userinsubjectgopsprofile,'profileManager')}">  checked  </c:if>></td>						 
								</tr>
								
								<tr>
									 <td  align="left" width="80%">SMS Contact Manager</td>
									 <td  align="center" width="20%"><input type="checkbox"  id="gopsprofile" value="20" onchange="updateProfiletoDataBase(this)" <c:if test = "${fn:contains(userinsubjectgopsprofile,'ManageSmscontact')}">     checked  </c:if>></td>								 
								</tr>
								
								<tr>
									 <td  align="left" width="80%">Airline Data Manager</td>
									 <td  align="center" width="20%"><input type="checkbox"  id="gopsprofile" value="21" onchange="updateProfiletoDataBase(this)" <c:if test = "${fn:contains(userinsubjectgopsprofile,'AirlineDataManager')}">   checked  </c:if>></td>								 
								</tr>
								
							</table>											
				  </td>
	 				
	 				
	 				
                <!--Third Column  -->
                  <td align="left" bgcolor="white">					
						<table width="100%" class="tableClass">
							<tr>
								 <td  colspan="2" align="center" ><b> Forms / Documents / Training / Manual </b></td>
							</tr>	
							    
							    <tr>
									 <td  align="left" width="80%">Document Manager (Add / Remove) </td>
									 <td  align="center" width="20%"><input type="checkbox"  id="gopsprofile" value="23" onchange="updateProfiletoDataBase(this)" <c:if test = "${fn:contains(userinsubjectgopsprofile,'docmanager')}">    checked  </c:if>></td>								 
								</tr>
								 
								<tr>
									 <td  align="left" width="80%"> Forms </td>
									 <td  align="center" width="20%"><input type="checkbox"  id="gopsprofile" value="17" onchange="updateProfiletoDataBase(this)" <c:if test = "${fn:contains(userinsubjectgopsprofile,'forms')}">  checked  </c:if>>  </td>							 
								</tr>
								
								<tr>
									 <td align="left" width="80%">Documentations</td>
									 <td align="center" width="20%"><input type="checkbox"  id="gopsprofile" value="16" onchange="updateProfiletoDataBase(this)" <c:if test = "${fn:contains(userinsubjectgopsprofile,'documentation')}"> checked  </c:if>></td>							 
								</tr>
								
								<tr>
									 <td  align="left" width="80%">Training </td>
									 <td  align="center" width="20%"><input type="checkbox"  id="gopsprofile" value="14" onchange="updateProfiletoDataBase(this)" <c:if test = "${fn:contains(userinsubjectgopsprofile,'traning')}">    checked  </c:if>></td>						 
								</tr>
								
								<tr>
									 <td  align="left" width="80%">Safety Compliance</td>
									 <td  align="center" width="20%"><input type="checkbox"  id="gopsprofile" value="13" onchange="updateProfiletoDataBase(this)"   <c:if test = "${fn:contains(userinsubjectgopsprofile,'safetycompliance')}">     checked  </c:if>></td>								 
								</tr>
									
								
								<tr>
									 <td  align="left" width="80%">Manuals</td>
									 <td  align="center" width="20%"><input type="checkbox"  id="gopsprofile" value="12" onchange="updateProfiletoDataBase(this)" <c:if test = "${fn:contains(userinsubjectgopsprofile,'Manuals')}">  checked  </c:if>></td>								 
								</tr>

								<tr>
									 <td  align="left" width="80%">GCI - GCM - GCR</td>
									 <td  align="center" width="20%"><input type="checkbox"  id="gopsprofile" value="11" onchange="updateProfiletoDataBase(this)" <c:if test = "${fn:contains(userinsubjectgopsprofile,'GCIGCMGCR')}">  checked  </c:if>></td>								 
								</tr>
									
							</table>												
				  </td>
     	                
	          </tr>
	           
	           
	           
    	            
	            

 		      <tr align="center"> 
				     					
						<td  bgcolor="white" colspan="3">				
			                   <span onClick="javascript:history.go(-1)" id="addnew" class="btn btn-primary" > &nbsp;User Search &nbsp;&nbsp;<i class="fa fa-search" aria-hidden="true"></i>  </span>  
			                   <!-- 
			                   &nbsp;&nbsp;&nbsp;   
			                   <span onClick="update_user();" id="addnew" class="btn btn-success" >&nbsp;Update &nbsp; <i class="fa fa-pencil-square-o" aria-hidden="true"></i> </span>
			                    -->
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
 <!-- Important Bottom Line Script-->  
  <script src="js/jquery-3.2.1.min.js" type="text/javascript"></script>
  <script src="js/chosen.jquery.js" type="text/javascript"></script>
  <script src="js/prism.js" type="text/javascript" charset="utf-8"></script>
  <script src="js/init.js" type="text/javascript" charset="utf-8"></script> 	 

</body>
</html>

<button style="display:none;" type="button" id="fireModalWindow" class="btn btn-info" data-toggle="modal" data-target="#errorModal">Open Modal</button>

	<!-- ERROR Modal -->
	<div id="errorModal" class="modal fade" role="dialog">
	  <div class="modal-dialog modal-dialog-centered">

		<!-- Modal content-->
		<div class="modal-content">
		  <div class="modal-header">
			<button type="button" class="close" data-dismiss="modal">&times;</button>
			<h4 class="modal-title"><i class="fa fa-exclamation-triangle"></i> Error!</h4>
		  </div>
		  <div class="modal-body">
			<p id="error_message" >Some text in the modal.</p>
		  </div>
		  <div class="modal-footer">
			<button type="button" class="btn btn-primary btn-sm" data-dismiss="modal">Close</button>
		  </div>
		</div>

	  </div>
	</div>

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
