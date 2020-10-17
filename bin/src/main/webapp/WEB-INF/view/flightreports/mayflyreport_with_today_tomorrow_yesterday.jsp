<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>


<!-- 

https://canvasjs.com/jsp-charts/pie-chart/
https://www.jeejava.com/google-chart-using-jsp-servlet/   

 -->

<jsp:include page="../include/header.jsp" >
  <jsp:param name="emailid" value='<%=request.getParameter("emailid")%>' />
</jsp:include>


<head>
    <title> Dashboard | May Fly Report </title>    
</head>


<script type="text/javascript">


function showmayFlyReport(){
	         
		document.mayFlightReport.method="POST";
		document.mayFlightReport.action="flight_mayFly_report";
	    document.mayFlightReport.submit();
		return true;

		
}//---------- End Of Function  ------------------




//-------------- Start Function -------------------
function Show_Tomorrow_Report(todaydate){
	     var someDate = new Date(document.mayFlightReport.datop.value);
         someDate.setDate(someDate.getDate() + 1); //number  of days to add, e.x. 15 days
         var dateFormated = someDate.toISOString().substr(0,10);         
         document.mayFlightReport.datop.value=dateFormated;
         alert(document.mayFlightReport.datop.value);
 		 document.mayFlightReport.method="POST";
		 document.mayFlightReport.action="flight_mayFly_report";
	     document.mayFlightReport.submit();
		 return true;
}




	
</script>

<style>

tr:nth-child(even) {
  background-color: #dddddd;
}

</style>


	

<body>
<!-- 
<br>
 <br>
   <div class="container" style="margin-top:60px;">	
		<div class="col-md-12 col-sm-12 col-xs-12" >
			<i class="fa fa-database fa-2x pull-left" aria-hidden="true"></i> &ensp;<span style="font-weight:600;font-size:13pt;">May Fly Report&nbsp;&nbsp;&nbsp;&nbsp; 
			 <c:set var = "now" value = "<%=new java.util.Date()%>" /> 
			 <fmt:formatDate type = "date"  value ="${now}" />
			 
			 </span>
	   </div>
  </div>	
 <br>
 --> 
   
 <br>
 <br>
 <br>
 <br>
 <br>
 
  
   
 <div class="container" align="center">
 
 
 
 <div class="col-md-12 col-sm-12 col-xs-12" align="left" >
 
 <form name="mayFlightReport" id="mayFlightReport">  
  
      <input type="hidden" name="emailid" id="emailid" value="<%=request.getParameter("emailid")%>">
       
		    <c:set var = "now" value = "<%=new java.util.Date()%>" /> 		     
		      <input type="hidden" name="datop" id="datop"   value="<fmt:formatDate pattern = "yyyy-MM-dd"  value = "${now}" />">
	       <table class="table table-striped table-bordered" border="1" style="width: 35%;" align="left">	    
    			<tbody>				     
				     <tr align="center">
					 <td  bgcolor="#0070BA">
					   <span style="color:white;">  <i class="fa fa-database fa-lx" aria-hidden="true"></i> &nbsp;<b>
					    May Fly Report Parameter &nbsp;&nbsp; 	 
					    <c:set var = "now" value = "<%=new java.util.Date()%>" /> 
			             <fmt:formatDate type = "date"  value ="${now}" />
					   </b></span>					 
					 </td>
				     </tr>
		            
					<tr>
					<td align="left" bgcolor="white" >
					 
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
				     
				    <tr align="left"> 
				     					
						<td  bgcolor="white">
								<div class="form-group">
										<label for="airlineCode">Departure Airport:</label>
										<div class="input-group">
											<span class="input-group-addon"><i class="fa fa-plane"></i></span>							
												
												<select id="airportcode" name="airportcode" class="form-control">
												<option value="ALL">All Airport</option>	
													     ${airportlist}
							                    </select>   
									
									</div>
								</div>
					
					       </td>
					 </tr>
				     
				  <tr align="left"> 
				     					
					<td  bgcolor="white">
				             
				             
				             <div class="form-group">
							<label for="sortBy">Sort By:</label>
							<div class="input-group">
								<span class="input-group-addon"><i class="fa fa-sort-amount-asc" aria-hidden="true"></i></span>
								<select id="sortby" name="sortby" class="form-control">
									
									   <option value="ETD_DATE_TIME">Expected Time Of Departure</option>
									   <option value="LONG_REG">Aircraft Reg</option>
									
								</select>
							</div>
						</div>
								
								
								
				       </td>
				     </tr>
				     
				    <tr align="center"> 
				     					
						<td  bgcolor="white">
					       <!-- 
					       <input id="Show Report"  class="ibutton" type="button" onclick="showmayFlyReport();" value="Show Report" />
					       <a onclick="showmayFlyReport();" class="btn btn-success"><i class="fa fa-plane fa-fw"></i> Click Me</a>
					        -->
					       <input type="submit" class="btn btn-primary" value="Show Report" onsubmit="showmayFlyReport();" /> 
					       
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
				                 <b> <span style="color:black;">Please note that the below are Zulu times. </span> </b>
				             </li>
				   
				             
				          </ul>             
                              
		
							   
				        
				        </td>
				    </tr>
				   
				   <!--  	    
				     <tr>
						 <td bgcolor="white">
								   <br>
					       <ul>
				              
				              
				              
				              
				             <li> 
				                 <span style="color:red;"> <b>RED </b></span> <span style="color:black;">&nbsp;&nbsp;= Flight Cancel / Delay more than 15 minutes.  </span>   
				             </li>
				          	 
				          	 <li> 
				                 <span style="color:orange;"> <b>ORANGE </b> </span> <span style="color:black;">= Flight Over Booked. </span>  
				             </li>
				          				   
				              <li> 
				                 <span style="color:red;"> <b>NOTE </b> </span> <span style="color:black;">&nbsp;&nbsp;<> Please note that the below are Zulu times. </span>  
				             </li>
						  </ul>	 
						 </td>
				    </tr>
		
				-->
				
				
				
			    </table>
			     
			     	   <br><br>           
	    	           <p align="center">    <img  src="<c:url value="images/${airlinecode}.png"/>" width="20%" > </p>
					    
				
			 
    	     <br>


   </div>
  


</div>		


<br>
 
 
 
 <!-- FOR TODAY TOMORROW YESTERDAY   -->
 <div class="container" align="center">
 
       <ul class="nav nav-pills">
			<li>
			  <a data-toggle="pill" href="#yesterday" >Yesterday Flights</a>
			
			</li>
			
			<li class="active">
			  <a data-toggle="pill" href="#today">Today Flights</a>
			</li>
			
			<li>
			   <a data-toggle="pill" href="#tomorrow">Tomorrow Flights</a>
			</li>
		
		</ul>
	<!-- END OF  TODAY TOMORROW YESTERDAY   DIV  MENU PAD -->





<div class="tab-content">





<!-- YESTERDAY BODY  -->
<div id="yesterday" class="tab-pane fade">
	<table class="table table-striped table-bordered" border="1" style="width: 100%;" align="center">	  
   
		<tbody>
	     <tr align="center">
	        
	                <td bgcolor="#0070BA">
					   <span style="color:white;"> <b> 
					    Flight Date	
					     </b></span>					 
					 </td>
		
					 <td bgcolor="#0070BA">
					   <span style="color:white;"> <b> 
					    Aircraft Reg
					     </b></span>					 
					 </td>
					 
					 <td bgcolor="#0070BA">
					   <span style="color:white;"> <b> 
					    Type	
					     </b></span>					 
					 </td>
					 <td bgcolor="#0070BA">
					   <span style="color:white;"> <b> 
					    Flight No	
					     </b></span>					 
					 </td>
					 <td bgcolor="#0070BA">
					   <span style="color:white;"> <b> 
					      From	
					     </b></span>					 
					 </td>

					 <td bgcolor="#0070BA">
					   <span style="color:white;"> <b> 
					       To	
					     </b></span>					 
					 </td>
					 <td bgcolor="#0070BA">
					   <span style="color:white;"> <b> 
					     STD	
					     </b></span>					 
					 </td>
					 <td bgcolor="#0070BA">
					   <span style="color:white;"> <b> 
					     ETD	
					     </b></span>					 
					 </td>
					 <td bgcolor="#0070BA">
					   <span style="color:white;"> <b> 
					      ATD	
					     </b></span>					 
					 </td>
					 <td bgcolor="#0070BA">
					   <span style="color:white;"> <b> 
					      STA	
					     </b></span>					 
					 </td>
					 <td bgcolor="#0070BA">
					   <span style="color:white;"> <b> 
					      ETA	
					     </b></span>					 
					 </td>
					 <td bgcolor="#0070BA">
					   <span style="color:white;"> <b> 
					       ATA	
					     </b></span>					 
					 </td>
					 
					 <td bgcolor="#0070BA">
					   <span style="color:white;"> <b> 
					     Config	
					     </b></span>					 
					 </td>
					 
					 <td bgcolor="#0070BA">
					   <span style="color:white;"> <b> 
					     Plan. Pax	
					     </b></span>					 
					 </td>
					 <td bgcolor="#0070BA">
					   <span style="color:white;"> <b> 
					     Act. Pax	
					     </b></span>					 
					 </td>
					 <td bgcolor="#0070BA">
					   <span style="color:white;"><b> 
					     Sect. Comments
					     </b></span>					 
					 </td>
					 <td bgcolor="#0070BA" >
					   <span style="color:white;"> <b> 
					     Delay Code/Time
					     </b></span>					 
					 </td>
				 </tr>
				 
				 
		

		 
				 
		<!-- Write DB Loops to display Data -->
		 <c:forEach var="fltleg" items="${reportbodyyesterday}"> 
		 
		 			 
			     <tr align="center">
		   
		                           
		              <td>
					    
					      ${fltleg.getFlightDatop()} 
					      					 
					 </td>
		    
		    
					 <td>
					    ${fltleg.aircraftReg} 
									    
					        <c:set var = "ftlreg"  value = "${fltleg.aircraftReg}"/>
						      <c:if test = "${ftlreg == null}">
						           <b> <span style="color:red;"> <c:out value = "CANC-"/>${fltleg.aircraftType}</span></b>
						      </c:if>
					 </td>
					 
					 <td>
					       
						<c:choose>
						    <c:when test="${ftlreg == null}">
						        <b> <span style="color:red;">${fltleg.aircraftType}</span></b>
						        <br/>
						    </c:when>    
						    <c:otherwise>
						        ${fltleg.aircraftType}
						        <br />
						    </c:otherwise>
						</c:choose>
					     
					     
					     
					     
					     
					      					 
					 </td>
				
					 <td>
					    
					    
						<c:choose>
						    <c:when test="${ftlreg == null}">
						        <b> <span style="color:red;">${fltleg.flightNo}</span></b>
						        <br/>
						    </c:when>    
						    <c:otherwise>
						        ${fltleg.flightNo}
						        <br />
						    </c:otherwise>
						</c:choose>
					    
					    
					    
					      					 
					 </td>
					 
					 <td>
					    
					     ${fltleg.from}
					      					 
					 </td>

					 <td>
					    
					    ${fltleg.to}
					      					 
					 </td>
					 
					 <td>
					    
					    ${fltleg.atd} 
					      					 
					 </td>
					 <td  >
					    
					      ${fltleg.etd}
					      					 
					 </td>
					 <td>
					    <a href="#" onclick="return false;" data-toggle="popover" data-trigger="hover"  title="ATD | Airborne Time" data-content="${fltleg.atd} | ${fltleg.airborn}"> 
					     ${fltleg.atd}
					     
					     </a>
					      					 
					 </td>
					 
					 <td>
					    
					      ${fltleg.sta}
					      					 
					 </td>
					 
					 <td>
					    
					       ${fltleg.eta}
					      					 
					 </td>
					 
					 <td>
					      <a href="#" onclick="return false;" data-toggle="popover" data-trigger="hover"  title="Landing Time | ATA" data-content="${fltleg.touchdown} | ${fltleg.ata}">${fltleg.ata}</a>
					      					 
					 </td>
					 
					 <td  >
					    
					      ${fltleg.noOfSeats}
					      					 
					 </td>
					 
					 <td>
					    
					     ${fltleg.bookedPax}	
					      					 
					 </td>
					 
					 <td>
					    
					      ${fltleg.totalOnBoard}	
					      					 
					 </td>
					 
					 
					 
					 
					 <td align="left">
					     &nbsp;&nbsp;
	                  <c:set var = "seccoment"  value = "${fn:length(fltleg.sectorComments1)}"/>
					      <c:if test = "${seccoment > 0}">
			               <a href="#" onclick="return false;" data-toggle="popover" data-trigger="hover" title="Ops Note" data-content="${fltleg.sectorComments1}"><i class="fa fa-user-plus"></i>
			                  &nbsp;</a>					      
					     </c:if>
		               
                   
                     <c:set var = "seccoment"  value = "${fn:length(fltleg.sectorComments2)}"/>
			 		      <c:if test = "${seccoment > 0}">
			               <a href="#" onclick="return false;" data-toggle="popover" data-trigger="hover" title="Ops Note" data-content="${fltleg.sectorComments2}"><i class="fa fa-thumbs-up"></i>
			                &nbsp;</a>					      
					     </c:if>
		                 
                     <c:set var = "seccoment"  value = "${fn:length(fltleg.sectorComments3)}"/>
					      <c:if test = "${seccoment > 0}">
			               <a href="#" onclick="return false;" data-toggle="popover" data-trigger="hover" title="Ops Note" data-content="${fltleg.sectorComments3}"><i class="fa fa-recycle"></i>
			                &nbsp;</a>					      
					     </c:if>
		                 
                     <c:set var = "seccoment"  value = "${fn:length(fltleg.sectorComments4)}"/>
					      <c:if test = "${seccoment > 0}">
			               <a href="#" onclick="return false;" data-toggle="popover" data-trigger="hover" title="Ops Note" data-content="${fltleg.sectorComments4}"><i class="fa fa-cutlery"></i>
			               </a>					      
					     </c:if>
		        
		                  
		                  
					 
					 </td>
					 
					 
					 
					 
					 
					 
					 <td align="left">
					  
					   <c:set var = "delaycode"  value = "${fn:length(fltleg.delayCode1)}"/>   
	                
					      <c:if test = "${delaycode >= 2}">
					           <a href="#" onclick="return false;" data-toggle="popover" data-trigger="hover"  title="Detail" data-content="${fltleg.delayCode1_desc}" data-placement="top">
					             <b> <c:out value = "${fltleg.delayCode1}"/></b></a>/${fltleg.delayCode1_time}
					        
					      </c:if>
						
					   <c:set var = "delaycode"  value = "${fn:length(fltleg.delayCode2)}"/>   
	                
					      <c:if test = "${delaycode >= 2}">,
					           <a href="#" onclick="return false;" data-toggle="popover" data-trigger="hover"  title="Detail" data-content="${fltleg.delayCode2_desc}" data-placement="top">
					             <b><c:out value = "${fltleg.delayCode2}"/></b></a>/${fltleg.delayCode2_time}
					        
					      </c:if>
					      
					      
					   <c:set var = "delaycode"  value = "${fn:length(fltleg.delayCode3)}"/>   
	                
					      <c:if test = "${delaycode >= 2}">,
					           <a href="#" onclick="return false;" data-toggle="popover" data-trigger="hover"  title="Detail" data-content="${fltleg.delayCode3_desc}" data-placement="top">
					             <b><c:out value = "${fltleg.delayCode3}"/></b></a>/${fltleg.delayCode3_time}
					        
					      </c:if>
					      
						
					   <c:set var = "delaycode"  value = "${fn:length(fltleg.delayCode4)}"/>   
	                
					      <c:if test = "${delaycode >= 2}">,
					           <a href="#" onclick="return false;" data-toggle="popover" data-trigger="hover"  title="Detail" data-content="${fltleg.delayCode4_desc}" data-placement="top">
					             <b><c:out value = "${fltleg.delayCode4}"/></b></a>&nbsp;/${fltleg.delayCode4_time}
					        
					      </c:if>
					      
					  
					  
					
					  
	      				      					 
					 </td>
				  
						  
				  
				  
				  </tr>
				     				
		    </c:forEach>		
		    
		    	    
		    <tr>
		    
		      <td colspan="17" align="center">
	              <c:set var = "rowcount" scope = "session" value = "${fn:length(reportbodyyesterday)}"/>
	              <c:if test = "${rowcount == 0}">
		              <b> Sorry There is no flight found based on your search criteria..</b>
		          </c:if>
		          
               </td> 
		    </tr>
		    		
			</tbody>				    
    </table>			
		
			
</div>
<!-- END OF YESTERDAY -->		






<!-- TODAY BODY  -->		
<div id="today" class="tab-pane fade in active" >
    <table class="table table-striped table-bordered" border="1" style="width: 100%;" align="center">	  
   
		<tbody>
	     <tr align="center">
	        
	                <td bgcolor="#0070BA">
					   <span style="color:white;"> <b> 
					    Flight Date	
					     </b></span>					 
					 </td>
		
					 <td bgcolor="#0070BA">
					   <span style="color:white;"> <b> 
					    Aircraft Reg
					     </b></span>					 
					 </td>
					 
					 <td bgcolor="#0070BA">
					   <span style="color:white;"> <b> 
					    Type	
					     </b></span>					 
					 </td>
					 <td bgcolor="#0070BA">
					   <span style="color:white;"> <b> 
					    Flight No	
					     </b></span>					 
					 </td>
					 <td bgcolor="#0070BA">
					   <span style="color:white;"> <b> 
					      From	
					     </b></span>					 
					 </td>

					 <td bgcolor="#0070BA">
					   <span style="color:white;"> <b> 
					       To	
					     </b></span>					 
					 </td>
					 <td bgcolor="#0070BA">
					   <span style="color:white;"> <b> 
					     STD	
					     </b></span>					 
					 </td>
					 <td bgcolor="#0070BA">
					   <span style="color:white;"> <b> 
					     ETD	
					     </b></span>					 
					 </td>
					 <td bgcolor="#0070BA">
					   <span style="color:white;"> <b> 
					      ATD	
					     </b></span>					 
					 </td>
					 <td bgcolor="#0070BA">
					   <span style="color:white;"> <b> 
					      STA	
					     </b></span>					 
					 </td>
					 <td bgcolor="#0070BA">
					   <span style="color:white;"> <b> 
					      ETA	
					     </b></span>					 
					 </td>
					 <td bgcolor="#0070BA">
					   <span style="color:white;"> <b> 
					       ATA	
					     </b></span>					 
					 </td>
					 
					 <td bgcolor="#0070BA">
					   <span style="color:white;"> <b> 
					     Config	
					     </b></span>					 
					 </td>
					 
					 <td bgcolor="#0070BA">
					   <span style="color:white;"> <b> 
					     Plan. Pax	
					     </b></span>					 
					 </td>
					 <td bgcolor="#0070BA">
					   <span style="color:white;"> <b> 
					     Act. Pax	
					     </b></span>					 
					 </td>
					 <td bgcolor="#0070BA">
					   <span style="color:white;"><b> 
					     Sect. Comments
					     </b></span>					 
					 </td>
					 <td bgcolor="#0070BA">
					   <span style="color:white;"> <b> 
					      Delay Code/Time
					     </b></span>					 
					 </td>
				 </tr>
				 
				 
		

		 
				 
		<!-- Write DB Loops to display Data -->
		 <c:forEach var="fltleg" items="${reportbodytoday}"> 
		 
		 			 
			     <tr align="center">
		   
		                           
		              <td>
					    
					      ${fltleg.getFlightDatop()} 
					      					 
					 </td>
		    
		    
					 <td>
					    ${fltleg.aircraftReg} 
									    
					        <c:set var = "ftlreg"  value = "${fltleg.aircraftReg}"/>
						      <c:if test = "${ftlreg == null}">
						           <b> <span style="color:red;"> <c:out value = "CANC-"/>${fltleg.aircraftType}</span></b>
						      </c:if>
					 </td>
					 
					 <td>
					       
						<c:choose>
						    <c:when test="${ftlreg == null}">
						        <b> <span style="color:red;">${fltleg.aircraftType}</span></b>
						        <br/>
						    </c:when>    
						    <c:otherwise>
						        ${fltleg.aircraftType}
						        <br />
						    </c:otherwise>
						</c:choose>
					     
					     
					     
					     
					     
					      					 
					 </td>
				
					 <td>
					    
					    
						<c:choose>
						    <c:when test="${ftlreg == null}">
						        <b> <span style="color:red;">${fltleg.flightNo}</span></b>
						        <br/>
						    </c:when>    
						    <c:otherwise>
						        ${fltleg.flightNo}
						        <br />
						    </c:otherwise>
						</c:choose>
					    
					    
					    
					      					 
					 </td>
					 
					 <td>
					    
					     ${fltleg.from}
					      					 
					 </td>

					 <td>
					    
					    ${fltleg.to}
					      					 
					 </td>
					 
					 <td>
					    
					    ${fltleg.atd} 
					      					 
					 </td>
					 <td  >
					    
					      ${fltleg.etd}
					      					 
					 </td>
					 <td>
					    <a href="#" onclick="return false;" data-toggle="popover" data-trigger="hover"  title="ATD | Airborne Time" data-content="${fltleg.atd} | ${fltleg.airborn}"> 
					     ${fltleg.atd}
					     
					     </a>
					      					 
					 </td>
					 
					 <td>
					    
					      ${fltleg.sta}
					      					 
					 </td>
					 
					 <td>
					    
					       ${fltleg.eta}
					      					 
					 </td>
					 
					 <td>
					      <a href="#" onclick="return false;" data-toggle="popover" data-trigger="hover"  title="Landing Time | ATA" data-content="${fltleg.touchdown} | ${fltleg.ata}">${fltleg.ata}</a>
					      					 
					 </td>
					 
					 <td  >
					    
					      ${fltleg.noOfSeats}
					      					 
					 </td>
					 
					 <td>
					    
					     ${fltleg.bookedPax}	
					      					 
					 </td>
					 
					 <td>
					    
					      ${fltleg.totalOnBoard}	
					      					 
					 </td>
					 
					 
					 
					 
					 <td align="left">
					     &nbsp;&nbsp;
	                  <c:set var = "seccoment"  value = "${fn:length(fltleg.sectorComments1)}"/>
					      <c:if test = "${seccoment > 0}">
			               <a href="#" onclick="return false;" data-toggle="popover" data-trigger="hover" title="Ops Note" data-content="${fltleg.sectorComments1}"><i class="fa fa-user-plus"></i>
			                  &nbsp;</a>					      
					     </c:if>
		               
                   
                     <c:set var = "seccoment"  value = "${fn:length(fltleg.sectorComments2)}"/>
			 		      <c:if test = "${seccoment > 0}">
			               <a href="#" onclick="return false;" data-toggle="popover" data-trigger="hover" title="Ops Note" data-content="${fltleg.sectorComments2}"><i class="fa fa-thumbs-up"></i>
			                &nbsp;</a>					      
					     </c:if>
		                 
                     <c:set var = "seccoment"  value = "${fn:length(fltleg.sectorComments3)}"/>
					      <c:if test = "${seccoment > 0}">
			               <a href="#" onclick="return false;" data-toggle="popover" data-trigger="hover" title="Ops Note" data-content="${fltleg.sectorComments3}"><i class="fa fa-recycle"></i>
			                &nbsp;</a>					      
					     </c:if>
		                 
                     <c:set var = "seccoment"  value = "${fn:length(fltleg.sectorComments4)}"/>
					      <c:if test = "${seccoment > 0}">
			               <a href="#" onclick="return false;" data-toggle="popover" data-trigger="hover" title="Ops Note" data-content="${fltleg.sectorComments4}"><i class="fa fa-cutlery"></i>
			               </a>					      
					     </c:if>
		        
		                  
		                  
					 
					 </td>
					 
					 
					 
					 
					 
				 
		 <td align="left">
					  
					   <c:set var = "delaycode"  value = "${fn:length(fltleg.delayCode1)}"/>   
	                
					      <c:if test = "${delaycode >= 2}">
					           <a href="#" onclick="return false;" data-toggle="popover" data-trigger="hover"  title="Detail" data-content="${fltleg.delayCode1_desc}" data-placement="top">
					             <b> <c:out value = "${fltleg.delayCode1}"/></b></a>/${fltleg.delayCode1_time}
					        
					      </c:if>
						
					   <c:set var = "delaycode"  value = "${fn:length(fltleg.delayCode2)}"/>   
	                
					      <c:if test = "${delaycode >= 2}">,
					           <a href="#" onclick="return false;" data-toggle="popover" data-trigger="hover"  title="Detail" data-content="${fltleg.delayCode2_desc}" data-placement="top">
					             <b><c:out value = "${fltleg.delayCode2}"/></b></a>/${fltleg.delayCode2_time}
					        
					      </c:if>
					      
					      
					   <c:set var = "delaycode"  value = "${fn:length(fltleg.delayCode3)}"/>   
	                
					      <c:if test = "${delaycode >= 2}">,
					           <a href="#" onclick="return false;" data-toggle="popover" data-trigger="hover"  title="Detail" data-content="${fltleg.delayCode3_desc}" data-placement="top">
					             <b><c:out value = "${fltleg.delayCode3}"/></b></a>/${fltleg.delayCode3_time}
					        
					      </c:if>
					      
						
					   <c:set var = "delaycode"  value = "${fn:length(fltleg.delayCode4)}"/>   
	                
					      <c:if test = "${delaycode >= 2}">,
					           <a href="#" onclick="return false;" data-toggle="popover" data-trigger="hover"  title="Detail" data-content="${fltleg.delayCode4_desc}" data-placement="top">
					             <b><c:out value = "${fltleg.delayCode4}"/></b></a>&nbsp;/${fltleg.delayCode4_time}
					        
					      </c:if>
					      
					  
					  
					
					  
	      				      					 
					 </td>
				  
										  
					  
				  </tr>
				     				
		    </c:forEach>		
		    
		    	    
		    <tr>
		    
		      <td colspan="17" align="center">
	              <c:set var = "rowcount" scope = "session" value = "${fn:length(reportbodytoday)}"/>
	              <c:if test = "${rowcount == 0}">
		              <b> Sorry There is no flight found based on your search criteria..</b>
		          </c:if>
		          
               </td> 
		    </tr>
		    		
			</tbody>				    
    </table>		                     
 
 </div>
 <!-- END OF TODAY REPORT -->
 
 
 
 


	<!-- START TOMORROW BODY  -->
	<div id="tomorrow" class="tab-pane fade">
		
		  <table class="table table-striped table-bordered" border="1" style="width: 100%;" align="center">	  
   
		<tbody>
	     <tr align="center">
	        
	                <td bgcolor="#0070BA">
					   <span style="color:white;"> <b> 
					    Flight Date	
					     </b></span>					 
					 </td>
		
					 <td bgcolor="#0070BA">
					   <span style="color:white;"> <b> 
					    Aircraft Reg
					     </b></span>					 
					 </td>
					 
					 <td bgcolor="#0070BA">
					   <span style="color:white;"> <b> 
					    Type	
					     </b></span>					 
					 </td>
					 <td bgcolor="#0070BA">
					   <span style="color:white;"> <b> 
					    Flight No	
					     </b></span>					 
					 </td>
					 <td bgcolor="#0070BA">
					   <span style="color:white;"> <b> 
					      From	
					     </b></span>					 
					 </td>

					 <td bgcolor="#0070BA">
					   <span style="color:white;"> <b> 
					       To	
					     </b></span>					 
					 </td>
					 <td bgcolor="#0070BA">
					   <span style="color:white;"> <b> 
					     STD	
					     </b></span>					 
					 </td>
					 <td bgcolor="#0070BA">
					   <span style="color:white;"> <b> 
					     ETD	
					     </b></span>					 
					 </td>
					 <td bgcolor="#0070BA">
					   <span style="color:white;"> <b> 
					      ATD	
					     </b></span>					 
					 </td>
					 <td bgcolor="#0070BA">
					   <span style="color:white;"> <b> 
					      STA	
					     </b></span>					 
					 </td>
					 <td bgcolor="#0070BA">
					   <span style="color:white;"> <b> 
					      ETA	
					     </b></span>					 
					 </td>
					 <td bgcolor="#0070BA">
					   <span style="color:white;"> <b> 
					       ATA	
					     </b></span>					 
					 </td>
					 
					 <td bgcolor="#0070BA">
					   <span style="color:white;"> <b> 
					     Config	
					     </b></span>					 
					 </td>
					 
					 <td bgcolor="#0070BA">
					   <span style="color:white;"> <b> 
					     Plan. Pax	
					     </b></span>					 
					 </td>
					 <td bgcolor="#0070BA">
					   <span style="color:white;"> <b> 
					     Act. Pax	
					     </b></span>					 
					 </td>
					 <td bgcolor="#0070BA">
					   <span style="color:white;"><b> 
					     Sect. Comments
					     </b></span>					 
					 </td>
					 <td bgcolor="#0070BA">
					   <span style="color:white;"> <b> 
					     Delay Code/Time
					     </b></span>					 
					 </td>
				 </tr>
				 
				 
		

		 
				 
		<!-- Write DB Loops to display Data -->
		 <c:forEach var="fltleg_t" items="${reportbodytomorrow}"> 
		 
		 			 
			     <tr align="center">
		   
		                           
		              <td>
					    
					      ${fltleg_t.getFlightDatop()} 
					      					 
					 </td>
		    
		    
					 <td>
					    ${fltleg_t.aircraftReg} 
									    
					        <c:set var = "ftlreg"  value = "${fltleg_t.aircraftReg}"/>
						      <c:if test = "${ftlreg == null}">
						           <b> <span style="color:red;"> <c:out value = "CANC-"/>${fltleg_t.aircraftType}</span></b>
						      </c:if>
					 </td>
					 
					 <td>
					       
						<c:choose>
						    <c:when test="${ftlreg == null}">
						        <b> <span style="color:red;">${fltleg_t.aircraftType}</span></b>
						        <br/>
						    </c:when>    
						    <c:otherwise>
						        ${fltleg_t.aircraftType}
						        <br />
						    </c:otherwise>
						</c:choose>
					     
					     
					     
					     
					     
					      					 
					 </td>
				
					 <td>
					    
					    
						<c:choose>
						    <c:when test="${ftlreg == null}">
						        <b> <span style="color:red;">${fltleg_t.flightNo}</span></b>
						        <br/>
						    </c:when>    
						    <c:otherwise>
						        ${fltleg_t.flightNo}
						        <br />
						    </c:otherwise>
						</c:choose>
					    
					    
					    
					      					 
					 </td>
					 
					 <td>
					    
					     ${fltleg_t.from}
					      					 
					 </td>

					 <td>
					    
					    ${fltleg_t.to}
					      					 
					 </td>
					 
					 <td>
					    
					    ${fltleg_t.atd} 
					      					 
					 </td>
					 <td  >
					    
					      ${fltleg_t.etd}
					      					 
					 </td>
					 <td>
					    <a href="#" onclick="return false;" data-toggle="popover" data-trigger="hover"  title="ATD | Airborne Time" data-content="${fltleg_t.atd} | ${fltleg_t.airborn}"> 
					     ${fltleg_t.atd}
					     
					     </a>
					      					 
					 </td>
					 
					 <td>
					    
					      ${fltleg_t.sta}
					      					 
					 </td>
					 
					 <td>
					    
					       ${fltleg_t.eta}
					      					 
					 </td>
					 
					 <td>
					      <a href="#" onclick="return false;" data-toggle="popover" data-trigger="hover"  title="Landing Time | ATA" data-content="${fltleg_t.touchdown} | ${fltleg_t.ata}">${fltleg_t.ata}</a>
					      					 
					 </td>
					 
					 <td  >
					    
					      ${fltleg_t.noOfSeats}
					      					 
					 </td>
					 
					 <td>
					    
					     ${fltleg_t.bookedPax}	
					      					 
					 </td>
					 
					 <td>
					    
					      ${fltleg_t.totalOnBoard}	
					      					 
					 </td>
					 
					 
					 
						 
		 <td align="left">
					  
					   <c:set var = "delaycode"  value = "${fn:length(fltleg_t.delayCode1)}"/>   
	                
					      <c:if test = "${delaycode >= 2}">
					           <a href="#" onclick="return false;" data-toggle="popover" data-trigger="hover"  title="Detail" data-content="${fltleg_t.delayCode1_desc}" data-placement="top">
					             <b> <c:out value = "${fltleg_t.delayCode1}"/></b></a>/${fltleg_t.delayCode1_time}
					        
					      </c:if>
						
					   <c:set var = "delaycode"  value = "${fn:length(fltleg_t.delayCode2)}"/>   
	                
					      <c:if test = "${delaycode >= 2}">,
					           <a href="#" onclick="return false;" data-toggle="popover" data-trigger="hover"  title="Detail" data-content="${fltleg_t.delayCode2_desc}" data-placement="top">
					             <b><c:out value = "${fltleg_t.delayCode2}"/></b></a>/${fltleg_t.delayCode2_time}
					        
					      </c:if>
					      
					      
					   <c:set var = "delaycode"  value = "${fn:length(fltleg_t.delayCode3)}"/>   
	                
					      <c:if test = "${delaycode >= 2}">,
					           <a href="#" onclick="return false;" data-toggle="popover" data-trigger="hover"  title="Detail" data-content="${fltleg_t.delayCode3_desc}" data-placement="top">
					             <b><c:out value = "${fltleg_t.delayCode3}"/></b></a>/${fltleg_t.delayCode3_time}
					        
					      </c:if>
					      
						
					   <c:set var = "delaycode"  value = "${fn:length(fltleg_t.delayCode4)}"/>   
	                
					      <c:if test = "${delaycode >= 2}">,
					           <a href="#" onclick="return false;" data-toggle="popover" data-trigger="hover"  title="Detail" data-content="${fltleg_t.delayCode4_desc}" data-placement="top">
					             <b><c:out value = "${fltleg_t.delayCode4}"/></b></a>&nbsp;/${fltleg_t.delayCode4_time}
					        
					      </c:if>
					      
					  
					  
					
					  
	      				      					 
					 </td>
				  
						  
									 
					 
					 
					 
					 <td align="left">
					     &nbsp;&nbsp;
					   <c:set var = "delaycode"  value = "${fn:length(fltleg_t.delayCode1)}"/>   
	                
					      <c:if test = "${delaycode >= 2}">
					           <a href="#" onclick="return false;" data-toggle="popover" data-trigger="hover"  title="Delay Time : ${fltleg_t.delayCode1_time} Minutes." data-content="${fltleg_t.delayCode1_desc}" data-placement="top">
					             <b> <c:out value = "${fltleg_t.delayCode1}"/></b>
					          </a>,&nbsp; 
					      </c:if>
						
	                  <c:set var = "delaycode"  value = "${fn:length(fltleg_t.delayCode2)}"/> 
					      <c:if test = "${delaycode >= 2}">
					           <a href="#" onclick="return false;" data-toggle="popover" data-trigger="hover"  title="Delay Time : ${fltleg_t.delayCode2_time} Minutes." data-content="${fltleg_t.delayCode2_desc}" data-placement="top">
					             <b><c:out value = "${fltleg_t.delayCode2}"/> </b>
					          </a>,&nbsp;
					      </c:if>
					      
					      
					  <c:set var = "delaycode"  value = "${fn:length(fltleg_t.delayCode3)}"/> 
					       <c:if test = "${delaycode >= 2}">
					           <a href="#" onclick="return false;" data-toggle="popover" data-trigger="hover"  title="Delay Time : ${fltleg_t.delayCode3_time} Minutes." data-content="${fltleg_t.delayCode3_desc}" data-placement="top">
					             <b><c:out value = "${fltleg_t.delayCode3}"/></b>
					          </a>,&nbsp;
					      </c:if>						
						
					  <c:set var = "delaycode"  value = "${fn:length(fltleg_t.delayCode4)}"/> 
					       <c:if test = "${delaycode >= 2}">
					           <a href="#" onclick="return false;" data-toggle="popover" data-trigger="hover"  title="Delay Time : ${fltleg_t.delayCode4_time} Minutes." data-content="${fltleg_t.delayCode4_desc}" data-placement="top">
					             <b><c:out value = "${fltleg_t.delayCode4}"/></b>
					          </a>
					  </c:if>	
					  
					  
					  <!-- 
					  
	 
	                  <c:set var = "delaytime"  value = "${fltleg.delayCode1_time}"/>
					      <c:if test = "${delaytime > 0}">
					                 <c:out value = "${fltleg.delayCode1_time}"/>/
					      </c:if>
						
	                  <c:set var = "delaytime"  value = "${fltleg.delayCode2_time}"/>
					      <c:if test = "${delaytime > 0}">
					             <c:out value = "${fltleg.delayCode2_time}"/>/
					      </c:if>
					      
					      
					  <c:set var = "delaytime"  value = "${fltleg.delayCode3_time}"/>
					      <c:if test = "${delaytime > 0}">					           
					             <c:out value = "${fltleg.delayCode3_time}"/>/
					          </a>
					      </c:if>	
					      					
						
					  <c:set var = "delaytime"  value = "${fltleg.delayCode4_time}"/>
					      <c:if test = "${delaytime > 0}">					           
					             <c:out value = "${fltleg.delayCode4_time}"/>
					          </a>
					      </c:if>	
						     				      					 
					 </td>
				  
				  
				   -->
				  
				  </tr>
				     				
		    </c:forEach>		
		    
		    	    
		    <tr>
		    
		      <td colspan="17" align="center">
	              <c:set var = "rowcount" scope = "session" value = "${fn:length(reportbodytomorrow)}"/>
	              <c:if test = "${rowcount == 0}">
		              <b> Sorry There is no flight found based on your search criteria..</b>
		          </c:if>
		          
               </td> 
		    </tr>
		    		
			</tbody>				    
    </table>		         



		
		
		
		
		
	</div>
	<!-- END OF TOMORROW -->







 
 
 			
				
   </div>
			
			
			
</div>
 
 
			
		<br>
		<br>
 
</body>



<%@include file="../include/footer.jsp" %>




