<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="../include/gopsheader.jsp" />

<head>
    <title> Dashboard | Update  Documents. </title>    
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
	     var docCate  = document.getElementById("cat");
	     
	     
	     if(filename.value == ''){
           alert("Please select file to be added");
           filename.focus();
           return false;           
	     }
	     
	     //-- Validate if the TOUCHPOINT Video file is getting uploaded 
	     if(docCate.value == "TOUCHPOINTOVERVIEW"){	    	 
	    	 if(filename.value.includes("mp4") || filename.value.includes("mp3")){
	    		 if(!filename.value.includes("touchpoint.mp4")){  
	    		   alert("Please Rename File to  touchpoint.mp4  \n Then try and upload again...");
	    		   return false;
	    		 } 
	    	 }
	     }
	     
	    
	     
	     search_progress();
	     document.getElementById("addnew").innerHTML = "<i class='fa fa-refresh fa-spin fa-lx' aria-hidden='true'>&nbsp;</i>Adding.";
	     
	    
		 document.documentmaster.method="POST";
		 document.documentmaster.action="addfiletofolder?cat="+category;
	     document.documentmaster.submit();
		 return true;

}




</script>



<body>

 
 <form name="documentmaster" id="documentmaster" enctype="multipart/form-data">   
  
 <input type="hidden" id="profilelist" name="profilelist" value="${profilelist}">
  <input type="hidden" name="usertype" value="${usertype}">
  <input type="hidden" name="cat" id="cat" value="<%=request.getParameter("cat")%>">
  
  

<div class="container-fluid" style="margin-top:80px;">	
		
	<div class="row" align="center">
			
	    <div class="col-md-8 col-md-offset-2 col-sm-12 col-xs-12">		     
			
		 	<div class="panel panel-primary" style="overflow-x:auto;">
			
							<div class="panel-heading" >  
			                    <c:if test = "${fn:contains(profilelist, 'docmanager')}"> 	
	
							  	    ${foldername}	&nbsp; &nbsp; &nbsp;			
								    <a href="javascript:void();" onClick="calDocumentUpdate('listdocuments?cat=<%=request.getParameter("cat")%>&operation=view');"><span class="label label-success">View Mode &nbsp;<i class="fa fa-eye" aria-hidden="true"></i></span></a>
								    ${status}
								
						         </c:if>
				             </div>
		
			<div class="panel-body" style="overflow-x:auto;">
						
				     	<table class="table table-responsive"  style="background:rgba(255,255,255);">	
						      
						      <tbody>

								   <c:set var = "rowcount"  value = "${fn:length(gopsfilelist)}"/>
			
							       <c:if test = "${rowcount == 0}">
							          
							             <tr>
							             
							               <td colspan="5" align="center">
							                    <span style="color:blue;font-size:10pt;"> Sorry No Document found&nbsp;!! </span>&nbsp;&nbsp;<i class="fa fa-frown-o  fa-lg"> </i>
							                    
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
													<th >Added Date.</th>
													<th>Category</th>
													<th>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Del</th>
												</tr>
											</thead>
						
													
										<c:forEach var="contract" items="${gopsfilelist}">    
												<tr>
															<td ><%=ctr++%>.</td>
															<td width="65%">
															    <img src="${contract.docType}.png"> &nbsp; 
																	<c:choose>
																	  <c:when test = "${fn:contains(contract.docCategory, 'FORM')}">
																	    <a href="FORMS/${contract.docCategory}/${contract.docName}" target="_new">
																	    
																	     <c:set var="string1" value=" ${contract.docName}"/>
							                                                    <c:set var="string2" value="${fn:substring(string1, 0,62)}" />
										                                            ${string2}
																	    </a>
																		  </c:when>
																	  <c:when test = "${fn:contains(contract.docPath, 'WEIGHTSTATEMENT')}">
																	    <a href="WEIGHTSTATEMENT/${contract.docCategory}/${contract.docName}" target="_new">
																	    
																	        <c:set var="string1" value=" ${contract.docName}"/>
							                                                    <c:set var="string2" value="${fn:substring(string1, 0,62)}" />
										                                            ${string2}
																	       </a>
																	  </c:when>
																	  <c:otherwise>
																	     <a href="${contract.docCategory}/${contract.docName}" target="_new">										    
																	        <c:set var="string1" value=" ${contract.docName}"/>
							                                                    <c:set var="string2" value="${fn:substring(string1, 0,60)}" />
										                                              ${string2}
																	       </a>
																	  </c:otherwise>
																	</c:choose>										
																	    
															</td>								
															<td width="11%">${contract.docAddedDate}</td>
															  <td align="left">
																	       
																	 		<c:set var="string1" value="${contract.docCategory}"/>
							                                                <c:set var="string2" value="${fn:substring(string1, 0,6)}" />
										                                      ${string2}
														     </td>
															
															<td align="center">
															  <i  class="fa fa-trash" aria-hidden="true"></i>
														  		  <span style="font-size:9pt;">
														   				 <a style="color:red;" href="javascript:void();" onClick="calDocumentUpdate('listdocuments?docid=${contract.docId}&operation=remove');">Rem </a>
														   		 </span>
														    </td>
														</tr>
										</c:forEach>
														
							       </c:if>
		
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
	     	

	     	
	     	
	     	
	     	
	     	
	
							</tbody>
					</table>
				</div>
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
</c:if>

<%@include file="../include/gopsfooter.jsp" %>

