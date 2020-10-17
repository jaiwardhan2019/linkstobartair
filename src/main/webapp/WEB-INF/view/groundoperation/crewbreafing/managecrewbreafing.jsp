<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="../../include/groundopsheader.jsp" />

<head>
    <title> Dashboard | Crew Briefing. </title>    
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
	
	
	
	 		 
		  <table  style="width: 55%;" align="center">
			  <tr>
					 <td align="left"> <font size="4">PPS Crew Briefing Integration:</font></td>
					  
			   </tr>
			
					
		 </table>	
			
		 	<br>
			
	

		<div  align="center" style="width:55%;">
			
			<div class="panel panel-primary" style="background:rgba(255,255,255);">
		
		
				<div class="row">
				<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
			
					<ul class="nav nav-pills nav-justified">
						<li class="active"><a data-toggle="pill" href="#dynamicmenu1">Briefing Search</a></li>
						<li><a data-toggle="pill" href="#dynamicmenu2">Token Maintenance</a></li>
						<li><a data-toggle="pill" href="#dynamicmenu3">Config Update</a></li>
					</ul>
					
					<div class="tab-content">
						<div id="dynamicmenu1" align="left" class="tab-pane fade in active">
						<br>
										
				       <table class="table table-bordered" border="1" style="width: 50%;" align="left">	    
				    			<tbody>				     
							     
			     		   <tr>
								   <td style="padding: 05px;">								          
								   			   <label>Search By Crew Member </label>
									
								   </td>
							   </tr>
							
							   <tr>
									<td align="left" style="padding: 05px;">
									 
									     <div class="col-xs-20">
											<div class="input-group">
											
												<span class="input-group-addon"><i class="fa fa-user-circle-o" aria-hidden="true"></i></span>								
														<select id="status" name="status" class="form-control" onchange="view_contract()" >	
     	   	                                                   <option value="Enable" <c:if test ="${airlineEntity.status == 'Enable'}"> selected </c:if> > -  CAP - JAI WARDHAN (JEA) - </option>
							                                   <option value="Disable" <c:if test ="${airlineEntity.status == 'Disable'}"> selected </c:if> > - NO  - </option>     					
													    </select>
													    
												</div>	
											</div>
							              
							              </td>	               
							   </tr>
		
							   <tr>
								   <td align="center" style="padding: 05px;">
								   		 <span onclick="searchUser();" id="buttonDemo1" class="btn btn-primary"><i class="fa fa-search" aria-hidden="true"></i>&nbsp; &nbsp; Search </span>
						                  			
								   </td>
							   </tr>
		                	</table>
							
						</div>
					
						
						<div id="dynamicmenu2" class="tab-pane fade">
				       <table class="table table-bordered" border="1" style="width: 50%;" align="center">	    
				    			<tbody>				     
							     
			     		   <tr>
								   <td style="padding: 05px;align:center;">								          
								   			   <label>Update Crew Briefing Auto Logon Tokens: </label>
									
								   </td>
							   </tr>
							
							
								<tr> 
								
									<td>
									
										<div class="input-group">
											<span class="input-group-addon"><i class="fa fa-text-height fa-lg" aria-hidden="true"></i></span>	
											<input readonly type="text" name="flightno" id="flightno" class="form-control" value="Available-> 23498">					
															
										</div>
									
									
									</td>
								</tr>
			
								<tr> 
								
									<td>
									
										<div class="input-group">
											<span class="input-group-addon"><i class="fa fa-text-height fa-lg" aria-hidden="true"></i></span>	
											<input  type="text" name="flightno" id="flightno" class="form-control" value="Lower Level -> 23498">					
															
										</div>
									
									
									</td>
								</tr>

							   <tr>
									<td align="left" style="padding: 05px;">
									 			<div class="col-xs-05">
													<div class="input-group"> 
														<span class="input-group-addon"><i class="fa fa-paperclip fa-lg" aria-hidden="true"></i>&nbsp;&nbsp;<b>Upload New Token</b></span>							
															 <input type="file"  id="gfile"  name="gfile" multiple  class="form-control"/>
													 </div>
														 
										        </div>
							
	
							              
							              </td>	               
							   </tr>
		
							   <tr>
								   <td align="center" style="padding: 05px;">
								   		 <span onclick="searchUser();" id="buttonDemo1" class="btn btn-primary"><i class="fa fa-search" aria-hidden="true"></i>&nbsp; &nbsp; Search </span>
						                  			
								   </td>
							   </tr>
		                	</table>						
							
							
							
							
						</div>
						
						
						<div id="dynamicmenu3" class="tab-pane fade">
							<h3>Cargo Flights</h3>
							<p>Create your content / table here</p>
						</div>
						
						
						
						
					</div>
				</div>
			</div>
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
	<br>
	<br>
	<br>
	<br>  
</c:if>

<%@include file="../../include/gopsfooter.jsp" %>




