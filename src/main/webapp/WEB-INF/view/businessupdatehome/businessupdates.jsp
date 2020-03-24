<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="../include/header.jsp">
    <jsp:param name="emailid" value="${emailid}" />
    <jsp:param name="password" value="${password}" />
</jsp:include>

<head>
    <meta charset="utf-8">
    <title> Business  | Updates </title>    
</head> 

<script>


function BusinessUpdates(category){
	document.businessupdates.action="businessupdates?businessupdates=yes&news="+category;
    document.businessupdates.submit();
	return true;
}


</script>



<body  style="font-family: 'Lato', 'Helvetica Neue', Helvetica, Arial, sans-serif;">


 
 <form name="businessupdates" method="POST">
   <input type="hidden" id="emailid" name="emailid" value="<%=request.getAttribute("emailid")%>">
   <input type="hidden" id="password" name="password" value="<%=request.getAttribute("password")%>">


<!-- Body Banner -->
<div class="container-fluid" style="margin-top:75px;">
	<div class="row">
		
	<!------------------ LEFT MENU ------------------------->	
		<div class="col-md-2 col-sm-2 col-xs-12">
				
				<div class="panel-group" id="accordion">
					<div class="panel panel-info">
						<div class="panel-heading" style="background:#fff;">
							<span style="font-weight:600;cursor:pointer;color:#000;" data-toggle="collapse" data-parent="#accordion" data-target="#collapse1">
								News<span class="servicedrop1 glyphicon glyphicon-chevron-up pull-right"></span>
							</span>
						</div>
						<div id="collapse1" class="panel-collapse collapse in">
							<ul class="nav nav-pills nav-stacked">
							  <li><a href="javascript:void();" onClick="BusinessUpdates('Latest');" class="leftlist" style="font-size:9.2pt;padding-top:8px;padding-bottom:8px;border-radius:0px;">Latest News</a></li>
							  <li><a href="javascript:void();" onClick="BusinessUpdates('Archive-2019');" class="leftlist" style="font-size:9.2pt;padding-top:8px;padding-bottom:8px;border-radius:0px;">Archives - 2019</a></li>
							</ul>
						</div>
					</div>
						  <!-- 
				  					
					<div class="panel panel-info">
						<div class="panel-heading" style="background:#fff;">
							<span style="font-weight:600;cursor:pointer;color:#000;" data-toggle="collapse" data-parent="#accordion" data-target="#collapse2">
								News Letter <span class="servicedrop2 glyphicon glyphicon-chevron-down pull-right"></span>
							</span>
						</div>
						
						<div id="collapse2" class="panel-collapse collapse">
							<ul class="nav nav-pills nav-stacked">							 
							  <li><a href="#" class="leftlist" style="font-size:9.2pt;padding-top:8px;padding-bottom:8px;border-radius:0px;">March 2020</a></li>
							  <li><a href="#" class="leftlist" style="font-size:9.2pt;padding-top:8px;padding-bottom:8px;border-radius:0px;">Feb 2020</a></li>
							  <li><a href="#" class="leftlist" style="font-size:9.2pt;padding-top:8px;padding-bottom:8px;border-radius:0px;">Jan 2020</a></li>
							</ul>
						</div>
					</div>
				  
	        		<div class="panel panel-info">
						<div class="panel-heading" style="background:#fff;color:#000;">
							<span style="font-weight:600;cursor:pointer;" data-toggle="collapse" data-parent="#accordion" data-target="#collapse3">
								Collapsible Group 3 <span class="servicedrop3 glyphicon glyphicon-chevron-down pull-right"></span>
							</span>
						</div>
						<div id="collapse3" class="panel-collapse collapse">
							<ul class="nav nav-pills nav-stacked">
							  <li><a href="#" class="leftlist" style="font-size:9.2pt;padding-top:8px;padding-bottom:8px;border-radius:0px;">Home</a></li>
							  <li><a href="#" class="leftlist" style="font-size:9.2pt;padding-top:8px;padding-bottom:8px;border-radius:0px;">Menu 1</a></li>
							  <li><a href="#" class="leftlist" style="font-size:9.2pt;padding-top:8px;padding-bottom:8px;border-radius:0px;">Menu 2</a></li>
							  <li><a href="#" class="leftlist" style="font-size:9.2pt;padding-top:8px;padding-bottom:8px;border-radius:0px;">Menu 3</a></li>
							</ul>
						</div>
					</div>
					
					-->
				</div>
		</div>
		
		
		<!----------------- RIGHT CONTENT -------------------->
		<div class="col-md-8 col-sm-8 col-xs-12">
			
			<ul class="breadcrumb">
			  <li><b>Business Updates</b> </li>
			   <li><b>News</b> </li>
			  <li>
			      <i>
			      
			      <%			      
			       if(request.getParameter("news").equals("Latest")){			    	   
			    	  out.println("<span class='label label-success' style='font-size:14px;font-weight:bold;'>"); 
			    	  out.println(request.getParameter("news")+"&nbsp; - All -  2020</span>");
			       }
			       if(request.getParameter("news").equals("Archive-2019")){			    	  
			    	   out.println("<span class='label label-warning' style='font-size:14px;font-weight:bold;'>"); 
			    	   out.println(request.getParameter("news")+"</span>");
			       }			     
			      %>
			       
			       
			       
			       </i>
			       
			       </li>
			  
			   
			</ul>
			
			
			<div class="panel panel-default">
			
				<div class="panel-heading">
				
				
						<table class="table" align="center" style="background:rgba(255,255,255);">	   
			 	
			 						<tr>
										<td width="4%">1.</td>
											<td width="13%" >11 Mar 2020</td>
										
										<td align="left"><img src="pdf.png"> &nbsp; 
										
										    <a href="GCI/GCI 2019.04 EMB Chocking Procedure.pdf" target="_new">GCI 2019.04 EMB Chocking Procedure.pdf</a>
									    </td>
										
									</tr>
					    
									<tr>
										<td width="4%">2.</td>
										<td width="13%" >11 Mar 2020</td>
										<td align="left"><img src="pdf.png"> &nbsp; 
										
										    <a href="GCI/GCI 2019.04 EMB Chocking Procedure.pdf" target="_new">GCI 2019.04 EMB Chocking Procedure.pdf</a>
									    </td>
										
											    
									</tr>
					    
									<tr>
										<td width="4%">3.</td>
											<td width="13%" >11 Mar 2020</td>
										<td ><img src="pdf.png"> &nbsp;
										    <a href="GCI/GCI 2019.06 MAC.pdf" target="_new">GCI 2019.06 MAC.pdf</a>
									    </td>
									</tr>
					    
									<tr>
										<td width="4%">4.</td>
											<td width="13%" >11 Mar 2020</td>
										<td ><img src="pdf.png"> &nbsp; 
											    <a href="GCI/GCI 2019.07 Organisation Structure.pdf" target="_new">GCI 2019.07 Organisation Structure.pdf</a>
										</td>
										
									    
									</tr>
					    
									<tr>
										<td width="4%">5.</td>
									    <td width="13%" >11 Mar 2020</td>
										<td ><img src="pdf.png"> &nbsp; 										
										    <a href="GCI/GCI 2019.08 Passenger Boarding Equipment.pdf" target="_new">GCI 2019.08 Passenger Boarding Equipment.pdf</a>
										
										</td>
										
											    
									</tr>
					    
						    		        
	
							</tbody>
					</table>				
					
					</div>
	
			</div>  <!-- End of Table DIV  -->
			
	
	
	
	
	
	
			
			
			</div>
	</div>

	
</div>

</form>
</body>

<br>
<br>
<br>
	



<%@include file="../include/footer.jsp" %>
