<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="../../include/groundopsheader.jsp" />

<head>
    <title> Dashboard | Show All Documents. </title>    
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
  
  <input type="hidden" name="emailid" value="<%=request.getParameter("emailid")%>">
  <input type="hidden" name="password" value="<%=request.getParameter("password")%>">
  <input type="hidden" name="usertype" value="${usertype}">
  <input type="hidden" id="cat" value="<%=request.getParameter("cat")%>">
 
 <br>
 <br>		

		
	<div class="row" align="center">
	

		<div  align="center" style="width:65%;">
			
			<div class="panel panel-primary" style="background:rgba(255,255,255);">
		
				
				
			   <c:if test="${profilelist.gopsadmin  == 'Y'}">
					<div class="panel-heading" style="background:#0070BA;">
						<h3 class="panel-title"><a href="javascript:void();" onClick="calDocumentUpdate('listdocuments?cat=<%=request.getParameter("cat")%>&operation=update');">${foldername}</a>
						    &nbsp;<i class="fa fa-pencil-square-o" aria-hidden="true"></i>
						    
						</h3>
					</div>
				</c:if>
				
				
				
			   <c:if test="${profilelist.gopsadmin  != 'Y'}">
					<div class="panel-heading" style="background:#0070BA;">
						<h3 class="panel-title">${foldername}	
						 		    
						</h3>
					</div>
				</c:if>
				
				
				
				
				
				
				
				<div class="panel-body">
					<table class="table" align="center" style="background:rgba(255,255,255);">	    
						<thead>
							<tr>
								<th>Sr.</th>
								<th>Description</th>
								<th>Dated</th>
								<th>Category</th>
							
							</tr>
	
			   <c:set var = "rowcount"  value = "${fn:length(gopsfilelist)}"/>
		       <c:if test = "${rowcount == 0}">
		          
		             <tr>
		             
		               <td colspan="4" align="center">
		                    <span style="color:blue;font-size:10pt;"> Sorry No Document found&nbsp;!!&nbsp;&nbsp;<i class="fa fa-frown-o  fa-lg"> </i>
		                    
		              </td>
		             
		             </tr>
		       
		       </c:if>
		    
		    
    <tbody>  
    
	
	  
		     <% 
		      int ctr=1;
		     %>
			 <c:if test = "${rowcount > 0}">
								
					<c:forEach var="contract" items="${gopsfilelist}">    
									<tr>
										<td width="4%"><%=ctr++%>.</td>
										<td width="70%"><img src="${contract.docType}.png"> &nbsp; <a href="<%=request.getParameter("cat")%>/${contract.docName}" target="_new">
										
										
										${contract.docName}
										
										
										</a></td>
										<td >${contract.docAddedDate}</td>
										<td >${contract.docCategory}</td>
									    
									</tr>
					</c:forEach>
									
		       </c:if>
		       
		        
	
							</tbody>
					</table>
				</div>
			</div>
			
		</div>
 </div>
 
 </form>
</body>

<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>

<%@include file="../../include/gopsfooter.jsp" %>




