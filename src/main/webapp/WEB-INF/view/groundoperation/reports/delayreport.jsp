<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="../../include/groundopsheader.jsp" />

<head>
    <title> Dashboard |Delay Flight Report </title>    
    <link rel="stylesheet" href="css/prism.css">
    <link rel="stylesheet" href="css/chosen.css">
</head>


<script src="https://canvasjs.com/assets/script/canvasjs.min.js"></script>

<script type="text/javascript">




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
		 document.DelayFlighReport.method="POST";
		 document.DelayFlighReport.action="delayflightreport";
	     document.DelayFlighReport.submit();
	     return true;
}	

</script>



<body>

 
 <form name="DelayFlighReport" id="DelayFlighReport">   
  
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
					    Delay Flights Report &nbsp;&nbsp;
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
											<select  data-placeholder="Type Station Code or Name.." class="chosen-select form-control" multiple id="airportcode" name="airportcode">
									            <option value=""></option>
									                   ${airportlist}	
										</select>						
															
									
									</div>
								</div>
					
					       </td>
					 </tr>
					 
					 
				  <tr align="left"> 
				     					
					<td>
				             
		               <div class="col-xs-12">
							<label for="startDate">Flight Date:</label>
							<div class="input-group">
								<span class="input-group-addon"><i class="fa fa-calendar"></i></span>								
								<input type="date" id="startDate" name="startdate" class="form-control datepicker" maxlength="12"
								    value="${startdate}" placeholder="(DD/MM/YYYY)"/>
							</div>	
						</div>
								
								
				       </td>
	       				
					<td>
							             
							<div class="col-xs-12">
										<label> Flight No </label>
										<div class="input-group">
											<span class="input-group-addon"><i class="fa fa-plane" aria-hidden="true"></i></span>	
													<input type="text"  name="flightno" id="flightno" class="form-control" value="">					
															
										</div>
							    </div>
				    
	    
							
				       </td>
				       
				       
				       
				     </tr>					 
				     
	 
	 <tr >
				     					
			<td align="center" colspan="2">
						   
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

  	<table class="table table-striped table-bordered" border="1" style="width: 100%;background:rgba(255,255,255);" align="left">	
		      
  
 
	     <tr align="center">
				    
				     <td bgcolor="#0070BA" width="7%">
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
					    IATA Delay Code Group	
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
					     Remark 
					     </b></span>					 
					 </td>
					 
					 <td bgcolor="#0070BA">
					   <span style="color:white;"> <b> 
					     Action   
					     </b></span>					 
					 </td>
					 
					 <td bgcolor="#0070BA">
					   <span style="color:white;"> <b> 
					     Status 
					     </b></span>					 
					 </td>
	
					 <td bgcolor="#0070BA">
					   <span style="color:white;"> <b> 
					     Comment  
					     </b></span>					 
					 </td>
					 <td bgcolor="#0070BA">
					   <span style="color:white;"> <b> 
					     Days Open 
					     </b></span>					 
					 </td>
	
					 <td bgcolor="#0070BA">
					   <span style="color:white;"> <b> 
					     Date Close 
					     </b></span>					 
					 </td>
					 
					 
					 <td bgcolor="#0070BA">
					   <span style="color:white;"> <b> 
					     &nbsp;
					     </b></span>					 
					 </td>
					 
					 
	
					 
				 </tr>
				 
				 
		 <% 
		  int ctr=0;
		%>  

		 
				 
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
					    
					        ${fltleg.aircraftReg} 
					      					 
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
					 
					 <td align="left" width="12%">	
				 
                         <a href="#" onclick="return false;" data-toggle="popover" data-trigger="hover"  title="Detail - Group" data-content="${fltleg.IATA_DelCodeGroup()}">
			               <c:set var="string1" value="${fltleg.IATA_DelCodeGroup()}"/>
                            <c:set var="string2" value="${fn:substring(string1, 0,18)}" />
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
													    <c:forEach var="fltnotea" items="${fltleg.getFlightNoteRemarks()}"> 
												                <li>${fltnotea}</li>
												         </c:forEach>
												      
													</ul>
								            </div>			
						                     <%
						                     ctr=ctr+1;
						                     %>
								  </c:if>	
									      
					
					     
					      					 
					 </td>
					 
					 <td>
					        ?????
					      					 
					 </td>
					 
					 <td align="left">
					 
					    ???
					      					 
					 </td>
					 
					 
					 
					 
	 
					 <td align="left">
				       ???
				    </td>
				  
					 
					 <td>
					     
					     ??
					      					 
					 </td>
					 
					 
					 <td width="7%">		
						      
		                    Close Date
					 </td>
				 
			     <td>
					          
					          <input  type="button" onClick="open_model_toAdd_Comment('${fltleg.flightNo}','${fltleg.getFlightDatop()}','${fltleg.from}','${fltleg.to}','<%=request.getParameter("emailid")%>');" value="Open ">
					         
                                    

				          
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
   	
 	<table class="table table-striped table-bordered" border="1" style="width: 100%;background:rgba(255,255,255);" align="left">	
		
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
  <script src="js/chosen.jquery.js" type="text/javascript"></script>
  <script src="js/prism.js" type="text/javascript" charset="utf-8"></script>
  <script src="js/init.js" type="text/javascript" charset="utf-8"></script> 



<br>
<br>

<%@include file="../../include/gopsfooter.jsp" %>


<script>


//-------- This will Open Model Where Feedback will be Entered ----------------
function open_model_toAdd_Comment(flightid,datop,fromstn,tostn,emailid){

          //- Display of the  Model  
	      document.getElementById("flightid").innerHTML = flightid+"   ("+fromstn+" - "+tostn+")";
	      document.getElementById("datopdisplay").innerHTML = " Date: "+datop;

          //-- Add value to the hidden form         
	       document.getElementById("flightno").value = flightid;
	       document.getElementById("datop").value    = datop;
	       document.getElementById("fromstn").value  = fromstn;
	       document.getElementById("tostn").value    = tostn;
	       document.getElementById("addedby").value  = emailid;



	   	   var tableheader ="<table id='displaydata' class='table table-striped table-bordered' border='1' style='width:100%;background:rgba(255,255,255);' align='left'><tr><td bgcolor='#0070BA' width='12%'> <span style='font-size: 12px;color:white;'> <b>Date</b></span></td> <td bgcolor='#0070BA'  ><span style='font-size: 12px;color:white;'> <b>Feedback </b></span></td> <td bgcolor='#0070BA' width='15%'><span style='font-size: 12px;color:white;'> <b> Added By</b></span></td></tr>";
	       //var tablebody   ="<tr bgcolor='#FDEBD0'> <td  style='font-size: 12px;'>"+datop+"</td><td style='font-size: 12px;'>"+feedback+"</td><td style='font-size: 12px;'>"+addedby+"</td></tr>";
	       var footervar   ="</table>"; 
	               



	       
         //--- Fetch Datafrom DB 
         
         var callingurl="ajaxrest/getflightcomment?flightno="+flightid+"&datop="+datop;
         
         $.ajax({
				type : 'GET',
				url : callingurl,
				dataType : 'json',
				contentType : 'application/json',				
				success : function(result) {
					var s = tableheader;
					for (var i = 0; i < result.length; i++) {
						s += "<tr bgcolor='#FDEBD0'> <td  style='font-size: 12px;'>"+result[i].flightDate+"</td><td style='font-size: 12px;'>"+result[i].comments+"</td><td style='font-size: 12px;'>"+result[i].enteredBy+"</td></tr>"; 
						
						/*
						s += '<br/>Id: ' + result[i].flightNumber;
						s += '<br/>Name: ' + result[i].flightNumber;
						s += '<br/>Price: ' + result[i].flightNumber;
						s += '<br/>___________________________';
						*/
					}	
					s += "</table>";			 
					$('#displaydata').html(s);
				}
			});  



           //-- Click and Open Model
	       document.getElementById("flightmodelbutton").click();
  }





//-------- This will Open Model Where Feedback will be Entered ----------------
function open_model_toAdd_Comment_After_Add(flightid,datop,fromstn,tostn,emailid){

          //- Display of the  Model  
	      document.getElementById("flightid").innerHTML = flightid+"   ("+fromstn+" - "+tostn+")";
	      document.getElementById("datopdisplay").innerHTML = " Date: "+datop;

          //-- Add value to the hidden form         
	       document.getElementById("flightno").value = flightid;
	       document.getElementById("datop").value    = datop;
	       document.getElementById("fromstn").value  = fromstn;
	       document.getElementById("tostn").value    = tostn;
	       document.getElementById("addedby").value  = emailid;



	   	   var tableheader ="<table id='displaydata' class='table table-striped table-bordered' border='1' style='width:100%;background:rgba(255,255,255);' align='left'><tr><td bgcolor='#0070BA' width='12%'> <span style='font-size: 12px;color:white;'> <b>Date</b></span></td> <td bgcolor='#0070BA'  ><span style='font-size: 12px;color:white;'> <b>Feedback </b></span></td> <td bgcolor='#0070BA' width='15%'><span style='font-size: 12px;color:white;'> <b> Added By</b></span></td></tr>";
	       //var tablebody   ="<tr bgcolor='#FDEBD0'> <td  style='font-size: 12px;'>"+datop+"</td><td style='font-size: 12px;'>"+feedback+"</td><td style='font-size: 12px;'>"+addedby+"</td></tr>";
	       var footervar   ="</table>"; 
	               


	       var callingurl="ajaxrest/getflightcomment?flightno="+flightid+"&datop="+datop;
	       
         //--- Fetch Datafrom DB
         $.ajax({
				type : 'GET',
				url : callingurl,
				dataType : 'json',
				contentType : 'application/json',				
				success : function(result) {
					var s = tableheader;
					for (var i = 0; i < result.length; i++) {
						s += "<tr bgcolor='#FDEBD0'> <td  style='font-size: 12px;'>"+result[i].flightDate+"</td><td style='font-size: 12px;'>"+result[i].comments+"</td><td style='font-size: 12px;'>"+result[i].enteredBy+"</td></tr>"; 
					}	
					s += "</table>";			 
					$('#displaydata').html(s);
				}
			});  




  }




//*** Here this function will update data in to database and write back to the DIV 
function ajaxUpdate(){


	 
	var feedback  = document.getElementById("feedback").value;
	var flightno  = document.getElementById("flightno").value;
	var datop     = document.getElementById("datop").value;
	var fromstn   = document.getElementById("fromstn").value;
	var tostn     = document.getElementById("tostn").value;
	var addedby   = document.getElementById("addedby").value;
	var status    = document.getElementById("status").value;
	var astatus   = document.getElementById("astatus").value;

    if (feedback == null || feedback == "" || feedback == " ")
    {
  		alert("Please fill this form");  		
  		document.getElementById("feedback").focus();
  		return false;
    }
    
    if(astatus == "ALL")
    {
  		alert("Please Select Status..");  		
  		document.getElementById("astatus").focus();
  		return false;
    }


  
    

    if(confirm("Are you sure about this feedback??")){	
  		
   
	
	var tableheader ="<table id='displaydata' class='table table-striped table-bordered' border='1' style='width:100%;background:rgba(255,255,255);' align='left'><tr><td bgcolor='#0070BA' width='12%'> <span style='font-size: 12px;color:white;'> <b>Date</b></span></td> <td bgcolor='#0070BA'  ><span style='font-size: 12px;color:white;'> <b>Feedback </b></span></td> <td bgcolor='#0070BA' width='15%'><span style='font-size: 12px;color:white;'> <b> Added By</b></span></td></tr>";
    var tablebody   ="<tr bgcolor='#FDEBD0'> <td  style='font-size: 12px;'>"+datop+"</td><td style='font-size: 12px;'>"+feedback+"</td><td style='font-size: 12px;'>"+addedby+"</td></tr>";
    var footervar   ="</table>"; 

   

       
  
    $.ajax({
			  url:'delayaction',
			  type:"POST",
			  data:{
				  feedback:feedback,
				  flightno:flightno,
				  datop   :datop,
				  fromstn :fromstn,
				  tostn   :tostn,
				  addedby :addedby,
				  status  :status,
				  astatus :astatus,
				  
			   },
			  success: function(data)
			  {

                   // This will display the comment in the same Model 
				   open_model_toAdd_Comment_After_Add(flightno,datop,fromstn,tostn,addedby);
	
				}// ------ END OF SUCCESS ----  
	
         }); //----- END OF AJAX FUNCTION ------- 


    } //--- End of are you sure if function 



    

  }//-------- END OF FUNCTION ---------------

</script>

















<form id="modelform">


<input type="hidden" id="flightno" value="">
<input type="hidden" id="datop"    value="">
<input type="hidden" id="fromstn"  value="">
<input type="hidden" id="tostn"    value="">
<input type="hidden" id="addedby"  value="">




<button style="display:none;" id="flightmodelbutton" type="button" class="btn btn-primary" data-toggle="modal" data-target=".bd-example-modal-lg">Large modal</button>

<div class="modal fade bd-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      
       
      <div class="modal-header" >
        <h2 class="modal-title" style="color:#0070BA;" id="flightid"></h2> 
         <h4 style="color:black;" class="modal-title" id="datopdisplay"></h4>
        
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      
      <div class="modal-body">
      
          <table id="displaydata" class="table table-striped table-bordered" border="1" style="width:100%;background:rgba(255,255,255);" align="left">	
	         <tr>
		           <td bgcolor="#0070BA" width="12%"> <span style="font-size: 12px;color:white;"> <b>Date</b></span></td>
		           <td bgcolor="#0070BA"  ><span style="font-size: 12px;color:white;"> <b>Feedback </b></span></td>
		           <td bgcolor="#0070BA" width="15%"><span style="font-size: 12px;color:white;"> <b> Added By</b></span></td>           
	         </tr>
	              
         </table>
        <br>
      		  
 

  <div class="form-row">
  
    <div class="col-md-6 col-sm-6 col-xs-12">
      <label >Status:</label>
      			<div class="form-check">
				  <input class="form-check-input" type="radio" name="exampleRadios" id="status" value="open" checked>				
				    Open &nbsp;&nbsp;&nbsp;
				  <input class="form-check-input" type="radio" name="exampleRadios" id="status" value="close">
				    Close
          </div>    
    </div>
    
    
    <div class="col-md-6 col-sm-6 col-xs-12">
    
          <label for="recipient-name" class="col-form-label">Action:</label>
				<div >
				    <select id="astatus" class="form-control">
			           <option value="ALL" selected>Choose...</option>
			           <option value="taken"> Taken</option>
			           <option value="ongoing"> Ongoing</option>
			         </select>
			   </div>
			   
	</div>
	   
   
			   
  </div>	   
  

  <div class="form-row">
  
    <div class="col-md-12 col-sm-12 col-xs-12">
   
            <label for="feedback" class="col-form-label">Message:</label>
            <textarea class="form-control" id="feedback" rows="06" maxlength="500" onkeyup="textCounter()"></textarea>
    </div>
  </div>  
<br>

<div class="form-row">  
    <div class="col-md-12 col-sm-12 col-xs-12">
          <div>
              <input type="text" id="textcount" value="0" size="1">/500<p style="color:red;font-size:12px;" id="errormessage"></p>
           </div>

</div>
</div>



      
      
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary" onClick="ajaxUpdate();">Update</button>
      </div>
      
      
      
      
      
    </div>
  </div>
</div>

  </form>


<script>

  function textCounter() {
	  var x = document.getElementById("feedback");
	  var count = document.getElementById("feedback").value.length;		
 	  document.getElementById("textcount").value=count;
 	  if(count > 500){
 		 errormessage.textContent = "Not More then 500 Char";
 		 //document.getElementById("textcount").focus();
 	  }
 	  else{	errormessage.textContent = "";  }
	}

</script>




</body>



