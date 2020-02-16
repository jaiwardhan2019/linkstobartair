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

</script>



<body>

 
 <form name="documentmaster" id="documentmaster">   
  
  <input type="hidden" name="emailid" value="<%=request.getParameter("emailid")%>">
  <input type="hidden" name="password" value="<%=request.getParameter("password")%>">
  <input type="hidden" name="usertype" value="${usertype}">
 
 <br>
 <br>		

		
	<div class="row" align="center">
	
		<div class="col-md-8 col-md-offset-1 col-sm-8 col-sm-offset-1 col-xs-8" align="center">
			
			<div class="panel panel-primary" style="background:rgba(255,255,255);">
		
				<div class="panel-heading" style="background:#0070BA;">
					<h3 class="panel-title">Folder Name</h3>
				</div>
		
		
		
		
				
				<div class="panel-body">
					<table class="table" align="center" style="background:rgba(255,255,255,0.5);">	    
						<thead>
							<tr>
								<th>Sr.</th>
								<th>Type</th>
								<th>Description</th>
								<th>Updated Date</th>
								
								<th>Updated By</th>
								<th>Remove </th>
							
							</tr>
						</thead>
						
						<tbody>
							<tr>
								<td>1.</td>
								<td>Surajit Majumdar</td>
								<td>+91 9614411550</td>
								<td>hello@surajitmajumdar.com</td>
								<td>Asansol</td>
						
							</tr>
							<tr >
								<td>2.</td>
								<td>Surajit Majumdar</td>
								<td>+91 9614411550</td>
								<td>hello@surajitmajumdar.com</td>
								<td>Asansol</td>
						
							</tr>
							<tr >
								<td>3.</td>
								<td>Surajit Majumdar</td>
								<td>+91 9614411550</td>
								<td>hello@surajitmajumdar.com</td>
								<td>Asansol</td>
			
							</tr>
							<tr >
								<td>4.</td>
								<td>Surajit Majumdar</td>
								<td>+91 9614411550</td>
								<td>hello@surajitmajumdar.com</td>
								<td>Asansol</td>
				
							</tr>
							</tbody>
					</table>
				</div>
			</div>
			
		</div>
 </div>
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




