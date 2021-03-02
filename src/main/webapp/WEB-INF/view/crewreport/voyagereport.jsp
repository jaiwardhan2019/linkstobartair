<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<jsp:include page="../include/header.jsp" />

<link rel="stylesheet" href="css/flightReportPrint.css">
<link rel="stylesheet" href="css/flightReportView.css">


<head>
    <title> Dashboard | Voyager Report </title>    
</head>


<script type="text/javascript">

//https://stackoverflow.com/questions/33966181/how-to-pass-parameters-to-jasperreport-with-java-to-use-later-in-sql-query


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


function showmyCrewFlightScheduleforSelectedDate(){
	     search_progress();  		
	     document.voygerReport.target="";
	     document.voygerReport.method="POST";
		 document.voygerReport.action="voyagerReport";
	     document.voygerReport.submit();
		 return true;
    	
}//---------- End Of Function  ------------------




//------ Print Report Blank 
function printVoygerReport(category){

	  var sel = document.getElementById('crewcode');
	  if(category == 'BLANK'){sel.value="BLANK";}else{sel.value=category;}		
	  
	  document.voygerReport.method="POST";
	  document.voygerReport.target="_new";
	  document.voygerReport.action="voyagerReportblankpdfWithFLTTemplet";
      document.voygerReport.submit();
      
      var sel = document.getElementById('crewcode');
      sel.value="ALL";
	  return true;
}




function printOneReport(crewcode){
	 
	  var sel = document.getElementById('crewcode');
	  sel.value=crewcode;
	  document.voygerReport.method="POST";
	  document.voygerReport.target="_new";
	  document.voygerReport.action="voyagerReportblankpdfWithFLTTemplet";
      document.voygerReport.submit();    
  	  return true;
}







function showOtherdDateCaption(){
	      search_progress(); 
	      document.voygerReport.target="";
          var sel = document.getElementById('crewcode');
          sel.value="ALL";
		  document.voygerReport.method="POST"
		  document.voygerReport.action="voyagerReport";
	      document.voygerReport.submit();
		  return true;
    
}




</script>

<style>
/*
tr:nth-child(even) {
  background-color: #dddddd;
}
*/
</style>


 <br>
 <br>

 <br>
 <br>
 <br>
 <br>

 
 
   
 <div class="container" align="center">

  <div class="row">
	
	   <!-- First Part  -->
		   <div class="col-md-4 col-md-offset-4 col-sm-12 col-xs-12">		
			
			<div class="panel panel-primary panel-shadow" style="overflow-x:auto;">
			 
			 <form name="voygerReport" id="voygerReport">  
			  
			   <input type="hidden" id="profilelist" name="profilelist" value="${profilelist}">
			
			
			          <table class="table table-striped table-bordered" border="1"  align="center">	    
			    			<tbody>				     
							     <tr align="center">
								 <td  bgcolor="#0070BA">
								   <span style="color:white;">  <i class="fa fa-database fa-lx" aria-hidden="true"></i> &nbsp;<b>
								    My Flight / Voyager  Report  &nbsp;&nbsp;
								   </b></span>					 
								 </td>
							     </tr>
						
						
						   <tr>
								<td align="left" bgcolor="white" >
								 
								
							     <div class="form-group">
										<label for="startDate">Flight Date:</label>
										<div class="input-group">
											<span class="input-group-addon"><i class="fa fa-calendar"></i></span>								
													<select id="flightdate" name="flightdate" class="form-control" onchange="showOtherdDateCaption()" >
													             ${selectoption}						
													</select>
										</div>	
									</div>
							
							
								<div class="form-group">
										<label  >Flight Captain:</label>
										<div class="input-group">
											<span class="input-group-addon"><i class="fa fa-user-circle-o" aria-hidden="true"></i></span>							
												
													<select  id="crewcode" name="crewcode" class="form-control" >
													
														<option value="ALL"> All - Caption </option>
														 <c:forEach var="caplst" items="${captionlist}"> 
															     <c:if test = "${caplst.getCrewid() == selectedcaption}">
														         <option value="${caplst.getCrewid()}" selected>${caplst.position} - ${caplst.getCrewFullName()} - (${caplst.getCrewid()})</option>
														         
												              </c:if> 
														      
														      <c:if test = "${caplst.getCrewid() != selectedcaption}">
														         <option value="${caplst.getCrewid()}">${caplst.position} - ${caplst.getCrewFullName()}- (${caplst.getCrewid()})</option>
												              </c:if> 
												
														 </c:forEach>
														 <option value="BLANK" hidden>-- BLANK --</option>
														 
													</select>
										</div>
									</div>
									
								
							
							
							
								
									</td>
									
							  </tr>	
									 
							     
							    <tr align="center"> 
							     					
									<td  bgcolor="white">
		
		
									        <span style="display:block" id="searchbutton">
									           <input type="button"  class="btn btn-primary" value="Show Report" onclick="showmyCrewFlightScheduleforSelectedDate();" /> 
									        </span>
									        
									        <span style="display:none" id="searchbutton1">
									              <div class="progress-bar progress-bar-striped active" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width:100%">
											         <b> &nbsp; In Progress ....</b>&nbsp;&nbsp;<i class="fa fa-spinner fa-pulse fa-2x"></i>
											      </div>   
									        </span>
								       
								     </td>
								     </tr>
							     
										    
							    </tbody>
						</table>
						</form>
             </div>
           </div>		

              
				 <div class="col-md-3 col-md-offset-7 col-sm-12 col-xs-12">	
				   <br><br>	<br><br>
				   
				   	  <c:if test = "${selectedcaption == 'ALL'}"> 
                         <button title="Print All Sheet."  onclick="printVoygerReport('ALL');"  type="button" class="btn  btn-sm"> <img src="pdf.png" > <b>Print ALL  </b> &nbsp;<i class="fa fa-print fa-lg" aria-hidden="true"></i></button>
		     	      </c:if>	      
		              &nbsp;&nbsp;&nbsp;&nbsp;
				      <button title="Print Blank Sheet."  onclick="printVoygerReport('BLANK');"  type="button" class="btn  btn-sm"> <img src="pdf.png" > <b>Print Blank Sheet  </b> &nbsp;<i class="fa fa-print fa-lg" aria-hidden="true"></i></button>
				 <br><br>
				 </div>
				 
				 
				
				 
 
   </div>	
 </div>
<!--  END of UPPER FORM PART   -->






<!--  START OF REPORT  PART   -->

<div class="container" style="font-size:90%" >



<p align="center">
<!-- 
  <input type="button" class="btn btn-primary" value=" Print Report With Data" onclick="printVoygerReport();" /> 
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
   -->
 	  
 
</p>
</div>



<div class="container" >
       
 <%int rowCtr=1;%>
 
 <c:forEach var="flightReport" items="${flightReport}">          



		
	

<div class="row">
   <div class="col-md-8 col-md-offset-2 col-sm-12 col-xs-12">	

<div class="panel-shadow"> 

 <table class="table table-bordered" border="1" style="font-size:11px;font-weight:bold;width:100%;background:white;" align="center">	
 	     
 	     <tr>
 	        <td bgcolor="#0070BA">
			   <span style="color:white;"> <b> 
					   Report:	
			     </b>	
			     </span>				 
			</td>
			<td colspan="9" bgcolor="white">
			  <b><%=rowCtr%></b>
			</td>
		</tr>	
				  
		<tr>
 	        <td bgcolor="#0070BA">
			   <span style="color:white;"> <b> 
					    Position :	
			     </b>	
			     </span>				 
			</td>
			<td colspan="9" bgcolor="white">
			  <b>
			    
			    <c:if test = "${fn:containsIgnoreCase(flightReport.position,'CAPT')}">
			       Capt.
			    </c:if>  
			    
			    <c:if test = "${fn:containsIgnoreCase(flightReport.position,'FO')}">
			       FO.
			    </c:if>  
			    <c:if test = "${fn:containsIgnoreCase(flightReport.position,'CC')}">
			       C.Crew.&nbsp;
			    </c:if>  
			    &nbsp;${flightReport.crewFirstName}&nbsp;${flightReport.crewLastName}
			  </b>
			
			</td>
		</tr>			  
		
		<tr>
 	        <td bgcolor="#0070BA">
			   <span style="color:white;"> <b> 
					    Crew :	  
			     </b>	
			     </span>				 
			</td>
			
			<td colspan="9" bgcolor="white">
			  <b>
		         <div id="crewList<%=rowCtr%>"> </div>
			  </b>
			</td>
		</tr>			  
		
		
		
	 <tr align="center" >
				    
				    <td bgcolor="#0070BA">
					   <span style="color:white;"> <b> 
					    Sec.	
					     </b>	</span>				 
					 </td>
					  
					 <td bgcolor="#0070BA">
					   <span style="color:white;"> <b> 
					      Date 
					     </b></span>					 
					 </td>
					 <td bgcolor="#0070BA">
					   <span style="color:white;"> <b> 
					    Reg  	
					     </b></span>					 
					 </td>
					 <td bgcolor="#0070BA">
					   <span style="color:white;"> <b> 
					      Flight No. 	
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
					     STA 	
					     </b></span>					 
					 </td>
				
				     <td bgcolor="#0070BA">
					   <span style="color:white;"> <b> 
					     Block  	
					     </b></span>					 
					 </td>
				
				    <td bgcolor="#0070BA" width="30%">
					   <span style="color:white;"> <b> 
					     Comments. 	
					     </b></span>					 
					 </td>
					 
          </tr>  
       	
       	
       	
 		<%int Ctr=1;%>
        <c:forEach var="flightSectorLog" items="${flightSectorList}">          
        
            
             
            <c:if test = "${(flightReport.crewid == flightSectorLog.flightCaption) || (flightReport.crewid == flightSectorLog.flightFirstOfficer)}">

    
				     <tr align="center" bgcolor="#ffffcc">
								    
								    <td>    
									    <b> 
								           <%=Ctr%>.
								    	   	 <script language="javascript"> 	
										   		 document.getElementById("crewList<%=rowCtr%>").innerHTML="${flightSectorLog.allCrewOfThisFlight}";
										   	 </script>
									     </b>				 
									 </td>
									  
								    <td>
									      ${flightSectorLog.getFlightDatop()}  
									  
									 		 
									 </td>
									 
									<td>
									
									    ${flightSectorLog.aircraftReg}   
									      
									 </td>
									
									<td>
									    
									    ${flightSectorLog.flightNo}   
									  
									 </td>
									
									<td>
									      
									    ${flightSectorLog.from}   
									   
									 </td>
									
									<td>
									       ${flightSectorLog.to}     
									 </td>
									<td>
									  
									       ${flightSectorLog.std}   
									    			 
									 </td>
									<td>
									        ${flightSectorLog.sta}	 
									 </td>
									<td>
								
									       ${flightSectorLog.getStaMinusStd()}  
										 
									 </td>
									 
									<td align="left">
		
		                                     
									      <c:set var = "len"  value = "${fn:length(flightSectorLog.sectorComments1)}"/>
									      <c:if test = "${len > 0}">
										     CX:${flightSectorLog.sectorComments1}
										  </c:if>					
										  
										  <c:set var = "len"  value = "${fn:length(flightSectorLog.sectorComments2)}"/>
									       <c:if test = "${len > 0}">
										     &nbsp;${flightSectorLog.sectorComments2} 
										  </c:if>					
										  
										  
										  <c:set var = "len"  value = "${fn:length(flightSectorLog.sectorComments3)}"/>
									       <c:if test = "${len > 0}">
										     &nbsp;Cleaning: ${flightSectorLog.sectorComments3} 
										  </c:if>					
										  
										  
										  <c:set var = "len"  value = "${fn:length(flightSectorLog.sectorComments4)}"/>
									       <c:if test = "${len > 0}">
										     &nbsp;${flightSectorLog.sectorComments4} 
										  </c:if>					
										  
									 </td>
									 
					      </tr> 
					       <% Ctr = Ctr +1;%>
					       
					     </c:if>     
      
        </c:forEach>      
        
   
        <tr>
	          <td colspan="10" align="right" bgcolor="white">		    	      
        	     <button onclick="printOneReport('${flightReport.crewid}');" type="button" class="btn  btn-sm"> 
        	        <img src="pdf.png"> &nbsp;<b> View - Print - Download  </b> &nbsp;<i class="fa fa-print fa-lg" aria-hidden="true"></i>
        	      </button>
        	      
		      </td>
		</tr>                             
                       	
       	
         
           
	      <c:set var = "rowcount"  value = "${fn:length(captionlist)}"/>
	      <c:if test = "${rowcount == 0}">
		      <tr>
	               <td colspan="10" align="center">
		                Sorry There is no Flight Scheduled ........
	               </td>
	          </tr>
               </c:if> 	

            
	 </table>  
	</div>	 
</div>
</div>	   
   <%rowCtr++;%>
   
   </c:forEach>  
       



</div>

<br>
<br>
<br>
<br>

<%@include file="../include/footer.jsp" %>




