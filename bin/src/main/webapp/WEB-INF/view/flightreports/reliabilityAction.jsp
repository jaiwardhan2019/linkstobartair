<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="userEmail" value='${userEmail}' scope="session" />
<jsp:include page="../include/header.jsp" />

<head>
    <title> Dashboard | Reliability Report </title>    
</head>

<script type="text/javascript">



function showReport(){

     
	    if(document.reliablityreportform.startDate.value == ""){
	       alert("Please Select Start Date");
	       document.reliablityreportform.startDate.focus();
	       return false;
		}

	    if(document.reliablityreportform.endDate.value == ""){
		       alert("Please Select End  Date");
		       document.reliablityreportform.endDate.focus();
		       return false;
		}
		
	    if(document.reliablityreportform.tolerance.value == ""){
		       alert("Please put value in Tolerance");
		       document.reliablityreportform.tolerance.focus();
		       return false;
		}  



		else
		{ 
		   document.reliablityreportform.method="POST";
		   document.reliablityreportform.action="reliabilityActionReport?emailid=${emailid}";
	       document.reliablityreportform.submit();
		   return true;
		}
		
}//----------- End of Function 
   
	
</script>



<body style="font-family: 'Lato', 'Helvetica Neue', Helvetica, Arial, sans-serif;">
  <br>
 <br>
  <br>
 <!-- 
   <div class="container" style="margin-top:60px;">	
		<div class="col-md-12 col-sm-12 col-xs-12" >
			<i class="fa fa-database fa-2x pull-left" aria-hidden="true"></i><span style="font-weight:600;font-size:13pt;">Reliability Report&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
			 </span>
	   </div>
  </div>
  --> 	
 <br>
  <br>
   
 <div class="container" align="left" >
 
 <form name="reliablityreportform" id="reliablityreportform">  
 
      <input type="hidden" name="emailid" id="emailid" value="<%=request.getAttribute("emailid")%>"> 
      <input type="hidden" name="password" id="password" value="<%=request.getAttribute("password")%>"> 
     
    <table class="table table-striped table-bordered" border="1" style="width: 35%;" align="left"> 
    			
				<tbody>	
		                       				     

		 	     <tr align="center">
					 <td  bgcolor="#0070BA">
					   <span style="color:white;">  <i class="fa fa-database fa-lx" aria-hidden="true"></i> &nbsp;<b>
					    Reliability Action 
					   </b></span>					 
					 </td>
				     </tr>
		   
		 
		 
		 
		 
		 
					<tr>
					<td>
						<div class="form-group">
							<label for="airlineCode">Operating Airline:</label>
							<div class="input-group">
								<span class="input-group-addon"><i class="fa fa-plane"></i></span>							
									
										<select id="airlineCode" name="airlineCode" class="form-control">
											<option value="ALL">All Airlines</option>
											
						                            	 ${airlinelist}
											
										</select>
								
							</div>
						</div>
						
								
			             </td>
			          </tr>
			          
	 
					<tr>
					
					
					<td>
						<div class="form-group">
							<label for="airlineCode">Departure Airport:</label>
							<div class="input-group">
								<span class="input-group-addon"><i class="fa fa-plane"></i></span>							
									
									<select id="airportCode" name="airportCode" class="form-control">
									<option value="ALL">All Airport</option>	
										     ${airportlist}
									</select>   
								
							</div>
						</div>
						
								
			             </td>
			          </tr>
			          
			          
			          
			          <tr>
			           <td>
	
	
	                    <div class="form-group">
							<label for="startDate">Start Date:</label>
							<div class="input-group">
								<span class="input-group-addon"><i class="fa fa-calendar"></i></span>								
								<input type="date" id="startDate" name="startDate" class="form-control datepicker" maxlength="12" value="${startDate}" />
							</div>	
						</div>
						
	
						</td>
						
				     </tr>	
				     
				     <tr>
				       <td>
				       
				       
				       <div class="form-group">
							<label for="endDate">End Date:</label>
							<div class="input-group">
								<span class="input-group-addon"><i class="fa fa-calendar"></i></span>
								
								<input type="date" id="endDate" name="endDate" class="form-control datepicker" maxlength="12" value="${endDate}"  max="${endDate}"/>
								
							</div>
						</div>
				       
				       
				       
				       
				       </td>
				     
				     </tr>
				     
		
				     <tr>
		
				      <td>
				      
							<label for="tolerance">Tolerance:</label>
							<div class="input-group">
								<span class="input-group-addon"><i class="fa fa-clock-o"></i></span>
								<input type="text" id="tolerance" name="tolerance" class="form-control" maxlength="9" value="0" placeholder="Delay Tolerance in Minutes"/>
							</div>
				      
				      </td>
				     
				     </tr>
				     
				     
				     <tr>
				        <td>
		                    
		                	<label for="delayGroupCode">Delay Code Group:</label>
							<div class="input-group">
								<span class="input-group-addon"><i class="fa fa-hand-stop-o"></i></span>
								<select id="delayCodeGroupCode" name="delayCodeGroupCode" class="form-control">
									<option value="ALL">All Delay Codes</option>
									
										<option value="A1" >Ground Ops</option>
									
										<option value="AX" >Stobart Attributable Delays</option>
									
										<option value="AY" >Non Stobart Delays</option>
									
								</select>
							</div>
		                    
		                  </td>
		               </tr>     
		                    
		                    
		                    
		                    
		                    
		                    
		                    		     
				     
				     
				     
				     
				    <tr align="center"> 
				     					
					<td  bgcolor="white">
				       
				   
				       <input type="button" class="btn btn-primary" value="Show Report" onClick="showReport();" />  
				       
				     </td>
				     </tr>
				     
							    
				    </tbody>
			</table>


  					
		    <table  class="table table-striped table-bordered"  border="0" style="width: 40%;" align="center">	
				    
				
				   <tr align="center">
					 <td  bgcolor="#0070BA">
					     <span style="color:white;"> <b>Useful Phone Numbers </b></span>					 
					 </td>
				     </tr>
		          
				    <tr>
				        <td bgcolor="white"> 
				           <br>
				          <ul>
				             <li> 
				                <i class="fa fa-phone" aria-hidden="true"></i>  <span style="color:black;"> Ops. Controller :  +353-1-8447617 </span>
				             </li>
				             
				             <li> 
				                <i class="fa fa-phone" aria-hidden="true"></i> <span style="color:black;"> Ops. Supervisor :  +353-1-8447602 </span>
				             </li>
				            
				             <li> 
				                <i class="fa fa-phone" aria-hidden="true"></i> <span style="color:black;">Customer & Handling Co-ordinator +353-1-8447618 </span>
				             </li>
				             
				                    
				             <li> 
				                 <i class="fa fa-clock-o" aria-hidden="true"></i> <b> <span style="color:black;">Please note that the below are Zulu times. </span> </b> 
				             </li>
				   
				             
				          </ul>             
                              
		
							   
				        
				        </td>
				    </tr>
		
			
			</table>


</div>		
 		<br>
		<br>	
		<br>
		<br>
		
 </form>		
 
</body>



<%@include file="../include/footer.jsp" %>