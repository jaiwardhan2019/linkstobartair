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
	print();
}



function showOtherdDateCaption(){

         
    	  document.voygerReport.method="POST"
		  document.voygerReport.action="voyagerReport?emailid=${emailid}";
	      document.voygerReport.submit();
		  return true;
         

}



	
</script>


 <br>
 <br>

 <br>
 <br>

 
   
 <div class="container" align="center">
 
 <div class="col-md-12 col-sm-12 col-xs-12" align="center" id="printButton">
 
 <form name="voygerReport" id="voygerReport">  
  
      <input type="hidden" name="emailid" id="emailid" value="<%=request.getParameter("emailid")%>">
      <input type="hidden" name="password" id="password" value="<%=request.getParameter("password")%>">
          <table class="table table-striped table-bordered" border="1" style="width: 30%;" align="center">	    
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
   </div>
  </div>		
</form>
 

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
  <input type="button" class="btn btn-primary" value=" Print Report With Data" onclick="printVoygerReport();" /> 
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
   
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




<!-- JAI  -->



<div id="voygerreportprint"  class="flightReportBox" >

<div id="report-wrapper">
		<div id="flightReportHeader">
			<table>
				<tr>
					<td >						
						<img src="images/logo_on_white.png"/>
					</td>
					<th id="flightReportHeaderCenter">Flight Report</th>
					<th id="flightReportHeaderRight">
	
			
							<table>
									<tr>
										<td>Tail Reg:</td>
										<td>
										
										</td>
									</tr>
									<tr>
										<td>Fuel On Board:</td>
										<td>
											
										</td>
									</tr>
								</table>
					</th>
				</tr>
			</table>
		</div>
	
	
		<!-- SECTION 1 -->
		<div id="flightReportBody">
			<table id="section1" border="0" >
				<tr>
					<td id="flightData-wrapper" align="center">
		
						<table id="flightData" class="subSection">
							<caption> 
							  FLIGHT DATA 
							</caption>
							
							<tr class="print-only">
								<th >Sec.</th>
								<th >Date</th>
								<th >Reg</th>
								<th >Flt. No.</th>
							</tr>
							
							<tr class="print-only">
								<td class="columnData sectorId ">1</td>
								<td class="columnData flightDate"></td>
								<td class="columnData regNo"></td>
								<td class="columnData fltNo"></td>
							</tr>
							<tr class="print-only">
								<td class="columnData sectorId ">2</td>
								<td class="columnData flightDate"></td>
								<td class="columnData regNo"></td>
								<td class="columnData fltNo"></td>
							</tr>
						
							<tr class="print-only">
								<td class="columnData sectorId ">3</td>
								<td class="columnData flightDate"></td>
								<td class="columnData regNo"></td>
								<td class="columnData fltNo"></td>
							</tr>
						
							<tr class="print-only">
								<td class="columnData sectorId ">4</td>
								<td class="columnData flightDate"></td>
								<td class="columnData regNo"></td>
								<td class="columnData fltNo"></td>
							</tr>
						
						
							<tr class="print-only">
								<td class="columnData sectorId">5</td>
								<td class="columnData flightDate">&nbsp;</td>
								<td class="columnData regNo">&nbsp;</td>
								<td class="columnData fltNo">&nbsp;</td>
							</tr>
						
							<tr class="print-only">
								<td class="columnData sectorId">6</td>
								<td class="columnData flightDate">&nbsp;</td>
								<td class="columnData regNo">&nbsp;</td>
								<td class="columnData fltNo">&nbsp;</td>
							</tr>
						
							<tr class="print-only">
								<td class="columnData sectorId">7</td>
								<td class="columnData flightDate">&nbsp;</td>
								<td class="columnData regNo">&nbsp;</td>
								<td class="columnData fltNo">&nbsp;</td>
							</tr>
						
						
						</table>
					</td>
					<td id="sectorData-wrapper" align="center">
					
						<table id="sectorData" class="subSection">
							<caption>SECTOR</caption>
							<tr class="print-only">
								<th class="columnHeader sectorId">Sec.</th>
								<th class="columnHeader destFrom">From</th>
								<th class="columnHeader destTo">To</th>
							</tr>
							<tr class="print-only">
								<td class="columnData sectorId">&nbsp;</td>
								<td class="columnData destFrom">&nbsp;</td>
								<td class="columnData destTo">&nbsp;</td>
							</tr>
							<tr class="print-only">
								<td class="columnData sectorId">&nbsp;</td>
								<td class="columnData destFrom">&nbsp;</td>
								<td class="columnData destTo">&nbsp;</td>
							</tr>
							<tr class="print-only">
								<td class="columnData sectorId">&nbsp;</td>
								<td class="columnData destFrom">&nbsp;</td>
								<td class="columnData destTo">&nbsp;</td>
							</tr>
							<tr class="print-only">
								<td class="columnData sectorId">&nbsp;</td>
								<td class="columnData destFrom">&nbsp;</td>
								<td class="columnData destTo">&nbsp;</td>
							</tr>
						
							
							<tr class="print-only">
								<td class="columnData sectorId">&nbsp;</td>
								<td class="columnData destFrom">&nbsp;</td>
								<td class="columnData destTo">&nbsp;</td>
							</tr>
						
							<tr class="print-only">
								<td class="columnData sectorId">&nbsp;</td>
								<td class="columnData destFrom">&nbsp;</td>
								<td class="columnData destTo">&nbsp;</td>
							</tr>
						
							<tr class="print-only">
								<td class="columnData sectorId">&nbsp;</td>
								<td class="columnData destFrom">&nbsp;</td>
								<td class="columnData destTo">&nbsp;</td>
							</tr>
						
						</table>
					</td>
					<td id="scheduleData-wrapper" align="center">
						<table id="scheduleData" class="subSection">
							<caption>SCHEDULE</caption>
							<tr class="print-only">
								<th class="columnHeader sectorId">Sec.</th>
								<th class="columnHeader std">STD</th>
								<th class="columnHeader sta">STA</th>
								<th class="columnHeader onBlock">Block</th>
							</tr>
						
						
							<tr class="print-only">
								<td class="columnData sectorId">&nbsp;</td>
								<td class="columnData std">&nbsp;</td>
								<td class="columnData sta">&nbsp;</td>
								<td class="columnData onBlock">&nbsp;</td>
							</tr>
						
							<tr class="print-only">
								<td class="columnData sectorId">&nbsp;</td>
								<td class="columnData std">&nbsp;</td>
								<td class="columnData sta">&nbsp;</td>
								<td class="columnData onBlock">&nbsp;</td>
							</tr>
						
							<tr class="print-only">
								<td class="columnData sectorId">&nbsp;</td>
								<td class="columnData std">&nbsp;</td>
								<td class="columnData sta">&nbsp;</td>
								<td class="columnData onBlock">&nbsp;</td>
							</tr>
						
							<tr class="print-only">
								<td class="columnData sectorId">&nbsp;</td>
								<td class="columnData std">&nbsp;</td>
								<td class="columnData sta">&nbsp;</td>
								<td class="columnData onBlock">&nbsp;</td>
							</tr>
					
								
								
									
								
									
								
						
							<tr class="print-only">
								<td class="columnData sectorId">&nbsp;</td>
								<td class="columnData std">&nbsp;</td>
								<td class="columnData sta">&nbsp;</td>
								<td class="columnData onBlock">&nbsp;</td>
							</tr>
						
							<tr class="print-only">
								<td class="columnData sectorId">&nbsp;</td>
								<td class="columnData std">&nbsp;</td>
								<td class="columnData sta">&nbsp;</td>
								<td class="columnData onBlock">&nbsp;</td>
							</tr>
						
							<tr class="print-only">
								<td class="columnData sectorId">&nbsp;</td>
								<td class="columnData std">&nbsp;</td>
								<td class="columnData sta">&nbsp;</td>
								<td class="columnData onBlock">&nbsp;</td>
							</tr>
						
						
						</table>
					</td>
					<td id="timeData-wrapper" align="center">
						<table id="timeData" class="subSection">
							<caption>ACTUAL TIME</caption>
							<tr>
								<th class="columnHeader sectorId">Sec.</th>
								<th class="columnHeader outOff">Out/Off</th>
								<th class="columnHeader landOnBlk">Land/On Blk</th>
								<th class="columnHeader onBlock">Block</th>
								<th class="columnHeader airTime">Air Time</th>
							</tr>
						
							
								
									
								
								
							
							<tr class="print-only">
								<td class="columnData sectorId">1</td>
								<td class="columnData outOff">&nbsp;</td>
								<td class="columnData landOnBlk">&nbsp;</td>
								<td class="columnData onBlock">&nbsp;</td>
								<td class="columnData airTime">&nbsp;</td>
							</tr>
						
							
								
								
									
								
							
							<tr class="print-only">
								<td class="columnData sectorId">2</td>
								<td class="columnData outOff">&nbsp;</td>
								<td class="columnData landOnBlk">&nbsp;</td>
								<td class="columnData onBlock">&nbsp;</td>
								<td class="columnData airTime">&nbsp;</td>
							</tr>
						
							
								
									
								
								
							
							<tr class="print-only">
								<td class="columnData sectorId">3</td>
								<td class="columnData outOff">&nbsp;</td>
								<td class="columnData landOnBlk">&nbsp;</td>
								<td class="columnData onBlock">&nbsp;</td>
								<td class="columnData airTime">&nbsp;</td>
							</tr>
						
							
								
								
									
								
							
							<tr class="print-only">
								<td class="columnData sectorId">4</td>
								<td class="columnData outOff">&nbsp;</td>
								<td class="columnData landOnBlk">&nbsp;</td>
								<td class="columnData onBlock">&nbsp;</td>
								<td class="columnData airTime">&nbsp;</td>
							</tr>
						
						
						
							<tr class="print-only">
								<td class="columnData sectorId">5</td>
								<td class="columnData outOff">&nbsp;</td>
								<td class="columnData landOnBlk">&nbsp;</td>
								<td class="columnData onBlock">&nbsp;</td>
								<td class="columnData airTime">&nbsp;</td>
							</tr>
						
							<tr class="print-only">
								<td class="columnData sectorId">6</td>
								<td class="columnData outOff">&nbsp;</td>
								<td class="columnData landOnBlk">&nbsp;</td>
								<td class="columnData onBlock">&nbsp;</td>
								<td class="columnData airTime">&nbsp;</td>
							</tr>
						
							<tr class="print-only">
								<td class="columnData sectorId">7</td>
								<td class="columnData outOff">&nbsp;</td>
								<td class="columnData landOnBlk">&nbsp;</td>
								<td class="columnData onBlock">&nbsp;</td>
								<td class="columnData airTime">&nbsp;</td>
							</tr>
						
						
						</table>
					</td>
					<td id="paxData-wrapper" align="center">
						<table id="paxData" class="subSection">
							<caption>Pax</caption>
							<tr>
								<th class="columnHeader sectorId">Sec.</th>
								<th class="columnHeader bookedPax">Book</th>
								<th class="columnHeader actPax">Act</th>
							</tr>
						
							
							<tr class="odd">
								<td class="columnData sectorId">1</td>
								<td class="columnData bookedPax">&nbsp;&nbsp;</td>
								<td class="columnData actPax">&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;</td>
							</tr>
							<tr class="even">
								<td class="columnData sectorId">2</td>
								<td class="columnData bookedPax">&nbsp;&nbsp;</td>
								<td class="columnData actPax">&nbsp;&nbsp;</td>
							</tr>
						
							
							<tr class="odd">
								<td class="columnData sectorId">3</td>
								<td class="columnData bookedPax">&nbsp;&nbsp;</td>
								<td class="columnData actPax">&nbsp;&nbsp;</td>
							</tr>
								
							<tr class="even">
								<td class="columnData sectorId">4</td>
								<td class="columnData bookedPax">&nbsp;&nbsp;</td>
								<td class="columnData actPax">&nbsp;&nbsp;</td>
							</tr>
						
						
						
							<tr>
								<td class="columnData sectorId">5</td>
								<td class="columnData bookedPax">&nbsp;</td>
								<td class="columnData actPax">&nbsp;&nbsp;</td>
							</tr>
						
							<tr>
								<td class="columnData sectorId">6</td>
								<td class="columnData bookedPax">&nbsp;</td>
								<td class="columnData actPax">&nbsp;</td>
							</tr>
						
							<tr>
								<td class="columnData sectorId">7</td>
								<td class="columnData bookedPax">&nbsp;</td>
								<td class="columnData actPax">&nbsp;&nbsp;</td>
							</tr>
						
						
						</table>
					</td>
					<td id="sectorComments-wrapper" align="center">
						
						<table id="sectorComments" class="subSection">
								<caption>Sector Comments</caption>
								<tr>
									<th class="columnHeader sectorId">Sec.</th>
									<th class="columnHeader sectorId">Comments</th>
								</tr>
										
								
								<tr class="print-only">
									<td class="columnData sectorId">1</td>
									<td class="columnData sectorComments">
									
							
								<tr class="print-only">
									<td class="columnData sectorId">2</td>
									<td class="columnData sectorComments">
									
								<tr class="print-only">
									<td class="columnData sectorId">3</td>
									<td class="columnData sectorComments">
									
								<tr class="print-only">
									<td class="columnData sectorId">4</td>
									<td class="columnData sectorComments">
								
						</table>
					</td>
				</tr>
			</table>
			<!--  END OF SECTION 1 -->
			
			
			
			<!-- SECTION 2 -->
			<table id="section2" border="1" >
				<tr>
					<td id="fuelData-wrapper" align="center">
						<table id="fuelData" class="subSection" >
							
							<caption> 
							   FUEL DATA
							</caption>
							
							<tr>
								<th class="columnHeader sectorId">Sec.</th>
								<th class="columnHeader initWt">Initial Kg.</th>
								<th class="columnHeader fuelUplift">Uplift Ltrs.</th>
								<th class="columnHeader departureWt">Depart Kg.</th>
								<th class="columnHeader arriveWt">Arrive Kg.</th>
								<th class="columnHeader fuelBurn">Burn Kg.</th>
							</tr>
							
							<tr class="odd">
								<td class="columnData sectorId">1</td>
								<td class="columnData initWt">&nbsp;</td>
								<td class="columnData fuelUplift">&nbsp;</td>
								<td class="columnData departureWt">&nbsp;</td>
								<td class="columnData arriveWt">&nbsp;</td>
								<td class="columnData fuelBurn">&nbsp;</td>
							</tr>
						
								
							
							<tr class="even">
								<td class="columnData sectorId">2</td>
								<td class="columnData initWt">&nbsp;</td>
								<td class="columnData fuelUplift">&nbsp;</td>
								<td class="columnData departureWt">&nbsp;</td>
								<td class="columnData arriveWt">&nbsp;</td>
								<td class="columnData fuelBurn">&nbsp;</td>
							</tr>
						
							
							<tr class="odd">
								<td class="columnData sectorId">3</td>
								<td class="columnData initWt">&nbsp;</td>
								<td class="columnData fuelUplift">&nbsp;</td>
								<td class="columnData departureWt">&nbsp;</td>
								<td class="columnData arriveWt">&nbsp;</td>
								<td class="columnData fuelBurn">&nbsp;</td>
							</tr>
							
							
							<tr class="even">
								<td class="columnData sectorId">4</td>
								<td class="columnData initWt">&nbsp;</td>
								<td class="columnData fuelUplift">&nbsp;</td>
								<td class="columnData departureWt">&nbsp;</td>
								<td class="columnData arriveWt">&nbsp;</td>
								<td class="columnData fuelBurn">&nbsp;</td>
							</tr>
						
						
						
							<tr>
								<td class="columnData sectorId">5</td>
								<td class="columnData initWt">&nbsp;</td>
								<td class="columnData fuelUplift">&nbsp;</td>
								<td class="columnData departureWt">&nbsp;</td>
								<td class="columnData arriveWt">&nbsp;</td>
								<td class="columnData fuelBurn">&nbsp;</td>
							</tr>
						
							<tr>
								<td class="columnData sectorId">6</td>
								<td class="columnData initWt">&nbsp;</td>
								<td class="columnData fuelUplift">&nbsp;</td>
								<td class="columnData departureWt">&nbsp;</td>
								<td class="columnData arriveWt">&nbsp;</td>
								<td class="columnData fuelBurn">&nbsp;</td>
							</tr>
						
							<tr>
								<td class="columnData sectorId">7</td>
								<td class="columnData initWt">&nbsp;</td>
								<td class="columnData fuelUplift">&nbsp;</td>
								<td class="columnData departureWt">&nbsp;</td>
								<td class="columnData arriveWt">&nbsp;</td>
								<td class="columnData fuelBurn">&nbsp;</td>
							</tr>
						
						
						</table>
					</td>


					<td id="deIceData-wrapper" align="center">
						<table id="deIceData" class="subSection">
							<caption>De-Ice</caption>
							<tr>
								<th class="columnHeader sectorId">Sec.</th>
								<th class="columnHeader deIceLitres">Litres</th>
							</tr>
						
							<tr class="odd">
								<td class="columnData sectorId">1</td>
								<td class="columnData">&nbsp;</td>
							</tr>
								
							<tr class="even">
								<td class="columnData sectorId">2</td>
								<td class="columnData">&nbsp;</td>
							</tr>
								<tr class="odd">
								<td class="columnData sectorId">3</td>
								<td class="columnData">&nbsp;</td>
							</tr>
							<tr class="even">
								<td class="columnData sectorId">4</td>
								<td class="columnData">&nbsp;</td>
							</tr>
								<tr>
								<td class="columnData sectorId">5</td>
								<td class="columnData">&nbsp;</td>
							</tr>
						
							<tr>
								<td class="columnData sectorId">6</td>
								<td class="columnData">&nbsp;</td>
							</tr>
						
							<tr>
								<td class="columnData sectorId">7</td>
								<td class="columnData">&nbsp;</td>
							</tr>
						
						
						</table>
					</td>

					<td id="delayData-wrapper" align="center">
						<table id="delayData" class="subSection">
							<caption>DELAY</caption>
							<tr>
								<th class="columnHeader sectorId">Sec.</th>
								<th class="columnHeader" colspan="2">Time / Code</th>
								<th class="columnHeader" colspan="2">Time / Code</th>
							</tr>
						
							
								
									
								
								
							
							<tr class="odd">
								<td class="columnData sectorId">1</td>
								<td class="columnData col_time">&nbsp;</td>
								<td class="columnData col_code">&nbsp;</td>
								<td class="columnData col_time">&nbsp;</td>
								<td class="columnData col_code">&nbsp;</td>
							</tr>
						
							
							<tr class="even">
								<td class="columnData sectorId">2</td>
								<td class="columnData col_time">&nbsp;</td>
								<td class="columnData col_code">&nbsp;</td>
								<td class="columnData col_time">&nbsp;</td>
								<td class="columnData col_code">&nbsp;</td>
							</tr>
							
							<tr class="odd">
								<td class="columnData sectorId">3</td>
								<td class="columnData col_time">&nbsp;</td>
								<td class="columnData col_code">&nbsp;</td>
								<td class="columnData col_time">&nbsp;</td>
								<td class="columnData col_code">&nbsp;</td>
							</tr>
							
							<tr class="even">
								<td class="columnData sectorId">4</td>
								<td class="columnData col_time">&nbsp;</td>
								<td class="columnData col_code">&nbsp;</td>
								<td class="columnData col_time">&nbsp;</td>
								<td class="columnData col_code">&nbsp;</td>
							</tr>
						
						
						
							<tr>
								<td class="columnData sectorId">5</td>
								<td class="columnData col_time">&nbsp;</td>
								<td class="columnData col_code">&nbsp;</td>
								<td class="columnData col_time">&nbsp;</td>
								<td class="columnData col_code">&nbsp;</td>
							</tr>
						
							<tr>
								<td class="columnData sectorId">6</td>
								<td class="columnData col_time">&nbsp;</td>
								<td class="columnData col_code">&nbsp;</td>
								<td class="columnData col_time">&nbsp;</td>
								<td class="columnData col_code">&nbsp;</td>
							</tr>
						
							<tr>
								<td class="columnData sectorId">7</td>
								<td class="columnData col_time">&nbsp;</td>
								<td class="columnData col_code">&nbsp;</td>
								<td class="columnData col_time">&nbsp;</td>
								<td class="columnData col_code">&nbsp;</td>
							</tr>
						
						
						</table>
					</td>
					<td id="catiiData-wrapper" align="center">	
						<table id="catiiData" class="subSection">
							<caption>CAT II</caption>
							<tr>
								<th class="columnHeader sectorId">Sec.</th>
								<th class="columnHeader rwy">Rwy</th>
								<th class="columnHeader satis">Satis</th>
								<th class="columnHeader unsatis">Unsatis</th>
							</tr>
						
							
								
									
								
								
							
							<tr class="odd">
								<td class="columnData sectorId">1</td>
								<td class="columnData">&nbsp;</td>
								<td class="columnData">&nbsp;</td>
								<td class="columnData">&nbsp;</td>
							</tr>
						
							
								
								
									
								
							
							<tr class="even">
								<td class="columnData sectorId">2</td>
								<td class="columnData">&nbsp;</td>
								<td class="columnData">&nbsp;</td>
								<td class="columnData">&nbsp;</td>
							</tr>
						
							
								
									
								
								
							
							<tr class="odd">
								<td class="columnData sectorId">3</td>
								<td class="columnData">&nbsp;</td>
								<td class="columnData">&nbsp;</td>
								<td class="columnData">&nbsp;</td>
							</tr>
						
							
								
								
									
								
							
							<tr class="even">
								<td class="columnData sectorId">4</td>
								<td class="columnData">&nbsp;</td>
								<td class="columnData">&nbsp;</td>
								<td class="columnData">&nbsp;</td>
							</tr>
						
						
						
							<tr>
								<td class="columnData sectorId">5</td>
								<td class="columnData">&nbsp;</td>
								<td class="columnData">&nbsp;</td>
								<td class="columnData">&nbsp;</td>
							</tr>
						
							<tr>
								<td class="columnData sectorId">6</td>
								<td class="columnData">&nbsp;</td>
								<td class="columnData">&nbsp;</td>
								<td class="columnData">&nbsp;</td>
							</tr>
						
							<tr>
								<td class="columnData sectorId">7</td>
								<td class="columnData">&nbsp;</td>
								<td class="columnData">&nbsp;</td>
								<td class="columnData">&nbsp;</td>
							</tr>
						
						
						</table>
					</td>
				</tr>
			</table>
			<!--  END OF SECTION 2 -->
		
			<!-- SECTION 3 -->
			<table id="section3" border="1">
				<tr>
					<td id="crewData-wrapper" align="center">					
						<table id="crewData" class="subSection" width="100%">
							<thead>
								<tr>
									<th class="columnHeader sectorsOperated" rowspan="2" width="30%">CREW NAMES</th>
									<th class="columnHeader sectorsOperated" colspan="7">Sectors Operated</th>
									<th class="columnHeader dutyTimes" colspan="2">DUTY TIMES</th>
								</tr>
								<tr>
									
										<td class="columnHeader sectorsOperated">1</td>
									
										<td class="columnHeader sectorsOperated">2</td>
									
										<td class="columnHeader sectorsOperated">3</td>
									
										<td class="columnHeader sectorsOperated">4</td>
									
										<td class="columnHeader sectorsOperated">5</td>
									
										<td class="columnHeader sectorsOperated">6</td>
									
										<td class="columnHeader sectorsOperated">7</td>
									
									<td class="columnHeader onDuty">On Duty</td>
									<td class="columnHeader offDuty">Off Duty</td>
								</tr>
							</thead>
							<tbody>
						<!-- Loop through each crew members -->	
							
							
								
									
										
									
									
								
								<tr class="odd">
									    
									    <td class="columnData sectorsOperated" >&nbsp;&nbsp;</td>
									
									<td class="columnData sectorsOperated">&nbsp;&nbsp;&nbsp;&nbsp;</td>
									
										<td class="columnData sectorsOperated">&nbsp;&nbsp;&nbsp;&nbsp;</td>
									
										<td class="columnData sectorsOperated">&nbsp;&nbsp;&nbsp;&nbsp;</td>
									
										<td class="columnData sectorsOperated">&nbsp;&nbsp;&nbsp;&nbsp;</td>
									
										<td class="columnData sectorsOperated">&nbsp;&nbsp;&nbsp;&nbsp;</td>
									
										<td class="columnData sectorsOperated">&nbsp;&nbsp;&nbsp;&nbsp;</td>
									
										<td class="columnData sectorsOperated">&nbsp;&nbsp;&nbsp;&nbsp;</td>
								
									<td class="columnData onDuty">&nbsp;</td>
									<td class="columnData offDuty">&nbsp;</td>
								</tr>
							
								
									
									
										
									
			
								<tr class="odd">
									    
									    <td class="columnData sectorsOperated" >&nbsp;&nbsp;</td>
									
									<td class="columnData sectorsOperated">&nbsp;&nbsp;&nbsp;&nbsp;</td>
									
										<td class="columnData sectorsOperated">&nbsp;&nbsp;&nbsp;&nbsp;</td>
									
										<td class="columnData sectorsOperated">&nbsp;&nbsp;&nbsp;&nbsp;</td>
									
										<td class="columnData sectorsOperated">&nbsp;&nbsp;&nbsp;&nbsp;</td>
									
										<td class="columnData sectorsOperated">&nbsp;&nbsp;&nbsp;&nbsp;</td>
									
										<td class="columnData sectorsOperated">&nbsp;&nbsp;&nbsp;&nbsp;</td>
									
										<td class="columnData sectorsOperated">&nbsp;&nbsp;&nbsp;&nbsp;</td>
									
									<td class="columnData onDuty">&nbsp;</td>
									<td class="columnData offDuty">&nbsp;</td>
								</tr>
							
								
									<tr class="odd">
									    
									    <td class="columnData sectorsOperated" >&nbsp;&nbsp;</td>
									
										<td class="columnData sectorsOperated">&nbsp;&nbsp;&nbsp;&nbsp;</td>
									
										<td class="columnData sectorsOperated">&nbsp;&nbsp;&nbsp;&nbsp;</td>
									
										<td class="columnData sectorsOperated">&nbsp;&nbsp;&nbsp;&nbsp;</td>
									
										<td class="columnData sectorsOperated">&nbsp;&nbsp;&nbsp;&nbsp;</td>
									
										<td class="columnData sectorsOperated">&nbsp;&nbsp;&nbsp;&nbsp;</td>
									
										<td class="columnData sectorsOperated">&nbsp;&nbsp;&nbsp;&nbsp;</td>
									
										<td class="columnData sectorsOperated">&nbsp;&nbsp;&nbsp;&nbsp;</td>
									
									<td class="columnData onDuty">&nbsp;</td>
									<td class="columnData offDuty">&nbsp;</td>
								</tr>
														
									
										
									
									
			
								<tr class="odd">
									    
									    <td class="columnData sectorsOperated" >&nbsp;&nbsp;</td>
									
									<td class="columnData sectorsOperated">&nbsp;&nbsp;&nbsp;&nbsp;</td>
									
										<td class="columnData sectorsOperated">&nbsp;&nbsp;&nbsp;&nbsp;</td>
									
										<td class="columnData sectorsOperated">&nbsp;&nbsp;&nbsp;&nbsp;</td>
									
										<td class="columnData sectorsOperated">&nbsp;&nbsp;&nbsp;&nbsp;</td>
									
										<td class="columnData sectorsOperated">&nbsp;&nbsp;&nbsp;&nbsp;</td>
									
										<td class="columnData sectorsOperated">&nbsp;&nbsp;&nbsp;&nbsp;</td>
									
										<td class="columnData sectorsOperated">&nbsp;&nbsp;&nbsp;&nbsp;</td>
									
									<td class="columnData onDuty">&nbsp;</td>
									<td class="columnData offDuty">&nbsp;</td>
								</tr>
														
									
								
									<tr class="print-only">
										<td class="columnData crewName">&nbsp;</td>
									
										<td class="columnData sectorsOperated">&nbsp;</td>
									
										<td class="columnData sectorsOperated">&nbsp;</td>
									
										<td class="columnData sectorsOperated">&nbsp;</td>
									
										<td class="columnData sectorsOperated">&nbsp;</td>
									
										<td class="columnData sectorsOperated">&nbsp;</td>
									
										<td class="columnData sectorsOperated">&nbsp;</td>
									
										<td class="columnData sectorsOperated">&nbsp;</td>
									
										<td class="columnData onDuty">&nbsp;</td>
										<td class="columnData offDuty">&nbsp;</td>
									</tr>
								
									<tr class="print-only">
										<td class="columnData crewName">&nbsp;</td>
									
										<td class="columnData sectorsOperated">&nbsp;</td>
									
										<td class="columnData sectorsOperated">&nbsp;</td>
									
										<td class="columnData sectorsOperated">&nbsp;</td>
									
										<td class="columnData sectorsOperated">&nbsp;</td>
									
										<td class="columnData sectorsOperated">&nbsp;</td>
									
										<td class="columnData sectorsOperated">&nbsp;</td>
									
										<td class="columnData sectorsOperated">&nbsp;</td>
									
										<td class="columnData onDuty">&nbsp;</td>
										<td class="columnData offDuty">&nbsp;</td>
									</tr>
								
							
							</tbody>
						</table>
					</td>
					<td id="catiiReasonData-wrapper" align="center">
						<table id="catiiReasonData" class="subSection">
							<thead>
								<tr>
									<th class="columnHeader" colspan="2">Reason for Unsatisfactory CAT II<br/>Approach</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td class="columnData reason">Airborne Equipment</td><td class="columnData check-box">&nbsp;</td>
								</tr>
								<tr>
									<td class="columnData reason">Ground Facilities</td><td class="columnData check-box">&nbsp;</td>
								</tr>
								<tr>
									<td class="columnData reason">Air Traffic Control</td><td class="columnData check-box">&nbsp;</td>
								</tr>
								<tr>
									<td class="columnData reason">Other</td><td class="columnData check-box">&nbsp;</td>
								</tr>
								<tr>
									<td class="columnData reason">Details</td><td class="columnData check-box">&nbsp;</td>
								</tr>
								<tr>
									<td colspan="2" class="columnData">&nbsp;</td>
								</tr>
								<tr>
									<td colspan="2" class="columnData">&nbsp;</td>
								</tr>
							</tbody>
						</table>
					</td>
				</tr>
			</table>	
			<!--  END OF SECTION 3 -->
			
			<!-- SECTION 4 -->
			<table id="section4" border="1">
				<tr>
					<td align="center">
						<table id="miscData" class="subSection">
							<caption>SECTOR COMMENTS</caption>
							<tr>
								<th class="columnHeader sectorId" width="9%">Sec.</th>
								<th class="columnHeader fltNo" width="9%">Flt. No</th>
								<th class="columnHeader acReg" width="9%">A/C Reg.</th>
								<th class="columnHeader comments" width="73%">Comments</th>
							</tr>
							
								  <tr>
										<td class="columnData sectorId"></td>
										<td class="columnData fltNo">&nbsp;</td>
										<td class="columnData acReg">&nbsp;</td>
										<td class="columnData comments">
										&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										</td>
									</tr>
								
									
								  <tr>
										<td class="columnData sectorId"></td>
										<td class="columnData fltNo">&nbsp;</td>
										<td class="columnData acReg">&nbsp;</td>
										<td class="columnData comments">
										&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										</td>
									</tr>
								
								  <tr>
										<td class="columnData sectorId"></td>
										<td class="columnData fltNo">&nbsp;</td>
										<td class="columnData acReg">&nbsp;</td>
										<td class="columnData comments">
										&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										</td>
									</tr>
								
									  <tr>
										<td class="columnData sectorId"></td>
										<td class="columnData fltNo">&nbsp;</td>
										<td class="columnData acReg">&nbsp;</td>
										<td class="columnData comments">
										&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										</td>
									</tr>
								
								  <tr>
										<td class="columnData sectorId"></td>
										<td class="columnData fltNo">&nbsp;</td>
										<td class="columnData acReg">&nbsp;</td>
										<td class="columnData comments">
										&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										</td>
									</tr>
								
								  <tr>
										<td class="columnData sectorId"></td>
										<td class="columnData fltNo">&nbsp;</td>
										<td class="columnData acReg">&nbsp;</td>
										<td class="columnData comments">
										&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										</td>
									</tr>
								
								  <tr>
										<td class="columnData sectorId"></td>
										<td class="columnData fltNo">&nbsp;</td>
										<td class="columnData acReg">&nbsp;</td>
										<td class="columnData comments">
										&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										</td>
									</tr>
								
							
							<tr class="freespace">
								<td class="columnData" colspan="4">&nbsp;</td>
							</tr>
						</table>
					</td>
				</tr>
						
				<tr>
					<td align="center">
						<table id="signatureAndFooterData" class="subSection">
							<tr id="signatureRow">
								<td class="columnData signatureHeader">Captains' Signature:</td>
							</tr>
							<tr>
								<td class="columnData footerNotice">Please Ensure Flight Report is transmitted to Operations via FAX, SCAN, or EMAIL. This copy to remain with flight envelope.</td>
							</tr>
						</table>
						</td>
					</tr>
				</table>
			<!--  END OF SECTION 4 -->
		</div>
		<!--  END OF BODY -->
	</div>
</div>
    

<br>
<br>
<br>




<!--

<div id="voygerreport" style="background-color: green;"> 
          
        <h2>Flight Report</h2> 
          
        <p> 
            This is inside the div and will be printed 
            on the screen after the click. 
        </p> 
    </div> 
      
    <input type="button" value="click" onclick="printVoygerReport()"> 


function printVoygerReport() {
	
    var divContents = document.getElementById("voygerreport").innerHTML; 
    var a = window.open('', ''); 
    a.document.write(divContents); 
    a.document.close(); 
    a.print(); 
} 

-->

