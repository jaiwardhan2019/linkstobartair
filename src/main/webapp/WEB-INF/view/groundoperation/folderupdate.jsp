<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="../include/groundopsheader.jsp" />

<head>
    <title> Dashboard | Show All Documents. </title>    
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
	
	     document.getElementById("addnew").innerHTML = "<i class='fa fa-refresh fa-spin fa-lx' aria-hidden='true'></i>&nbsp;&nbsp;Searching..&nbsp;&nbsp;";
	     //<input type="button"  class="btn btn-primary" value="Show Report" onclick="showFlightReport();" />        
	     //search_progress();
		 document.FlightReport.method="POST";
		 document.FlightReport.action="flightreport";
	     document.FlightReport.submit();
	     return true;
}	




function calDocumentUpdate(reportname){

		var str = reportname;
		var re = /remove/i;

		var str = reportname;
		var pos = str.indexOf('remove');
        if(pos != -1){
		
	       if(confirm("Are you sure about removing this file..??")){
	    	 document.documentmaster.method="POST";
	  		 document.documentmaster.action=reportname;
	  	     document.documentmaster.submit();
	  		 return true;
		   }
	       else
		   {
             return false;
		   } 
           
	         
	    }
	    
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
	     search_progress();
	     document.getElementById("addnew").innerHTML = "<i class='fa fa-refresh fa-spin fa-lx' aria-hidden='true'></i>Uploading..";
	     
	    
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
  <input type="hidden" name="cat" id="cat" value="<%=request.getParameter("cat")%>">
 
 <br>
 <br>		

		
	<div class="row" align="center">
	

		<div  align="center" style="width:65%;">
			
			<div class="panel panel-primary" style="background:rgba(255,255,255);">
		
				
				
			   <c:if test="${profilelist.docmanager  == 'Y'}">
					<div class="panel-heading" style="background:#0070BA;">
						<h3 class="panel-title"><a href="javascript:void();" onClick="calDocumentUpdate('listdocuments?cat=<%=request.getParameter("cat")%>&operation=view');">${foldername}</a>
						    <i class="fa fa-eye" aria-hidden="true"></i>
						    &nbsp; &nbsp; &nbsp;${status}
						</h3>
					</div>
				</c:if>
				
				
				<div class="panel-body">
	
	
					<table class="table" align="center" style="background:rgba(255,255,255);">	    
	
	
	
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
						
						
					<thead>
							<tr>
								<th>Sr.</th>
								<th>Description</th>
								<th >Dated </th>
								<th>Category</th>
								<th>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Del</th>
							</tr>
						</thead>
	
						
			<c:forEach var="contract" items="${gopsfilelist}">    
							<tr>
								<td ><%=ctr++%>.</td>
								<td width="70%">
								    <img src="${contract.docType}.png"> &nbsp; <a href="${contract.docCategory}/${contract.docName}" target="_new">
								                  ${contract.docName}    								
								    </a>
								</td>								
								<td width="10%">${contract.docAddedDate}</td>
								<td >&nbsp;&nbsp;${contract.docCategory}
								</td>
								
								<td>&nbsp;&nbsp;&nbsp;
								  <i  class="fa fa-trash" aria-hidden="true"></i>
							  		  <span style="font-size:9pt;">
							   				 <a style="color:red;" href="javascript:void();" onClick="calDocumentUpdate('listdocuments?docid=${contract.docId}&operation=remove');">Rem </a>
							   		 </span>
							    </td>
							</tr>
			</c:forEach>
							
       </c:if>
       
       
   <c:if test="${param.cat != 'home'}">    
	 
		<tr>
					<td align="right" colspan="4">
					    <br>
						<div class="col-xs-05">
							<div class="input-group"> 
								<span class="input-group-addon"><i class="fa fa-paperclip fa-lg" aria-hidden="true"></i>&nbsp;&nbsp;<b>Add New</b></span>							
									 <input type="file"  id="gfile"  name="gfile" multiple  class="form-control"/>
							 </div>
								 
				        </div>
				    
						</td>
		
		
		
		
						
							<td align="left">
							  <br>															 
                                 <span onClick="addDocument('<%=request.getParameter("cat")%>');" id="addnew" class="btn btn-primary" >&nbsp;Upload&nbsp;<i class="fa fa-cloud-upload" aria-hidden="true"></i>  </span>  
                                  
							</td>
								
	     	</tr>
	     	
	       <tr>
		    <td colspan="5">
					    <span style="display:none" id="searchbutton1">
					              <div class="progress-bar progress-bar-striped active" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width:100%">
							        In Progress Please wait... 
							      </div>   
					        </span>
		   </td>
		</tr>	     	
	     	
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
<c:if test = "${rowcount <= 5}">	
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>  
	<br>
	<br> 
</c:if>

<%@include file="../include/gopsfooter.jsp" %>

