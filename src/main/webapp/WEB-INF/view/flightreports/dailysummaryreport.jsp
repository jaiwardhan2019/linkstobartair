<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="../include/header.jsp" />

<head>
    <title> Dashboard | Daily Summary Report </title>    
</head>
   
<script type="text/javascript">


//----------- THis will Print the Webpage Content -----------------------------------
function printThisPage_PDF() {
	var confirmationMessage = 'Are you sure that you want to print this Report?'; 
	var confirmationHeader = 'Link Admin';
	if (confirm( confirmationMessage, confirmationHeader)){
		//print();
		 print_Report_Pdf_Format();
		}else{return false;}
}


function printThisPage_WORD() {
	var confirmationMessage = 'Are you sure that you want to print this Report?'; 
	var confirmationHeader = 'Link Admin';
	if (confirm( confirmationMessage, confirmationHeader)){
		 exportHTML();
         //printThisPage_DOC('printareareport', filename = 'DailySummaryReport'); 
		}else{return false;}
}



function printThisPage_DOC(element, filename = ''){

         var preHtml = "<html xmlns:o='urn:schemas-microsoft-com:office:office' xmlns:w='urn:schemas-microsoft-com:office:word' xmlns='http://www.w3.org/TR/REC-html40'><head><meta charset='utf-8'><title>Export HTML To Doc</title></head><body>";
         var postHtml = "</body></html>";
         var html = preHtml+document.getElementById(element).innerHTML+postHtml;

         var blob = new Blob(['\ufeff', html], {
             type: 'application/msword'
         });
         
         // Specify link url
         var url = 'data:application/vnd.ms-word;charset=utf-8,' + encodeURIComponent(html);
         
         // Specify file name
         filename = filename?filename+'.doc':'document.doc';
         
         // Create download link element
         var downloadLink = document.createElement("a");

         document.body.appendChild(downloadLink);
         
         if(navigator.msSaveOrOpenBlob ){
             navigator.msSaveOrOpenBlob(blob, filename);
         }else{
             // Create a link to the file
             downloadLink.href = url;
             
             // Setting the file name
             downloadLink.download = filename;
             
             //triggering the function
             downloadLink.click();
         }
         
         document.body.removeChild(downloadLink);
	
}







function exportHTML(){
    var header = "<html xmlns:o='urn:schemas-microsoft-com:office:office' "+
         "xmlns:w='urn:schemas-microsoft-com:office:word' "+
         "xmlns='http://www.w3.org/TR/REC-html40'>"+
         "<head><meta charset='utf-8'><title>Export HTML to Word Document with JavaScript</title></head><body>";
    var footer = "</body></html>";
    //var sourceHTML = header+document.getElementById("printareareport").innerHTML+footer;
    
    var sourceHTML = document.getElementById("printareareport").innerHTML;
    
    var source = 'data:application/vnd.ms-word;charset=utf-8,' + encodeURIComponent(sourceHTML);
    var fileDownload = document.createElement("a");
    document.body.appendChild(fileDownload);
    fileDownload.href = source;
    fileDownload.download = 'document.doc';
    fileDownload.click();
    document.body.removeChild(fileDownload);
 }


// https://www.baeldung.com/java-microsoft-word-with-apache-poi
// https://howtodoinjava.com/library/read-generate-pdf-java-itext/  <<-- Create PDF File 


	
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


 <div class="container" align="center"  id="exportContent" name="exportContent">
       
       <table align="center" border="0" width="90%">
               <tbody>	
               
               <tr>
	               <td  align="center" >	               
	                   <c:if test = "${airlinecode != 'all'}">   
	                           <img  src="<c:url value="images/${airlinecode}1.png"/>" >
	                   </c:if>
	                
	                </td>
	                
	               <td  align="center"> 
	               
	                  &nbsp;&nbsp;&nbsp;&nbsp;<img  src="images/re1.png">    
	               
	               </td>    
	               
	                          
	               <td  align="center">
	               
	                 <table> 
		                 <tr><td> 
		                      <a href="javascript:void();" onClick="printThisPage_PDF();" ><img src="images/page_white_acrobat.png">&nbsp;&nbsp;Print .Pdf Report</a> 
		                 </td></tr>
		                 
		                 <c:if test = "${airlinecode == 'ei'}">      
					        
					                 <tr>
				                 <td> 
				                  
				                 </td>
				                 </tr>
				             
					             <!--  
				                 <tr>
				                 <td> 
				                      <a href="javascript:void();" onClick="printThisPage_WORD();" ><img src="images/page_word.png">&nbsp;&nbsp;Print .Doc Report</a>
				                 </td>
				                 </tr>
				                  -->
				                  
				                 <tr><td> 
				                      <i class="fa fa-cogs" aria-hidden="true"></i> &nbsp;&nbsp;<a href="https://online2pdf.com/pdf2word" target="blank" title="Download pdf file using above link  Then Use this tool to convert to word" >PDF to Word Conversion tool </a>
				                 </td></tr>
				           </c:if>
				             
		             </table>	                  

	  
	               </td>
	               
	            </tr>
	            
               <tr>
                <td colspan="3" align="center" bgcolor="white"><br>
                  <h2><b>Operations Daily Summary - ${dateofoperation}</b></h2>
                 </td> 
               </tr>
               
              <tr>
                <td colspan="3" align="left">

			   
			                 <c:if test = "${airlinecode == 'ei'}">      
			                          Operating Airline:	<b>Aer Lingus</b>
			                  </c:if>  
			                  <c:if test = "${airlinecode == 'ba'}">      
			                          Operating Airline:	<b>British Air City Flyer</b>
			                  </c:if>  
			                  <c:if test = "${airlinecode == 'be'}">      
			                          Operating Airline:	<b>Fly Be</b>
			                  </c:if>                                    
			                 <c:if test = "${airlinecode == 'kl'}">      
			                          Operating Airline:	<b>KLM City Hopper</b>
			                 </c:if>                    
			                 <c:if test = "${airlinecode == 're'}">      
			                          Operating Airline:	<b>Stobart Air</b>
			                 </c:if>    
			                                       
			                  <c:if test = "${airlinecode == 'all'}">      
			                          Operating Airline:	<b>All Airline</b>
			                 </c:if>
			                 <br>                 
			                  
			                  Commercial Operation:	 <b>${Operation} </b>&nbsp;&nbsp;
			                  <br>
			                  
			                  Flights: ${flybeflightlist}
			                
                 </td> 
               </tr>
               
               </tbody>	
           	
       
       </table>
   
 </div>
 <br>

 
 <div class="container" align="center" >
 
 			<table class="table table-hover table-bordered table-condensed" style="width: 90%;">
				<thead>
				
					<tr>
						<th colspan="2" style="color: white;" bgcolor="#0070BA">Completion KPI</th>
						<th colspan="2" style="color: white;" bgcolor="#0070BA">Pax KPI</th>
						
					</tr>
				</thead>
				<tbody>	
				
			              ${fltCompletionkpipax}	
			     </tbody>         	
				
						
	            </table>	
 
 
 </div> 
 
 

 
 
 <div class="container" align="center">

  			<table class="table table-hover table-bordered table-condensed" style="width: 90%;border-collapse: collapse;">
			
					<tr>
						<th  colspan="7" style="color: white;text-align: center;" bgcolor="#0070BA">Punctuality Statistics</th>
						
					</tr>
				
				  <tr>
				  <td> <b>From Port </b> </td>
				  <td> <b>Status</b> </td>
				  <td> <b>No. Of Flights </b></td>
				  <td> <b>On Time % </b></td>
				  
				  <td> <b><= <c:out value="${punctualityTarget['title']}"/> Minutes &nbsp;&nbsp;(<c:out value="${punctualityTarget['lessthen5minut']}"/>%) </b></td>
				  
				  <td> <b><= 15 Minutes&nbsp;&nbsp;(<c:out value="${punctualityTarget['lessthen15minut']}"/>%)</b></td>
				  <td> <b>Comments / Notes </b></td>
				  </tr>	
	               ${punctualitystatus}		 
	                
			
			
			
			</table>		
		        
 
 </div>
 

  
 <div class="container" align="center">
 
 			<table class="table table-hover table-bordered table-condensed" style="width: 90%;border-collapse: collapse;">
				<thead>
				
					<tr >
						<th align="center" colspan="4" style="color: white;text-align: center;" bgcolor="#0070BA">No. Of Departure Delays By IATA Delay Code Category</th>
						
					</tr>
				</thead>
				
				<tbody> 
		
		
		        ${delaycodegroupstat}				  
				  
				  
				</tbody>
			
			
			</table>		
		        
 
 </div>
 
 <div class="container" align="center">
 
 			<table class="table table-bordered" style="width: 90%;border-collapse: collapse;">
		
		<c:if test="${fn:length(rootdelaylist) > 0}">
			    
		
				<thead>
				
					<tr>
						<th colspan="9" style="color: white;text-align: center;" bgcolor="#0070BA" >Narrative Summary of Root Delays:</th>
					</tr>
				
					<tr>
						<th  style="color: white;text-align: left;" bgcolor="#0070BA" >Flight No</th>
						<th  style="color: white;text-align: left;" bgcolor="#0070BA" > Reg -Type </th>
						<th  style="color: white;text-align: left;" bgcolor="#0070BA" >STD</th>
						<th  style="color: white;text-align: left;" bgcolor="#0070BA" >Route</th>
						<th  style="color: white;text-align: left;" bgcolor="#0070BA" >Delay 1.</th>
						<th  style="color: white;text-align: left;" bgcolor="#0070BA" >Delay 2.</th>
						<th  style="color: white;text-align: left;" bgcolor="#0070BA" >Delay 3.</th>
						<th  style="color: white;text-align: left;" bgcolor="#0070BA" >Delay 4.</th>
						<th  style="color: white;text-align: left;" bgcolor="#0070BA" >Delay Comments</th>
						
					</tr>
					
					
				</thead>
				
	
		
				
				<tbody> 

				 <c:forEach var="fltrootdelay" items="${rootdelaylist}"> 					
								  <tr>
									  <td>  ${fltrootdelay.flightNo} </td>
									  <td>  ${fltrootdelay.aircraftReg} -  ${fltrootdelay.aircraftType}</td>
									  <td> ${fltrootdelay.std} </td>
									  <td>  ${fltrootdelay.from}&nbsp; - &nbsp; ${fltrootdelay.to} </td>
									  <td>  
									  
										<c:set var = "delaycode"  value = "${fn:length(fltrootdelay.delayCode1)}"/>   
										
												<c:if test = "${delaycode >= 2}">
											
													<b> <c:out value = "${fltrootdelay.delayCode1}"/></b>-${fltrootdelay.delayCode1_time}
												
										</c:if>


								       </td>
								         <td>  
									  
										<c:set var = "delaycode"  value = "${fn:length(fltrootdelay.delayCode2)}"/>   
										
												<c:if test = "${delaycode >= 2}">
												<b> <c:out value = "${fltrootdelay.delayCode2}"/></b>-${fltrootdelay.delayCode2_time} 
												
										</c:if>


								       </td>
								  <td>  
									  
										<c:set var = "delaycode"  value = "${fn:length(fltrootdelay.delayCode3)}"/>   
										
												<c:if test = "${delaycode >= 2}">
												<b> <c:out value = "${fltrootdelay.delayCode3}"/></b>-${fltrootdelay.delayCode3_time}
												
										</c:if>


								       </td>
								  <td>  
									  
										<c:set var = "delaycode"  value = "${fn:length(fltrootdelay.delayCode4)}"/>   										
												<c:if test = "${delaycode >= 2}">
												<b> <c:out value = "${fltrootdelay.delayCode4}"/></b>-${fltrootdelay.delayCode4_time}
												
										</c:if>


								       </td>
								 
	
									  <td width="40%">
			
										    <c:forEach var="fltnote" items="${fltrootdelay.getFlightNoteRemarks()}"> 
									                 ${fltnote} <br>
									         </c:forEach>
							  
								  </tr>	
				</c:forEach>				  
			
			 </c:if>				
			
			
			     <c:if test="${fn:length(rootdelaylist) < 1}">
			    
			       <tr> 
			       <td colspan="9" align="center"> <b>Sorry There is No Delay flights.. </b></td>
			       </tr>
			    
			     </c:if>				
				
			  </tbody>
     </table>
  
  
     
     

      <c:if test="${fn:length(cancleflights) > 1}">
  
     		
     	 <table class="table table-bordered" style="width: 90%;border-collapse: collapse;">
				
					<tr>
						<th colspan="3" style="color: white;text-align: center;" bgcolor="#0070BA" >Summary of Cancelled Flights:</th>
					</tr>
				
					<tr>
						<th  style="color: white;text-align: left;" width="12%" bgcolor="#0070BA" >Flight No</th>
						<th  style="color: white;text-align: left;" width="12%" bgcolor="#0070BA" > Booked Pax</th>
						<th  style="color: white;text-align: left;" width="76%" bgcolor="#0070BA" >Sector Comment</th>
						
					</tr>
				
					
			<tbody> 
			  
			  ${cancleflights}
			  			
			</tbody>	
	          
      </table>	
     
      </c:if>	 
     
         
     
</div>				  
 <br>
 <br>
 <br>
   
<script type="text/javascript">

			
function print_Report_Pdf_Format(){
	
		var print_div = document.getElementById("printareareport");
		var print_area = window.open();
		print_area.document.write(print_div.innerHTML);
		print_area.document.close();
		print_area.focus();
		print_area.print();
		print_area.close();
}



</script>

<style>
		
	.myTable tr, .myTable td, .myTable th{
		padding: 8px;
		border:1px solid black;
	}
	
	
</style>



<body class="myBody">

<!-- THIS IS FOR PRINTING AREA  

<div id="printareareport" style="display:none">

 --> 
 
 
 
<div class="printarea" id="printareareport" style="display:none">

  <div>   
    
      <table class="hdTable" style="width:100%;border:0px solid black;border-collapse: collapse;">
       
               <tr>
	               <td  align="left"  >	               
	                    <c:if test = "${airlinecode != 'all'}">   
	                       <img  src="<c:url value="images/${airlinecode}1.png"/>" >
	                   </c:if>
	                   
	                </td>
	                
	               <td  align="right">
	                       &nbsp;&nbsp;&nbsp;&nbsp;<img src="<c:url value="images/re1.png"/>">   
	                </td>    
	               
	            </tr>
	            
               <tr>
                <td colspan="3" align="center" bgcolor="white"><br>
                  <h2>Operations Daily Summary - ${dateofoperation}</h2>
                 </td> 
               </tr>
               
              <tr>
                <td colspan="3" align="left">			   
			                 <c:if test = "${airlinecode == 'ei'}">      
			                          Operating Airline:	<b>Aer Lingus</b>
			                  </c:if>  
			                  <c:if test = "${airlinecode == 'ba'}">      
			                          Operating Airline:	<b>British Air City Flyer</b>
			                  </c:if>  
			                  <c:if test = "${airlinecode == 'be'}">      
			                          Operating Airline:	<b>Fly Be</b>
			                  </c:if>                                    
			                 <c:if test = "${airlinecode == 'kl'}">      
			                          Operating Airline:	<b>KLM City Hopper</b>
			                 </c:if>                    
			                 <c:if test = "${airlinecode == 're'}">      
			                          Operating Airline:	<b>Stobart Air</b>
			                 </c:if>    
			                                       
			                  <c:if test = "${airlinecode == 'all'}">      
			                          Operating Airline:	<b>All Airline</b>
			                 </c:if>
			                 <br>                 
			                  
			                  Commercial Operation:	 <b>${Operation} </b>&nbsp;&nbsp;
			                  <br>
                              Flights: ${flybeflightlist}
                              			                   
				                 			                   
		
                 </td> 
               </tr>
               
           	
       
       </table>
   
 </div>

 <div  align="center" >
 
      <table class="myTable" style="width:100%;border:1px solid black;border-collapse: collapse;">
    		<thead>
				
					<tr>
						<th colspan="2" >Completion KPI</th>
						<th colspan="2" >Pax KPI</th>
						
					</tr>
				</thead>
				
			              ${fltCompletionkpipax}	
				
						
	            </table>	
 
 
 </div> 
 
 <br> 
 
 <div  align="center">

      <table class="myTable" style="width:100%;border:1px solid black;border-collapse: collapse;">
    	   
			
					<tr>
						<th  colspan="7" >Punctuality Statistics</th>
						
					</tr>
				
			
				  <tr>
				  <td> <b>From Port </b> </td>
				  <td> <b>Status</b> </td>
				  <td> <b>No. Of Flights </b></td>
				  <td> <b>On Time % </b></td>
				  
				  <td> <b><= <c:out value="${punctualityTarget['title']}"/> Minutes &nbsp;&nbsp;(<c:out value="${punctualityTarget['lessthen5minut']}"/>%) </b></td>
				  
				  <td> <b><= 15 Minutes&nbsp;&nbsp;(<c:out value="${punctualityTarget['lessthen15minut']}"/>%)</b></td>
				  <td> <b>Comments / Notes </b></td>
				  </tr>	
	  	               ${punctualitystatus}		 
			
			</table>		
 
 </div>
 
<br>
  
 <div align="center">
 
 	
      <table class="myTable" style="width:100%;border:1px solid black;border-collapse: collapse;">
    			<thead>
				
					<tr >
						<th align="center" colspan="4">No. Of Departure Delays By IATA Delay Code Category</th>
						
					</tr>
				</thead>
				
		
		
		
		        ${delaycodegroupstat}				  
				  
				  
			
			</table>		
		        
 
 </div>
 
 
 
 
 
 <br>
 <div  align="center">
 
 		
      <table class="myTable" style="width:100%;border:1px solid black;border-collapse: collapse;">
    		<thead>
				
					<tr>
						<th colspan="9" >Narrative Summary of Root Delays:</th>
					</tr>
				
					<tr>
						<th    >Flight No</th>
						<th    > Reg -Type </th>
						<th    >STD</th>
						<th    >Route</th>
						<th    >Delay 1.</th>
						<th    >Delay 2.</th>
						<th    >Delay 3.</th>
						<th    >Delay 4.</th>
						<th    >Delay Comments</th>
						
					</tr>
					
					
				</thead>
				
	
				 <c:forEach var="fltrootdelay" items="${rootdelaylist}"> 					
								  <tr>
									  <td>  ${fltrootdelay.flightNo} </td>
									  <td>  ${fltrootdelay.aircraftReg} -  ${fltrootdelay.aircraftType}</td>
									  <td> ${fltrootdelay.std} </td>
									  <td>  ${fltrootdelay.from}&nbsp; - &nbsp; ${fltrootdelay.to} </td>
									  <td>  
									  
										<c:set var = "delaycode"  value = "${fn:length(fltrootdelay.delayCode1)}"/>   
										
												<c:if test = "${delaycode >= 2}">
											
													<b> <c:out value = "${fltrootdelay.delayCode1}"/></b>-${fltrootdelay.delayCode1_time}
												
										</c:if>


								       </td>
								         <td>  
									  
										<c:set var = "delaycode"  value = "${fn:length(fltrootdelay.delayCode2)}"/>   
										
												<c:if test = "${delaycode >= 2}">
												<b> <c:out value = "${fltrootdelay.delayCode2}"/></b>-${fltrootdelay.delayCode2_time} 
												
										</c:if>


								       </td>
								  <td>  
									  
										<c:set var = "delaycode"  value = "${fn:length(fltrootdelay.delayCode3)}"/>   
										
												<c:if test = "${delaycode >= 2}">
												<b> <c:out value = "${fltrootdelay.delayCode3}"/></b>-${fltrootdelay.delayCode3_time}
												
										</c:if>


								       </td>
								  <td>  
									  
										<c:set var = "delaycode"  value = "${fn:length(fltrootdelay.delayCode4)}"/>   										
												<c:if test = "${delaycode >= 2}">
												<b> <c:out value = "${fltrootdelay.delayCode4}"/></b>-${fltrootdelay.delayCode4_time}
												
										</c:if>


								       </td>
								 
	
									  <td >
			
										    <c:forEach var="fltnote" items="${fltrootdelay.getFlightNoteRemarks()}"> 
									                 ${fltnote} <br>
									         </c:forEach>
							  
								  </tr>	
				</c:forEach>				  
			
			     <c:if test="${fn:length(rootdelaylist) < 1}">
			    
			       <tr> 
			       <td colspan="9" align="center"> <b>Sorry There is no flights.. </b></td>
			       </tr>
			    
			     </c:if>				
				
			
     </table>
      
     <br>

      <c:if test="${fn:length(cancleflights) > 0}">
  
     		
    
      <table class="myTable" style="width:100%;border:1px solid black;border-collapse: collapse;">
    			
					<tr>
						<th colspan="3"  >Summary of Cancelled Flights:</th>
					</tr>
				
					<tr>
						<th >Flight No</th>
						<th > Booked Pax</th>
						<th >Sector Comment</th>
						
					</tr>
				
					
			<tbody> 
			  
			  ${cancleflights}
			  			
			</tbody>	
	          
      </table>	
     
      </c:if>	 
   
</div>

<style>
		
	.myTable tr, .myTable td, .myTable th{
		padding: 2px;
		border:1px solid black;
		font-size: 9pt;
		font-family: arial,verdana;
	}
	
	.hdTable tr, .hdTable td, .hdTable th{
		padding: 2px;	
		font-size: 9pt;
		font-family: arial,verdana;
	}
	
	
</style>
	
</body>






