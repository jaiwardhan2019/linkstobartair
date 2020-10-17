<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="../../include/groundopsheader.jsp" />

<!DOCTYPE html>
<html>
<head>


<meta charset="ISO-8859-1">

<title>Update Airline Data</title>
</head>




<script type="text/javascript">


function add_new_user(){
	
	   document.smsreportuser.method="POST"	  
	   document.smsreportuser.action="manageairlinedata";
	   document.smsreportuser.submit();
	   return true;		

} //-------- End Of Function 




function update_user(){

	var iatacode = document.getElementById("iatacode").value;
	var icaocode  = document.getElementById("icaocode").value;
	var airlinename   = document.getElementById("airlinename").value;


	if(iatacode == "" || iatacode == " ") {
		alert("Please Enter IATA Code..");
		document.getElementById("iatacode").focus();	
		return false;
	}
	
	

	if(icaocode == "" || icaocode == " ") {
		alert("Please Enter ICAO Code..");
		document.getElementById("icaocode").focus();	
		return false;
	}
	
	

	if(airlinename == "" || airlinename == " ") {
		alert("Please Enter Airline Name .");
		document.getElementById("airlinename").focus();	
		return false;
	}

	
	if(confirm("Are you sure about Updating detail.. ??")){			  
		   document.smsreportuser.method="POST"
		   document.smsreportuser.operation.value="save";			   
		   document.smsreportuser.action="manageairlinedata";
		   document.smsreportuser.submit();
		   return true;				
	}
		

} //-------- End Of Function 





</script>



<body>


<!-- Body Banner -->
<div class="container" align="center" >
	  	
<!----------------- RIGHT CONTENT -------------------->
<div class="col-md-12 col-sm-12 col-xs-12" align="center" >

<form method="post" name="smsreportuser" id="smsreportuser"  onSubmit="return searchUser()";>

  <input type="hidden" id="emailid" name="emailid" value="<%=request.getAttribute("emailid")%>">
  <input type="hidden" id="password" name="password" value="<%=request.getAttribute("password")%>">
  <input type="hidden" name="usertype" value="${usertype}">
  <input type="hidden" name="operation" id="operation" value="">
  <input type="hidden" name="userinsubject" id="userinsubject"  value="${airlineEntity.id}">

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
					   <span style="color:white;"> <i class="fa fa-plane fa-lg" aria-hidden="true"></i> &nbsp;<b>
					    (Add / Update) Airline Data &nbsp;&nbsp;
					   </b></span>					 
					 </td>
			     </tr>
			
			
			   <tr>
                
                  <td align="left" bgcolor="white" width="50%">
					<div class="col-xs-10">
							<label> IATA Code </label>
							<div class="input-group">
								<span class="input-group-addon"><i class="fa fa-text-height fa-lg" aria-hidden="true"></i></i></span>	
										<input type="text"  name="iatacode" id="iatacode" class="form-control" value="${airlineEntity.iata_code}">					
												
							</div>
				    </div>
				    
	    
		                
	                </td>
	 				
				            
	              <td align="left" bgcolor="white" width="50%">
					<div class="col-xs-10">
							<label  >ICAO Code</label>  
							<div class="input-group">
								<span class="input-group-addon"><i class="fa fa-text-height fa-lg" aria-hidden="true"></i></span>
										<input type="text"   name="icaocode" id="icaocode" class="form-control"  value="${airlineEntity.icao_code}">										
							</div>
				    </div>
		           </td>
      	                
	           </tr>
	           
	           
	           
          
	           <tr>        
	               <td align="left" bgcolor="white" width="50%">
					     <div class="col-xs-10">
							<label >Airline Name </label>
							<div class="input-group">
								<span class="input-group-addon"><i class="fa fa-phone" aria-hidden="true"></i></span>
									<input type="text"  name="airlinename"  id="airlinename" value="${airlineEntity.airline_name}" class="form-control" >  										
							</div>
			            </div>
	               </td>
	
		               
	               <td align="left" bgcolor="white" width="50%">
					     <div class="col-xs-10">
							<label>Operational </label>
							<div class="input-group">
								<span class="input-group-addon"><i class="fa fa-universal-access" aria-hidden="true"></i></span>								
										<select id="status" name="status" class="form-control" onchange="view_contract()" >	
                                               <option value="Enable" <c:if test ="${airlineEntity.status == 'Enable'}"> selected </c:if> > -  YES - </option>
                                               <option value="Disable" <c:if test ="${airlineEntity.status == 'Disable'}"> selected </c:if> > - NO  - </option>     					
										</select>
							</div>	
						</div>
	               
	               
	               </td>	               
	 	           
						  
	           </tr>
	           
				
			   <tr>
                
                  <td align="left" bgcolor="white" width="50%">
					<div class="col-xs-10">
							<label> SLA One  </label>
							<div class="input-group">
								<span class="input-group-addon"><i class="fa fa-text-height fa-lg" aria-hidden="true"></i></i></span>	
										<textarea rows="02"  name="slaone" id="slaone" class="form-control" value="${airlineEntity.sla_one}">${airlineEntity.sla_one}</textarea>		 			
												
							</div>
				    </div>
				    
	    
		                
	                </td>
	 				
				            
	              <td align="left" bgcolor="white" width="50%">
					<div class="col-xs-10">
							<label>SLA Two</label>  
							<div class="input-group">
								<span class="input-group-addon"><i class="fa fa-text-height fa-lg" aria-hidden="true"></i></span>
										<textarea rows="02"   name="slatwo" id="slatwo" class="form-control"  value="${airlineEntity.sla_two}">${airlineEntity.sla_two} </textarea>										
							</div>
				    </div>
		           </td>
      	                
	           </tr>
	            
	            <tr>
	            
	             <td align="left" bgcolor="white" colspan="2">
					<div class="col-xs-10">
							<label>Any Comment</label>  
							<div class="input-group">
								<span class="input-group-addon"><i class="fa fa-text-height fa-lg" aria-hidden="true"></i></span>
										<textarea rows="02"   name="comment" id="comment" class="form-control"  value="${airlineEntity.comment}">${airlineEntity.comment} </textarea>										
							</div>
				    </div>
		           </td>
      	                
	           </tr>
	            
	            
	            

 		      <tr align="center"> 
				     					
						<td  bgcolor="white" colspan="2">	
			
			                   <span onClick="add_new_user();" id="addnew" class="btn btn-primary" > &nbsp;Back&nbsp;<i class="fa fa-search" aria-hidden="true"></i>  </span>  
			                   &nbsp;&nbsp;&nbsp;   
			                   <span onClick="update_user();" id="addnew" class="btn btn-success" >&nbsp;Update &nbsp; <i class="fa fa-pencil-square-o" aria-hidden="true"></i> </span>
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
<br>
<br>
<br>
<br>
<br>
<br>
 <%@include file="../../include/gopsfooter.jsp" %>
