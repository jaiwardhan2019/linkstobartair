<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="../include/gopsheader.jsp" />

<!--  
  https://www.w3schools.com/Bootstrap/bootstrap_grid_examples.asp
-->
<head>
    <meta charset="utf-8">
    <title> Ground Operations | Home  </title>    
</head>


<script type="text/javascript">

//https://codepen.io/yemon/pen/pWoROm   <<-- For the Text Annimation 

// ---------- Every 15 minutes this function will be called and refresh the ground Ops Home page 
setInterval(function(){ cal_groundops_home('${usertype}'); }, 900000);


function open_model_toAdd_Comment(){
     
	document.getElementById("flightmodelbutton").click();
	
}


</script>


<body>
<br>
<br>



<div class="container-fluid">
 
	<div class="row">

	
	   <!--Daily Punctuality Statistics -->
		<div class="col-sm-3 col-md-3 col-xs-12"> 
			
			<div class="panel panel-primary panel-shadow" style="overflow-x:auto;">
			 
			 
			
				<div class="panel-body">  
				                   	 
					<p>
						<span style="font-weight:600;font-size:12pt;color:#0071ba;"><b> Daily Punctuality Statistics   </b>&nbsp;<i class="fa fa-line-chart fa-lg" aria-hidden="true"></i></span>
						
					</p>
					<hr align="left"  style="border-top: 1px solid black;" >
					
			    
			          <table  style="width:85%;" align="center" style="background:rgba(255,255,255,0.5);">	    
			    	
						
						   <tr>
			                
			                  <td  align="center" bgcolor="white" width="60%" colspan="2">
			                    	<span style="font-size:10pt;font-weight:600;"> <%= (new java.util.Date()).toLocaleString()%>	   </span>
				              </td>
			      	                
				           </tr>
						   
						   
						   
						   <c:set var = "rowcount"  value = "${fn:length(DailyPunctStatistics)}"/>
					       <c:if test = "${rowcount > 0}">		           
				          
						          <tr>
							          <td colspan="2" align="left" height="30px">
							            <u><span style="font-size:09pt;font-weight:600;"> Origin </span></u> 				          
							          </td>
						          </tr>						
						           ${DailyPunctStatistics}
					       
					       </c:if>
					       
					       <c:if test = "${rowcount == 0}">
					       
					                <tr>
							          <td colspan="2" align="center" height="30px"><br>
							            <span style="font-size:10pt;font-weight:600;color:blue;"> Sorry no flights today </span>	
							            <br><br>			          
							          </td>
						          </tr>						
						
					       
					       </c:if>
					       
					       
				               
					   <!--   
				           <tr>
					          <td colspan="2" align="right" height="30px"><br>
		                            <a href="javascript:void();" onClick="cal_groundops_home('${usertype}');"> <span class="label label-primary"> Refresh &nbsp;<i class="fa fa-refresh" aria-hidden="true"></i></span></a>
				 
					          </td>
				          </tr>
				       -->
			        
		      </table>   					
				
					
				</div>
				    
			</div>
			
		  <!--   <a href="javascript:void();" onClick="Calqpulse();"><img src="safety.png" width="100%"></a> -->	
			
		   <table   style="width:100%;" align="center" style="background:rgba(255,255,255,0.5);">	 
           
	           <tr align="center">
	             <td style="padding:5px;"> 
	           		<button type="button" class="btn btn-primary" onClick="Calqpulse();"><i class="fa fa-commenting-o fa-lg" aria-hidden="true"></i> &nbsp;<b> File A Report </b>  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</button>
	             </td>
	           </tr> 
	           
	           <tr align="center">
	             <td style="padding:5px;"> 
	           		<button type="button" onClick="window.open('DERP/${emergencyresponseplan}','_blank');" class="btn btn-primary"><i class="fa fa-volume-control-phone fa-lg" aria-hidden="true"></i> &nbsp;<b>Emergency Response</b></button></a>
	             </td>
	           </tr> 
	           
	           <tr align="center">
	             <td style="padding:5px;"> 
	           		<button type="button" onClick="CalKeyContact();"  class="btn btn-primary" onClick="Calqpulse();"><i class="fa fa-envelope-o fa-lg" aria-hidden="true"></i> &nbsp;<b> Key Contacts </b>  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</button>
	             </td>
	           </tr> 
	 
			
		</table>

		</div> 	<!-- END OF DAILY PUNCT STATS DIV  --> 
		
			
	














		<!--RECENT DOCUMENT UPDATE -->
	
			
                     
         <div class="col-sm-5 col-md-5 col-xs-12">
			
			<div class="panel pane-default panel-shadow" style="overflow-x:auto;">
			
				<div class="panel-body"> 
                     
					<p>
						<span  style="font-weight:600;font-size:12pt;color:#0071ba;"><b>Recent Documents Update</b>&nbsp;<i class="fa fa-bell-o fa-lg" aria-hidden="true"></i></span>	 				  
					
					</p> 
					 <hr align="left"  style="border-top: 1px solid black;" >
					 
                      <table class="table"  style="width:100%;" align="center">	  
                      
			                        
							   <c:set var = "rowcount"  value = "${fn:length(gopsfilelist)}"/>
								       <c:if test = "${rowcount == 0}">
								          
								             <tr>
								             
								                <td colspan="3" align="center">
								                    <span style="color:blue;font-size:10pt;"> Sorry No Document found&nbsp;!!&nbsp;&nbsp;<i class="fa fa-frown-o  fa-lg"> </i>
								                    
								              </td>
								             
								             </tr>
								       
								       </c:if>
	  
		     <% 
		      int ctr=1;
		     %>
					    
		  <c:if test = "${rowcount > 0}">
		  			
		  			
		  			<c:forEach begin="0" end="12" var="contract" items="${gopsfilelist}">  
							<tr style="font-size:09pt">									
									<td width="75%"><img src="${contract.docType}.png"> &nbsp; 
											
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
                                                    <c:set var="string2" value="${fn:substring(string1, 0,62)}" />
			                                              ${string2}
										       </a>
										  </c:otherwise>
										  
										</c:choose>
			                              								      
									</td>									
									<td width="17%">${contract.docAddedDate}</td>
									<td align="left">										 
								 		<c:set var="string1" value="${contract.docCategory}"/>
                                              <c:set var="string2" value="${fn:substring(string1, 0,6)}" />
	                                      ${string2}
									</td>
									
																    
								</tr>
	  			
	  			
		  			</c:forEach>
		  			
						   			           
			</c:if>	           
				           
			     <c:if test="${fn:indexOf(profilelist,'docmanager') == -1}">         
					  <tr>
					       <td colspan="3" align="right">
					       <br>
					        <a href="javascript:void();" onClick="calDocumentReport('listdocuments?cat=home&operation=view');"> <span class="label label-primary">Show All</span></a>
					       </td>
					   </tr>   
				 </c:if>         						          			
		

				           
			   <c:if test = "${fn:contains(profilelist,'docmanager')}"> 
					  <tr>
					       <td colspan="3" align="right">
					       <br>
					       <a href="javascript:void();" onClick="calDocumentReport('listdocuments?cat=home&operation=update');"><span class="label label-success">Update <i class="fa fa-pencil-square-o" aria-hidden="true"></i></span></a>&nbsp;&nbsp;<a href="javascript:void();" onClick="calDocumentReport('listdocuments?cat=home&operation=view');"><span class="label label-primary">Show All&nbsp;<i class="fa fa-eye" aria-hidden="true"></i></span></a>
					       </td>
					   </tr>   
				          						          			
		       </c:if>
		         
		      </table>     
		     
					
				</div>
			</div>
			
		</div> <!--END OF RECENT UPDATE -->
	
	
			
	
	
	
		<!--START VOICE OF GUEST-->
		<div class="col-sm-4 col-md-4 col-xs-12" style="overflow-x:auto;">
			
			<div class="panel pane-default panel-shadow">
				<div class="panel-body">
				     <p>
						<span  style="font-weight:600;font-size:12pt;color:#0071ba;"><b>Touchpoint Overview</b>&nbsp;<i class="fa fa-bullhorn fa-lg" aria-hidden="true"></i></span>	 				  
			
					</p>  			           
					<hr align="left"  style="border-top: 1px solid black;" >
					
                       <table>
	                     <tr>
		                     <td> 		                      
		                      	   <!-- <a href="javascript:void();" onClick="calDocumentReport('displaytouchpointvideo');">  &nbsp;&nbsp; <img src="TOUCHPOINTOVERVIEW/${voiceofguest}"  width="95%">  </a>-->
		                       	   
							<video width="99%"   controls>
							  <source src="TOUCHPOINTOVERVIEW/touchpoint.mp4" type="video/mp4">
							  Your browser does not support HTML5 video.
							</video>
		                     </td>
	                     </tr>
	                    
	                     <c:if test = "${fn:contains(profilelist,'docmanager')}"> 
							    <tr align="center">
								       <td  align="center">
								       <a href="javascript:void();" onClick="calDocumentReport('listdocuments?cat=TOUCHPOINTOVERVIEW&operation=update');"><span class="label label-success">Update Image / Video <i class="fa fa-pencil-square-o" aria-hidden="true"></i></span></a>
								       </td>
     							   </tr>  
				         </c:if> 

				     </table>     						          			

		  
                    
	
				</div>
			</div>
			
		</div>
	
</div>


	
	

	
</div>  <!-- END OF MAIN DIV  -->	

	
	
	
	
	
	
	

	<!-- 
	 For Flashing TEXT in the  BOTTOM
	  https://www.techonthenet.com/html/elements/marquee_tag.php
	-->

   <div class="col-xs-12 col-md-12">

				<div class="panel-body">       
					
					<marquee>
						<span class="label label-warning"  style="font-weight:600;font-size:22pt;background-color:#0071ba;">
						    
							
						   <c:if test = "${fn:contains(profilelist,'gopsadmin')}"> 					    
						    <a id="flashingmessage" href="javascript:void();" style="color:white;" onClick="open_model_toAdd_Comment();"> 
						       <b> ${gopsflashingmessage}  </b>
					        </a>					      
					      </c:if>
						  
						  <c:if test="${fn:indexOf(profilelist,'gopsadmin') == -1}">
						       <b> ${gopsflashingmessage}  </b>
					      </c:if>			      
					        
						</span>
				
					</marquee>
	                 
	            </div>
	              
	  </div>



<br>
<br>
<br>
<br>

<%@include file="../include/gopsfooter.jsp" %>
	
<script type="text/javascript">

		function readPropertyFile(){
			
				
			var htmlMessage = document.getElementById("flsmessage").value;
			var callingurl="ajaxrest/updateflashingmessageonhomepage?messagevalue="+htmlMessage+"&profilelist="+document.getElementById("profilelist").value;
			$.ajax({
						type : 'GET',
						url  : callingurl,
						success : function(result) {
				    		$('#flsmessage').text(htmlMessage);         // <<-- This will update text box 				    	
						    $('#flashingmessage').text(htmlMessage);	// <<-- This will update text on the bottom of screen  			    		
						}
				});
				
		}			
      
</script>	  
	  

<form id="modelform">

   <input type="hidden" id="profilelist" name="profilelist" value="${profilelist}">


<button style="display:none;" id="flightmodelbutton" type="button" class="btn btn-primary" data-toggle="modal" data-target=".bd-example-modal-lg">Large modal</button>

<div class="modal fade bd-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
	  <div class="modal-dialog modal-lg">
	    <div class="modal-content">
	      
	    <br>
	  <div class="form-row">
	  
	    <div class="col-md-12 col-sm-12 col-xs-12">   
	            <font size="4"><b>Update Flashing Message On Home Page:</b> </font> <br>
	            <textarea class="form-control" id="flsmessage" rows="04" maxlength="300" style="white-space:pre">${gopsflashingmessage}</textarea>
	    </div>
	  </div>  
	  
	  <div class="form-row">
	  
	    <div class="col-md-12 col-sm-12 col-xs-12">   
	       &nbsp;
	    </div>
	  </div>  
  
  
  
	    <div class="modal-footer">
	      <br>
	      <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>&nbsp;&nbsp;
	      <button type="button" class="btn btn-primary" id="updatebutton" data-dismiss="modal" onClick="readPropertyFile();">Update</button>
	    </div>
	      
      
    </div>
  </div>
</div>

</form>
</body>