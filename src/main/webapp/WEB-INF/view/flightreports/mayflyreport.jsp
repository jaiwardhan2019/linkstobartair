<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>



<jsp:include page="../include/header.jsp" >
  <jsp:param name="emailid" value='<%=request.getParameter("emailid")%>' />
  <jsp:param name="password" value='<%=request.getParameter("password")%>' />
</jsp:include>


<head>
    <title> Dashboard | Flight Report | May Fly</title>    
</head>


<script src="https://canvasjs.com/assets/script/canvasjs.min.js"></script>

<script type="text/javascript">


//------------- FOR THE GRAPH DISPLAY ------------------ 
window.onload = function() { 

var chart = new CanvasJS.Chart("chartContainer",{
	animationEnabled: true,
	theme: "light2",   // "light1", "dark1", "dark2"
	title: {
		text: ""
	},
	subtitles: [{
		text: ""
	}],
	data: [{
		//type: "pie",
		type: "doughnut",
		yValueFormatString: "#,##0",
		indexLabel: "{label}: {y}",
		toolTipContent: "{y} Flights",
		dataPoints : ${dataPoints}
	}]
});
chart.render();

	}


function showmayFlyReport(){

	   
	    if(document.mayFlightReport.datop.value == ""){
	       alert("Please Select Start Date");
	       document.mayFlightReport.datop.focus();
	       return false;
		}
		else
        {
         
	  	  document.mayFlightReport.method="POST";
		  document.mayFlightReport.action="flight_mayFly_report";
	      document.mayFlightReport.submit();
		  return true;
        } 
		
}//---------- End Of Function  ------------------




	
</script>

<style>

tr:nth-child(even) {
  background-color: #dddddd;
}

</style>


	

<body>

   
 <br>
 <br>
 <br>
 <br>
 <br>
 
  
   
 <div class="container" align="center">
 
 
 
 <div class="col-md-12 col-sm-12 col-xs-12" align="left" >
 
 <form name="mayFlightReport" id="mayFlightReport">  
  
      <input type="hidden" name="emailid" id="emailid" value="<%=request.getParameter("emailid")%>">
      <input type="hidden" name="password" id="password" value="<%=request.getParameter("password")%>">
          <table class="table table-striped table-bordered" border="1" style="width: 35%;" align="left">	    
    			<tbody>				     
				     <tr align="center">
					 <td  bgcolor="#0070BA">
					   <span style="color:white;">  <i class="fa fa-database fa-lx" aria-hidden="true"></i> &nbsp;<b>
					    Flight Report Parameter &nbsp;&nbsp;
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
							<label for="startDate">Date:</label>
							<div class="input-group">
								<span class="input-group-addon"><i class="fa fa-calendar"></i></span>								
								<input type="date" id="datop" name="datop" class="form-control datepicker" maxlength="12"
								    value="${datop}" placeholder="(DD/MM/YYYY)"/>
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
					       <input type="button" class="btn btn-primary" value="Show Report" onclick="showmayFlyReport();" /> 
					       
					     </td>
					     </tr>
				     
							    
				    </tbody>
			</table>
			 
		
		
	
		 	   
		    <table  class="table table-striped table-bordered"  border="0" style="width: 40%;" align="center">	
		   
		             
		           <div id="chartContainer" style="height: 370px; width: 50%;"></div>
		   
		    
		    </table>
		
				
		              <p align="center">    <img  src="images/${airlinecode}1.png"> </p>
    	

   </div>
  


</div>		


<br>
 
 
 
 <!-- FOR All / CANCEL FLIGHTS    -->
 <div class="container" align="center">
 
       <ul class="nav nav-pills">

			
			<li class="active">
			  <a data-toggle="pill" href="#today">${fn:length(reportbody)} - Flights</a>
			</li>
			
			<li>
			   <a data-toggle="pill" href="#tomorrow">${reportbody_cancle.stream().distinct().count()} - Cancelled</a>
			</li>
		    	
	         <span style="color:red;"> <b>RED </b></span> <span style="color:black;">= Flight Cancel / Delay more than 15 minutes.</span>&nbsp;&nbsp;
	         <span style="color:#D35400;"> <b>ORANGE </b> </span> <span style="color:black;">= Flight Over Booked. </span>&nbsp;&nbsp;  
		     <i class="fa fa-clock-o" aria-hidden="true"></i> <span style="color:black;font-weight:bold;"> ZULU Time. </span>
		</ul>
	<!-- END OF  TODAY TOMORROW YESTERDAY   DIV  MENU PAD -->





  <div class="tab-content">





<!-- TODAY BODY  -->		
<div id="today" class="tab-pane fade in active" >
    <table class="table table-striped table-bordered" border="1" style="width: 100%;" align="center">	  
   
		<tbody>
	     <tr align="center">
	        
	                <td bgcolor="#0070BA" width="7%">
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
		 <c:forEach var="fltleg" items="${reportbody}"> 
		 
		 
		 
		       <!-- BLACK DEFAULT COLOR  -->      
               <c:set var = "colorcodestyle"   value = ""/>
               
               <!-- ORANGE COLOR  -->
		       <c:set var="totalbookedper" value="${(fltleg.bookedPax*100)/fltleg.noOfSeats}"/>
		       <c:if test="${totalbookedper >= 90}">
		          <c:set var = "colorcodestyle"   value = "color:#D35400;font-weight:bold"/>
		       </c:if>
		       
		       
		       <!-- RED COLOR  -->
		       <c:set var = "ftlreg"  value = "${fltleg.aircraftReg}"/>
			   <c:if test = "${ftlreg == null}">
			          <c:set var = "colorcodestyle"   value = "color:red;font-weight:bold"/>
			   </c:if>		       
      
		 		<fmt:formatNumber var="total_delay" type="number" minIntegerDigits="2" maxFractionDigits="0" value="${(fltleg.delayCode1_time + fltleg.delayCode2_time+fltleg.delayCode3_time+fltleg.delayCode4_time)}"/>
	            <c:if test = "${total_delay > 15}">
			          <c:set var = "colorcodestyle"   value = "color:red;font-weight:bold"/>
			   </c:if>	
		       
		       
		 			 
			     <tr align="center">
		   
		     
		                            
		              <td>
					    
					     <span style="${colorcodestyle}">
					    
					         ${fltleg.getFlightDatop()}
					      
					      </span> 
					      					 
					 </td>
		    
		    
					 <td>
					     
					     	    
					     <span style="${colorcodestyle}">
					    
					          ${fltleg.aircraftReg} 
					      
					      </span> 
					
					 </td>
					 
					 <td>
					     
					     <span style="${colorcodestyle}">
					    
					          ${fltleg.aircraftType} 
					      
					      </span> 
					      					 
					 </td>
				
					 <td>
							     
					     <span style="${colorcodestyle}">
					    
					          ${fltleg.flightNo} 
					      
					      </span> 
					
			    
					    
					      					 
					 </td>
					 
					 <td>
					      <span style="${colorcodestyle}">
					         ${fltleg.from}
					      </span>
					       					 
					 </td>

					 <td>
					     <span style="${colorcodestyle}">
					        ${fltleg.to}
					     </span>   
					    
					      					 
					 </td>
					 
					 <td>
					      <span style="${colorcodestyle}">
					         ${fltleg.std} 
					     </span> 					 
					 </td>
					 
					 <td>
					    <span style="${colorcodestyle}">   
					      ${fltleg.etd}
					     </span> 
					      					 
					 </td>
					 
					 
					 <td>
					    <a href="#" onclick="return false;" data-toggle="popover" data-trigger="hover"  title="ATD | Airborne Time" data-content="${fltleg.atd} | ${fltleg.airborn}"> 
					   
					         <span style="${colorcodestyle}">
					              ${fltleg.atd}
					          </span>    
					     
					     </a>
					      					 
					 </td>
					 
					 <td>
					 
					        <span style="${colorcodestyle}">
					    
					           ${fltleg.sta}
					        </span>   
					      					 
					 </td>
					 
					 <td>
					        <span style="${colorcodestyle}">
					           ${fltleg.eta}
					         </span>  
					      					 
					 </td>
					 
					 <td>
					      <a href="#" onclick="return false;" data-toggle="popover" data-trigger="hover"  title="Landing Time | ATA" data-content="${fltleg.touchdown} | ${fltleg.ata}">
					      
					          <span style="${colorcodestyle}">
					             ${fltleg.ata}
					          </span>   
						      
					      </a>
					      					 
					 </td>
					 
					 <td>
					    
					    <span style="${colorcodestyle}">
					    
					      ${fltleg.noOfSeats}
					   </span>
					      					 
					 </td>
					 
					 <td>
					       <span style="${colorcodestyle}">
					           ${fltleg.bookedPax}	
					       </span>    
					      					 
					 </td>
					 
					 <td>
					        <span style="${colorcodestyle}">
					              ${fltleg.totalOnBoard}	
					         </span>     
					      					 
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
					             <b> <c:out value = "${fltleg.delayCode1}"/></b></a>
					        
					    		<fmt:formatNumber var="delay_hour" type="number" minIntegerDigits="2" maxFractionDigits="0" value="${ ((fltleg.delayCode1_time - (fltleg.delayCode1_time % 60)) / 60)}"/>
								<fmt:formatNumber var="delay_minute" type="number" minIntegerDigits="2" maxFractionDigits="0" value="${fltleg.delayCode1_time % 60}" />
									/ ${delay_hour}${delay_minute}
					      
					      </c:if>
						
					   <c:set var = "delaycode"  value = "${fn:length(fltleg.delayCode2)}"/>   
	                
					      <c:if test = "${delaycode >= 2}">,
					           <a href="#" onclick="return false;" data-toggle="popover" data-trigger="hover"  title="Detail" data-content="${fltleg.delayCode2_desc}" data-placement="top">
					             <b><c:out value = "${fltleg.delayCode2}"/></b></a>
					             
			       	    		<fmt:formatNumber var="delay_hour" type="number" minIntegerDigits="2" maxFractionDigits="0" value="${ ((fltleg.delayCode2_time - (fltleg.delayCode2_time % 60)) / 60)}"/>
								<fmt:formatNumber var="delay_minute" type="number" minIntegerDigits="2" maxFractionDigits="0" value="${fltleg.delayCode2_time % 60}" />
									/ ${delay_hour}${delay_minute}
					        
					      </c:if>
					      
					      
					   <c:set var = "delaycode"  value = "${fn:length(fltleg.delayCode3)}"/>   
	                
					      <c:if test = "${delaycode >= 2}">,
					           <a href="#" onclick="return false;" data-toggle="popover" data-trigger="hover"  title="Detail" data-content="${fltleg.delayCode3_desc}" data-placement="top">
					             <b><c:out value = "${fltleg.delayCode3}"/></b></a>					             
			       	    		<fmt:formatNumber var="delay_hour" type="number" minIntegerDigits="2" maxFractionDigits="0" value="${ ((fltleg.delayCode3_time - (fltleg.delayCode3_time % 60)) / 60)}"/>
								<fmt:formatNumber var="delay_minute" type="number" minIntegerDigits="2" maxFractionDigits="0" value="${fltleg.delayCode3_time % 60}"/>
								/${delay_hour}${delay_minute}					        
					      </c:if>
					      
						
					   <c:set var = "delaycode"  value = "${fn:length(fltleg.delayCode4)}"/>   
	                
					      <c:if test = "${delaycode >= 2}">,
					           <a href="#" onclick="return false;" data-toggle="popover" data-trigger="hover"  title="Detail" data-content="${fltleg.delayCode4_desc}" data-placement="top">
					             <b><c:out value = "${fltleg.delayCode4}"/></b></a>					             
			       	    		<fmt:formatNumber var="delay_hour" type="number" minIntegerDigits="2" maxFractionDigits="0" value="${ ((fltleg.delayCode4_time - (fltleg.delayCode4_time % 60)) / 60)}"/>
								<fmt:formatNumber var="delay_minute" type="number" minIntegerDigits="2" maxFractionDigits="0" value="${fltleg.delayCode4_time % 60}" />
								/${delay_hour}${delay_minute}						        
					      </c:if>
					
	      				      					 
					 </td>
				  
				  
				
										  
					  
				  </tr>
				     				
	
	
	 </c:forEach>		
		    
		    	    
		    <tr>
		    
		      <td colspan="17" align="center">
	              <c:set var = "rowcount" scope = "session" value = "${fn:length(reportbody)}"/>
	              <c:if test = "${rowcount == 0}">
		              <b> Sorry There is no flight found based on your search criteria..</b>
		          </c:if>
		          
               </td> 
		    </tr>
		    		
			</tbody>				    
    </table>		                     
 
 </div>
 <!-- END OF TODAY REPORT -->
 
 
 
 


	<!-- START CANCEL  BODY  -->
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
		 <c:forEach var="fltleg" items="${reportbody_cancle}"> 
		 
		 			 
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
					    
					    ${fltleg.std} 
					      					 
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
					             <b> <c:out value = "${fltleg.delayCode1}"/></b></a>					        
					    		<fmt:formatNumber var="delay_hour" type="number" minIntegerDigits="2" maxFractionDigits="0" value="${ ((fltleg.delayCode1_time - (fltleg.delayCode1_time % 60)) / 60)}"/>
								<fmt:formatNumber var="delay_minute" type="number" minIntegerDigits="2" maxFractionDigits="0" value="${fltleg.delayCode1_time % 60}" />/${delay_hour}${delay_minute}
						  
					      </c:if>
						
					   <c:set var = "delaycode"  value = "${fn:length(fltleg.delayCode2)}"/>   
	                
					      <c:if test = "${delaycode >= 2}">,
					           <a href="#" onclick="return false;" data-toggle="popover" data-trigger="hover"  title="Detail" data-content="${fltleg.delayCode2_desc}" data-placement="top">
					             <b><c:out value = "${fltleg.delayCode2}"/></b></a>
					             
			       	    		<fmt:formatNumber var="delay_hour" type="number" minIntegerDigits="2" maxFractionDigits="0" value="${ ((fltleg.delayCode2_time - (fltleg.delayCode2_time % 60)) / 60)}"/>
								<fmt:formatNumber var="delay_minute" type="number" minIntegerDigits="2" maxFractionDigits="0" value="${fltleg.delayCode2_time % 60}" />
								/${delay_hour}${delay_minute}
					        
					      </c:if>
					      
					      
					   <c:set var = "delaycode"  value = "${fn:length(fltleg.delayCode3)}"/>   
	                
					      <c:if test = "${delaycode >= 2}">,
					           <a href="#" onclick="return false;" data-toggle="popover" data-trigger="hover"  title="Detail" data-content="${fltleg.delayCode3_desc}" data-placement="top">
					             <b><c:out value = "${fltleg.delayCode3}"/></b></a>
					             
			       	    		<fmt:formatNumber var="delay_hour" type="number" minIntegerDigits="2" maxFractionDigits="0" value="${ ((fltleg.delayCode3_time - (fltleg.delayCode3_time % 60)) / 60)}"/>
								<fmt:formatNumber var="delay_minute" type="number" minIntegerDigits="2" maxFractionDigits="0" value="${fltleg.delayCode3_time % 60}" />
								/${delay_hour}${delay_minute}
					        
					      </c:if>
					      
						
					   <c:set var = "delaycode"  value = "${fn:length(fltleg.delayCode4)}"/>   
	                
					      <c:if test = "${delaycode >= 2}">,
					           <a href="#" onclick="return false;" data-toggle="popover" data-trigger="hover"  title="Detail" data-content="${fltleg.delayCode4_desc}" data-placement="top">
					             <b><c:out value = "${fltleg.delayCode4}"/></b></a>
					             
			       	    		<fmt:formatNumber var="delay_hour" type="number" minIntegerDigits="2" maxFractionDigits="0" value="${ ((fltleg.delayCode4_time - (fltleg.delayCode4_time % 60)) / 60)}"/>
								<fmt:formatNumber var="delay_minute" type="number" minIntegerDigits="2" maxFractionDigits="0" value="${fltleg.delayCode4_time % 60}" />
								/${delay_hour}${delay_minute}
						        
					      </c:if>
					  
	      				      					 
					 </td>
				  
				  
					  
										  
					  
				  </tr>
				     				
		    </c:forEach>		
		    				 
		
		
		
		
		
		
		

				     				
	
		    
		    	    
		    <tr>
		    
		      <td colspan="17" align="center">
	              <c:set var = "rowcount" scope = "session" value = "${fn:length(reportbody_cancle)}"/>
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




