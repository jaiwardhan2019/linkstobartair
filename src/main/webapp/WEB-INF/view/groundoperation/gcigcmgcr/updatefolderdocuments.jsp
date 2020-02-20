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
	
	     document.getElementById("addnew").innerHTML = "<i class='fa fa-refresh fa-spin fa-lx' aria-hidden='true'></i>&nbsp;&nbsp;Searching..&nbsp;&nbsp;";
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




function addDocument(category){

	     var filename = document.getElementById("gfile");
	     if(filename.value == ''){
           alert("Please select file to be added");
           filename.focus();
           return false;           
	     }
	     
	     document.getElementById("addnew").innerHTML = "<i class='fa fa-refresh fa-spin fa-lx' aria-hidden='true'></i>&nbsp;&nbsp;Uploading..&nbsp;&nbsp;";
	     
	    
		 document.documentmaster.method="POST";
		 document.documentmaster.action="addfiletofolder?cat="+category;
	     document.documentmaster.submit();
		 return true;

}




</script>



<body>

 
 <form name="documentmaster" id="documentmaster" enctype="multipart/form-data">   
  
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
						<h3 class="panel-title"><a href="javascript:void();" onClick="calDocumentUpdate('listdocuments?cat=<%=request.getParameter("cat")%>&operation=read');">${foldername}</a>
						    <i class="fa fa-eye" aria-hidden="true"></i>
						    &nbsp; &nbsp; &nbsp;${status}
						</h3>
					</div>
				</c:if>
				
				
				<div class="panel-body">
					<table class="table" align="center" style="background:rgba(255,255,255);">	    
						<thead>
							<tr>
								<th>Sr.</th>
								<th>Description</th>
								<th>Dated </th>
								<th>Category</th>
								<th> &nbsp</th>
							</tr>
						</thead>
	
	
	
	
	   <c:set var = "rowcount"  value = "${fn:length(gopsfilelist)}"/>
       <c:if test = "${rowcount == 0}">
          
             <tr>
             
               <td colspan="5" align="center">
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
								<td width="60%"><img src="${contract.docType}.png"> &nbsp; ${contract.docName}</td>
								<td width="15%">${contract.docAddedDate}</td>
								<td width="8%">${contract.docCategory}</td>
							    <td align="center"><i class="fa fa-trash" aria-hidden="true"></i>
							    <span style="color:red;font-size:9pt;">
							    Rem
							    </span>
							    </td>
							</tr>
			</c:forEach>
							
       </c:if>
       
       
       
	 
		<tr>
					<td align="center" colspan="3">
					    <br>
						<div class="col-xs-05">
							<div class="input-group"> 
								<span class="input-group-addon"><i class="fa fa-paperclip fa-lg" aria-hidden="true"></i>&nbsp;&nbsp;<b>Add New File</b></span>							
									 <input type="file"  id="gfile"  name="gfile"   class="form-control"/>
							 </div>
							 									 
							 
				        </div>
						</td>
						
							<td align="left" colspan="2" >
							  <br>
															 
                                 <span onClick="addDocument('<%=request.getParameter("cat")%>');" id="addnew" class="btn btn-primary" > &nbsp;Upload &nbsp;<i class="fa fa-cloud-upload" aria-hidden="true"></i>  </span>  
                                    
									
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




