<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="../../include/adminheader.jsp" />

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Link | Update Users  Profile  </title>
</head>



<script type="text/javascript">
	
// https://html5-tutorial.net/forms/checkboxes/  <<-- For Validation 

function updateUser(){

        if(confirm("Are you sure about this Profile Changes.?!")){
      	      document.linkuser.method="POST"
    		  document.linkuser.action="updatelinkuserprofileToDataBase?emailid=${emailid}";
    	      document.linkuser.submit();
    		  return true;

         }
          

}



function  UserSearch(){

	      document.linkuser.method="POST"
		  document.linkuser.action="profilemanager?emailid=${emailid}";
	      document.linkuser.submit();
		  return true;
         

	
}






function remove_user_Profile(){
			
		if(confirm("Are you sure about Removing Thesse Profile for User?!")){
		      document.linkuser.method="POST"
			  document.linkuser.action="removelinkuserprofile?emailid=${emailid}";
		      document.linkuser.submit();
			  return true;
		
		 }
		

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
	  updateUserProfileToDataBase(document.getElementById("userinsubject").value,checkboxElem.value,document.getElementById("operation").value);
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

<br>
<br><br>
<br>


 <div   align="center">	
	
		<div class="col-md-12 col-sm-12 col-xs-12"  align="left">
			<i class="fa fa-users" aria-hidden="true"></i>&ensp;<span style="font-weight:600;font-size:13pt;">Update Link Users Profile  </span></a>
	   </div>	
  
  </div>		
	
<br>

  
<span align="center">   <H2>Profile : ${linkuserdetail.getFirstName()} ${linkuserdetail.getLastName()}  </H2> </span>				           
 	 
     	
<!-- Body Banner -->
<div class="container" align="center" >
	  	
<!----------------- RIGHT CONTENT -------------------->
<div class="col-md-12 col-sm-12 col-xs-12" align="center" >

<form method="post" name="linkuser" id="linkuser">   
   
     <input type="hidden" name="userinsubject"  id="userinsubject" value="${linkuserdetail.getEmailId()}">
     <input type="hidden" id="profilelist" name="profilelist" value="${profilelist}">
      <input type="hidden" name="operation" id="operation" value="">
      
 	 	 
  <table class="table table-striped table-bordered" border="1" style="width: 80%;" align="center">	
		
	     <tr align="center">
				    
				    <td bgcolor="#0070BA">
					   <span style="color:white;" > <b> 
					    First Name	
					     </b></span>					 
					 </td>
					  
					 <td bgcolor="#0070BA">
					   <span style="color:white;"> <b> 
					      Last Name 
					     </b></span>					 
					 </td>
					 <td bgcolor="#0070BA">
					   <span style="color:white;"> <b> 
					    Email ID  	
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
					      Admin  / User  	
					     </b></span>					 
					 </td>
          </tr>
           
                       
		          <tr>
		          
		          <td align="center"> ${linkuserdetail.getFirstName()} </td>
		          <td align="center"> ${linkuserdetail.getLastName()} </td>
		          <td align="center"> ${linkuserdetail.getEmailId()} </td>
		          <td align="center"> 
		          
		             
		             
		          
		            <select name="activestatus" id="activestatus">
		             
		       
		           <c:choose>
					
					    <c:when test="${linkuserdetail.getActiveStatus() == 'Active'}">
					             <option  value="Active" selected> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Active &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  </option>
					             <option value="Dactive"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Disable &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  </option>
		             
					        <br />
					    </c:when>    
					
					   <c:when test="${linkuserdetail.getActiveStatus() == 'Dactive'}">
					             <option value="Dactive" selected> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Disable &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  </option>		               
		                         <option value="Active"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Active &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  </option>
					             
					        <br />
					    </c:when>    
					
					</c:choose> 
		              
		             </select>
		            
		            
		          </td>
		          
		          <td align="center">
		          
	  				<c:choose>
					    <c:when test="${linkuserdetail.getStobart_external_user() == 'I'}">
					            <b> <span style="color:green;"> <c:out value = "Stobart User "/></span></b>
					        <br />
					    </c:when>    
					    <c:otherwise>
					           <b> <span style="color:blue;"> <c:out value = "External User "/></span></b>
					        <br />
					    </c:otherwise>
					</c:choose> 
	 
	                 
		          </td>
		           
		           <td align="center"> 
		          
		          <select name="adminstatus" id="adminstatus">
		           
		           <c:choose>
					
					    <c:when test="${linkuserdetail.getAdminStatus() == 'Y'}">
					             <option  value="Y" selected> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Admin &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  </option>
					             <option value="N"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; User &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  </option>
		             
					        <br />
					    </c:when>    
					
					   <c:when test="${linkuserdetail.getAdminStatus() == 'N'}">
					             <option value="N" selected> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; User &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  </option>		               
		                         <option value="Y"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Admin &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  </option>
					             
					        <br />
					    </c:when>    
					
					</c:choose> 
	 
		            </select>    
		           </td>
		          
		          </tr>
		         
	          <tr>
           </tr>
      
 </table> 
         
 
 
  	 	 
  <table  style="width: 80%;" align="center">	
     <tr>
     
	       
	     <td align="right" colspan="5" > 	      
	      
	      <span onClick="UserSearch();"  class="btn btn-primary"  > <i class="fa fa-search-plus" aria-hidden="true"></i> Back To Search  </span>
	       &nbsp;&nbsp;&nbsp; 
	       <span onClick="updateUser();"  class="btn btn-success"><i class="fa fa-plus" aria-hidden="true"></i> Update Profile </span>
	        
	     </td>
	     
	 
	     
     </tr>
  
  
  </table>       
 <br>
 <br>
 
 
   <table  border="0" style="width: 50%;" align="center"> 
		     <tr>
		        <td align="center"><br>
		            <span id="updatestatus" style="color:#0070BA;font-size:16px;"><b> </b></span>
		               
		       </td>
		     </tr>
	
  </table>	
     
<table class="table table-striped table-bordered" style="width:80%;background:rgba(255,255,255,0.5);" align="center">	
       
    	     
		     <tr align="center">
					 <td  bgcolor="#0070BA" colspan="3" align="left">
					   <span style="color:white;font-size:18px;"><b>
					    Link Portal Profile #
					   </b></span>
					  </td>

		     </tr>
		
			
			 <tr>
                  <!--First Column  -->
                  <td align="left" bgcolor="white" width="35%">	
							
						<table width="100%" class="tableClass">
							<tr>
								 <td  colspan="2" align="center" ><b> Main Module </b></td>
							</tr>		 
								<tr>
									 <td  align="left" width="80%">Contract Database</td>
									 <td  align="center" width="20%"><input type="checkbox"  id="gopsprofile" value="9" onchange="updateProfiletoDataBase(this)" <c:if test = "${fn:contains(userinsubjectgopsprofile,'Contract')}">   checked  </c:if>>  </td>							 
								</tr>
								
								<tr>
									 <td align="left" width="80%"> Human Resources </td>
									 <td align="center" width="20%"><input type="checkbox"  id="gopsprofile" value="6" onchange="updateProfiletoDataBase(this)" <c:if test = "${fn:contains(userinsubjectgopsprofile,'Cascade')}">   checked  </c:if>></td>							 
								</tr>
								
								<tr>
									 <td  align="left" width="80%"> Miscellaneous / Crew Brifing Manager </td>
									 <td  align="center" width="20%"><input type="checkbox"  id="gopsprofile" value="22" onchange="updateProfiletoDataBase(this)" <c:if test = "${fn:contains(userinsubjectgopsprofile,'CrewBrifingManager')}">    checked  </c:if>></td>						 
								</tr>
								
								<tr>
									 <td  align="left" width="80%">Miscellaneous / Invoice-Conversion-Tool </td>
									 <td  align="center" width="20%"><input type="checkbox"  id="gopsprofile" value="25" onchange="updateProfiletoDataBase(this)" <c:if test = "${fn:contains(userinsubjectgopsprofile,'Invoice-Conversion-Tool')}">    checked  </c:if>></td>								 
								</tr>
								
									
								<tr>
									 <td  align="left" width="80%">Miscellaneous / Download Fuel Report </td>
									 <td  align="center" width="20%"><input type="checkbox"  id="gopsprofile" value="28" onchange="updateProfiletoDataBase(this)" <c:if test = "${fn:contains(userinsubjectgopsprofile,'Fuel Report')}">    checked  </c:if>></td>								 
								</tr>
								
												
							</table>
											
				  </td>
				  
				  
				  <td align="left" bgcolor="white" width="30%">	
				  	<table width="100%" class="tableClass">
							<tr>
								 <td  colspan="2" align="center" ><b> Main Module </b></td>
							</tr>
				  			<tr>
									 <td  align="left" width="80%">New Ground Ops </td>
									 <td  align="center" width="20%"><input type="checkbox"  id="gopsprofile" value="10" onchange="updateProfiletoDataBase(this)" <c:if test = "${fn:contains(userinsubjectgopsprofile,'Refis')}">  checked  </c:if>></td>								 
								</tr>
								
						 
							 <tr>
									 <td  align="left" width="80%">StaffTravel</td>
									 <td  align="center" width="20%"><input type="checkbox"  id="gopsprofile" value="8" onchange="updateProfiletoDataBase(this)" <c:if test = "${fn:contains(userinsubjectgopsprofile,'StaffTravel')}">   checked  </c:if>>  </td>							 
							</tr>
										
								<tr>
									 <td  align="left" width="80%">Miscellaneous / Remove Staff Travel User</td>
									 <td  align="center" width="20%"><input type="checkbox"  id="gopsprofile" value="26" onchange="updateProfiletoDataBase(this)" <c:if test = "${fn:contains(userinsubjectgopsprofile,'RemoveStaffTravelUser')}">  checked  </c:if>></td>								 
								</tr>
								
					
	
							<tr>
									 <td  align="left" width="80%">Reports / Daily Summary</td>
									 <td  align="center" width="20%"><input type="checkbox"  id="gopsprofile" value="3" onchange="updateProfiletoDataBase(this)" <c:if test = "${fn:contains(userinsubjectgopsprofile,'Daily_Summary')}">   checked  </c:if>>  </td>							 
							</tr>
							
				     </table> 
				  
				  
				   </td>
				    
				    
				    
				    <td align="left" bgcolor="white" width="30%">
				      &nbsp;	
				    </td>
	 				
         </tr>
     </table>            
         
         
 <br>
 <br>
 <br>    
 <br>    
<br>    
         
     
<table class="table table-striped table-bordered" style="width:80%;background:rgba(255,255,255,0.5);" align="center">	
       
    	     
		     <tr align="center">
					 <td  bgcolor="#0070BA" colspan="3" align="left">
					   <span style="color:white;font-size:18px;"><b>
					    Ground Operations Profile #
					     &nbsp;&nbsp; </b></span>
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
         
         
         
         
         
         
         
         
         
         
         
         
         

        </div>
        
        
        
      </div>  


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

