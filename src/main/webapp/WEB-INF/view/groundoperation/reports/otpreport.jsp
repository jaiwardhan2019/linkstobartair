<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="../../include/groundopsheader.jsp" />

<head>
    <title> Dashboard |On Time Performance Report </title>    
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
		 document.OtpFlighReport.method="POST";
		 document.OtpFlighReport.action="otpflightreport";
	     document.OtpFlighReport.submit();
	     return true;
}




//*** Here this function will update data in the form to database and write back to the DIV 
function Download_ExcelReport(){

	document.getElementById("downloading").innerHTML = "<i class='fa fa-refresh fa-spin fa-lx' aria-hidden='true'></i>&nbsp;&nbsp;Downloading..&nbsp;&nbsp;";
	search_progress();
    var urldetail ="CreateExcelReliabilityReport?delay=yes&airlinecode="+document.getElementById("airlinecode").value; 
    urldetail = urldetail +"&airportcode="+document.getElementById("airportcode").value;
    urldetail = urldetail +"&startdate="+document.getElementById("startdate").value;		
    urldetail = urldetail +"&enddate="+document.getElementById("startdate").value;	
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

 
 <form name="OtpFlighReport" id="OtpFlighReport">   
  
  <input type="hidden" id="emailid" name="emailid" value="<%=request.getParameter("emailid")%>">
  <input type="hidden" name="password" value="<%=request.getParameter("password")%>">
  <input type="hidden" name="usertype" value="${usertype}">

    
    
 <div class="container" align="center">
 
 
 
 <div class="col-md-7 col-sm-7 col-xs-7" align="left" >
 
 
       
  <table class="table table-striped table-bordered" border="1" style="width:80%;background:rgba(255,255,255);" align="left">	
   			<tbody>				     
				 <tr align="center">
					 <td  bgcolor="#0070BA" colspan="2">
					   <span style="color:white;">  <i class="fa fa-database fa-lx" aria-hidden="true"></i> &nbsp;<b>
					    On Time Performance Report &nbsp;&nbsp;
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
										<label for="airlineCode">Departure Station:</label>
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
							<label for="startDate">From Date:</label>
							<div class="input-group">
								<span class="input-group-addon"><i class="fa fa-calendar"></i></span>								
								<input type="date" id="startdate" name="startdate" class="form-control datepicker" maxlength="12"
								    value="${startdate}" placeholder="(DD/MM/YYYY)"/>
							</div>	
						</div>
								
								
				       </td>
	       				
					<td>
					
					
				    <div class="col-xs-12">
							<label for="startDate">To Date:</label>
							<div class="input-group">
								<span class="input-group-addon"><i class="fa fa-calendar"></i></span>								
								<input type="date" id="enddate" name="enddate" class="form-control datepicker" maxlength="12"
								    value="${enddate}" placeholder="(DD/MM/YYYY)"/>
							</div>	
						</div>
								
							
				       </td>
				       
				       
				       
				     </tr>
				
				<!--      					 
				    <tr>
				    <td colspan="2" align="left">		             
				    
		               <div class="checkbox disabled">		               
  				              <label><input type="checkbox" id="Active" name="Active"  value="Active" ${Active}> <span class="label label-info"><i class="fa fa-check-circle  fa-lg" aria-hidden="true"></i><b> All Delay Code.</b></span></label>&nbsp; 
						      <label><input type="checkbox" id="Dactive" name="Dactive" value="Dactive" ${Dactive}><span class="label label-danger"><i class="fa fa-check-circle  fa-lg" aria-hidden="true"></i><b> Ground Ops Delay.</b></span></label>&nbsp;  						      
						      <label><input type="checkbox" id="Archived" name="Archived"  value="Archived" ${Archived}> <span class="label label-warning"><i class="fa fa-check-circle  fa-lg" aria-hidden="true"></i><b> Stobart Delay.</b></span></label>&nbsp;
						      <label><input type="checkbox" id="Archived" name="Archived"  value="Archived" ${Archived}> <span class="label label-success"><i class="fa fa-check-circle  fa-lg" aria-hidden="true"></i><b> Non-Stobart Delay.</b></span></label>
						      
					    </div>
					    
				    </td>
				    
				    </tr>
				    -->
				    
				    <tr>
				     				     					
					<td >
				             
				             
				         <div class="col-xs-12">
							<label for="sortBy">Delay Code Group:</label> 
							<div class="input-group">
								<span class="input-group-addon"><i class="fa fa-text-height" aria-hidden="true"></i></span>
								<select id="delayCodeGroupCode" name="delayCodeGroupCode" class="form-control">
								<option value="ALL">All Delay Codes</option>
										<option value="GOPSDELAYCODE" <c:if test="${delaycode == 'GOPSDELAYCODE'}"> selected </c:if> >Ground Ops</option>
										<option value="STOBARTDELYCODE" <c:if test="${delaycode == 'STOBARTDELYCODE'}"> selected </c:if> >Stobart Attributable Delays</option>
										<option value="NONSTOBARTDELAYCODE" <c:if test="${delaycode == 'NONSTOBARTDELAYCODE'}"> selected </c:if>  >Non Stobart Delays</option>	
									
								</select>
							</div>
						</div>
				       </td>
				       
		
				       
				    
	   			     <td  align="center">
	   			          <br>
				          <span id="searchbutton" onClick="showFlightReport();"  class="btn btn-primary" ><i  class="fa fa-search" aria-hidden="true"></i>&nbsp;&nbsp;Show Report </span> 
		                     <!-- &nbsp;&nbsp;<button type="button"  class="btn btn-success" onClick="Download_ExcelReport();"  id="downloading">Excel Report&nbsp;&nbsp;<i class="fa fa-file-excel-o" aria-hidden="true"></i></button> -->	
		 			     
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
	  </div>
	
</form>

		<div class="col-md-5 col-sm-5 col-xs-5" align="left" >
		      
		      <!-- <div id="chartContainer" style="height: 260px; width: 90%;"></div>-->
		      				
		    <table  class="table table-striped table-bordered"  border="0" style="width: 100%;" align="center">	
				    
				
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
<br>
<br>
 
 
 
 
	   
 <div class="container" align="center">
 
 <div class="col-md-12 col-sm-12 col-xs-12" align="left" >
 <!-- 
   		<ul class="nav nav-pills">
						<li class="active">
						 <a data-toggle="pill" href="#menu1"><b>${reportbody.stream().distinct().count()}</b> - All Delay</a>
						</li>
						<li>
						   <a data-toggle="pill" href="#menu2"><b>${reportbody_C.stream().distinct().count()}</b> - Stobart Delay </a>
						</li>   
	                        
	    </ul>		
 -->
 
<div class="tab-content">
   
   <div id="menu1" class="tab-pane fade in active">					

  	<table class="table table-striped table-bordered" border="1" style="width: 100%;background:rgba(255,255,255);" align="left">	
		 		<tr>
						<th  style="color: white;text-align: left;" bgcolor="#0070BA" >Flight Date</th>
						<th  style="color: white;text-align: left;" bgcolor="#0070BA" >Flight No</th>
						<th  style="color: white;text-align: left;" bgcolor="#0070BA" >Ac - Reg</th>
						<th  style="color: white;text-align: left;" bgcolor="#0070BA" >From.</th>
						<th  style="color: white;text-align: left;" bgcolor="#0070BA" >To.</th>
						<th  style="color: white;text-align: left;" bgcolor="#0070BA" >Del Code.</th>
						<th  style="color: white;text-align: left;" bgcolor="#0070BA" >Time.</th>
						<th  style="color: white;text-align: left;" bgcolor="#0070BA" width="15%">Description</th>
						<th  style="color: white;text-align: left;" bgcolor="#0070BA" width="40%">Note</th>
				</tr>
							  <tr>
									  <td>  ${flightnotes.flightNo} </td>
									  <td>  ${flightnotes.aircraftReg} -  ${flightnotes.aircraftType}</td>
									  <td> ${flightnotes.std} </td>
									  <td>  ${flightnotes.from}&nbsp; - &nbsp; ${flightnotes.to} </td>
									  <td>  
									  
										<c:set var = "delaycode"  value = "${fn:length(flightnotes.delayCode1)}"/>   
										
												<c:if test = "${delaycode >= 2}">
											
													<b> <c:out value = "${flightnotes.delayCode1}"/></b>-${flightnotes.delayCode1_time}
												
										</c:if>


								       </td>
								         <td>  
									  
										<c:set var = "delaycode"  value = "${fn:length(flightnotes.delayCode2)}"/>   
										
												<c:if test = "${delaycode >= 2}">
												<b> <c:out value = "${flightnotes.delayCode2}"/></b>-${flightnotes.delayCode2_time} 
												
										</c:if>


								       </td>
								  <td>  
									  
										<c:set var = "delaycode"  value = "${fn:length(flightnotes.delayCode3)}"/>   
										
												<c:if test = "${delaycode >= 2}">
												<b> <c:out value = "${flightnotes.delayCode3}"/></b>-${flightnotes.delayCode3_time}
												
										</c:if>


								       </td>
								  <td>  
									  
										<c:set var = "delaycode"  value = "${fn:length(flightnotes.delayCode4)}"/>   										
												<c:if test = "${delaycode >= 2}">
												<b> <c:out value = "${flightnotes.delayCode4}"/></b>-${flightnotes.delayCode4_time}
												
										</c:if>


								       </td>
								 
	
									  <td>
			
										    <c:forEach var="fltnote" items="${flightnotes.getFlightNoteRemarks()}"> 
									                 ${fltnote} <br>
									         </c:forEach>
							  
								  </tr>	
								  		
			

		
			     <c:if test="${fn:length(flightnotes) < 1}">
			    
			       <tr> 
			       <td colspan="10" align="center"> <b>No flight delays. </b></td>
			       </tr>
			    
			     </c:if>				
				
			     
  	    		
				    
    </table>	
  
   </div>
   
   
   
   
   
   <!-- SECOND TAB FOR THE CANCLE FLIGHTS  -->
   	<div id="menu2" class="tab-pane fade"> 
   	
 	<table class="table table-striped table-bordered" border="1" style="width: 100%;background:rgba(255,255,255);" align="left">	
		
		    		
				    
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
	      document.getElementById("flightid").innerHTML = flightid+"&nbsp;&nbsp;("+fromstn+")<img src='flightarrow.png'>("+tostn+")";
	      document.getElementById("datopdisplay").innerHTML = " Date: "+datop;

          //-- Add value to the hidden form         
	       document.getElementById("flightno").value = flightid;
	       document.getElementById("datop").value    = datop;
	       document.getElementById("fromstn").value  = fromstn;
	       document.getElementById("tostn").value    = tostn;
	       document.getElementById("addedby").value  = emailid;



	   	   var tableheader ="<table id='displaydata' class='table table-striped table-bordered' border='1' style='width:100%;background:rgba(255,255,255);' align='left'><tr><td bgcolor='#0070BA' width='14%'> <span style='font-size: 12px;color:white;'> <b> Comment On</b></span></td> <td bgcolor='#0070BA'  ><span style='font-size: 12px;color:white;'> <b>Feedback </b></span></td> <td bgcolor='#0070BA' width='15%'><span style='font-size: 12px;color:white;'> <b> Added By</b></span></td></tr>";
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
					var i = 0;
					for (i = 0; i < result.length; i++) {
						s += "<tr bgcolor='#FDEBD0'> <td  style='font-size: 12px;'>"+result[i].dateTimeEntered+"</td><td style='font-size: 12px;'>"+result[i].comments+"</td><td style='font-size: 12px;'>"+result[i].enteredBy+"</td></tr>"; 
						
						/*
						s += '<br/>Id: ' + result[i].flightNumber;
						s += '<br/>Name: ' + result[i].flightNumber;
						s += '<br/>Price: ' + result[i].flightNumber;
						s += '<br/>___________________________';
						*/
					}	
					s += "</table>";			 
					$('#displaydata').html(s);
					if(i == 0){$('#displaydata').html("");}
				}
			});  



           //-- Click and Open Model
	       document.getElementById("flightmodelbutton").click();
  }





//-------- This will Open Model Where Feedback will be Entered ----------------
function open_model_toAdd_Comment_After_Add(flightid,datop,fromstn,tostn,emailid){

          //- Display of the  Model  
	      document.getElementById("flightid").innerHTML = flightid+"&nbsp;&nbsp;("+fromstn+")<img src='flightarrow.png'>("+tostn+")";
	      document.getElementById("datopdisplay").innerHTML = " Date: "+datop;

          //-- Add value to the hidden form         
	       document.getElementById("flightno").value = flightid;
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
					for (var i = 0; i < result.length; i++) {
						s += "<tr bgcolor='#FDEBD0'> <td  style='font-size: 12px;'>"+result[i].dateTimeEntered+"</td><td style='font-size: 12px;'>"+result[i].comments+"</td><td style='font-size: 12px;'>"+result[i].enteredBy+"</td></tr>"; 
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
      
       
      <div class="modal-header"  >
        <h3 class="modal-title" style="color:black;" id="flightid"></h3> 
         <h5 style="color:black;" class="modal-title" id="datopdisplay"></h5>
        
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      
      <div class="modal-body">
      
          <table id="displaydata" class="table table-striped table-bordered" border="1" style="width:100%;background:rgba(255,255,255);">	
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



