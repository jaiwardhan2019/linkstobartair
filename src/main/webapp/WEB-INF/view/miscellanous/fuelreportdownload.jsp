<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<jsp:include page="../include/header.jsp" />


<head>
    <title> Stobart Air Fuel Report Download EXCEL </title>    
</head>

<script src="https://canvasjs.com/assets/script/canvasjs.min.js"></script>

<script type="text/javascript">

//--- Validating Uploaded File
// --https://www.codeproject.com/Questions/873759/How-do-I-read-contents-of-multiple-files-with-File


function search_progress() {
    var e = document.getElementById("convertbtn");
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





function Search_Invoice() {
		search_progress();
		document.fuelinvoice.method = "POST"
		document.fuelinvoice.action = "fuelreportdownload";
		document.fuelinvoice.submit();
		return true;
	
}//---------- End Of Function  ------------------






//*** Here this function will update data in the form to database and write back to the DIV 
function Download_ExcelReport(){

		 var emailId = document.getElementById("profilelist").value;
		 emailId    = emailId.split("#",1);
		
		document.getElementById("downloading").innerHTML ="<i class='fa fa-refresh fa-spin fa-lx' aria-hidden='true'></i>&nbsp;&nbsp;&nbsp;Downloading....";
		//search_progress();
		 if(document.getElementById("financialyear").value == ""){document.getElementById("financialyear").value=getCurrentYear();}
		 var urldetail ="downloadfuleinvoiceinexcelfile?financialyear="+document.getElementById("financialyear").value; 
		 urldetail = urldetail +"&emailid="+emailId;
		 urldetail = urldetail +"&batch="+document.getElementById("batch").value;		
		 urldetail = urldetail +"&invoiceno="+document.getElementById("invoiceno").value;	
		 //alert(urldetail);
		 
		 
  
		  $.ajax({
				  url : urldetail,
				  type:"POST",
				  success : function(result)
				  {
					//document.getElementById("searchbutton1").style.display = "none";
		      	    //document.getElementById("downloading").innerHTML = "<i class='fa fa-file-excel-o' aria-hidden='true'></i>&nbsp;Excel Report&nbsp;";
		      	    //window.location = emailId+"/onTimePerformanceFlightReport.xls";	           
		                      
					}// ------ END OF SUCCESS ----  
		
		}); //----- END OF AJAX FUNCTION ------- 
		


	

}//-------- END OF FUNCTION ---------------


function getCurrentYear(){
		  var dateNow = new Date();
		  var currentYear = dateNow.getFullYear().toString().substr(-2);		  
          return currentYear;
}

	
	
</script>



 
 <br>
 
 <div  style="margin-top:60px;" align="center">	
	
		<div class="col-md-12 col-sm-12 col-xs-12"  align="left">
			<i class="fa fa-cogs fa-2x" aria-hidden="true"></i>&ensp;&ensp;<span style="font-weight:600;font-size:13pt;">Fuel Report Download.</span></a>
	   </div>	
  
  </div>		
 <br>
 <br>
 <br>

 <body>
   
 <div class="container" align="center">
 
   <div class="col-md-6 col-md-offset-3 col-sm-12 col-xs-12">	

         <div class="panel-shadow"> 
		
 
 <form name="fuelinvoice"  method="post" >
  
    <input type="hidden" id="profilelist" name="profilelist" value="${profilelist}">
       
      <table class="table table-striped table-bordered" border="1" style="width:100%;" align="center">	    
    		<tbody>				     
			     <tr align="center">
					 <td  bgcolor="#0070BA" colspan="4">
					   <span style="color:white;"> <i class="fa fa-file-excel-o" aria-hidden="true"></i> &nbsp;<b>
					    Search & Download Fuel Report &nbsp;&nbsp;
					   </b></span>					 
					 </td>
			     </tr>
			
	           
	           <tr>
							<td align="right" bgcolor="white">
							
									<label>Fin. Year </label>
							</td>

							<td align="left" bgcolor="white" width="35%">
					          <div >
								    <div class="input-group">
									    <span class="input-group-addon"><i class="fa fa-calendar" aria-hidden="true"></i></span>
                                               <input type="text" name="financialyear" id="financialyear"  class="form-control" value="${financialyear}"/>
								     </div>
					           </div>	  
					           
					                        	               
	                    </td>
	                    
	                    <td align="right" bgcolor="white">
							
							<label>Batch </label>
							</td>

							<td align="left" bgcolor="white" width="35%">
					          <div >
								    <div class="input-group">
									    <span class="input-group-addon"><i class="fa fa-truck" aria-hidden="true"></i></span>
                                               <input type="text"  name="batch" id="batch" value="${batch}" class="form-control"/>
								     </div>
					           </div>	  
					           
					                        	               
	                    </td>
	           </tr>
	    
	         
	                <tr >
                       <td align="right" bgcolor="white" >
							
							<label>Invoice No. </label>
							</td>

							<td align="left" bgcolor="white" width="35%">
					          <div >
								    <div class="input-group">
									    <span class="input-group-addon"><i class="fa fa-file-pdf-o" aria-hidden="true"></i></span>
                                               <input type="text"  id="invoiceno"  name="invoiceno" class="form-control" value="${invoiceno}"/>
								     </div>
					           </div>	  
					           
					                        	               
	                    </td>
				     </tr>
		
	    
	           
         
	                <tr align="center" >
				     					
						<td  bgcolor="white" colspan="4">	
						
					        <span style="display:block" id="convertbtn">
					           <input type="button"  class="btn btn-primary" value="Search Invoice" onclick="Search_Invoice();" /> 
					        </span>
						        
					        <span style="display:none" id="searchbutton1">
					                <div class="progress-bar progress-bar-striped active" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width:100%">
							         <b> Populating Invoice please wait....</b>&nbsp;&nbsp;<i class="fa fa-spinner fa-pulse fa-2x"></i>
							         </div>
					        </span>
						        
					        
			 			     </td>
				     </tr>
				     			
					 <c:if test="${fn:length(status) > 1}">
					      <tr align="left">				     					
							<td  bgcolor="white" colspan="2"> <span style="color:red">${status}</td>
						  </tr>	
					 
					 </c:if>
					 
					 
				    </tbody>
			</table>
	   </form>     
     </div>

  </div>
</div>  	



 
	   
 <div class="container" align="center">
 
 <div class="col-md-12 col-sm-12 col-xs-12" align="left" >
 
 

	    <div class="col-md-12 col-sm-12 col-xs-12">
	    
	        <c:if test="${fn:length(invoicelist) < 1}">
			      <table align="center">    
				       <tr align="center"> 
				          <td colspan="12" align="center"> <b>Sorry there is No Invoice on your Selected Search Criteria. </b></td>
				       </tr>
			      </table>
		     </c:if>				
	    
	    
	    
            <c:if test="${fn:length(invoicelist) > 0}"> 
             	<table class="table table-responsive"  style="background:rgba(255,255,255);font-weight:600;font-size:09pt;">	
				      
				      <tbody>
			          	       <tr align="right"> 
	                              <td colspan="12" align="right">
	                                      	    <button onclick="Download_ExcelReport();" id="downloading" type="button" class="btn  btn-sm"> 
        	                                      <img src="xls.png"> &nbsp;<b>  Download  </b> &nbsp;<i class="fa fa-download fa-lg" aria-hidden="true"></i>
        	                                    </button>
	                              </td>
	                           </tr>
			          
							<tr bgcolor="#0070BA"  style="color:white;">
								<th width="1%">Sr.</th>
								<th >Invoice No</th>
								<th>Invoice Date</th>
								<th>Batch</th>	
							    <th width="25%">Supplier Code - Name</th>	
								<th >Franchise</th>	
								<th >Amount </th>
								<th > IATA Code </th>
								<th > Flight No </th>
								<th > Aircraft  Reg</th>
								<th > Charge Type</th>
							</tr>
					
					      <% 
					       int ctrLst=1;   
					       %>
						 <c:forEach var="invlist" items="${invoicelist}"> 
							
							<tr>
							
							 <td><%=ctrLst++%></td>
							 
							 <td>${invlist.invoiceNo}</td>
							 <td>${fn:substring(invlist.invoiceDate, 0, 11)}</td>
							 <td>${invlist.invoiceBatch}</td>
							
							 <td>${invlist.invoiceSupplierCode} - &nbsp;${invlist.invoiceSupplierName}</td>
							 <td>${invlist.franchiseName}</td>
							 <td>${invlist.invoiceAmount}</td>
							 <td>${invlist.invoiceIataCode}</td>
							 <td>${invlist.flightNo}</td>
							 <td>${invlist.airCraftReg}</td>
							 <td>${invlist.feeType}</td>
							 
							 
							</tr>
							
							</c:forEach>
				
                      </tbody>
                 </table>     
            
               </c:if>	
            


			</div>
		</div>
	</div>
















 

<!--  END of UPPER FORM PART   -->

</body>


<!--  START OF REPORT  PART   -->
<br>
<br>
<br>
<br>
<br>
<br>
<%@include file="../include/footer.jsp" %>

