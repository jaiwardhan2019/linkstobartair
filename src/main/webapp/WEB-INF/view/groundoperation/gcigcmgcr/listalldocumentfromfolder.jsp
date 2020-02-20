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
	

		<div  align="center" style="width:55%;">
			
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
						     ${gopsfilelist}  			    
						</h3>
					</div>
				</c:if>
				
				
				
				
				
				
				
				<div class="panel-body">
					<table class="table" align="center" style="background:rgba(255,255,255);">	    
						<thead>
							<tr>
								<th>Sr.</th>
								<th>Dated </th>
								<th>Description</th>
								<th>Category</th>
								<th> </th>
							</tr>
						</thead>
						
						<tbody>
							<tr>
								<td width="3%">1.</td>
								<td width="18%">10 Jan 2020</td>
								<td width="70%"><img src="pdf.png">&nbsp;First File Name for the test the testthe testthe testthe testthe testthe testthe </td>
								<td width="5%">GHB</td>
							</tr>
						<tr>
								<td width="6%">2.</td>
								<td width="18%">10 Jan 2020</td>
								<td width="55%"><img src="pdf.png">&nbsp;First File Name for the test</td>
								<td width="6%">GHB</td>
							</tr>
							<tr>
								<td width="6%">3.</td>
								<td width="18%">10 Jan 2020</td>
								<td width="55%"><img src="pdf.png">&nbsp;First File Name for the test</td>
								<td width="6%">GHB</td>
							</tr>
						<tr>
								<td width="6%">4.</td>
								<td width="18%">10 Jan 2020</td>
								<td width="55%"><img src="pdf.png">&nbsp;First File Name for the test</td>
								<td width="6%">GHB</td>
							</tr>
						<tr>
								<td width="6%">5.</td>
								<td width="18%">10 Jan 2020</td>
								<td width="55%"><img src="pdf.png">&nbsp;First File Name for the test</td>
								<td width="6%">GHB</td>
							</tr>
		
	
	 
	
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




