<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>


<jsp:include page="../include/header.jsp" />

<head>
    <title> Dashboard | Reliability Report </title>    
</head>

<script src="https://canvasjs.com/assets/script/canvasjs.min.js"></script>
<script type="text/javascript">


function excelReport(){
	
	     //var url = 'flight_daily_summary_report';
	     // popupWindow = window.open(url,'popUpWindow','height=300,width=600,left=500,top=150,resizable=no,scrollbars=yes,toolbar=no,menubar=no,location=no,directories=no, status=yes');
	     //search_progress();
	     document.reliablityreport.method="POST";
		 document.reliablityreport.action="Create_Excel_Reliability_Report?emailid=${emailid}";
	     document.reliablityreport.submit();		 
		 return false;
		  
		
}//----------- End of Function 





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




/*------------- FOR THE GRAPH DISPLAY ------------------ 
window.onload = function() { 
 
var chart = new CanvasJS.Chart("chartContainer", {
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


window.onload = function() { 
	 
	var chart = new CanvasJS.Chart("chartContainer", {
		animationEnabled: true,
		title:{
			text: " "
		},
		legend: {
			verticalAlign: "center",
			horizontalAlign: "right"
		},
		data: [{
			type: "doughnut",
			showInLegend: true,
			indexLabel: "{y}",
			indexLabelPlacement: "inside",
			legendText: "{label}: {y}",
			toolTipContent: "<b>{label}</b>: {y}",
			dataPoints : ${dataPoints}
		}]
	});
	chart.render();
	 
	}





  window.onload = function() { 
	  
	  var chart = new CanvasJS.Chart("chartContainer", {
	  	theme: "light2",
	  	animationEnabled: true,
	  	exportFileName: "Flight Report",
	  	exportEnabled: true,
	  	title:{
	  		text: "-"
	  	},
	  	data: [{
	  		type: "pie",
	  		showInLegend: true,
	  		legendText: "{label}",
	  		toolTipContent: "{label}: <strong>{y}</strong>",
	  		indexLabel: "{label} {y}",
	  		dataPoints :  ${dataPoints}
	  	}]
	  });
	   
	  chart.render();
	   
	  }  

  */








</script>





<style>

tr:nth-child(even) {
  background-color: #dddddd;
}
</style>





<body>

 <br>
 <br>
 <br><br>
 <br>
 <br>
 
 <% 
 
 int ctr=0;
 %> 
   
 <div class="container" align="center">
 
 
 <div class="col-md-12 col-sm-12 col-xs-12" align="left" >
 
 <form name="reliablityreport" id="reliablityreport" method="POST">   
 
    <table class="table table-striped table-bordered" border="1" style="width: 45%;" align="left">
    			
				<tbody>	
		
		 	     <tr align="center">
					 <td colspan="2" bgcolor="#0070BA">
					   <span style="color:white;">  <i class="fa fa-database fa-lx" aria-hidden="true"></i> &nbsp;<b>
					    Reliability Report Selected Parameter &nbsp;&nbsp; 	 
					   
					   </b></span>					 
					 </td>
				</tr>
	 
					<tr>
					<td width="50%" bgcolor="white" align="left">
					      <input type="hidden" name="airlineCode" id="airlineCode" value="${airlinecode}">
					      
					      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					      <img  src="<c:url value="images/${airlinecode}1.png"/>"  >	
						
						
					</td>
		
					<td width="50%" bgcolor="white">
						  <div class="form-group">
							<label for="airlineCode">Departure Airport</label>
							<div class="input-group">
								<span class="input-group-addon"><i class="fa fa-plane"></i></span>							
									
									<select id="airportcode" disabled name="airportcode" class="form-control">
									<option value="ALL" 	>All Airport</option>	
										     ${airportlist}
									</select>   
								
							</div>
						
						
						
								
			             </td>
			          </tr>
			         
			         
			         
			         <tr>
				          <td bgcolor="white">
				                   
	                      <div class="form-group">
							<label for="startDate">Start Date</label>
							<div class="input-group">
								<span class="input-group-addon"><i class="fa fa-calendar"></i></span>								
								<input id="startDate" name="startDate" class="form-control " readonly maxlength="12" value="${startDate}"  placeholder="${startDate}"/>
							</div>	
						</div>
						
				                   
				          
				          </td>
				     
				          <td bgcolor="white">
				           
				                <div class="form-group">
							<label for="endDate">End Date</label>
							<div class="input-group">
								<span class="input-group-addon"><i class="fa fa-calendar"></i></span>
								
								<input  id="endDate" name="endDate" class="form-control " maxlength="12" readonly value="${endDate}" placeholder="${endDate}"/>
							</div>
						</div>
				          
				          </td>			         
				     
				     </tr> 
			          
			          
			          
			          
			          
			        <tr>
				          <td bgcolor="white">
				     	 <label for="tolerance">Tolerance</label>
							<div class="input-group">
								<span class="input-group-addon"><i class="fa fa-clock-o"></i></span>
								<input type="text" id="tolerance" readonly name="tolerance" class="form-control" maxlength="9" value="${tolerance} Minutes" />
							</div>
		
				          
				          </td>
				     
				       <td bgcolor="white">
				     	<label for="delayGroupCode">Delay Code Group</label>
							<div class="input-group">
								<span class="input-group-addon"><i class="fa fa-hand-stop-o"></i></span>
								<input type="text" id="delayCodeGroupCode" name="delayCodeGroupCode" readonly class="form-control" maxlength="9" value="${delayCodeGroupCode}" /> 
								
						</div>
				          
				          </td>			         
				     
				     </tr>  
			        
			        <tr>
				          <td>
				     
				          
				          </td>
				     
				          <td>
				     
				          
				          </td>			         
				     
				     </tr>   
			          

				    <tr align="center"> 
				     					
					<td  bgcolor="white" colspan="2">
				         
				     
				        
				       
		      		        <span style="display:block" id="searchbutton">					            
					            <button type="button" onClick="excelReport();" class="btn btn-primary btn-sm"><b>Download Excel Report</b>&nbsp;&nbsp;<i class="fa fa-cloud-download fa-lg" aria-hidden="true"></i>	</button>				       
					            &nbsp;<img  src="<c:url value="images/excel.png"/>" width="5%" >	
					        </span>
					        
					        
					        
					        <span style="display:none" id="searchbutton1">
					              <div class="progress-bar progress-bar-striped active" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width:100%">
							         <b>Generating Report..</b>&nbsp;&nbsp;<i class="fa fa-spinner fa-pulse fa-2x"></i>
							         &nbsp;<img  src="<c:url value="images/excel.png"/>" width="5%" >
							      </div>   
					        </span>
					  
		    
				       
				       
				       
				       
				       
				       
				       
				     </td>
				     </tr>
				     
							    
				    </tbody>
			</table>
		   
	
	
		 	   
		    <table  class="table table-striped table-bordered"  border="0" style="width: 40%;" align="center">	
		   
		   
		           <div id="chartContainer" style="height: 370px; width: 50%;"></div>
		   
		    
		    </table>
		
		
			
 </form>
</div>	
</div>	
<br>
<br>

	   
 <div class="container" align="center">
 
 <div class="col-md-12 col-sm-12 col-xs-12" align="left" >
 
   		<ul class="nav nav-pills">
						<li class="active"><a data-toggle="pill" href="#menu1"><b>${reportbody.stream().distinct().count()}</b> - Flights</a></li>
						<li><a data-toggle="pill" href="#menu2"><b>${reportbody_C.stream().distinct().count()}</b> - Cancelled </a></li>                    		    	
	                   <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		               <i class="fa fa-clock-o" aria-hidden="true"></i> <span style="color:black;font-weight:bold;"> ZULU Time. </span>
	                    
	                        
	    </ul>
					

<div class="tab-content">
   
   <div id="menu1" class="tab-pane fade in active">					

  	<table class="table table-striped table-bordered" border="1" style="width: 100%;" align="left">	
		
	     <tr align="center">
				    
				     <td bgcolor="#0070BA" width="8%">
					   <span style="color:white;" > <b> 
					    Flt. Date	
					     </b></span>					 
					 </td>
					  
					 <td bgcolor="#0070BA">
					   <span style="color:white;"> <b> 
					    Flt. No	
					     </b></span>					 
					 </td>
					 <td bgcolor="#0070BA">
					   <span style="color:white;"> <b> 
					    Type	
					     </b></span>					 
					 </td>
					 <td bgcolor="#0070BA">
					   <span style="color:white;"> <b> 
					      Aircraft Reg	
					     </b></span>					 
					 </td>

					 <td bgcolor="#0070BA">
					   <span style="color:white;"> <b> 
					      STD	
					     </b></span>					 
					 </td>
					 <td bgcolor="#0070BA">
					   <span style="color:white;"> <b> 
					     STA	
					     </b></span>					 
					 </td>
					 <td bgcolor="#0070BA">
					   <span style="color:white;"> <b> 
					     ATD	
					     </b></span>					 
					 </td>
					 <td bgcolor="#0070BA">
					   <span style="color:white;"> <b> 
					      ATA	
					     </b></span>					 
					 </td>
					 
					 <td bgcolor="#0070BA">
					   <span style="color:white;"> <b> 
					     ATA - ATD
					     </b></span>					 
					 </td>
					 
					 <td bgcolor="#0070BA">
					   <span style="color:white;"> <b> 
					      DEP	
					     </b></span>					 
					 </td>
					 <td bgcolor="#0070BA">
					   <span style="color:white;"> <b> 
					      ARR	
					     </b></span>					 
					 </td>
					 <td bgcolor="#0070BA">
					   <span style="color:white;"> <b> 
					       TOB
					     </b></span>					 
					 </td>
					 
					 <td bgcolor="#0070BA">
					   <span style="color:white;"> <b> 
					     Delay Group	
					     </b></span>					 
					 </td>
					 
					 <td bgcolor="#0070BA">
					   <span style="color:white;"> <b> 
					     Delay Code/Time 
					     </b></span>					 
					 </td>
					 <td bgcolor="#0070BA">
					   <span style="color:white;"> <b> 
					     Total Delay	
					     </b></span>					 
					 </td>

					 <td bgcolor="#0070BA">
					   <span style="color:white;"> <b> 
					     Delay Remark 
					     </b></span>					 
					 </td>
				 </tr>
				 
				 
		

		 
				 
		<!-- Write DB Loops to display Data -->
		 <c:forEach var="fltleg" items="${reportbody}"> 
		 
		 			 
			     <tr align="center">
		            
	
		              <td width="7%">
					    
					      ${fltleg.getFlightDatop()} 
					      					 
					 </td>
		  
				 
					 <td>
					  	<a href="#" onclick="return false;" data-toggle="popover" data-trigger="hover" 
					    title="  CAPTION       |   ${fltleg.flightCaption} " 
					    data-content="FIR. OFFI | ${fltleg.flightFirstOfficer}">  
					     ${fltleg.flightNo}
					    </a>
					      					 
					 </td>
				
					 <td>
					    
					      ${fltleg.aircraftType} 
					      					 
					 </td>
					 
					 <td>
					    
					         ${fltleg.aircraftReg} 
									    
					        <c:set var = "ftlreg" scope = "session" value = "${fltleg.aircraftReg}"/>
						      <c:if test = "${ftlreg == null}">
						           <b> <span style="color:red;"> <c:out value = "CANC-"/>${fltleg.aircraftType}</span></b>
						      </c:if>
					      					 
					 </td>

					 <td>
					    
					    ${fltleg.std}
					      					 
					 </td>
					 
					 <td>
					    
					    
					    ${fltleg.sta} 
					    
					 
					      					 
					 </td>
					 
					 <td>
					        
					        <a href="#" onclick="return false;" data-toggle="popover" data-trigger="hover" 
					             title="ATD | Airborne Time" data-content="${fltleg.atd} | ${fltleg.airborn}">  
					             ${fltleg.atd}
					        </a>
					     
					      					 
					 </td>
					 
					 <td>
					    
					     <a href="#" onclick="return false;" data-toggle="popover" data-trigger="hover"  title="Landing Time | ATA" data-content="${fltleg.touchdown} | ${fltleg.ata}">${fltleg.ata}</a>
					      					 
					 </td>
					 
					 		 
					 <td>
	                       
	                         ${fltleg.getAtaMinusAtd()}
		                
					 
					 </td>
					 
			
					 
					 <td>
					    
					        ${fltleg.from}
					      					 
					 </td>
					 
					 <td>
					    
					       ${fltleg.to}
					      					 
					 </td>
					 
					 <td>
					        ${fltleg.totalOnBoard}
					      					 
					 </td>
					 
					 <td align="left">
					 
                         <a href="#" onclick="return false;" data-toggle="popover" data-trigger="hover"  title="Detail - Group" data-content="${fltleg.IATA_DelCodeGroup()}">
			              
			               <c:set var="string1" value="${fltleg.IATA_DelCodeGroup()}"/>
                            <c:set var="string2" value="${fn:substring(string1, 0,16)}" />
			                   ${string2}
			             </a>
			     
					      					 
					 </td>
					 
					 
					 
					 
	 
					 <td align="left">
					     
					   <c:set var = "delaycode"  value = "${fn:length(fltleg.delayCode1)}"/>   
	                
					      <c:if test = "${delaycode >= 2}">
					           <a href="#" onclick="return false;" data-toggle="popover" data-trigger="hover"  title="Delay Code Description" data-content="${fltleg.delayCode1_desc}" data-placement="top">
					             <b> <c:out value = "${fltleg.delayCode1}"/></b></a>					             		
					             <fmt:formatNumber var="delay_hour" type="number" minIntegerDigits="2" maxFractionDigits="0" value="${ ((fltleg.delayCode1_time - (fltleg.delayCode1_time % 60)) / 60)}"/>
								 <fmt:formatNumber var="delay_minute" type="number" minIntegerDigits="2" maxFractionDigits="0" value="${fltleg.delayCode1_time % 60}" />
								  /${delay_hour}:${delay_minute}
											        
					      </c:if>
						
					     
					   <c:set var = "delaycode"  value = "${fn:length(fltleg.delayCode2)}"/>   
	                
					      <c:if test = "${delaycode >= 2}">
					           <a href="#" onclick="return false;" data-toggle="popover" data-trigger="hover"  title="Delay Code Description" data-content="${fltleg.delayCode2_desc}" data-placement="top">
					             ,<b> <c:out value = "${fltleg.delayCode2}"/></b></a>					             
					             <fmt:formatNumber var="delay_hour" type="number" minIntegerDigits="2" maxFractionDigits="0" value="${ ((fltleg.delayCode2_time - (fltleg.delayCode2_time % 60)) / 60)}"/>
								 <fmt:formatNumber var="delay_minute" type="number" minIntegerDigits="2" maxFractionDigits="0" value="${fltleg.delayCode2_time % 60}" />
								  /${delay_hour}:${delay_minute}					             
					        
					      </c:if>
						
					      
					      
					   <c:set var = "delaycode"  value = "${fn:length(fltleg.delayCode3)}"/>   
	                
					      <c:if test = "${delaycode >= 2}">
					           <a href="#" onclick="return false;" data-toggle="popover" data-trigger="hover"  title="Delay Code Description" data-content="${fltleg.delayCode3_desc}" data-placement="top">
					             ,<b> <c:out value = "${fltleg.delayCode3}"/></b></a>
					             <fmt:formatNumber var="delay_hour" type="number" minIntegerDigits="2" maxFractionDigits="0" value="${ ((fltleg.delayCode3_time - (fltleg.delayCode3_time % 60)) / 60)}"/>
								 <fmt:formatNumber var="delay_minute" type="number" minIntegerDigits="2" maxFractionDigits="0" value="${fltleg.delayCode3_time % 60}" />
								  /${delay_hour}:${delay_minute}					             
					        
					      </c:if>
					      
						
					   <c:set var = "delaycode"  value = "${fn:length(fltleg.delayCode4)}"/>   
	                
					      <c:if test = "${delaycode >= 2}">
					           <a href="#" onclick="return false;" data-toggle="popover" data-trigger="hover"  title="Delay Code Description" data-content="${fltleg.delayCode4_desc}" data-placement="top">
					             ,<b> <c:out value = "${fltleg.delayCode4}"/></b></a>
					             <fmt:formatNumber var="delay_hour" type="number" minIntegerDigits="2" maxFractionDigits="0" value="${ ((fltleg.delayCode4_time - (fltleg.delayCode4_time % 60)) / 60)}"/>
								 <fmt:formatNumber var="delay_minute" type="number" minIntegerDigits="2" maxFractionDigits="0" value="${fltleg.delayCode4_time % 60}" />
								  /${delay_hour}:${delay_minute}					             
					        
					      </c:if>
	      				      					 
					 </td>
				  
					 
					 <td>
					      ${fltleg.getTotalDelayTime()}
					      					 
					 </td>
					 
					 
					 
					 
					 
					 
					 <td>		
						         
						   
						         
						       <c:if test="${fn:length(fltleg.getFlightNoteRemarks()) > 0}">
						           	
								  <a href="#" onclick="return false;">  <i class="fa fa-newspaper-o" rel="popover" data-popover-content="#popover<%=ctr%>" title="Remark " data-trigger="hover" data-placement="auto"></i> </a>
								  			<div id="popover<%=ctr%>" class="hide">
													<ul>													
													    <c:forEach var="fltnote" items="${fltleg.getFlightNoteRemarks()}"> 
												                <li>${fltnote}</li>
												         </c:forEach>
												      
													</ul>
								            </div>			
						                     <%
						                     ctr=ctr+1;
						                     %>
								  </c:if>	
									      
					      
					 </td>
				 

				 
				 
				  
				  
				  
				  </tr>
				     				
		    </c:forEach>		
		    
		    	    
		    <tr>
		    
		      <td colspan="16" align="center">
	              <c:set var = "rowcount"  value = "${fn:length(reportbody)}"/>
	              <c:if test = "${rowcount == 0}">
		              <b> Sorry There is no flight found based on your search criteria..!!!</b>
		          </c:if>		          
               </td> 
               
               
               
		    </tr>
		    		
				    
    </table>	
  
   </div>
   
   
   
   
   
   <!-- SECOND TAB FOR THE CANCLE FLIGHTS  -->
   	<div id="menu2" class="tab-pane fade"> 
   	
 	<table class="table table-striped table-bordered" border="1" style="width: 100%;" align="left">	
		
	     <tr align="center">
				     
				    <td bgcolor="#0070BA">
					   <span style="color:white;"> <b> 
					    Flight Date	
					     </b></span>					 
					 </td>
					 <td bgcolor="#0070BA">
					   <span style="color:white;"> <b> 
					    Flight No	
					     </b></span>					 
					 </td>
					 <td bgcolor="#0070BA">
					   <span style="color:white;"> <b> 
					    Type	
					     </b></span>					 
					 </td>
					 <td bgcolor="#0070BA">
					   <span style="color:white;"> <b> 
					      Aircraft Reg	
					     </b></span>					 
					 </td>

					 <td bgcolor="#0070BA">
					   <span style="color:white;"> <b> 
					      STD	
					     </b></span>					 
					 </td>
					 <td bgcolor="#0070BA">
					   <span style="color:white;"> <b> 
					     STA	
					     </b></span>					 
					 </td>
					 
					 <td bgcolor="#0070BA">
					   <span style="color:white;"> <b> 
					      ACT DEP	
					     </b></span>					 
					 </td>
					 <td bgcolor="#0070BA">
					   <span style="color:white;"> <b> 
					      ACT ARR	
					     </b></span>					 
					 </td>
					 <td bgcolor="#0070BA">
					   <span style="color:white;"> <b> 
					       Planned Pax
					     </b></span>					 
					 </td>
					 
					 <td bgcolor="#0070BA">
					   <span style="color:white;"> <b> 
					     Delay Group	
					     </b></span>					 
					 </td>
					 
					 <td bgcolor="#0070BA">
					   <span style="color:white;"> <b> 
					     Delay Code 
					     </b></span>					 
					 </td>
					 <td bgcolor="#0070BA">
					   <span style="color:white;"> <b> 
					     Total Delay	
					     </b></span>					 
					 </td>

					 <td bgcolor="#0070BA">
					   <span style="color:white;"> <b> 
					     Comments
					     </b></span>					 
					 </td>
				 </tr>
				 
				 
		

		 
				 
		<!-- Write DB Loops to display Data -->
		 <c:forEach var="fltleg" items="${reportbody_C}"> 
		 
		 			 
			     <tr align="center">
		              
		              <td>
					    
					      ${fltleg.getFlightDatop()} 
					      					 
					 </td>
		    
				 
					 <td>
					
					  	<a href="#" onclick="return false;" data-toggle="popover" data-trigger="hover" 
					    title="  CAPTION       |   ${fltleg.flightCaption} " 
					    data-content="FIR. OFFI | ${fltleg.flightFirstOfficer}">  
					      <span style="color:red;"> <b>${fltleg.flightNo} </b></span>			
					    </a>
					      		 
					 </td>
				
					 <td>
					    
					      ${fltleg.aircraftType} 
					      					 
					 </td>
					 
					 <td>
					    
					    <b> <span style="color:red;"> <c:out value = "CANX-"/>${fltleg.aircraftType}</span></b>
					       
						
					      					 
					 </td>

					 <td>
					    
					    ${fltleg.std}
					      					 
					 </td>
					 
					 <td>
					    
					    
					    ${fltleg.sta} 
					    
					 
					      					 
					 </td>
					 
    		
					 
					 <td>
					    
					        ${fltleg.from}
					      					 
					 </td>
					 
					 <td>
					    
					       ${fltleg.to}
					      					 
					 </td>
					 
					 <td>
					        ${fltleg.bookedPax}
					      					 
					 </td>
					 
					 <td align="left">
					 
                         <a href="#" onclick="return false;" data-toggle="popover" data-trigger="hover"  title="Remark" data-content="${fltleg.IATA_DelCodeGroup()}">
			              
			               <c:set var="string1" value="${fltleg.IATA_DelCodeGroup()}"/>
                            <c:set var="string2" value="${fn:substring(string1, 0, 25)}" />
			                   ${string2}
			             </a>
			     
					      					 
					 </td>
					 
					 <td align="left">
					    
					  <c:set var = "delaycode"  value = "${fn:length(fltleg.delayCode1)}"/>   	
					      <c:if test = "${delaycode >= 2}">
					           <a href="#" onclick="return false;" data-toggle="popover" data-trigger="hover"  title="Delay Code Description" data-content="${fltleg.delayCode1_desc}">
					             <b> <c:out value = "${fltleg.delayCode1}"/></b>/
					          </a>${fltleg.delayCode1_time}
					      </c:if>
					      
					    
					  <c:set var = "delaycode"  value = "${fn:length(fltleg.delayCode2)}"/>   	
					      <c:if test = "${delaycode >= 2}">
					           <a href="#" onclick="return false;" data-toggle="popover" data-trigger="hover"  title="Delay Code Description" data-content="${fltleg.delayCode2_desc}">
					             <b> <c:out value = "${fltleg.delayCode2}"/></b>/
					          </a>${fltleg.delayCode2_time}
					      </c:if>
					      
						    
					  <c:set var = "delaycode"  value = "${fn:length(fltleg.delayCode3)}"/>   	
					      <c:if test = "${delaycode >= 2}">
					           <a href="#" onclick="return false;" data-toggle="popover" data-trigger="hover"  title="Delay Code Description" data-content="${fltleg.delayCode3_desc}">
					             <b> <c:out value = "${fltleg.delayCode3}"/></b>/
					          </a>${fltleg.delayCode3_time}
					      </c:if>
					    
					  <c:set var = "delaycode"  value = "${fn:length(fltleg.delayCode4)}"/>   	
					      <c:if test = "${delaycode >= 2}">
					           <a href="#" onclick="return false;" data-toggle="popover" data-trigger="hover"  title="Delay Code Description" data-content="${fltleg.delayCode4_desc}">
					             <b> <c:out value = "${fltleg.delayCode4}"/></b>/
					          </a>${fltleg.delayCode4_time}
					      </c:if>
					      
					      
			
					      					 
					 </td>
					 
					 <td>
					    
					    
					    
					      ${fltleg.getTotalDelayTime()}
					      					 
					 </td>
					 
					 
					 
					 
					 
					 
					 
					 <td>
			            
			           <c:if test="${fn:length(fltleg.getFlightnote()) > 0}">   
			   
	   	                  <a href="#" onclick="return false;"  data-placement="left" data-toggle="popover" data-trigger="hover" title="Sector Comment" data-content="${fltleg.getFlightnote()}" ><i class="fa fa-newspaper-o" data-placement="left" ></i>
	   	                  
	   	               </c:if>    
	   	           	     
	   	                   
	   	                 </a>
		               
		                  
		             </td>
				  
				  </tr>
				     				
		    </c:forEach>		
		    
		    	    
		    <tr>
		    
		      <td colspan="16" align="center">
	              <c:set var = "rowcount"  value = "${fn:length(reportbody)}"/>
	              <c:if test = "${rowcount == 0}">
		              <b> Sorry There is no flight found based on your search criteria..!!!</b>
		          </c:if>		          
               </td> 
               
               
               
		    </tr>
		    		
				    
    </table>   		
						
						
						
						
						
			
			
	</div>
	
	
	
	
	
	
		
   
  
 </div> 
    	                     
 
 </div>
			

	</div>
 
</body>
<br>
<br>
<br>
<br>
<br>
<br><br>
<br>
<br>


<%@include file="../include/footer.jsp" %>