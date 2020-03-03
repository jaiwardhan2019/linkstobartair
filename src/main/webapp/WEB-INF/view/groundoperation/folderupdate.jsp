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
  <input type="hidden" name="cat" id="cat" value="GEN">
 
 <br>
 <br>		

		
	<div class="row" align="center">
	

		<div  align="center" style="width:65%;">
			
			<div class="panel panel-primary" style="background:rgba(255,255,255);">
		
				
				
			   <c:if test="${profilelist.docmanager  == 'Y'}">
					<div class="panel-heading" style="background:#0070BA;">
						<h3 class="panel-title"><a href="javascript:void();" onClick="calDocumentUpdate('listdocuments?cat=home&operation=view');">${foldername}</a>
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
						
						
					<thead>
							<tr>
								<th>Sr.</th>
								<th>Description</th>
								<th >Dated </th>
								<th>Category</th>
							</tr>
						</thead>
	
						
			<c:forEach var="contract" items="${gopsfilelist}">    
							<tr>
								<td width="3%"><%=ctr++%>.</td>
								<td width="70%">
								    <img src="${contract.docType}.png"> &nbsp; <a href="<%=request.getParameter("cat").toUpperCase()%>/${contract.docName}" target="_new">
								                  ${contract.docName}    								
								    </a>
								</td>								
								<td>${contract.docAddedDate}&nbsp;&nbsp;&nbsp;&nbsp;</td>
								<td>${contract.docCategory} &nbsp;&nbsp;&nbsp;<i  class="fa fa-trash" aria-hidden="true"></i>
							  		  <span style="font-size:9pt;">
							   				 <a style="color:red;" href="javascript:void();" onClick="calDocumentUpdate('listdocuments?cat=GEN&docid=${contract.docId}&operation=remove');">Rem </a>
							   		 </span>
							    </td>
							</tr>
			</c:forEach>
							
       </c:if>
       
       
   
		<tr>
					<td align="right" colspan="3">
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
                                 <span onClick="addDocument('GEN');" id="addnew" class="btn btn-primary" > &nbsp;Upload &nbsp;<i class="fa fa-cloud-upload" aria-hidden="true"></i>  </span>  
                                  
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
<c:if test = "${rowcount <= 5}">	
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>  
</c:if>

<%@include file="../include/gopsfooter.jsp" %>

