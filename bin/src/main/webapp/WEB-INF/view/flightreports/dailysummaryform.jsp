<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="../include/header.jsp" />

<head>
    <title> Dashboard | Daily Summary Report </title>    
</head>

<script type="text/javascript">


var airlineLists = new Array(5) 
airlineLists["ALL"] = ["All Airline"]; 
airlineLists["EI"] = ["Regional"]; 
airlineLists["BA"] = ["All Operation"]; 
airlineLists["BE"] = ["All Operation","CPA","Franchise"]; 
airlineLists["KL"]=["All Operation"];  
airlineLists["RE"]= ["All Operation"];  




function Load_Commercial_Operation(selectObj){


	// Get the index of the selected option 
	 var idx = selectObj.selectedIndex; 

	 // get the value of the selected option 
	 var which = selectObj.options[idx].value;
	 // use the selected option value to retrieve the list of items from the countryLists array 
	 var cList = airlineLists[which]; 
	 // get the country select element via its known id 
	 var cSelect = document.getElementById("airlineOperationCode");
	 // remove the current options from the country select 
	 var len=cSelect.options.length; 
	 while (cSelect.options.length > 0){cSelect.remove(0);}
	 var newOption; 
	 // Create new options 
	 for (var i=0; i<cList.length; i++) { 
		 newOption = document.createElement("option"); 
		 newOption.value = cList[i];  // assumes option string and value are the same 
		 newOption.text=cList[i]; 
		 // add the new option 
		 try { 
		 	cSelect.add(newOption);  // this will fail in DOM browsers but is needed for IE 
		 } catch(e){cSelect.appendChild(newOption);} 
	 }//---------- END OF FOR LOOP -------------------------------  

}//------ End Of Function     
 	


function showReport(){
	    
	    if(document.dailySummaryForm.flightDate.value == ""){
	       alert("Please select Date");
	       document.dailySummaryForm.flightDate.focus();
	       return false;
		}else
			{ 
		document.dailySummaryForm.method="POST";
		document.dailySummaryForm.action="flight_daily_summary_report";
	    document.dailySummaryForm.submit();
		return true;
			}
}
   
	
</script>



<body style="font-family: 'Lato', 'Helvetica Neue', Helvetica, Arial, sans-serif;">
<br>
 <br>
 <!-- 
   <div class="container" style="margin-top:60px;">	
		<div class="col-md-12 col-sm-12 col-xs-12" >
			<i class="fa fa-database fa-2x pull-left" aria-hidden="true"></i><span style="font-weight:600;font-size:13pt;">Stobart Air Daily Summary Report&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
			 </span>
	   </div>
  </div>
  --> 	
 <br>
  <br>
   <br>
  <br>
   
 <div class="container" align="left" > 
 
 <form name="dailySummaryForm" id="dailySummaryForm">  
 
      <input type="hidden" name="emailid" id="emailid" value="<%=request.getAttribute("emailid")%>">  
      <input type="hidden" name="password" id="password" value="<%=request.getAttribute("password")%>">  
    	
	 <table class="table table-striped table-bordered" border="1" style="width: 30%;" align="left">	 
	 			
				<tbody>	
		                       				     
				    <tr align="center"> 
				     					
					<td   bgcolor="#0070BA">  
				
					 <span style="color:white;">  <i class="fa fa-database fa-lx" aria-hidden="true"></i> &nbsp; <b>Daily Summary Report Parameter: </b></span>
					 
					  </td>
				     </tr>
		 
					<tr>
					<td align="left" >
						 <b>Operating Airline</b> &nbsp;<i class="fa fa-plane"></i>						
								<select id="airlineCode" name="airlineCode" class="form-control" onChange="Load_Commercial_Operation(this);">
									
									             ${airlinelist}
									             
								    </select>
			            <br>
			            
			        </td>
			        
			        <tr>
			        <td>    
						 <b>Commercial Operation</b> &nbsp;<i class="fa fa-plane"></i>						
								<select id="airlineOperationCode" name="airlineOperationCode" class="form-control">
									   <option value="ALL">All Operations</option>		
								</select>
					           <br>
						       <b> Flight Date</b>  &nbsp;
							   <i class="fa fa-calendar"></i>
							   								
								 <input type="date" id="flightDate" name="flightDate" class="form-control datepicker" maxlength="12" max="${todaydate}" value="${todaydate}" placeholder="(DD/MM/YYYY)"/> 
								<!-- <input type="date" class="form-control datepicker" id="flightDate"  data-provide="datepicker" data-date-format="dd/mm/yyyy" maxlength="12" max="${todaydate}"> -->
						</td>
						
				     </tr>	
				     
				    <tr align="center"> 
				     					
					<td  bgcolor="white">
				       
				      <!--  <input id="Show Report"  class="ibutton" type="button" onclick="showReport();" value="Show Report" />  -->
				       
				       <input type="button" class="btn btn-primary" value="Show Report" onclick="showReport();" /> 
					
				       
				        
				     </td>
				     </tr>
				     
							    
				    </tbody>
			</table>
			
					
		    <table  class="table table-striped table-bordered"  border="0" style="width: 40%;" align="center">	
				    
				
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
                              
		
							   
				        
				        </td>
				    </tr>
		
			
			</table>

</div>		
 		<br>
		<br>	
		<br>
		<br>
 
</body>



<%@include file="../include/footer.jsp" %>