<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
			<i class="fa fa-users" aria-hidden="true"></i>&ensp;<span style="font-weight:600;font-size:13pt;">Update Link Users Profile  </span></a>
	   </div>	
  
  </div>		
	
<br>

<!-- Body Banner -->
<div class="container" align="center">
     	
  
    <span align="center">   <H2>Profile : ${linkuserdetail.getFirstName()} ${linkuserdetail.getLastName()}  </H2> </span>				           
	
 	 
     	
<!----------------- RIGHT CONTENT MAIN BODY  -------------------->
<div class="col-md-12 col-sm-12 col-xs-12" align="center">

<form method="post" name="linkuser" id="linkuser">   
   
     <input type="hidden" name="id"  value="${linkuserdetail.getEmailId()}">
     <input type="hidden" id="profilelist" name="profilelist" value="${profilelist}">
 	 	 
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
		         
		 
          
  		
	     <tr align="center">
				    
				    <td  colspan="3" width="50%" >
					   <span style="color:green;" > <b> 
					       Existing Authorisation 
					     </b></span>					 
					 </td>
					  
				    <td  colspan="3" width="50%">
					   <span style="color:blue;" > <b> 
					      Add Profile  
					     </b></span>					 
					 </td>
	      </tr>     
         
         
         
         
          <tr>
  
  
            <!--  THIS PART WILL SHOW USERS EXISTING PROFILE -->
            <td colspan="3" > 
            
          
              <table border="1" width="80%" align="center">
   
   
                    ${userprofilelist}               
   
   
               </table>
            </td>
            
            <!--  THIS PART WILL SHOW ALL PROFILE E -->            
            <td colspan="3" >   
              
              <table border="1" width="80%" align="center">
    
                       ${linkprofilelist}
             
               </table>
 
               
            
            
            </td>
  
          </tr>
          
      
         </table> 
         
  	 	 
  <table  style="width: 80%;" align="center">	
     <tr>
     
	     <td align="center"> 
	         <span onClick="remove_user_Profile();" class="btn btn-danger"><i class="fa fa-trash-o fa-fw"></i> Remove Profile </span>
	     </td>
	     
	     
	     <td align="center"> 	      
	      
	      <span onClick="UserSearch();"  class="btn btn-primary"  > <i class="fa fa-search-plus" aria-hidden="true"></i> Back To Search  </span>
	        
	     </td>
	     
	     
	     <td align="center"> 
	     
	              <span onClick="updateUser();"  class="btn btn-success"><i class="fa fa-plus" aria-hidden="true"></i> Update Profile </span>
	            
	            
	     </td>
	     
     </tr>
  
  
  </table>       
         

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

