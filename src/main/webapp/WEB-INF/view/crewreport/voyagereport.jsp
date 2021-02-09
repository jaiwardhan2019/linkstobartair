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


function showmyCrewFlightSchedule(){
	   
	  	  document.voygerReport.method="POST";
		  document.voygerReport.action="voyagerReport";
	      document.voygerReport.submit();
		  return true;
     
		
}//---------- End Of Function  ------------------


function printVoygerReport(category){

	  var sel = document.getElementById('crewcode');
	  if(category == 'BLANK'){sel.value="BLANK";}		
	  document.voygerReport.method="POST";
	  document.voygerReport.target="_new";
	  document.voygerReport.action="voyagerReportblankpdfWithFLTTemplet";
      document.voygerReport.submit();
	  return true;
}



function showOtherdDateCaption(){
	
    	  document.voygerReport.method="POST"
		  document.voygerReport.action="voyagerReport";
	      document.voygerReport.submit();
		  return true;
    
}




</script>

<style>

tr:nth-child(even) {
  background-color: #dddddd;
}

</style>


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
								    Voyager  Report  &nbsp;&nbsp;
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
													
														<option value="ALL"> All  -   CAPTAINS</option>
														 <c:forEach var="caplst" items="${captionlist}"> 
															     <c:if test = "${caplst.getCrewid() == selectedcaption}">
														         <option value="${caplst.getCrewid()}" selected>CAP -  ${caplst.getCrewFullName()} - (${caplst.getCrewid()})</option>
														         
												              </c:if> 
														      
														      <c:if test = "${caplst.getCrewid() != selectedcaption}">
														         <option value="${caplst.getCrewid()}">CAP - ${caplst.getCrewFullName()}- (${caplst.getCrewid()})</option>
												              </c:if> 
												
														 </c:forEach>
														 <option value="BLANK">-- BLANK --</option>
														 
													</select>
										</div>
									</div>
									
								
							
							
							
								
									</td>
									
							  </tr>	
									 
							     
							    <tr align="center"> 
							     					
									<td  bgcolor="white">
								       <!-- 
								       <input id="Show Report"  class="ibutton" type="button" onclick="showmyCrewFlightSchedule();" value="Show Report" />
								       <a onclick="showmyCrewFlightSchedule();" class="btn btn-success"><i class="fa fa-plane fa-fw"></i> Click Me</a>
								        -->
								       <input type="button" class="btn btn-primary" value="Show Report" onclick="showmyCrewFlightSchedule();" /> 
								       
								     </td>
								     </tr>
							     
										    
							    </tbody>
						</table>
						</form>
             </div>
           </div>		

   
				 <div class="col-md-2 col-md-offset-10 col-sm-12 col-xs-12">		
				   
				  <button  onclick="printVoygerReport('BLANK');"  type="button" class="btn btn-info btn-sm"> <b>Print Blank Sheet  </b> &nbsp;<i class="fa fa-print fa-lg" aria-hidden="true"></i></button>
				
				    
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



<div class="container" id="printButton">

 <table class="table table-striped table-bordered" border="1" style="width: 100%;" align="center">	
		
	     <tr align="center">
				    
				    <td bgcolor="#0070BA">
					   <span style="color:white;" > <b> 
					    Sec.	
					     </b></span>					 
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
       	
	     <tr align="center" >
				    
				    <td>
					    <b> 
					       1. 
					     </b>				 
					 </td>
					  
				    <td>
					      Add Profile  
					 		 
					 </td>
					<td>
					      Add Profile  
					 </td>
					<td>
					      Add Profile  
					 </td>
					<td>
					      Add Profile  
					 </td>
					<td>
					      Add Profile  
					 </td>
					<td>
					  
					      Add Profile  
					    			 
					 </td>
					<td>
					  
					      Add Profile  
							 
					 </td>
					<td>
				
					      Add Profile  
						 
					 </td>
					<td>
			
					      Add Profile  
			      	    <button onclick="printVoygerReport('CREW');"  type="button" class="btn btn-success btn-sm"> <b> Print </b> &nbsp;<i class="fa fa-print fa-lg" aria-hidden="true"></i></button>
			
					 
					 </td>
					 
	      </tr>     
         
             	
	     <tr align="center" >
				    
				    <td>
					    <b> 
					       1. 
					     </b>				 
					 </td>
					  
				    <td>
					      Add Profile  
					 		 
					 </td>
					<td>
					      Add Profile  
					 </td>
					<td>
					      Add Profile  
					 </td>
					<td>
					      Add Profile  
					 </td>
					<td>
					      Add Profile  
					 </td>
					<td>
					  
					      Add Profile  
					    			 
					 </td>
					<td>
					  
					      Add Profile  
							 
					 </td>
					<td>
				
					      Add Profile  
						 
					 </td>
					<td>
			
					      Add Profile  
			      	    <button onclick="printVoygerReport('CREW');"  type="button" class="btn btn-success btn-sm"> <b> Print </b> &nbsp;<i class="fa fa-print fa-lg" aria-hidden="true"></i></button>
			
					 
					 </td>
					 
	      </tr>     
         
      
            
 </table>           



</div>



