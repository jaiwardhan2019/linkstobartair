<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8"/>
		<title></title>
		<style>

	body {
		height: 100%;		
		margin: 0;
	}
	
	#report-wrapper {
		width:100%;
		font-family: arial,verdana;
		border:1px solid #000000;
		font-size: 10pt;
	}
	
	#flightReportHeader {
		border:0px solid #000000;
		width:100%;
	}
	
	#flightReportHeader th {
		width:33.33%;
	
	}
	
	#flightReportHeaderLeft {
		text-align:center;
	}
	
	#flightReportHeaderCenter {
		text-align:center;		
		font-size: 20pt;
	}
	
	#flightReportHeaderRight {

	}
	
		
	#initialData {
		 width:100%;
		 table-layout: auto;
		 font-size: 10pt;
	}
	
	
	#flightReportBody {
		width: 100%;
	}
	
	#flightReportBody td {
		padding-top:2pt;
		border:1px solid #000000;
	}
	
	#section1>tr>td, #section2>tr>td, #section3>tr>td, #section4>tr>td {
		border:1px solid #000000;
		text-align:center;
	}
	
	.subSection {
		font-size: 8pt;
		font-weight: normal;
		border-collapse: collapse;
	}
	
	.subSection td, .subSection th{
		padding-left:2pt;
		padding-right:2pt;
	}
	
	.subSection td {
		
	}
	
	.subSection th {
		text-align:center;
		font-weight: normal;
		font-size: 7pt;
	}
	
	.subSection caption {
		text-align:center;
		background-color:#fff;
		border:1px solid #000000;
		font-size: 8pt;	
		font-weight: bold;		
		margin-bottom: 2pt;
		
	}
	
	.subSection .columnData {
		padding-top:1pt;
		padding-bottom:1pt;
		border:1px solid #000000;
		vertical-align: middle;
		height:10pt;
	}
	
	.sectorId {
		width:16pt;
		height:10pt;
	}
	
	
	#section1{
		width:100%;
	}
	
	#flightData {
	}
	
	
	#flightData .sectorId {
	    height:10pt;
		
	}
	
	#flightData .flightDate {
		width: 42pt;
		height:10pt;
	}
	
	#flightData .regNo {
		width: 34pt;
	}
	
	#flightData td.fltNo {
		width: 37pt;
	}
	
	#sectorData {
		border-collapse : collapse;
		
	}
	

	#sectorData .destTo {
		width:20pt;
		height:12pt;
		text-align:center;
	}
	
	#sectorData .destFrom {
		width:20pt;
		height:12pt;
		text-align:center;
	}
	
	
	#scheduleData {
		border-collapse : collapse;
	}
	
	#scheduleData .std,
	#scheduleData .sta,
	#scheduleData .onBlock{
		width:23pt;
		height:12pt;
		text-align:center;
	}
	
	
	#timeData {
		
	}
	
	#timeData .outOff,
	#timeData .landOnBlk {
		width: 40pt;
		height:12pt;
		text-align:center;
	}
	
	#timeData .onBlock,
	#timeData .airTime {
		width: 32pt;
	}
	
	#paxData {
		
	}
	
	#paxData .bookedPax,
	#paxData .actPax {
	    height:12pt;
		width: 20pt;
		text-align:center;
		
	}
	
	#paxData td.bookedPax,
	#paxData td.actPax {		
		height:12pt;
		padding-right: 3pt;
		text-align:center;
	}
	
	#paxData td.bookedPax {
		font-weight:bold;
		text-align:center;
	}
	
	#section2{
		padding-top:2pt;
		width:100%;
	}
	
	
	#fuelData .initWt,
	#fuelData .fuelUplift,
	#fuelData .departureWt,
	#fuelData .arriveWt,
	#fuelData .fuelBurn {
		width: 38pt;
	}
	
	
	#deIceData .deIceLitres{
		width:35pt;
		height:10pt;
	}
	
	
	#delayData .col_time {
		width: 30pt;
		height:10pt;
		text-align:center;
	}
	
	#delayData .col_code {
		width: 18pt;
		text-align:center;
	}
	
	
	#catiiData .rwy {
		width:25pt;
	}
	
	#catiiData .satis {
	
		width:25pt;
	}
	
	#catiiData .unsatis {
		width:25pt;
	}
	
	
	#section3 {
		padding-top: 0pt;
		width:100%;
	}
	
	#crewData-wrapper {
		vertical-align:top;
	}
	
	#crewData .crewName {
		width: 140pt;
		height:10pt;
		text-align:left;
		padding: 1pt 5pt 1pt 5pt;
	}
	
	#crewData th.columnHeader.sectorsOperated {
		text-align:center;
	}
	
	#crewData th.columnHeader.dutyTimes {
		text-align:center;
	}
	
	#crewData td.sectorsOperated {
		width:14pt;
		height:10pt;
		text-align:center;
	}
	

	#crewData thead .columnHeader {
		border-top: 1px solid #fff;
		border-left: 1px solid #fff;
		border-right: 1px solid #fff;
	}
	
	
	#crewData .onDuty,
	#crewData .offDuty{
		width: 30pt;
		height:10pt;
		text-align:center;
	}
	
	
	
	#catiiReasonData-wrapper {
		vertical-align:top;
	}
	
	#catiiReasonData td.reason {
		width:110pt !important;
		height:10pt;
		text-align:left;
	}
	
	#catiiReasonData td.check-box {
		width:20pt !important;
		text-align:left;
	}
	
	
	#section4 {
		width:100%;
	}
	
	#miscData {
		height:210pt !important;
		width:100%;
		margin-left:auto;
		margin-right:auto;
	}
	
	
	#miscData .fltNo,
	#miscData .acReg {
		width:32pt;
		text-align:center;
		white-space: nowrap;
	}
	
	#miscData .comments {
		width:340pt;
		text-align:left;
	}
	
	#miscData .freespace {
		height:140%;
	}
	
	
	
	#signatureAndFooterData {
		width:100%;
		margin-left:auto;
		margin-right:auto;
		font-size:7pt;
	}
	
	#signatureAndFooterData td {
		border: 0px solid #fff;
	}
	
	#signatureAndFooterData td.footerNotice {
		padding-bottom:10pt;
	}
	
	#signatureRow td{
		padding-top:10pt;
		border-bottom:1px solid #000 !important;
	}
	
	.signatureHeader{
		text-align: left;
	}
	
	.signatureDottedLine {
		
	}
	
	.footerNotice {
		text-align:center;
		border: 0px;
	}


		</style>
	</head>
	
	


<body>
	
	
	
	
<!-- Start Main Table Outer Most Main-->	
<table id="report-wrapper">
	
	

	
	<!-- Start Of First Row Header -->	
	<tr>  
		<td>


			<table id="flightReportHeader">
				<tr>
					<th id="flightReportHeaderLeft">
						<img src="https://link.stobartair.com/images/logo.png"> </img> 						
					</th>
					<th id="flightReportHeaderCenter">Flight Report 	</th>
					
					<th id="flightReportHeaderRight">
						 
						<table id="initialData">
							<tr>
								<td>Tail Reg:</td>
								<td>
								      <#assign flTObj = detailList[0]> 						             
									  ${(flTObj.aircraftReg)!""}
								</td>
							</tr>
							<tr>
								<td>Fuel On Board:</td>
								<td>
									${(flTObj.fuelAtthetimeofdep)!""}
								</td>
							</tr>
						</table>
					</th>
				</tr>
				
			</table>
			
			
		</td>
	</tr>
	<!-- End  Of First Row Header -->
	
	
	
	
	
	<!-- Start OF Second Row -->
	<tr>
		<td><!-- SECTION 1 START-->
			<table id="flightReportBody">
				<tr>
					<td>
						<table id="section1">
									<tr>
										<td id="flightData-wrapper">
											<table id="flightData" class="subSection">
												<caption>FLIGHT DATA</caption>
												<tr>
													<th class="columnHeader sectorId">Sec.</th>
													<th class="columnHeader flightDate">Date</th>
													<th class="columnHeader regNo">Reg</th>
													<th class="columnHeader fltNo">Flt. No.</th>
												</tr>
											   <#assign rowCtr = 1>
											   <#list detailList as fltObj>
													<tr>
														<td class="columnData sectorId">${fltObj_index+1}</td>
														<td class="columnData flightDate">${(fltObj.flightDate)!""}</td>
														<td class="columnData regNo">${(fltObj.aircraftReg)!""} </td>
														<td class="columnData fltNo">${(fltObj.flightNo)!""}</td>
													</tr>
													<#assign rowCtr++>
											  </#list>
											  
											  <#if rowCtr != 7>
												
													<#list rowCtr..7 as w>
														<tr>
															<td class="columnData sectorId">${rowCtr}</td>
															<td class="columnData flightDate"></td>
															<td class="columnData regNo"></td>
															<td class="columnData fltNo"></td>
															<#assign rowCtr++>
														</tr>
												    </#list>												  
											  											  
											  </#if>
											  
											  
											  
											</table>
											
										</td>
									</tr>
								</table>
					</td>
					
					<td id="sectorData-wrapper"><!-- SECTION 3 START-->
								   
									<table id="sectorData" class="subSection">
										<tr>
											<td id="sectorData-wrapper">
												<table id="sectorData" class="subSection">
													<caption>SECTOR</caption>
													<tr>
														<th class="columnHeader sectorId">From.</th>
														<th class="columnHeader destTo">To</th>											
													</tr>
												    <#assign rowCtr = 1>
												    <#list detailList as fltObj>
													<tr>
														<td class="columnData destFrom">${(fltObj.from)!""} </td>
														<td class="columnData destTo">${(fltObj.to)!""}</td>
													</tr>
													<#assign rowCtr++>
												  </#list>
													  
												  <#if rowCtr != 7>													
														<#list rowCtr..7 as w>
															<tr>
																<td class="columnData destFrom"> </td>
																<td class="columnData destTo"> </td>
															</tr>													
														</#list>							  
												  </#if>
												  
												  
												  
												  
												  
												</table>
												
											</td>
										</tr>
									</table>
												
						
					</td> <!-- SECTION 3 END-->
					
					
					<td id="scheduleData-wrapper"> <!-- SECTION 4 START-->	
									   
						<table id="scheduleData" class="subSection">
							<tr>
								<td id="scheduleData-wrapper">
									<table id="scheduleData" class="subSection">
											<caption>SCHEDULE</caption>
										<tr>
											<th class="columnHeader sectorId">STD</th>
											<th class="columnHeader flightDate">STA</th>
											<th class="columnHeader regNo">Block</th>
									
										</tr>
										
									    <#assign rowCtr = 1>
									    <#list detailList as fltObj>
										<tr>
											<td class="columnData std"> ${(fltObj.std)!""} </td>
											<td class="columnData sta">${(fltObj.sta)!""}</td>
											<td class="columnData onBlock">${(fltObj.getStaMinusStd())!""}</td>									
										</tr>
										<#assign rowCtr++>
									  </#list>
									  
									  <#if rowCtr != 7>													
											<#list rowCtr..7 as w>									  
												<tr>
													<td class="columnData std"> </td>
													<td class="columnData sta"> </td>
													<td class="columnData onBlock"> </td>									
												</tr>
										
											</#list>	
									  </#if> 		
									  
									</table>
									
								</td>
							</tr>
						</table>			
					</td> <!-- SECTION 4 END-->					
					
					<td id="timeData-wrapper"> <!-- SECTION 5 START-->	
						<table id="timeData" class="subSection">
							<caption>ACTUAL TIME</caption>
							<tr>
								<th class="columnHeader outOff">Out/Off</th>
								<th class="columnHeader landOnBlk">Land/On Blk</th>
								<th class="columnHeader onBlock">Block</th>
								<th class="columnHeader airTime">Air Time</th>
							</tr>
						<#list 1..7 as x>  
							<tr>
								<td class="columnData outOff">  </td>
								<td class="columnData landOnBlk">  </td>
								<td class="columnData onBlock">  </td>
								<td class="columnData airTime">  </td>
							</tr>
						 </#list>	
						</table>
					</td>
					
					<td id="paxData-wrapper">
						<table id="paxData" class="subSection">
							<caption>Pax</caption>
							<tr>
								<th class="columnHeader bookedPax">Book</th>
								<th class="columnHeader actPax">Act</th>
							</tr>
							<#assign rowCtr = 1>	
							<#list detailList as fltObj1>	
								<tr>
									<td class="columnData bookedPax">${(fltObj1.bookedPax)!""}</td> 
									<td class="columnData actPax">  </td>
								</tr>
								<#assign rowCtr++>
							 </#list>	
							 
							<#list rowCtr..7 as x>  
					            <tr>
									<td class="columnData bookedPax"></td> 
									<td class="columnData actPax">  </td>
								</tr>					
							 </#list>	
							 
		
						</table>
					</td>
			
				
				</tr>
            </table>				
		</td>
		
	</tr>      
	 <!-- End Of Second Row -->            
	      
	<tr>
		<td>
						<!-- SECTION 2 -->
						<table id="section2">
							<tr>
								<td id="fuelData-wrapper">
									<table id="fuelData" class="subSection">
										<caption>FUEL DATA</caption>
										<tr>
											<th class="columnHeader sectorId">Sec.</th>
											<th class="columnHeader initWt">Initial Kg.</th>
											<th class="columnHeader fuelUplift">Uplift Ltrs.</th>
											<th class="columnHeader departureWt">Depart Kg.</th>
											<th class="columnHeader arriveWt">Arrive Kg.</th>
											<th class="columnHeader fuelBurn">Burn Kg.</th>
										</tr>
									<#list 1..7 as x>  
										<tr>
											<td class="columnData sectorId"></td>
											<td class="columnData initWt"></td>
											<td class="columnData fuelUplift"></td>
											<td class="columnData departureWt"></td>
											<td class="columnData arriveWt"></td>
											<td class="columnData fuelBurn"></td>
										</tr>
									</#list>	
									</table>
								</td>
								
								
								<td id="deIceData-wrapper">
									<table id="deIceData" class="subSection">
										<caption>De-Ice</caption>
										<tr>
											<th class="columnHeader deIceLitres">Litres</th>
										</tr>
										<#list 1..7 as x>  
										<tr>
											<td class="columnData"></td>
										</tr>
										</#list>	
							
									</table>
								</td>
								
								<td id="delayData-wrapper">
									<table id="delayData" class="subSection">
										<caption>DELAY</caption>
										<tr>
											<th class="columnHeader" colspan="2">Time / Code</th>
											<th class="columnHeader" colspan="2">Time / Code</th>
										</tr>
										<#list 1..7 as x> 
										<tr>
											<td class="columnData col_time"> </td>
											<td class="columnData col_code"> </td>
											<td class="columnData col_time"> </td>
											<td class="columnData col_code"> </td>
										</tr>
										</#list>
								</table>
								</td>
								<td id="catiiData-wrapper">	
									<table id="catiiData" class="subSection">
										<caption>CAT II</caption>
										<tr>
											<th class="columnHeader rwy">Rwy</th>
											<th class="columnHeader satis">Satis</th>
											<th class="columnHeader unsatis">Unsatis</th>
										</tr>
										<#list 1..7 as x> 
										<tr>
											<td class="columnData"> </td>
											<td class="columnData"> </td>
											<td class="columnData"> </td>
										</tr>	
										</#list>
									</table>
								</td>
							</tr>
						</table>
						<!--  END OF SECTION 2 -->
		</td>
	</tr>
	

	<tr>
		<td>
		<!-- SECTION 3 -->
		<table id="section3">
			<tr>
				<td id="crewData-wrapper">
					<table id="crewData" class="subSection">
						<thead>
							<tr>
								<th class="columnHeader crewName" rowspan="2" width="20%">CREW NAMES</th>
								<th class="columnHeader sectorsOperated" colspan="7">Sectors Operated</th>
								<th class="columnHeader dutyTimes" colspan="2">DUTY TIMES</th>
							</tr>
							<tr>
								 
								<#list 1..7 as x> 
									 <td class="columnHeader sectorsOperated">${x}</td>
								</#list>
								<td class="columnHeader onDuty">On Duty</td>
								<td class="columnHeader offDuty">Off Duty</td>
							</tr>
						</thead>
						<tbody>
						<!-- Loop through each crew members -->	
						<#assign flTObj = detailList[0]> 
						
						<#list flTObj.allCrewOfThisFlight as creName> 
							<tr>
								<td class="columnData crewName">${(creName)!""}</td>
								<#list 1..7 as x> 
									<td class="columnData sectorsOperated"></td>
								</#list>
								<td class="columnData onDuty"></td>
								<td class="columnData offDuty"></td>
							</tr>
						</#list>	

						
						</tbody>
					</table>
				</td>
				<td id="catiiReasonData-wrapper">
					<table id="catiiReasonData" class="subSection">
						<thead>
							<tr>
								<th class="columnHeader" colspan="2">Reason for Unsatisfactory CAT II<br/>Approach</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td class="columnData reason">Airborne Equipment</td><td class="columnData check-box"></td>
							</tr>
							<tr>
								<td class="columnData reason">Ground Facilities</td><td class="columnData check-box"></td>
							</tr>
							<tr>
								<td class="columnData reason">Air Traffic Control</td><td class="columnData check-box"></td>
							</tr>
							<tr>
								<td class="columnData reason">Other</td><td class="columnData check-box"></td>
							</tr>
							<tr>
								<td class="columnData reason">Details</td><td class="columnData check-box"></td>
							</tr>
							<tr>
								<td colspan="2" class="columnData"></td>
							</tr>
							<tr>
								<td colspan="2" class="columnData"></td>
							</tr>
						</tbody>
					</table>
				</td>
			</tr>
		</table>	
		
		<!--  END OF SECTION 3 -->
	   </td>
   </tr>
	
	

   <tr>
	   <td>	
		<!-- SECTION 4 -->
		<table id="section4">
			<tr>
				<td>
					<table id="miscData" class="subSection">
						<caption>SECTOR COMMENTS</caption>
						<tr>
							<th class="columnHeader sectorId">Sec.</th>
							<th class="columnHeader fltNo">Flt. No</th>
							<th class="columnHeader acReg">A/C Reg.</th>
							<th class="columnHeader comments">Comments</th>
						</tr>
						<#assign rowCtr = 1>
						<#list detailList as fltObj>
							<tr>
										<td class="columnData sectorId">${rowCtr}</td>
										<td class="columnData fltNo"> ${(fltObj.flightNo)!""}</td>
										<td class="columnData acReg">${(fltObj.aircraftReg)!""}</td>
										<td class="columnData comments">
										       ${(fltObj.sectorComments1)!""}  
											   ${(fltObj.sectorComments2)!""}  
											   ${(fltObj.sectorComments3)!""} 
										       ${(fltObj.sectorComments4)!""} 
										
										</td>
										<#assign rowCtr++>
							</tr>
						 </#list>
						
						<tr class="freespace">
							<td class="columnData" colspan="4"></td>
						</tr>
					</table>
				</td>
			</tr>
		</table>	
		</td>
	</tr>	
		

	
	<tr>
		<td>
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

		
	
		
	
 </table>  <!-- End of Outer Most Main Table  -->
	
</body>
    
</html>	