<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@page import="sun.util.calendar.LocalGregorianCalendar.Date"%>

<jsp:include page="../../include/gopsheader.jsp" />

<head>
    <title> Dashboard |Delay Flight Report </title>    
    <link rel="stylesheet" href="css/prism.css">
    <link rel="stylesheet" href="css/chosen.css">
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
	
	     document.getElementById("searchbutton").innerHTML = "<i class='fa fa-refresh fa-spin fa-lx' aria-hidden='true'></i>&nbsp;&nbsp;Searching..&nbsp;&nbsp;";
	     //<input type="button"  class="btn btn-primary" value="Show Report" onclick="showFlightReport();" />        
	     search_progress();
		 document.DelayFlighReport.method="POST";
		 document.DelayFlighReport.action="delayflightreport";
	     document.DelayFlighReport.submit();
	     return true;
}




//*** Here this function will update data in the form to database and write back to the DIV 
function Download_ExcelReport(){

	document.getElementById("downloading").innerHTML = "<i class='fa fa-refresh fa-spin fa-lx' aria-hidden='true'></i>&nbsp;&nbsp;Downloading..&nbsp;&nbsp;";
	search_progress();
    var urldetail ="CreateExcelReport?delay=yes&airlinecode="+document.getElementById("airlinecode").value; 
    urldetail = urldetail +"&airportcode="+document.getElementById("airportcode").value;
    urldetail = urldetail +"&startdate="+document.getElementById("startdate").value;		
    urldetail = urldetail +"&enddate="+document.getElementById("enddate").value;	
    urldetail = urldetail +"&emailid="+document.getElementById("emailid").value;  
	
    $.ajax({
        
		  url : urldetail,
		  type:"GET",
		  success : function(result)
		  {
				document.getElementById("searchbutton1").style.display = "none";
        	    document.getElementById("downloading").innerHTML = "<i class='fa fa-file-excel-o' aria-hidden='true'></i>&nbsp;&nbsp;Excel Report&nbsp;&nbsp;";
        	    window.location = document.getElementById("emailid").value+"/delayFlightReport.xls";	           

			}// ------ END OF SUCCESS ----  

    }); //----- END OF AJAX FUNCTION ------- 

	

 }//-------- END OF FUNCTION ---------------


</script>



<body>

<%
String[] userProfileList   =  request.getAttribute("profilelist").toString().split("#");
String userFullEmailid     =  userProfileList[0];
%>


 <div class="container" align="center">

  <div class="row">
	
	   <!-- First Part  -->
		<div class="col-sm-6 col-md-6 col-xs-12"> 
			
			<div class="panel panel-primary panel-shadow" style="overflow-x:auto;">
			
				<div class="panel-body"> 

 
				 <form name="DelayFlighReport" id="DelayFlighReport">   
				  
				 <input type="hidden" id="profilelist" name="profilelist" value="${profilelist}">
				 
				 <input type="hidden" name="usertype" value="${usertype}">
				       
				  <table class="table" style="width:100%;background:white" align="left">	
			
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
								     					 
								    <tr>
								    <td>		             
											<div class="col-xs-12">
														<label> Flight No </label>
														<div class="input-group">
															<span class="input-group-addon"><i class="fa fa-plane" aria-hidden="true"></i></span>	
																	<input type="text"  name="flightno" id="flightno" class="form-control" value="">					
																			
														</div>
											    </div>
								    
								    </td>
								    
								     <td align="center">
								                <br>
								     		 <span id="searchbutton" onClick="showFlightReport();"  class="btn btn-primary" ><i  class="fa fa-search" aria-hidden="true"></i>&nbsp;&nbsp;Show Report </span> 
						                     <!-- &nbsp;&nbsp;<button type="button"  class="btn btn-success" onClick="Download_ExcelReport();"  id="downloading">Excel Report&nbsp;&nbsp;<i class="fa fa-file-excel-o" aria-hidden="true"></i>	</button> -->	
						 
									     
								     </td>
								    
								    
								</tr>
								    
								     
					
								     
						  <tr>
							  <td colspan="2">
								    <span style="display:none" id="searchbutton1">
									          <div class="progress-bar progress-bar-striped active" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width:100%">
												         . 
										      </div>   
								     </span>
										
							  </td>
						  </tr>		     
	
								    </tbody>
							</table>
					
				</form>
				
               </div>
           </div>
         </div>
           
           
           

		   <div class="col-md-5 col-sm-5 col-xs-5" align="left" >
				      
				    <!-- <div id="chartContainer" style="height: 260px; width: 90%;"></div>-->
				      				
				    <table class="table table-bordered" border="1"  style="width:100%;background:white;" align="center">	  
						    
						
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

    </div>
 
 </div>


<br>
<br>
 
 
	   
 <div class="container" align="center">
 
 
 
    <c:if test="${fn:length(reportbody) < 1}">
	      <table align="center">    
	       <tr align="center"> 
	       <td colspan="16" align="center"> <b>Sorry there is No flight on your above Selected Search Criteria. </b></td>
	       </tr>
	      </table>
	</c:if>		
	
		
   <c:if test="${fn:length(reportbody) > 0}">  	
      
      <div class="col-md-12 col-sm-12 col-xs-12" align="left" >
 
   		<ul class="nav nav-pills">
            <li class="active"><a data-toggle="pill" href="#menu1"><b>${reportbody.stream().distinct().count()}</b> - Flights</a></li>
            <li><a data-toggle="pill" href="#menu2"><b>${reportbody_C.stream().distinct().count()}</b> - Cancelled </a></li>

	    </ul>
					

<div class="tab-content">
   
   <div id="menu1" class="tab-pane fade in active">		
   
   
   
  	

		

  	<table class="table table-bordered" border="1" style="width: 100%;background:white;" align="left">	
		      
  
 
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
					    IATA Delay Code 
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
					     Rem.
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
					     Comment
					     </b></span>					 
					 </td>
					 
					 <td bgcolor="#0070BA">
					   <span style="color:white;"> <b> 
					    Attributable Delay.
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
					    
					      ${fltleg.sect.getFlightDatop()} 
					      					 
					 </td>
		  
				 
					 <td>
					  	<a href="#" onclick="return false;" data-toggle="popover" data-trigger="hover" 
					    title="  CAPTION       |   ${fltleg.sect.flightCaption} " 
					    data-content="FIR. OFFI | ${fltleg.sect.flightFirstOfficer}">  
					     ${fltleg.sect.flightNo}
					    </a>
					      					 
					 </td>
				
					 <td>
					    
					        ${fltleg.sect.aircraftReg} 
					      					 
					 </td>
					 
					 <td>
					    
					        ${fltleg.sect.std}					 
					 </td>

					 <td>
					     ${fltleg.sect.sta} 
					  
					      					 
					 </td>
					 
					 <td>
					    
					      ${fltleg.sect.from}	 
					 </td>
					 
					 <td>
					        
						    ${fltleg.sect.to}   
					      					 
					 </td>
					 
					 <td align="left" width="12%">	
				 
                         <a href="#" onclick="return false;" data-toggle="popover" data-trigger="hover"  title="Detail - Group" data-content="${fltleg.sect.IATA_DelCodeGroup()}">
			               <c:set var="string1" value="${fltleg.sect.IATA_DelCodeGroup()}"/>
                            <c:set var="string2" value="${fn:substring(string1, 0,18)}" />
			                   ${string2}
			             </a>
			     	 </td>
					 
					 		 
					 <td align="left">
					     
					   <c:set var = "delaycode"  value = "${fn:length(fltleg.sect.delayCode1)}"/>   
	                
					      <c:if test = "${delaycode >= 2}">
					           <a href="#" onclick="return false;" data-toggle="popover" data-trigger="hover"  title="Delay Code Description" data-content="${fltleg.sect.delayCode1_desc}" data-placement="top">
					             <b> <c:out value = "${fltleg.sect.delayCode1}"/></b></a>					             		
					             <fmt:formatNumber var="delay_hour" type="number" minIntegerDigits="2" maxFractionDigits="0" value="${ ((fltleg.sect.delayCode1_time - (fltleg.sect.delayCode1_time % 60)) / 60)}"/>
								 <fmt:formatNumber var="delay_minute" type="number" minIntegerDigits="2" maxFractionDigits="0" value="${fltleg.sect.delayCode1_time % 60}" />
								  /${delay_hour}:${delay_minute}
											        
					      </c:if>
						
					     
					   <c:set var = "delaycode"  value = "${fn:length(fltleg.sect.delayCode2)}"/>   
	                
					      <c:if test = "${delaycode >= 2}">
					           <a href="#" onclick="return false;" data-toggle="popover" data-trigger="hover"  title="Delay Code Description" data-content="${fltleg.sect.delayCode2_desc}" data-placement="top">
					             ,<b> <c:out value = "${fltleg.sect.delayCode2}"/></b></a>					             
					             <fmt:formatNumber var="delay_hour" type="number" minIntegerDigits="2" maxFractionDigits="0" value="${ ((fltleg.sect.delayCode2_time - (fltleg.sect.delayCode2_time % 60)) / 60)}"/>
								 <fmt:formatNumber var="delay_minute" type="number" minIntegerDigits="2" maxFractionDigits="0" value="${fltleg.sect.delayCode2_time % 60}" />
								  /${delay_hour}:${delay_minute}					             
					        
					      </c:if>
						
					      
					      
					   <c:set var = "delaycode"  value = "${fn:length(fltleg.sect.delayCode3)}"/>   
	                
					      <c:if test = "${delaycode >= 2}">
					           <a href="#" onclick="return false;" data-toggle="popover" data-trigger="hover"  title="Delay Code Description" data-content="${fltleg.sect.delayCode3_desc}" data-placement="top">
					             ,<b> <c:out value = "${fltleg.sect.delayCode3}"/></b></a>
					             <fmt:formatNumber var="delay_hour" type="number" minIntegerDigits="2" maxFractionDigits="0" value="${ ((fltleg.sect.delayCode3_time - (fltleg.sect.delayCode3_time % 60)) / 60)}"/>
								 <fmt:formatNumber var="delay_minute" type="number" minIntegerDigits="2" maxFractionDigits="0" value="${fltleg.sect.delayCode3_time % 60}" />
								  /${delay_hour}:${delay_minute}					             
					        
					      </c:if>
					      
						
					   <c:set var = "delaycode"  value = "${fn:length(fltleg.sect.delayCode4)}"/>   
	                
					      <c:if test = "${delaycode >= 2}">
					           <a href="#" onclick="return false;" data-toggle="popover" data-trigger="hover"  title="Delay Code Description" data-content="${fltleg.sect.delayCode4_desc}" data-placement="top">
					             ,<b> <c:out value = "${fltleg.sect.delayCode4}"/></b></a>
					             <fmt:formatNumber var="delay_hour" type="number" minIntegerDigits="2" maxFractionDigits="0" value="${ ((fltleg.sect.delayCode4_time - (fltleg.sect.delayCode4_time % 60)) / 60)}"/>
								 <fmt:formatNumber var="delay_minute" type="number" minIntegerDigits="2" maxFractionDigits="0" value="${fltleg.sect.delayCode4_time % 60}" />
								  /${delay_hour}:${delay_minute}					             
					        
					      </c:if>
	      				      					 
		                       
	                      
					 
					 </td>
					 
			
					 
					 <td>
					    
					       ${fltleg.sect.getTotalDelayTime()} 
					      					 
					 </td>
					 
					 <td>
					    
					    				   
						         
						       <c:if test="${fn:length(fltleg.sect.getFlightNoteRemarks()) > 0}">
						           	
								  <a href="#" onclick="return false;">  <i class="fa fa-newspaper-o" rel="popover" data-popover-content="#popover<%=ctr%>" title="Remark " data-trigger="hover" data-placement="auto"></i> </a>
								  			<div id="popover<%=ctr%>" class="hide">
													<ul>													
													    <c:forEach var="fltnotea" items="${fltleg.sect.getFlightNoteRemarks()}"> 
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
					      <b>  ${fltleg.comment.action} </b> 
					      					 
					 </td>
					 
					 <td align="left">
					  <c:if test="${fltleg.comment.status == 'open'}"> <span class="label label-info"><i class="fa fa-check-circle  fa-lg" aria-hidden="true"></i>&nbsp;<b> OPEN  </b>  </span> </c:if>
					  <c:if test="${fltleg.comment.status == 'close'}"> <span class="label label-danger"><i class="fa fa-times  fa-lg" aria-hidden="true"></i>&nbsp;<b> CLOSED </b>  </span> </c:if>
				         					 
					 </td>
					 
					 <td>
					     <b>
					          ${fltleg.comment.noofDaysOpened()}   
					      	</b>				 
					 </td>
					 
					 
					 <td >
		                     ${fltleg.comment.dateTimeClosed} 
					 </td>
				 
			         <td>        
                   
                        <a href="javascript:void();"><span class="label label-success"  onClick="open_model_toAdd_Comment('${fltleg.sect.flightNo}','${fltleg.sect.flightDate}','${fltleg.sect.from}','${fltleg.sect.to}','<%=userFullEmailid%>')" ><i   class="fa fa-pencil-square-o" aria-hidden="true" ></i>&nbsp; <b>Comment. </b></span></a>
	               				          
				     </td>
				  
				     <td> 
				   
				       
				       	<c:if test="${fltleg.comment.stobartdelay == 'YES'}">
		                     <i class="fa fa-check-circle  fa-lg" aria-hidden="true"></i>&nbsp;<span style="color:green;font-weight:bold;">Yes</span>
		                </c:if>
		          
		          
		            	 <c:if test="${fltleg.comment.stobartdelay == 'NO'}">
		                    <i class="fa fa-times  fa-lg" aria-hidden="true"></i>&nbsp;<span style="color:red;font-weight:bold;">No</span>
		                </c:if>
		           
				       
				       
				       
				         
				     
				     </td> 
				  
				  </tr>
				     				
		    </c:forEach>		

				    
       </table>	
  
	
  
   </div>
   
   
   
   
   
   <!-- SECOND TAB FOR THE CANCLE FLIGHTS  -->
   	<div id="menu2" class="tab-pane fade"> 
   	
 	<table class="table table-bordered" border="1" style="width: 100%;background:white;" align="left">	
		
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
 
   </c:if>	   	                     
 
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
<br>
<br>
<br>
<br>
<%@include file="../../include/gopsfooter.jsp" %>


<script>


/*
 * -------- This will Open Model Where Feedback will be Entered 
 *          On CLICK ON THE COMMENT Button 
 */
function open_model_toAdd_Comment(flightid,datop,fromstn,tostn,emailid){

          //- Display of the  Model  
	      document.getElementById("flightid").innerHTML = flightid+"&nbsp;&nbsp;("+fromstn+")<img src='flightarrow.png'>("+tostn+")";
	      document.getElementById("datopdisplay").innerHTML = " Date: "+datop;

          //-- Add value to the hidden form         
	       document.getElementById("cBoxflightno").value = flightid;
	       document.getElementById("datop").value    = datop;
	       document.getElementById("fromstn").value  = fromstn;
	       document.getElementById("tostn").value    = tostn;
	       document.getElementById("addedby").value  = emailid;


           // Builting Table for the previousely entered comment
	   	   var tableheader ="<table id='displaydata' class='table table-striped table-bordered' border='1' style='width:100%;background:rgba(255,255,255);' align='left'><tr><td bgcolor='#0070BA' width='14%'> <span style='font-size: 12px;color:white;'> <b> Comment On</b></span></td> <td bgcolor='#0070BA'  ><span style='font-size: 12px;color:white;'> <b>Feedback </b></span></td> <td bgcolor='#0070BA' width='15%'><span style='font-size: 12px;color:white;'> <b> Added By</b></span></td></tr>";
	       var footervar   ="</table>"; 
	               
	       
         //--- Fetch Datafrom DB 
         
         var callingurl="ajaxrest/getflightcomment?flightno="+flightid+"&datop="+datop;
         
         $.ajax({
				type : 'GET',
				url : callingurl,
				dataType : 'json',
				contentType : 'application/json',				
				success : function(result) {
					var tablebody = tableheader;
					var status ="new";
					var astatus ="ongoing";
					var stobartad ="NO";
					var i = 0;
					for (i = 0; i < result.length; i++) {
						tablebody += "<tr bgcolor='#FDEBD0'> <td  style='font-size: 12px;'>"+result[i].dateTimeEntered+"</td><td style='font-size: 12px;'>"+result[i].comments+"</td><td style='font-size: 12px;'>"+result[i].enteredBy+"</td></tr>"; 
						status    = result[i].status;
						astatus   = result[i].action;	
						stobartad = result[i].stobartdelay;
					}	
					tablebody += "</table>";			 
					$('#displaydata').html(tablebody);

					
					if(status == 'close'){						
					  document.getElementById("status_close").checked=true;
					  document.getElementById("feedback").value        ="   Issue is Resolved..   ";
					  document.getElementById("feedback").readOnly     = true;
					  document.getElementById("updatebutton").disabled = true;					  
					}
					if(status == 'open'){
						  document.getElementById("feedback").readOnly     = false;
						  document.getElementById("updatebutton").disabled = false;
						  document.getElementById("astatus").selectedIndex = "0";
						  document.getElementById("feedback").value    ="";
						  document.getElementById("status_open").checked=true;
						
					}
					if(status == 'new'){
						  document.getElementById("feedback").readOnly     = false;
						  document.getElementById("updatebutton").disabled = false;
						  document.getElementById("astatus").selectedIndex = "0";
						  document.getElementById("feedback").value    ="";
						  document.getElementById("status_open").checked=true;
						  $('#displaydata').html("");
						
					}
					
					//--- This will update Status  && Action Field 
					if(astatus == 'ongoing'){document.getElementById("astatus").selectedIndex = "2";}
					if(astatus == 'taken')  {document.getElementById("astatus").selectedIndex = "1";}
					if(stobartad == 'NO')   {document.getElementById("stobartad").selectedIndex = "0";}
					if(stobartad == 'YES')  {document.getElementById("stobartad").selectedIndex = "1";}
				
				    
					//---- For the external user disable this option  
					if(!isStobartUser(emailid)){
						document.getElementById("stobartad").disabled = true;	
						document.getElementById("status_close").disabled = true; 	
					}
				    

										
				}
			      
			});            

           
           //-- Click and Open Model
	       document.getElementById("flightmodelbutton").click();
	   
  }



//---  if the user id with the email id like john@stobartair.com then retrun true or else return false
function isStobartUser(mail){
	
	if (/^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$/.test(mail)){
       return true;
    }
	else
	{
		return false;
	}
}



//-------- This will Open Model Where Feedback will be Entered ----------------
function open_model_toAdd_Comment_After_Add(flightid,datop,fromstn,tostn,emailid){

          //- Display of the  Model  
	      document.getElementById("flightid").innerHTML = flightid+"&nbsp;&nbsp;("+fromstn+")<img src='flightarrow.png'>("+tostn+")";
	      document.getElementById("datopdisplay").innerHTML = " Date: "+datop;

          //-- Add value to the hidden form         
	       document.getElementById("cBoxflightno").value = flightid;
	       document.getElementById("datop").value    = datop;
	       document.getElementById("fromstn").value  = fromstn;
	       document.getElementById("tostn").value    = tostn;
	       document.getElementById("addedby").value  = emailid;



	   	   var tableheader ="<table id='displaydata' class='table table-striped table-bordered' border='1' style='width:100%;background:rgba(255,255,255);' align='left'><tr><td bgcolor='#0070BA' width='14%'> <span style='font-size: 12px;color:white;'> <b> Comment On</b></span></td> <td bgcolor='#0070BA'  ><span style='font-size: 12px;color:white;'> <b>Feedback </b></span></td> <td bgcolor='#0070BA' width='15%'><span style='font-size: 12px;color:white;'> <b> Added By</b></span></td></tr>";
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
					var status ="new";
					var astatus ="ongoing";

					for (var i = 0; i < result.length; i++) {
						s += "<tr bgcolor='#FDEBD0'> <td  style='font-size: 12px;'>"+result[i].dateTimeEntered+"</td><td style='font-size: 12px;'>"+result[i].comments+"</td><td style='font-size: 12px;'>"+result[i].enteredBy+"</td></tr>";
						status = result[i].status;
						astatus =result[i].action;
					}	
					s += "</table>";			 
					$('#displaydata').html(s);

					
					if(status == 'close'){						
						  document.getElementById("status_close").checked=true;
						  document.getElementById("feedback").value        ="   Issue is Resolved..   ";
						  document.getElementById("feedback").readOnly     = true;
						  document.getElementById("updatebutton").disabled = true;					  
					}
					if(status == 'open'){
							  document.getElementById("feedback").readOnly     = false;
							  document.getElementById("updatebutton").disabled = false;
							  document.getElementById("astatus").selectedIndex = "0";
							  document.getElementById("feedback").value    ="";
							  document.getElementById("status_open").checked=true;
							 
					}
					if(status == 'new'){
						  document.getElementById("feedback").readOnly     = false;
						  document.getElementById("updatebutton").disabled = false;
						  document.getElementById("astatus").selectedIndex = "0";
						  document.getElementById("feedback").value    ="";
						  document.getElementById("status_open").checked=true;
						  $('#displaydata').html("");
						
					}
	
						
					//--- This will update Status  && Action Field 
					if(astatus == 'ongoing'){document.getElementById("astatus").selectedIndex = "2";}
					if(astatus == 'taken')  {document.getElementById("astatus").selectedIndex = "1";}
	
				}
		
			});  




  }




//*** Here this function will update data in to database and write back to the DIV 
function ajaxUpdate(){
	 
	var feedback  = document.getElementById("feedback").value;
	var flightno  = document.getElementById("cBoxflightno").value;
	var datop     = document.getElementById("datop").value;
	var fromstn   = document.getElementById("fromstn").value;
	var tostn     = document.getElementById("tostn").value;
	var addedby   = document.getElementById("addedby").value;	
	var astatus   = document.getElementById("astatus").value;
	var stobartad = document.getElementById("stobartad").value;
	
	var status;

   if(document.getElementById('status_open').checked) { 
	   status = document.getElementById("status_open").value; 
             
      } 
   

   if(document.getElementById('status_close').checked) { 
	   status = document.getElementById("status_close").value; 
             
      } 
   
	
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
  		
   
	
	var tableheader ="<table id='displaydata' class='table table-striped table-bordered' border='1' style='width:100%;background:rgba(255,255,255);' align='left'><tr><td bgcolor='#0070BA' width='12%'> <span style='font-size: 12px;color:white;'> <b>Comment Date</b></span></td> <td bgcolor='#0070BA'  ><span style='font-size: 12px;color:white;'> <b>Feedback </b></span></td> <td bgcolor='#0070BA' width='15%'><span style='font-size: 12px;color:white;'> <b> Added By</b></span></td></tr>";
    var tablebody   ="<tr bgcolor='#FDEBD0'> <td  style='font-size: 12px;'>"+datop+"</td><td style='font-size: 12px;'>"+feedback+"</td><td style='font-size: 12px;'>"+addedby+"</td></tr>";
    var footervar   ="</table>"; 
  
    $.ajax({
			  url :'delayaction',
			  type:"POST",
			  data:{
				  feedback:feedback,
				  flightno:flightno,
				  datop   :datop,
				  fromstn :fromstn,
				  tostn   :tostn,
				  addedby :addedby,
				  status  :status,
				  stobartad:stobartad,
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


<input type="hidden" id="cBoxflightno" value="">
<input type="hidden" id="datop"    value="">
<input type="hidden" id="fromstn"  value="">
<input type="hidden" id="tostn"    value="">
<input type="hidden" id="addedby"  value="">




<button style="display:none;" id="flightmodelbutton" type="button" class="btn btn-primary" data-toggle="modal" data-target=".bd-example-modal-lg">Large modal</button>

<div class="modal fade bd-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      
       
      <div class="modal-header"  >
        <h3 class="modal-title" style="color:black;" id="flightid"></h3> 
         <h5 style="color:black;" class="modal-title" id="datopdisplay"></h5>
        
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      
      <div class="modal-body">
      
          <table id="displaydata" class="table table-striped table-bordered" border="1" style="width:100%;background:white;">	
	         <tr>
		           <td bgcolor="#0070BA" width="12%"> <span style="font-size: 12px;color:white;"> <b>Date</b></span></td>
		           <td bgcolor="#0070BA"  ><span style="font-size: 12px;color:white;"> <b>Feedback </b></span></td>
		           <td bgcolor="#0070BA" width="15%"><span style="font-size: 12px;color:white;"> <b> Added By</b></span></td>           
	         </tr>
	              
         </table>
        <br>
      		  
 

  <div class="form-row">
  
    <div class="col-md-4 col-sm-4 col-xs-12">
      <label >Status:</label>
      			<div>
				  <input class="form-check-input" type="radio" name="status" id="status_open" value="open" checked>				
				    Open &nbsp;&nbsp;&nbsp;
				  <input class="form-check-input" type="radio" name="status" id="status_close" value="close">
				    Close
	        </div>    
    </div>
    
    <div class="col-md-4 col-sm-4 col-xs-12">
      <label >Stobart Attributable Delay</label>
      			<div >
				    <select id="stobartad" class="form-control">
			           <option value="NO"> NO </option>
			           <option value="YES"> YES</option>
			         </select>
			   </div>
   
    </div>
    
    
    
    
    <div class="col-md-4 col-sm-4 col-xs-12">
    
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
        <button type="button" class="btn btn-primary" id="updatebutton" onClick="ajaxUpdate();">Update</button>
      </div>
      
      
      
      
      
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
 	  if(count == 500){
 		 errormessage.textContent = "Not More then 500 Char";
 		 //document.getElementById("textcount").focus();
 	  }
 	  else{	errormessage.textContent = "";  }
	}
  
 

</script>




</body>



