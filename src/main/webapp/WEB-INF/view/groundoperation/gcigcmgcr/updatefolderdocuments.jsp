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
 
 <br>
 <br>		

		
	<div class="row" align="center">
	

		<div  align="center" style="width:55%;">
			
			<div class="panel panel-primary" style="background:rgba(255,255,255);">
		
				
				
			   <c:if test="${profilelist.gopsadmin  == 'Y'}">
					<div class="panel-heading" style="background:#0070BA;">
						<h3 class="panel-title"><a href="javascript:void();" onClick="calDocumentUpdate('listdocuments?cat=gci&operation=read');">${foldername}</a>
						    <i class="fa fa-eye" aria-hidden="true"></i>
						
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
								<th> &nbsp</th>
							</tr>
						</thead>
						
						<tbody>
							<tr>
								<td width="5%">1.</td>
								<td width="15%">10 Jan 2020</td>
								<td width="55%"><img src="pdf.png">&nbsp;First File Name for the test</td>
								<td width="10%">GHB</td>
							    <td width="10%" ><i class="fa fa-trash" aria-hidden="true"></i>&nbsp;Remove</td>
							</tr>

							<tr>
								<td width="5%">2.</td>
								<td width="15%">10 Jan 2020</td>
								<td width="55%"><img src="pdf.png">&nbsp;First File Name for the test</td>
								<td width="10%">GHB</td>
							    <td width="10%" ><i class="fa fa-trash" aria-hidden="true"></i>&nbsp;Remove</td>
							</tr>
							<tr>
								<td width="5%">3.</td>
								<td width="15%">10 Jan 2020</td>
								<td width="55%"><img src="pdf.png">&nbsp;First File Name for the test</td>
								<td width="10%">GHB</td>
							    <td width="10%" ><i class="fa fa-trash" aria-hidden="true"></i>&nbsp;Remove</td>
							</tr>
							<tr>
								<td width="5%">4.</td>
								<td width="15%">10 Jan 2020</td>
								<td width="55%"><img src="pdf.png">&nbsp;First File Name for the test</td>
								<td width="10%">GHB</td>
							    <td width="10%" ><i class="fa fa-trash" aria-hidden="true"></i>&nbsp;Remove</td>
							</tr>
				
	 
							<tr>
								<td align="center" colspan="3">
								    <br>
									<div class="col-xs-05">
										<div class="input-group"> 
											<span class="input-group-addon"><i class="fa fa-paperclip fa-lg" aria-hidden="true"></i>&nbsp;&nbsp;<b>Add New File</b></span>							
												 <input type="file"  id="cfile"  name="cfile"   class="form-control"/>
										 </div>
										 									 
										 
							        </div>
									</td>
								
								<td align="left" colspan="2" >
								  <br>
																 
	                                 <span onClick="alert('Under Construction');" id="addnew" class="btn btn-primary" > &nbsp;Upload &nbsp;<i class="fa fa-cloud-upload" aria-hidden="true"></i>  </span>  

										
								</td>
								
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




