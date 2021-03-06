<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="../../include/gopsheader.jsp" />

<head>
    <title> Dashboard |Delay Flight Report </title>    
</head>



<script src="https://canvasjs.com/assets/script/canvasjs.min.js"></script>

<script type="text/javascript">





function search_progress() {
  
    var e1 = document.getElementById("searchbutton1");
    if(e1.style.display == 'block')
        e1.style.display = 'none';
     else
        e1.style.display = 'block';    
 }

function showFlightReport(){

			 if(document.DelayFlighReport.tolerance.value == ""){document.DelayFlighReport.tolerance.value=0}
		     document.getElementById("searchbutton").innerHTML = "<i class='fa fa-refresh fa-spin fa-lx' aria-hidden='true'></i>&nbsp;&nbsp;Searching..&nbsp;&nbsp;";
		     //<input type="button"  class="btn btn-primary" value="Show Report" onclick="showFlightReport();" />        
		     search_progress();
			 document.DelayFlighReport.method="POST";
			 document.DelayFlighReport.action="reliablityflightreport";
		     document.DelayFlighReport.submit();
		     return true;

}	




//*** Here this function will update data in the form to database and write back to the DIV 
function Download_ExcelReport(){
      
	  var emailId = document.getElementById("profilelist").value;
	  emailId     = emailId.split("#",1);
	  search_progress();
	  document.getElementById("downloading").innerHTML = "<i class='fa fa-refresh fa-spin fa-lx' aria-hidden='true'></i>&nbsp;&nbsp;Downloading..&nbsp;&nbsp;";
      var urldetail ="CreateExcelReport?delay=no&airlinecode="+document.getElementById("airlinecode").value; 
      urldetail = urldetail +"&airportcode="+document.getElementById("airportcode").value;
      urldetail = urldetail +"&startdate="+document.getElementById("startdate").value;		
      urldetail = urldetail +"&enddate="+document.getElementById("enddate").value;	
      urldetail = urldetail +"&emailid="+emailId;	      
      urldetail = urldetail +"&delayCodeGroupCode="+document.getElementById("delayCodeGroupCode").value;
      urldetail = urldetail +"&profilelist="+document.getElementById("profilelist").value;	
      $.ajax({
          
 		  url : urldetail,
		  type:"POST",
		  success : function(result)
		  {
				//document.getElementById("downloadstatus").style.display = "none";
          	    document.getElementById("downloading").innerHTML = "<i class='fa fa-file-excel-o' aria-hidden='true'></i>&nbsp;&nbsp;Excel Report&nbsp;&nbsp;";
          	    window.location = emailId+"/viewExcelReliabilityReportFlights.xls";	 
          	    document.getElementById("searchbutton1").style.display = 'none';          
                          
			}// ------ END OF SUCCESS ----  

   }); //----- END OF AJAX FUNCTION ------- 



	

}//-------- END OF FUNCTION ---------------








</script>



<body>

 
 <div class="container" align="center">

  <div class="row">
	
	   <!-- First Part  -->
		<div class="col-sm-6 col-md-6 col-xs-12"> 
			
			<div class="panel panel-primary panel-shadow" style="overflow-x:auto;">
			
				<div class="panel-body">  
 
 
					 <form name="DelayFlighReport" id="DelayFlighReport" method="POST">   
					  
					 <input type="hidden" id="profilelist" name="profilelist" value="${profilelist}">
					  <input type="hidden" name="usertype" value="${usertype}">       
					    <table class="table"  style="width:100%;background:white;align:center;">	
					   			<tbody>				     
									 <tr align="center">
										 <td  bgcolor="#0070BA" colspan="2">
										   <span style="color:white;">  <i class="fa fa-database fa-lx" aria-hidden="true"></i> &nbsp;<b>
										    Reliablity Report  &nbsp;&nbsp;
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
									     					
										<td>
									             
							               <div class="col-xs-12">
												<label for="startDate">Start Date:</label>
												<div class="input-group">
													<span class="input-group-addon"><i class="fa fa-calendar"></i></span>								
													<input type="date" id="startdate" name="startdate" class="form-control datepicker" maxlength="12"
													    value="${startdate}" placeholder="(DD/MM/YYYY)"/>
												</div>	
											</div>
													
													
									       </td>
										<td>
									             
							               <div class="col-xs-12">
												<label for="startDate">End Date:</label>
												<div class="input-group">
													<span class="input-group-addon"><i class="fa fa-calendar"></i></span>								
													<input type="date" id="enddate" name="enddate" class="form-control datepicker" maxlength="12"
													    value="${enddate}" placeholder="(DD/MM/YYYY)"/>
												</div>	
											</div>
													
													
									       </td>
									       
									       
									       
									     </tr>					 
									     
									  <tr align="left"> 
									  
									     
									  
									     					
										<td >
									             
									             
									         <div class="col-xs-12">
												<label for="sortBy">Delay Code Group:</label> 
												<div class="input-group">
													<span class="input-group-addon"><i class="fa fa-text-height" aria-hidden="true"></i></span>
													<select id="delayCodeGroupCode" name="delayCodeGroupCode" class="form-control">
													<option value="ALL" <c:if test="${delaycode == 'ALL'}"> selected </c:if> >------All-------</option>									
															<option value="GOPS" <c:if test = "${delaycode == 'GOPS'}"> selected </c:if>  >Ground Ops </option>									
															<option value="SAD" <c:if test = "${delaycode == 'SAD'}"> selected </c:if> >Stobart Attributable Delays</option>									
															<option value="NSAD" <c:if test = "${delaycode == 'NSAD'}"> selected </c:if> >Non Stobart Delays</option>
						
														
													</select>
												</div>
											</div>
									       </td>
									       
									       			  
						                <td bgcolor="white">
									     	<label for="delayGroupCode">Tolerance:</label>&nbsp; <span style="font-size:80%;color:green;font-weight: 700;"> >=  Minutes</span>
												<div class="input-group">
													<span class="input-group-addon"><i class="fa fa-hand-stop-o"></i></span>
													<input type="text" id="tolerance" name="tolerance"  class="form-control" maxlength="9" value="${tolerance}" /> 
													
											</div>
									          
							          </td>			         
						
						 </tr>
						 
						 <tr >
									     					
								<td align="center" colspan="2">
											   
									 <span id="searchbutton" onClick="showFlightReport();"  class="btn btn-primary" ><i  class="fa fa-search" aria-hidden="true"></i>&nbsp;&nbsp;Show Report </span> 
							         &nbsp;
							         <button type="button"  class="btn btn-success" onClick="Download_ExcelReport();"  id="downloading">Excel Report&nbsp;&nbsp;<i class="fa fa-file-excel-o" aria-hidden="true"></i>	</button>	
											  
									 </td>
								</tr>		    
										<tr>
												<td colspan="2">
													<span style="display:none" id="searchbutton1">
														<div class="progress-bar progress-bar-striped active" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width:100%">
														   Please have some patience as this might take a while ... 
														</div>   
													</span>
												</td>
											</tr>		     
									     
												    
									    </tbody>
								</table>
						  </div>
						
					</form>
					
				</div>
			</div>	
					
 
		<div class="col-md-5 col-sm-5 col-xs-5" align="left" >
		      
		      <!-- <div id="chartContainer" style="height: 260px; width: 90%;"></div>-->
		      				
		    <table  class="table table-bordered"  border="0" style="width: 100%;" align="center">	
				    
				
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
                              
		
							   <p align="center">    <img  src="images/${airlinecode}1.png"> </p> 
				        
				        </td>
				    </tr>
			</table>
		</div>




    </div> <!-- END OF ROW  -->

</div>	<!-- END OF CONTAINER -->

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

  	<table class="table table-striped table-bordered" border="1" style="width: 100%;background:white;" align="left">	
		      
  
 
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
   	
 	<table class="table table-bordered" border="1" style="width:100%;background:white;" align="left">	
		
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
var input = document.getElementById("tolerance");
input.addEventListener("keyup", function(event) {
  if (event.keyCode == 13) {
   event.preventDefault();
   if(document.DelayFlighReport.tolerance.value == ""){document.DelayFlighReport.tolerance.value=0}
   showFlightReport();
  }
});
</script>
 
</body>

<br>
<br>

<%@include file="../../include/gopsfooter.jsp" %>




