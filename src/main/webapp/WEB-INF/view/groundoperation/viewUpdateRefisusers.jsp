<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="../include/groundopsheader.jsp" />

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Manage Ground Ops User Account </title>
</head>



<script type="text/javascript">
	





function update_user(accountid){
			
		if(confirm("Are you sure about Updating detail.. ??")){			  
			   document.refieUser.method="POST"
			   document.refieUser.operation.value="update";			   
			   document.refieUser.action="managegopssuser";
			   document.refieUser.submit();
			   return true;				
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




$(".chosen").chosen({
    width: "300px",
    enable_search_threshold: 10
}).change(function(event)
{
    if(event.target == this)
    {
        var value = $(this).val();
        $("#result").text(value);
    }
});




</script>



<body>


<!-- Body Banner -->
<div class="container" align="center" >
	  	
<!----------------- RIGHT CONTENT -------------------->
<div class="col-md-12 col-sm-12 col-xs-12" align="center" >

<form method="post" name="refieUser" id="refieUser"  onSubmit="return searchUser()";>

  <input type="hidden" id="emailid" name="emailid" value="<%=request.getAttribute("emailid")%>">
  <input type="hidden" id="password" name="password" value="<%=request.getAttribute("password")%>">
  <input type="hidden" name="usertype" value="${usertype}">
  <input type="hidden" name="operation" id="operation" value="">

  <table  border="0" style="width: 50%;" align="center"> 
		     <tr>
		        <td align="center"><br>
		              <span style="color:white;"> <b> ${status}    </b></span>	 
		               
		       </td>
		     </tr>
	
  </table>	

        
     <table class="table table-striped table-bordered" border="1" style="width: 60%;" align="center">	    
    		<tbody>				     
			     <tr align="center">
					 <td  bgcolor="#0070BA" colspan="2">
					   <span style="color:white;"> <i class="fa fa-user-circle fa-lg" aria-hidden="true"></i> &nbsp;<b>
					    Update Ground Ops User &nbsp;&nbsp;
					   </b></span>					 
					 </td>
			     </tr>
			
			
			   <tr>
                
                  <td align="left" bgcolor="white" width="50%">
					<div class="col-xs-10">
							<label> User Name </label>
							<div class="input-group">
								<span class="input-group-addon"><i class="fa fa-text-height fa-lg" aria-hidden="true"></i></i></span>							
									<input type="text"  name="userid" readonly id="userid" class="form-control" value="${gopsuserdetail.username}">
											
							</div>
				    </div>
				    
	    
		                
	                </td>
	 				
				            
	              <td align="left" bgcolor="white" width="50%">
					<div class="col-xs-10">
							<label  >Password </label>  
							<div class="input-group">
								<span class="input-group-addon"><i class="fa fa-strikethrough fa-lg" aria-hidden="true"></i></span>
										<input type="text"   name="userpassword" id="userpassword" class="form-control"  value="${gopsuserdetail.getPasswordDecodeBase64()}">										
							</div>
				    </div>
		           </td>
      	                
	           </tr>
	           
	           
	           
	           <tr>
               
	               <td align="left" bgcolor="white" width="50%">
					  <div class="col-xs-10">
					 		<label> Email Id </label>
							<div class="input-group">
								<span class="input-group-addon"><i class="fa fa-text-height fa-lg" aria-hidden="true"></i></i></span>							
									<input type="email"  name="useremail"  id="useremail" class="form-control" value="${gopsuserdetail.email}" aria-describedby="emailHelp" placeholder="Enter email">
											
							</div>
				    </div>
				    
	               </td>	               
	
	               
	               <td align="left" bgcolor="white" width="50%">
					     <div class="col-xs-12">
							<label >Description </label>
							<div class="input-group">
								<span class="input-group-addon"><i class="fa fa-industry" aria-hidden="true"></i></span>
									<textarea rows="02" name="description"  id="description" value="${gopsuserdetail.description}" class="form-control" >${gopsuserdetail.description} </textarea>  										
							</div>
			            </div>
	               </td>
	               
	           </tr>
	           
	           
	           <tr>
		               
	               <td align="left" bgcolor="white" width="50%">
					     <div class="col-xs-10">
							<label >Active Status </label>
							<div class="input-group">
								<span class="input-group-addon"><i class="fa fa-universal-access" aria-hidden="true"></i></span>								
										<select id="status" name="status" class="form-control" onchange="view_contract()" >	
                                               <option value="Active" <c:if test ="${gopsuserdetail.enabled == 'Active'}"> selected </c:if> > -  Active - </option>
                                               <option value="Dactive" <c:if test ="${gopsuserdetail.enabled == 'Dactive'}"> selected </c:if> > -  Disable - </option>     					
										</select>
							</div>	
						</div>
	               
	               
	               </td>	               
	 	           
	           
	    
	              <td  align="left" bgcolor="white" >
                          	               
  				          
					     <div class="col-xs-10">
							<label >Email Notification  </label>
							<div class="input-group">
				              <input type="checkbox" id="enableforemail" name="enableforemail"  value="Active">&nbsp; Enable.</span>&nbsp; &nbsp; 
							</div>	
						</div>
	               
  				              
  				              
  						      
					    </div>
			    				  
				  </td>
				  
					  
	           </tr>
	           
	           

	           <tr>
                 
	               <td align="left" bgcolor="white" width="50%">
					     <div class="col-xs-12">
							<label> Eligible Air Line  </label>
							<div class="input-group">
								<span class="input-group-addon"><i class="fa fa-plane" aria-hidden="true"></i></span>
									    <select multiple class="form-control" name="airline" id="airline">
									      <option>EI   -   AirLingus</option>
									      <option>BE   -   FlyBe</option>
									      <option>BA   -   British Air</option>
									      <option>RE   -   StobartAir</option>
									      
									    </select>										
							</div>
			            </div>
	               </td>
	               
	               
	               <!--    https://harvesthq.github.io/chosen/  -->
	              
	               <td align="left" bgcolor="white" width="50%">
					  <div class="col-xs-10">
					 		<label> Airport Stations   </label>					 							 		
							<div class="input-group">							
								<span class="input-group-addon"><i class="fa fa-text-height fa-lg" aria-hidden="true"></i></i></span>							
									<input type="text"  name="station"  id="station" class="form-control" value="DUB,DBX" readonly>
											
							</div>
				    </div>
				    
	               
	               
	               </td>	               
	
		           
	           
	           </tr>

 		      <tr align="center"> 
				     					
						<td  bgcolor="white" colspan="2">	
			
			                   <span onClick="calRefisReport('managegopssuser');" id="addnew" class="btn btn-primary" > &nbsp;Search User&nbsp;<i class="fa fa-search" aria-hidden="true"></i>  </span>  
			                   &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;   
			                   <span onClick="update_user('${gopsuserdetail.username}');" id="addnew" class="btn btn-success" >&nbsp;Update &nbsp; <i class="fa fa-pencil-square-o" aria-hidden="true"></i> </span>
 		 			     </td>
				     </tr>
	           	           
       	   </tbody>             
     </table>  	   
      

      <table width="65%" align="center" border="0">
      		     <tr align="center" > 
				     					
						<td  bgcolor="white" colspan="2" >			                   
			                 
			                <span style="display:none" id="uploadstatus">   
			                  <div  class="progress-bar progress-bar-striped active" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width:100%">
							         <b>Updating..</b>&nbsp;&nbsp;<i class="fa fa-spinner fa-pulse fa-lg"></i>
			                  </div>
			                 </span> 
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
 <%@include file="../include/gopsfooter.jsp" %>
