<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="../../include/groundopsheader.jsp" />

<head>
    <title> Dashboard | Flight Report </title>    
</head>


<script src="https://canvasjs.com/assets/script/canvasjs.min.js"></script>

<script type="text/javascript">


//------------- FOR THE GRAPH DISPLAY ------------------ 
//https://canvasjs.com/javascript-charts/json-data-api-ajax-chart/
window.onload = function() { 

var chart = new CanvasJS.Chart("chartContainer",{
	
	animationEnabled: true,
	//theme: "light2",   // "light1", "dark1", "dark2" ,"light2"
	title: {
		text: ""
	},
	subtitles: [{
		text: ""
	}],
	data: [{
		//type: "pie",
		//type: "doughnut",
		type: "column",
		yValueFormatString: "#,##0",
		indexLabel: "{label}: {y}",
		toolTipContent: "{y} Flights",
		dataPoints : ${dataPoints}
	}]
  });

  chart.render();

}




function search_progress() {
    var e = document.getElementById("searchbutton");
    if(e.style.display == 'block')
       e.style.display = 'none';
    else
       e.style.display = 'block';

    var e1 = document.getElementById("searchbutton1");
    if(e1.style.display == 'block')
        e1.style.display = 'none';
     else
        e1.style.display = 'block';    
 }

function showFlightReport(){
	
	     document.getElementById("searchbutton").innerHTML = "<i class='fa fa-refresh fa-spin fa-lx' aria-hidden='true'></i>&nbsp;&nbsp;Searching..&nbsp;&nbsp;";
	     //<input type="button"  class="btn btn-primary" value="Show Report" onclick="showFlightReport();" />        
	     //search_progress();

		 document.FlightReport.method="POST";
		 document.FlightReport.action="flightreport";
	     document.FlightReport.submit();
	     return true;
}	

</script>



<body>

 
 <form name="FlightReport" id="FlightReport">   
  
  <input type="hidden" name="emailid" value="<%=request.getParameter("emailid")%>">
  <input type="hidden" name="password" value="<%=request.getParameter("password")%>">
  <input type="hidden" name="usertype" value="${usertype}">
    
    
 <div class="container" align="center">
 
 
 
 <div class="col-md-7 col-sm-7 col-xs-7" align="left" >
 
 
       
  <table class="table table-striped table-bordered" border="1" style="width:80%;background:rgba(255,255,255);" align="left">	
   			<tbody>				     
				 <tr align="center">
					 <td  bgcolor="#0070BA" colspan="2">
					   <span style="color:white;">  <i class="fa fa-database fa-lx" aria-hidden="true"></i> &nbsp;<b>
					    Flight Report Parameter &nbsp;&nbsp;
					   </b></span>					 
					 </td>
				 </tr>
		            
			    <tr>
					<td align="left" >
					 
							<div class="col-xs-12">
									<label for="airlineCode">Operating Airline:</label>
									<div class="input-group">
										<span class="input-group-addon"><i class="fa fa-plane"></i></span>
												<select id="airlinecode" name="airlinecode" class="form-control">
								                            	 ${airlinelist}
												</select>
									</div>
								</div>
							
						</td>
						
		
				     					
						<td>
								<div class="col-xs-12">
										<label for="airlineCode">Departure Airport:</label>
										<div class="input-group">
											<span class="input-group-addon"><i class="fa fa-plane"></i></span>							
												
												<select id="airportcode" name="airportcode" class="form-control">												
													     ${airportlist}
							                    </select>   
									
									</div>
								</div>
					
					       </td>
					 </tr>
					 
					 
				  <tr align="left"> 
				     					
					<td  >
				             
		               <div class="col-xs-12">
							<label for="startDate">Date:</label>
							<div class="input-group">
								<span class="input-group-addon"><i class="fa fa-calendar"></i></span>								
								<input type="date" id="datop" name="datop" class="form-control datepicker" maxlength="12"
								    value="${datop}" placeholder="(DD/MM/YYYY)"/>
							</div>	
						</div>
								
								
				       </td>
				       				
					<td>
							             
							<div class="col-xs-12">
										<label> Flight No </label>
										<div class="input-group">
											<span class="input-group-addon"><i class="fa fa-text-height fa-lg" aria-hidden="true"></i></i></span>	
													<input type="text"  name="flightno" id="flightno" class="form-control" value="">					
															
										</div>
							    </div>
				    
	    
							
				       </td>
				       
				       
				       
				     </tr>					 
				     
				  <tr align="left"> 
				     					
					<td >
				             
				             
				         <div class="col-xs-12">
							<label for="sortBy">Sort By:</label>
							<div class="input-group">
								<span class="input-group-addon"><i class="fa fa-sort-amount-asc" aria-hidden="true"></i></span>
								<select id="sortby" name="sortby" class="form-control">
									
									   <option value="ETD_DATE_TIME">Exp.Time Of Depart.</option>
									   <option value="LONG_REG">Aircraft Reg</option>
									
								</select>
							</div>
						</div>
								
								
								
				       </td>
	
				     					
						<td align="center">
						    <br>
					       
				          	    <span id="searchbutton" onClick="showFlightReport();"  class="btn btn-primary" ><i  class="fa fa-search" aria-hidden="true"></i>&nbsp;&nbsp;Show Report </span> 
		                   
			           
					        
					        <span style="display:none" id="searchbutton1">
					              <div class="progress-bar progress-bar-striped active" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width:100%">
							         <b>Searching..</b>&nbsp;&nbsp;<i class="fa fa-spinner fa-pulse fa-2x"></i>
							      </div>   
					        </span>
					  
					     </td>
					     </tr>
				     
							    
				    </tbody>
			</table>
	  </div>
	
</form>
 
		<div class="col-md-5 col-sm-5 col-xs-5" align="left" >
		      
		      <div id="chartContainer" style="height: 260px; width: 90%;"></div>
		      <br>
		       <p align="center">    <img  src="images/${airlinecode}1.png"> </p>
		      
		 
		</div>
		 

</div>	
<br>
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
    <table class="table table-striped table-bordered" border="1" style="width: 100%;background:rgba(255,255,255,0.5);" align="center">	  
   
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
	              <c:set var = "rowcount"  value = "${fn:length(reportbody)}"/>
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
		
		  <table class="table table-striped table-bordered" border="1" style="width: 100%;background:rgba(255,255,255);" align="center">	  
   
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
 

<script>
var input = document.getElementById("flightno");
input.addEventListener("keyup", function(event) {
  if (event.keyCode == 13) {
   event.preventDefault();
   showFlightReport();
  }
});
</script>
	
 
</body>

<br>
<br>

<%@include file="../../include/gopsfooter.jsp" %>




