<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<jsp:include page="../../include/adminheader.jsp" />

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Link | Update Users Profile For Contract Management  </title>
</head>



<script type="text/javascript">
	

function updateUserAccess(ope,profileid){

    if(document.contractuser.department.value == 'ALL'){
        alert("Please select Department.."); 
        document.contractuser.department.focus();
        return false; 
    }

    if(document.contractuser.subdepartment.value == 'ALL'){
        alert("Please select Subdepartment as well.."); 
        document.contractuser.subdepartment.focus();
        return false; 
      }
  
	
        if(confirm("Are you sure about this Change .?!")){    
              document.contractuser.operation.value=ope;
        	  document.contractuser.profileid.value=profileid;
      	      document.contractuser.method="POST";
    		  document.contractuser.action="showcontractaccessprofile";
    	      document.contractuser.submit();
    		  return true;

         }
          

} //--------- End of Function ----------




function Load_Dept_Subdept(){

	      document.contractuser.operation.value="LOAD";
          document.contractuser.method="POST"
		  document.contractuser.action="showcontractaccessprofile";
	      document.contractuser.submit();

	
}//-------- End Of Function ---------


function remove_user_Profile(){
			
		if(confirm("Are you sure about Removing Access from this User.. ??")){
			  document.contractuser.operation.value=REM;
		      document.contractuser.method="POST"
			  document.contractuser.action="showcontractaccessprofile";
		      document.contractuser.submit();
			  return true;
		
		 }
		

} //-------- End Of Function 


function UserSearch(){
	
     document.contractuser.method="POST"
	 document.contractuser.action="profilemanager";
     document.contractuser.submit();


}//-------- End Of Function ---------


</script>

<style>

tr:nth-child(even) {
  background-color: #F8F9F9;
}

</style>



<body>

<br>
<br><br>
<br>


 <div   align="center">	
	
		<div class="col-md-12 col-sm-12 col-xs-12"  align="left">
			<i class="fa fa-users" aria-hidden="true"></i>&ensp;<span style="font-weight:600;font-size:13pt;">Manage User Access to Stobart Contract </span></a>
	   </div>	
  
  </div>		
	
<br>
<br>

 	

<!-- Body Banner -->
<div class="container" align="center">
     	
         
	
 
     	
<!----------------- RIGHT CONTENT MAIN BODY  -------------------->
<div class="col-md-12 col-sm-12 col-xs-12" align="center">

<form method="post" name="contractuser" id="contractuser">   
   

  <input type="hidden" name="emailid" id="emailid" value="${emailid}">
  <input type="hidden" name="userid" id="userid" value="${userid}">
  <input type="hidden" name="operation" id="operation" value="">
  <input type="hidden" name="profileid" id="profileid" value="">
   
 	 	 
  <table class="table table-striped table-bordered" border="1" style="width: 70%;" align="center">	
	     
   <tr>
          	 <td  bgcolor="#0070BA" >
					   <span style="color:white;"> <b>
					    Main Department
					   </b></span>					 
					 </td>
			
			 <td  bgcolor="#0070BA" >
					   <span style="color:white;"> <b>
					    Sub Department
					   </b></span>					 
		     </td>
		     
			 <td  bgcolor="#0070BA" >
					   <span style="color:white;"> <b>
					    Admin Status
					   </b></span>					 
		     </td>		     
		     
				 <td  bgcolor="#0070BA" >
					   <span style="color:white;"> <b>
					    Email Notification 
					   </b></span>					 
		     </td>		     
			 
      	 	
   </tr>
   
   <tr>
   
    <td >
    	    <div class="col-xs-15">
							<div class="input-group">
								<span class="input-group-addon"><i class="fa fa-universal-access" aria-hidden="true"></i></span>								
										<select id="department" name="department" class="form-control" onChange="Load_Dept_Subdept();">
										     <option value="ALL"> ------- ALL ------ </option>										
											 ${departmentlist}
																			
										</select>
							</div>	
						</div>
				
			
    
    
    </td>
    
 <td >
    				<div class="col-xs-15">
							<div class="input-group">
								<span class="input-group-addon"><i class="fa fa-university" aria-hidden="true"></i></i></span>							
									
										<select  id="subdepartment" name="subdepartment" class="form-control" >	
										  <option value="ALL"> ------- ALL ------ </option>			
                                                ${subdepartmentlist}
											
										</select>
							</div>
				    </div>
	
    </td>
    
    	     <td >
		     			<div >
						 		
								<div class="input-group"> 
									<span class="input-group-addon"><i class="fa fa-thumbs-o-up fa-lg" aria-hidden="true"></i></span>							
										<select id="admin" name="admin" class="form-control"  >										
												<option value="Y" >Admin User</option>	
												<option value="N" selected >General User</option>
																					
											</select>
								</div>
	
						  </div>
		
		     </td>
	
   	     <td >
		     			<div>
						 		
								<div class="input-group"> 
									<span class="input-group-addon"><i  class="fa fa-envelope-o fa-lg" aria-hidden="true"></i></span>							
										<select id="eligible_for_email_notification" name="eligible_for_email_notification" class="form-control"  >										
												<option value="Y" selected > -YES-</option>	
												<option value="N" > -NO- </option>
																					
											</select>
								</div>
	
						  </div>
		
		     </td>
   
   </tr>
   
   
  
      
  </table> 
         
	 
  <table  style="width: 70%;" align="center">	
  
     <tr>
         <td align="left" width="50%" >
		      <span style="font-weight:550;font-size:9pt;color:red">  
		       Admin User :</span>
		       <span style="font-weight:150;font-size:9pt;color:black">  
		        Can Do following (Add / Update / Archive / Renew ) Contract. &nbsp;
		      </span>
		      <br>
		      <span style="font-weight:550;font-size:9pt;color:red">  
		         General User :</span>
		       <span style="font-weight:150;font-size:9pt;color:black">  
		        Can only Add and view Contract. &nbsp;
		      </span>       
     
          
         </td>
         
	     <td align="left"> 	         
	         &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span onClick="UserSearch();"  class="btn btn-primary"  > <i class="fa fa-search-plus" aria-hidden="true"></i> User Search  </span>	     
	        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	         <span onClick="updateUserAccess('ADD');"  class="btn btn-success"><i class="fa fa-plus" aria-hidden="true"></i> Add Access </span>
	     </td>
	     
     </tr>
   
  
     <tr bgcolor="white">
     
        <td align="center" colspan="2" bgcolor="white"><br>
	         <span style="font-weight:400;font-size:10pt;color:blue">  ${statusmessage} </span>
        
        </td>
       
     </tr>
 
  
  
  </table>       
         
       </div>
        
      </div>  



<br>
<br>

<table  style="width: 50%;" align="center">
	<tr>
		 <td align="center">	
		      <H4> <u>Profile Of : ${userid} </u> </H4>
		  
		        <c:set var = "rowcount"  value = "${fn:length(usercontractprofilelist)}"/>
                  <c:if test = "${rowcount == 0}"> <br>   
                     <span style="color:red;font-size:10pt;"> 
                          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                           &nbsp;!!&nbsp;&nbsp;Sorry No profile&nbsp;&nbsp; <i class="fa fa-frown-o  fa-lx"> </i>
                      </span>      
                   </c:if>   
		  
		  </td>
		  
	</tr>
	  		 	
	
</table>		



<c:if test = "${rowcount > 0}"> 

		<table   class="table table-striped"  style="width: 50%;" align="center">								
	         
	        <tr>
	         <td> 
	           <h4><span class="label label-primary">No.</span></h4>
	         </td>
	         <td> 
	           <h4><span class="label label-primary">Department</span></h4>
	         </td>
	         <td> 
	           <h4><span class="label label-primary">Sub Department</span></h4>
	         </td>
	         <td> 
	           <h4><span class="label label-primary">Admin / General / Email </span></h4>
	         </td>
	         
	         <td> 
	         
	           <h4><span class="label label-danger">Remove</span></h4>
	         
	         </td>
	         
	          
	        </tr>
	        
	    <%
		 
         int srno=1;
         
	     %>
             
	  <c:forEach var="contractprofile" items="${usercontractprofilelist}">               
	
			<tr> 
				<td align="left" width="5%"><b><%=srno++%>.</b>&nbsp;</td>
				
			    <td> ${contractprofile.department} </td>
			    
			    <td> ${contractprofile.subDepartment} </td>
			    <td> 
			    
		       	     <c:if test="${contractprofile.adminstatus == 'Y'}">
		       	        <span style="font-weight:600;font-size:10pt;color:blue">
				          <i class="fa fa-user-md" aria-hidden="true"></i> &nbsp; Admin
				        </span>    
				      </c:if>
				      
				      <c:if test="${contractprofile.adminstatus == 'N'}">
				      <span style="font-weight:600;font-size:10pt;color:black">
				         <i class="fa fa-user-circle-o" aria-hidden="true"></i> &nbsp; General
				      </span>  
					       <c:if test="${contractprofile.eligibleforemailnotification == 'Y'}">
					         &nbsp;<i class="fa fa-envelope-o" aria-hidden="true"></i>
					       </c:if>
					      
				       
				      </c:if>
				      
			      
			
			    
			    </td>
			    
				<td align="left" width="12%">
				   <span style="font-weight:600;font-size:9pt;color:red">
				        <i class="fa fa-trash-o" aria-hidden="true"></i><a  href="javascript:updateUserAccess('REM','${contractprofile.profileid}')">&nbsp;Remove</a>
				    </span>  
				 </td>
			</tr>
	 </c:forEach> 
		
			
		</table>

</c:if>





 </form>



</body>
</html>
<br>
<br>
<%@include file="../../include/footer.jsp" %>
