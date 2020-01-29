<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<jsp:include page="../include/header.jsp" />


<head>
    <title> Stobart Air Contract Manager </title>    
</head>

<script src="https://canvasjs.com/assets/script/canvasjs.min.js"></script>
<script type="text/javascript">





function contract_home(event){    
	    document.contract.method="POST"
	    document.contract.action="contractManager";
        document.contract.submit();
	    return true;
	
}//---------- End Of Function  ------------------





function  renew_contract(contractref){


	   if(confirm("Are you Sure about Renewing this Contract ..??")){			
			    document.contract.event.value="renew";		
			    document.contract.refno.value=contractref;
		        document.contract.method="POST";
			    document.contract.action="contractManager";
		        document.contract.submit();
			    return true;
	   }
}



function update_contract(contractref,department,subdepartment){
            
        document.contract.refno.value=contractref;
        document.contract.departmentselected.value=department;   
        document.contract.subdepartmentselected.value=subdepartment;              
        document.contract.method="POST"
	    document.contract.action="contractManager?event=view";
        document.contract.submit();
	    return true;

}
	
</script>



 
  <br>
 
 <div  style="margin-top:60px;" align="center">	
	
		<div class="col-md-12 col-sm-12 col-xs-12"  align="left">
			<i class="fa fa-suitcase fa-2x" aria-hidden="true"></i>&ensp;<span style="font-weight:600;font-size:13pt;">View Stobart Air Contract</span></a>
	   </div>	
  
  </div>		




 <br>
 <br>

 <body>
   
 <div class="container" align="center">
 
 <div class="col-md-12 col-sm-12 col-xs-12" align="center">
 
 
 
 <form name="contract" id="contract" method="post" >
   
      <input type="hidden" name="emailid" id="emailid" value="<%=request.getParameter("emailid")%>">
      <input type="hidden" name="password" id="password" value="<%=request.getParameter("password")%>">
      <input type="hidden" name="departmentselected" id="departmentselected" value="${contractdetail.department_code}">
      <input type="hidden" name="subdepartmentselected" id="subdepartmentselected" value="${contractdetail.subdepartment_code}">
      <input type="hidden" name="refno" id="refno" value="">
      <input type="hidden" name="event" id="event" value="">
      
   
          
     <table class="table table-striped table-bordered" border="1" style="width:60%;" align="center">	    
    		<tbody>				     
			     <tr align="center">
					 <td  bgcolor="#0070BA" colspan="2">
					   <span style="color:white;"> <i class="fa fa-suitcase fa-lg" aria-hidden="true"></i> &nbsp;<b>
					    Contract Detail 
					   </b></span>					 
					 </td>
			     </tr>
			
	
			
			   <tr>
                
                  <td align="left" bgcolor="white" width="25%">
								<label  >Reference No</label> 
	              </td>
				            
	              <td align="left" bgcolor="white" width="75%">
                        ${contractdetail.refrence_no}
		          </td>
      	                
	           </tr>
	           
			
			   <tr>
                
                  <td align="left" bgcolor="white" >
								<label> Contract Detail </label>
	              </td>
				            
	              <td align="left" bgcolor="white" >
                        ${contractdetail.contract_description}
		          </td>
      	                
	           </tr>
	           
	
         
	           <tr>
                
                  <td align="left" bgcolor="white" >
								<label> Department </label>
	              </td>
				            
	              <td align="left" bgcolor="white" >
                        ${contractdetail.department}&nbsp;&nbsp;- &nbsp;&nbsp; ${contractdetail.subdepartment} 
		          </td>
      	                
	           </tr>
		           
	        
	           <tr>
		           <td align="left" bgcolor="white" >
                   		<label for="startDate">Start Date</label>
							
								
		           </td>
		           
		           <td align="left" bgcolor="white" >
		              
		                 
		                 
				 	<c:set var="startdate" value="${contractdetail.start_date}" />
						<fmt:parseDate value="${startdate}" var="parsedCurrentDate" pattern="yyyy-MM-dd" />
				        <fmt:formatDate type = "date"  value = "${parsedCurrentDate}" />
  		                 

		           </td>
		           
		           		           
	           </tr>
	           
	           <tr>
		           <td align="left" bgcolor="white" >
                   		<label for="startDate">End Date</label>
							
								
		           </td>
		           
		           <td align="left" bgcolor="white" >
		           
			    	<c:set var="enddate" value="${contractdetail.end_date}" />
						<fmt:parseDate value="${enddate}" var="parsedEndDate" pattern="yyyy-MM-dd" /> 
				       <fmt:formatDate type = "date"  value = "${parsedEndDate}" />
		
		           </td>
		           
		           		           
	           </tr>
	           
	
	
	
		      <tr>
		           <td align="left" bgcolor="white" >
                   		<label for="startDate">Status</label>	
		           </td>
		           
		           <td align="left" bgcolor="white" >
		               
		                 
		                 
		                 <c:if test="${contractdetail.status == 'Active'}">
		                            &nbsp;<span class="label label-success"><i class="fa fa-check-circle  fa-lg" aria-hidden="true"></i>&nbsp; <b> Active.</b></span>
		                     
		                </c:if>
		          
		          
		            	<c:if test="${contractdetail.status == 'Dactive'}">
			                       
			                         &nbsp;<span class="label label-danger"><i class="fa fa-times  fa-lg" aria-hidden="true"></i>&nbsp; <b> Expired.</b></span>
		                </c:if>
		          
	          
		            	<c:if test="${contractdetail.status == 'Archived'}">
			                       
			                         &nbsp;<span class="label label-warning"><i class="fa fa-check-circle  fa-lg" aria-hidden="true"></i>&nbsp; <b> Archived.</b></span>
		                </c:if>
		          
		                 
		                 
		                 

		           </td>
		           
		           		           
	           </tr>
	           
	
	
		      <tr>
		           <td align="left" bgcolor="white" >
                   		<label for="startDate">Contractor Company</label>
		           </td>
		           
		           <td align="left" bgcolor="white" >
		                 ${contractdetail.contractor_name} <br>  ${contractdetail.contractor_contact_detail}
		           </td>
		           
		           		           
	           </tr>
	           
	 	           


	           <tr>
	              <td align="left" bgcolor="white" colspan="2">
		         	
						<label>Already attached File. </label>							
				        <br>
				        <br>
							<span style="font-weight:400;font-size:10pt;">							
				
						<table  align="center"   class="table table-striped" style="width:75%;">							
							<% 							
							int filecount=1;							
							%>
							 <c:forEach var="filelist" items="${filelist}">       
							<tr> 
								<td align="left" width="80%"><b><%=filecount++%></b>.&nbsp; <img  src="images/page_white_acrobat.png">&nbsp;&nbsp; 
								
								 <b> <a href="${contractdetail.refrence_no}/${filelist}"  target="_blank">  ${filelist}  </a> </b>
								  
								</td>
								</tr>
						  </c:forEach>
							
							</table>
							</span>
				 		  
				  
				  </td>
				  
	           </tr>



				    <tr align="center"> 
				     					
						<td  bgcolor="white" colspan="2">	
				                   <span onClick="contract_home();" id="addnew" class="btn btn-primary" > &nbsp;Contract &nbsp; <i class="fa fa-home" aria-hidden="true"></i>  </span>  
 	                                 <c:if test = "${contractdetail.is_admin == 'Y'}"> 
						                   &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;   
						                   <span onClick="renew_contract('${contractdetail.refrence_no}');" id="addnew" class="btn btn-warning" >&nbsp;Renew Contract &nbsp; <i class="fa fa-repeat" aria-hidden="true"></i> </span>
						                   &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;
						                   <span  onClick="update_contract('${contractdetail.refrence_no}','${contractdetail.department_code}','${contractdetail.subdepartment_code}');" id="addnew" class="btn btn-success" >&nbsp;&nbsp;&nbsp;Update &nbsp;<i class="fa fa-pencil-square-o" aria-hidden="true"></i> </span>
 		 			               </c:if>
 			              </td>
				     </tr>
		        	           
       	   </tbody>             
     </table>  	   
    
    
    <br>
    <br>
    <br>
      				 
	  
	
			
   </div>


 

  </div>




  	
</form>
 

<!--  END of UPPER FORM PART   -->

</body>




<!--  START OF REPORT  PART   -->
<br>
<br>
<br>
<br>
<br>
<br>

<%@include file="../include/footer.jsp" %>

