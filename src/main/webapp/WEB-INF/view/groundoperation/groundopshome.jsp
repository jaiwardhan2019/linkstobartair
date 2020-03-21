<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="../include/groundopsheader.jsp" />

<!--  
  https://www.w3schools.com/Bootstrap/bootstrap_grid_examples.asp
-->
<head>
    <meta charset="utf-8">
    <title> Ground Operation | Home  </title>    
</head>


<script type="text/javascript">

//https://codepen.io/yemon/pen/pWoROm   <<-- For the Text Annimation 



</script>





<body>

<div> 
	

	
			<!--Daily Punctuality Statistics -->
		<div class="col-xs-3 col-md-3">
			
			<div class="panel pane-default panel-shadow" >
				<div class="panel-body">                     	 
					<p>
						<span style="font-weight:600;font-size:12pt;color:#0071ba;"><b> Daily Punctuality Statistics   </b>&nbsp;<i class="fa fa-line-chart fa-lg" aria-hidden="true"></i></span>
						 _________________________________________	 
					</p>
			    
			    <table   style="width:100%;" align="center" style="background:rgba(255,255,255,0.5);">	    
			    	
						
						   <tr>
			                
			                  <td  align="center" bgcolor="white" width="60%" colspan="2">
			                    	<span style="font-size:10pt;font-weight:600;"> <%= (new java.util.Date()).toLocaleString()%>	   </span>
				              </td>
			      	                
				           </tr>
				           
				          
				          <tr>
					          <td colspan="2" align="left" height="30px">
					            <u><span style="font-size:09pt;font-weight:600;"> Origin </span></u> 				          
					          </td>
				          </tr>
				
				               ${DailyPunctStatistics}
					     
				           <tr>
					          <td colspan="2" align="right" height="30px"><br>
		                            <a href="javascript:void();" onClick="cal_groundops_home('${usertype}');"> <span class="label label-primary"> Refresh &nbsp;<i class="fa fa-refresh" aria-hidden="true"></i></span></a>
				 
					          </td>
				          </tr>
				
			        
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
	           		<button type="button" onClick="window.open('emergencyresponseplan.pdf','_blank');" class="btn btn-primary"><i class="fa fa-volume-control-phone fa-lg" aria-hidden="true"></i> &nbsp;<b>Emergency Response</b></button></a>
	             </td>
	           </tr> 
	           
	           <tr align="center">
	             <td style="padding:5px;"> 
	           		<button type="button" onClick="CalKeyContact();"  class="btn btn-primary" onClick="Calqpulse();"><i class="fa fa-envelope-o fa-lg" aria-hidden="true"></i> &nbsp;<b> Key Contacts </b>  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</button>
	             </td>
	           </tr> 
	 
			
		</table>

		</div> 
		
			
	<!-- END OF DAILY PUNCT STATS DIV  -->	


		<!--RECENT DOCUMENT UPDATE -->
		<div class="col-xs-5 col-md-5" >
			
			<div class="panel pane-default panel-shadow">
				<div class="panel-body">
                     
					<p>
						<span  style="font-weight:600;font-size:12pt;color:#0071ba;"><b>Recent Documents Update</b>&nbsp;<i class="fa fa-bell-o fa-lg" aria-hidden="true"></i></span>	 				  
					________________________________________________________________________	 
					</p>
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
									<a href="${contract.docCategory}/${contract.docName}" target="_new" >									     
								            <c:set var="string1" value=" ${contract.docName}"/>
                                                    <c:set var="string2" value="${fn:substring(string1, 0,62)}" />
			                                            ${string2}
			                              </a>									      
									</td>									
									<td width="17%">${contract.docAddedDate}</td>
									<td align="left">${contract.docCategory}</td>								    
								</tr>
	  			
	  			
		  			</c:forEach>
		  			
						   			           
			</c:if>	           
				           
				           
			   <c:if test="${profilelist.docmanager  != 'Y'}">
					  <tr>
					       <td colspan="3" align="right">
					       <br>
					        <a href="javascript:void();" onClick="calDocumentReport('listdocuments?cat=HOME&operation=view');"> <span class="label label-primary">Show All</span></a>
					       </td>
					   </tr>   
				          						          			
		       </c:if>  

				           
			   <c:if test="${profilelist.docmanager  == 'Y'}">
					  <tr>
					       <td colspan="3" align="right">
					       <br>
					       <a href="javascript:void();" onClick="calDocumentReport('listdocuments?cat=HOME&operation=update');"><span class="label label-success">Update <i class="fa fa-pencil-square-o" aria-hidden="true"></i></span></a>&nbsp;&nbsp;<a href="javascript:void();" onClick="calDocumentReport('listdocuments?cat=home&operation=view');"><span class="label label-primary">Show All&nbsp;<i class="fa fa-eye" aria-hidden="true"></i></span></a>
					       </td>
					   </tr>   
				          						          			
		       </c:if>
		         
		      </table>     
		     
					
					
				</div>
			</div>
			
		</div> <!--END OF RECENT UPDATE -->
	
	
			
	
	
	
		<!--START VOICE OF GUEST-->
		<div class="col-xs-4 col-md-4">
			
			<div class="panel pane-default panel-shadow">
				<div class="panel-body">
				     <p>
						<span  style="font-weight:600;font-size:12pt;color:#0071ba;"><b>Voice OF Guest</b>&nbsp;<i class="fa fa-bullhorn fa-lg" aria-hidden="true"></i></span>	 				  
					    ________________________________________________________
					</p>
  			             &nbsp;&nbsp; <img src="images/vog1.jpg"  width="95%">
                    
	
				</div>
			</div>
			
		</div>
	
	
	

	
</div>  <!-- END OF MAIN DIV  -->	

	
	
	
	
	
	
	
	            
	
<!-- Modal ------- 
<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModal">
  Launch demo modal
</button>

<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h4 class="modal-title" id="exampleModalLabel">Modal title</h4>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        Toggle a working modal demo by clicking the button below. It will slide down and fade in from the top of the page.
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary">Save changes</button>
      </div>
    </div>
  </div>
</div>
-->


	<!-- 
	 For Flashing TEXT in the  BOTTOM
	  https://www.techonthenet.com/html/elements/marquee_tag.php
	-->

   <div class="col-xs-12 col-md-12">
			
		

				<div class="panel-body">                     	 

					 <marquee>
					
						<span class="label label-warning" style="font-weight:600;font-size:22pt;color:black;"><b> News &nbsp;&nbsp;&nbsp; Bulletin&nbsp;&nbsp; Message &nbsp;&nbsp;here ..........!!!   </b></span>
				
					</marquee>
			
	                 
	                </div>
	      
	              
	  </div>


<br>
<br>
<br>


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
<br>
<br>
<br>
 <%@include file="../include/gopsfooter.jsp" %>

