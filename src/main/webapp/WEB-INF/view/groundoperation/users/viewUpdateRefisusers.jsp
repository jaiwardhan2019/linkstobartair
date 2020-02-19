<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="../../include/groundopsheader.jsp" />

<!DOCTYPE html>
<html>
<head>

<link rel="stylesheet" href="css/prism.css">
<link rel="stylesheet" href="css/chosen.css">



<meta charset="ISO-8859-1">

<title>Manage Ground Ops User Account </title>
</head>




<script type="text/javascript">
	





function update_user(accountid){


	
	if(password == "" || password == " ") {
	   alert("Please Enter Password");
	   document.getElementById("userpassword").focus();
	  return false;
	}

	
	if(description == "" || description == " ") {
		alert("Please Enter Description");
		document.getElementById("description").focus();
		return false;
	}


	if(airline == "" || airline == " ") {
		alert("Please Select Airline..");
		document.getElementById("airline").focus();
		return false;
	}


	if(station == "" || station == " ") {
		alert("Please Select Airport Station..");
		document.getElementById("station").focus();	
		return false;
	}
	
	if(confirm("Are you sure about Updating detail.. ??")){			  
		   document.refieUser.method="POST"
		   document.refieUser.operation.value="update";			   
		   document.refieUser.action="managegopssuser";
		   document.refieUser.submit();
		   return true;				
	}
		

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
  <input type="hidden" name="userinsubject" id="userinsubject"  value="${gopsuserdetail.username}">

  <table  border="0" style="width: 50%;" align="center"> 
		     <tr>
		        <td align="center"><br>
		              <span style="color:white;"> <b> ${status}    </b></span>	 
		               
		       </td>
		     </tr>
	
  </table>	

      <table class="table table-striped table-bordered" border="1" style="width: 60%;background:rgba(255,255,255,0.5);" align="center">	
        
     	     
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
										<input type="text"   name="userpassword" id="userpassword" class="form-control"  value="${password}">										
							</div>
				    </div>
		           </td>
      	                
	           </tr>
	           
	           
	           
          
	           <tr>
	           
	                       
	               <td align="left" bgcolor="white" width="50%">
					     <div class="col-xs-12">
							<label >Description </label>
							<div class="input-group">
								<span class="input-group-addon"><i class="fa fa-industry" aria-hidden="true"></i></span>
									<textarea rows="02" name="description"  id="description" value="${gopsuserdetail.description}" class="form-control" >${gopsuserdetail.description} </textarea>  										
							</div>
			            </div>
	               </td>
	
		               
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
	 	           
						  
	           </tr>
	           
	           

	           <tr>
                 
	               <td align="left" bgcolor="white" width="50%">
					     <div class="col-xs-12">
							<label> Access to Air Line  </label>
							<div class="input-group">
								<span class="input-group-addon"><i class="fa fa-plane" aria-hidden="true"></i></span>
									    <select multiple class="form-control" name="airline" id="airline">
									           ${listofairline}
									    </select>										
							</div>
			            </div>
	               </td>
	               
	               
	               <!--    https://harvesthq.github.io/chosen/  -->
	              
	               <td align="left" bgcolor="white" width="50%">
					  <div class="col-xs-15">
					 		<label> Access to Airport Stations   </label>					 							 		
							<div class="input-group">							
								<span class="input-group-addon"><i class="fa fa-text-height fa-lg" aria-hidden="true"></i></i></span>	
								
								
														
									<!-- <input type="text"  name="statio	n"  id="station" class="form-control" value="DUB,DBX" readonly>  -->
									
						<select  data-placeholder="Type Station Code or Name.." class="chosen-select form-control" multiple id="station" name="station">
					            <option value=""></option>
					                   ${listofstation}	
						</select>						
											
									
											
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
 <%@include file="../../include/gopsfooter.jsp" %>
