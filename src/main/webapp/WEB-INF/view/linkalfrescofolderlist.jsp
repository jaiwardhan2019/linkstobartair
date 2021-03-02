<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="include/header.jsp"></jsp:include>

<head>
    <title> Dashboard | Show  Documents. </title>    
</head>


<script src="https://canvasjs.com/assets/script/canvasjs.min.js"></script>

<script type="text/javascript">


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

function showFlightReport(){
	
	     document.getElementById("searchbutton").innerHTML = "<i class='fa fa-refresh fa-spin fa-lx' aria-hidden='true'></i>&nbsp;&nbsp;Searching..&nbsp;&nbsp;";
	     //<input type="button"  class="btn btn-primary" value="Show Report" onclick="showFlightReport();" />        
	     //search_progress();

		 document.FlightReport.method="POST";
		 document.FlightReport.action="flightreport";
	     document.FlightReport.submit();
	     return true;
}	





function calDocumentUpdate(reportname){
		 document.documentmaster.method="POST";
		 document.documentmaster.action=reportname;
	     document.documentmaster.submit();
		 return true;
}



</script>



<body>

 
 <form name="documentmaster" id="documentmaster">   
  
  <input type="hidden" id="profilelist" name="profilelist" value="${profilelist}">
  <input type="hidden" name="usertype" value="${usertype}">
  <input type="hidden" id="cat" value="<%=request.getParameter("cat")%>">
 
<br>
<br>
<br>


<div class="container-fluid" style="margin-top:80px;">	
		
	<div class="row" align="center">
			
	    <div class="col-md-8 col-md-offset-2 col-sm-12 col-xs-12">		     
			
		 	<div class="panel panel-primary" style="overflow-x:auto;">
			
				<div class="panel-heading" style="background:#0070BA;">  
					
					   <c:if test = "${fn:contains(profilelist,'docmanager')}">
					              
					        
								  
								     <h3 class="panel-title">
								            <b> ${foldername} </b> 
								               <!-- 
								               &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										       <a href="javascript:void();" onClick="CalAlfresco();">
										           <span class="label label-success">Open Alfresco&nbsp;<i class="fa fa-pencil-square-o" aria-hidden="true"></i></span>
										       </a>
										        -->
								     </h3>
						</c:if>
		
	          </div>
	          
				
			    <c:if test="${fn:indexOf(profilelist,'docmanager') == -1}">  
					<div class="panel-heading" style="background:#0070BA;">
						<h3 class="panel-title">${foldername}
						 		    
						</h3>
					</div>
				</c:if>
				
				
				<div class="panel-body" style="overflow-x:auto;">
				
				<table class="table" align="center" style="background:rgba(255,255,255);">	   
				
					   <c:set var = "rowcount"  value = "${fn:length(gopsfilelist)}"/>
					       <c:if test = "${rowcount == 0}">
					          
					             <tr>
					             
					               <td colspan="4" align="center">
					                    <span style="color:blue;font-size:10pt;"> Sorry No Document found&nbsp;!!&nbsp;&nbsp;<i class="fa fa-frown-o  fa-lg"> </i>
					                    
					              </td>
					             
					             </tr>
					       
					       </c:if>
	
	  
		     <% 
		      int ctr=1;
		     %>
			 <c:if test = "${rowcount > 0}">
		    					
				<thead>
							<tr>
								<th>Sr.</th>
								<th>Description</th>
								<!-- 
								<th>Dated</th>
								<th align="center">Category</th>
								 -->							
							</tr>
                 <tbody>
								
					<c:forEach var="contract" items="${gopsfilelist}">    
					
					
					    
                         <c:if test="${fn:contains(contract, 'Organisational Pandemic Guidance Manual Revision')}">  
			 
									<tr>
										<td width="4%"><%=ctr++%>.</td>
										<td width="70%"><img src="${contract.docType}.png"> &nbsp; 
										    <a href="${contract.docPath}/${contract.docName}" target="_new">${contract.docName}</a>
										</td>
							
									</tr>
					
					       </c:if>
					
					</c:forEach>
									
		       </c:if>
		       
		        
	
							</tbody>
					</table>
					
		            </div> <!-- End of  <div class="panel-body"> -->
					
			    </div>  <!-- Primary end   -->
			
			
			  </div> <!-- Row   -->
			
			</div> <!-- Column   -->
			
		</div><!-- Container Flued   -->
 
 </form>
</body>


<br>
<br>
<br>
<br>
<br>
<br>
<c:if test = "${rowcount <= 5}">	
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>  
</c:if>

<jsp:include page="include/footer.jsp"></jsp:include>




