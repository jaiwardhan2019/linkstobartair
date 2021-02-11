<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="../include/gopsheader.jsp" />

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
 
 
<div class="container-fluid" style="margin-top:80px;">	
		
	<div class="row" align="center">
			
	    <div class="col-md-8 col-md-offset-2 col-sm-12 col-xs-12">		     
			
		 	<div class="panel panel-primary" style="overflow-x:auto;">
			
							<div class="panel-heading" >  
							
								  <c:if test = "${fn:contains(profilelist, 'docmanager')}"> 
					 		          
											<c:if test="${alfresco  != 'YES'}">
											           ${foldername} &nbsp;&nbsp;&nbsp;
												<a href="javascript:void();" onClick="calDocumentUpdate('listdocuments?cat=<%=request.getParameter("cat")%>&operation=update');">
												    <span class="label label-success">Update List &nbsp;<i class="fa fa-pencil-square-o" aria-hidden="true"></i></span>
												</a>
											</c:if>
											
											<c:if test="${alfresco  == 'YES'}">
												${foldername}								    
											</c:if>
				                 
				   	                </c:if>
				   	           
				   	           
				   	                 <c:if test="${fn:indexOf(profilelist,'docmanager') == -1}">
						
									         ${foldername}
							
						 	          </c:if>
							
								
							</div> <!-- End of class="panel-heading"> -->
						
						
			<div class="panel-body" style="overflow-x:auto;" width="80%">
				
		     	<table class="table table-responsive"  style="background:rgba(255,255,255);">	
				      
				      <tbody>
			         
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

		    					
					 
			
							<tr>
								<th>Sr.</th>
								<th>Description</th>
								<!-- <th>Added Date</th>
								<th align="center">Category</th>	
								 -->						
							</tr>
          
								
					<c:forEach var="contract" items="${gopsfilelist}">    
							 
							 <tr>
										<td width="2%"><%=ctr++%>.</td>
										<td width="70%"><img src="${contract.docType}.png">&nbsp;
										
										<c:choose>
										  <c:when test = "${fn:contains(contract.docCategory, 'FORM')}">
										    <a href="FORMS/${contract.docCategory}/${contract.docName}" target="_new">
										    
										     <c:set var="string1" value=" ${contract.docName}"/>
                                                    <c:set var="string2" value="${fn:substring(string1, 0,120)}" />
			                                            ${string2}
										    </a>
											  </c:when>
										  <c:when test = "${fn:contains(contract.docPath, 'WEIGHTSTATEMENT')}">
										    <a href="WEIGHTSTATEMENT/${contract.docCategory}/${contract.docName}" target="_new">
										    
										        <c:set var="string1" value=" ${contract.docName}"/>
                                                    <c:set var="string2" value="${fn:substring(string1, 0,120)}" />
			                                            ${string2}
										       </a>
										  </c:when>
										  <c:otherwise>
										     <a href="${contract.docCategory}/${contract.docName}" target="_new">										    
										        <c:set var="string1" value=" ${contract.docName}"/>
                                                    <c:set var="string2" value="${fn:substring(string1, 0,120)}" />
			                                              ${string2}
										       </a>
										  </c:otherwise>
										</c:choose>										
										
										
										</td>
										<!-- 
										<td >${contract.docAddedDate}</td>
										
										<td align="left">										 
										 		<c:set var="string1" value="${contract.docCategory}"/>
                                                <c:set var="string2" value="${fn:substring(string1, 0,6)}" />
			                                      ${string2}
										 </td>
										  -->
									    
									</tr>
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

<%@include file="../include/gopsfooter.jsp" %>




