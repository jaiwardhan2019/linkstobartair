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


function showmyVoygerReport(){
	   
	  	  document.voygerReport.method="POST";
		  document.voygerReport.action="voyagerReport";
	      document.voygerReport.submit();
		  return true;
     
		
}//---------- End Of Function  ------------------



function printVoygerReport() {
	//print();
	alert("Under Construction.. Please Use the Blank report By the time");	
} 

function printVoygerReport_Blank(){
	
	  document.voygerReport.method="POST";
      document.voygerReport.target="_new";
	  document.voygerReport.action="voyagerReportblankpdf";
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
														         <option value="${caplst.getCrewid()}" selected>CAP -  ${caplst.getCrewName()}- (${caplst.getCrewid()})</option>
												              </c:if> 
														      
														      <c:if test = "${caplst.getCrewid() != selectedcaption}">
														         <option value="${caplst.getCrewid()}">CAP -  ${caplst.getCrewName()}- (${caplst.getCrewid()})</option>
												              </c:if> 
												
														 </c:forEach>
														 
													</select>
										</div>
									</div>
									
								
							
							
							
								
									</td>
									
							  </tr>	
									 
							     
							    <tr align="center"> 
							     					
									<td  bgcolor="white">
								       <!-- 
								       <input id="Show Report"  class="ibutton" type="button" onclick="showmyVoygerReport();" value="Show Report" />
								       <a onclick="showmyVoygerReport();" class="btn btn-success"><i class="fa fa-plane fa-fw"></i> Click Me</a>
								        -->
								       <input type="button" class="btn btn-primary" value="Show Report" onclick="showmyVoygerReport();" /> 
								       
								     </td>
								     </tr>
							     
										    
							    </tbody>
						</table>
						</form>
             </div>
           </div>		

      </div>
  </div>		
 

<!--  END of UPPER FORM PART   -->






<!--  START OF REPORT  PART   -->

<div class="container" style="font-size:90%" id="printButton">

<table class="table table-striped table-bordered" border="1" style="width:20%;" align="left">
	<tr>
	    <td colspan="2" align="center" bgcolor="#0070BA">
	          <span style="color:white;" > <b> 
					    Crew Detail 
		 </b></span>	
	   </td>
	   
	</tr>
	
	<tr>
   
	   <td width="80%" bgcolor="#FCF3CF">
	       <b>Crew Name </b>  
	   </td>
	   
	</tr>
	
	<tr>
	   
	   <td width="80%" bgcolor="#FCF3CF">
	       <b>Crew Name </b>   
	   </td>
	   
   </tr>
   
</table>


<p align="center">
<!-- 
  <input type="button" class="btn btn-primary" value=" Print Report With Data" onclick="printVoygerReport();" /> 
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
   -->

   
  <span onClick="printVoygerReport_Blank();"  class="btn btn-success"><i class="fa fa-print" aria-hidden="true"></i> Print Blank Report </span>
  		            
	  
 
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
       	
	     <tr align="center" bgcolor="#FCF3CF">
				    
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
					 
					 </td>
					 
	      </tr>     
         
      
            
 </table>           



</div>



