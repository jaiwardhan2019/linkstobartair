<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<jsp:include page="../include/header.jsp" />


<head>
    <title> Stobart Contract Manager </title>    
</head>


<script type="text/javascript">




function manage_contract(event){    
	    document.contract.method="POST"
	    document.contract.action="contractManager?event="+event;
        document.contract.submit();
	    return true;
	
}//---------- End Of Function  ------------------


function update_contract(contractref){

    
        document.contract.method="POST"
	    document.contract.action="contractManager?event=update&refno"+contractref;
        document.contract.submit();
	    return true;

}

	
</script>


	

<style>

tr:nth-child(even) {
  background-color: #dddddd;
}

</style>

 
  <br>
 
 <div  style="margin-top:60px;" align="center">	
	
		<div class="col-md-12 col-sm-12 col-xs-12"  align="left">
			<i class="fa fa-suitcase fa-2x" aria-hidden="true"></i>&ensp;<span style="font-weight:600;font-size:13pt;">Manage Stobart Contracts.</span></a>
	   </div>	
  
  </div>		




 <br>
 <br>

 
   
 <div class="container" align="center">
 
 <div class="col-md-12 col-sm-12 col-xs-12" align="center" id="printButton">
 
 <form name="contract" id="contract">  
  
      <input type="hidden" name="emailid" id="emailid" value="<%=request.getParameter("emailid")%>">
      <input type="hidden" name="password" id="password" value="<%=request.getParameter("password")%>">
          <table class="table table-striped table-bordered" border="1" style="width: 30%;" align="center">	    
    			<tbody>				     
				     <tr align="center">
					 <td  bgcolor="#0070BA">
					   <span style="color:white;"> <i class="fa fa-suitcase fa-lg" aria-hidden="true"></i> &nbsp;<b>
					    Filter Contract  &nbsp;&nbsp;
					   </b></span>					 
					 </td>
				     </tr>
			
			
			   <tr>
					<td align="left" bgcolor="white" >
					 
					
				     <div class="form-group">
							<label for="department">Department.</label>
							<div class="input-group">
								<span class="input-group-addon"><i class="fa fa-universal-access" aria-hidden="true"></i></span>								
										<select id="department" name="department" class="form-control" onchange="showOtherdDateCaption()" >
											<option value="ALL"> -  All - </option>
											<option value="ENG"> -  Engineering - </option>		
											<option value="FIN" > - Finance - </option>
											<option value="GEN" > - General - </option>	
										</select>
							</div>	
						</div>
				
				
					<div class="form-group">
							<label  >Sub Depart.</label>
							<div class="input-group">
								<span class="input-group-addon"><i class="fa fa-university" aria-hidden="true"></i></i></span>							
									
										<select  id="subdepartment" name="subdepartment" class="form-control" >
											<option value="ALL"> -  All - </option>
											<option value="ELE"> -  Electrical - </option>		
											
										</select>
							</div>
						</div>
						
					
				
				
				
					
						</td>
						
				  </tr>	
						 
				     
				    <tr align="center"> 
				     					
						<td  bgcolor="white">
					
					       
					               
					       <span onClick="manage_contract('search');"  class="btn btn-primary" ><i class="fa fa-search" aria-hidden="true"></i>&nbsp;&nbsp;Search Contract </span> 
					 
					           
					
					       
					     </td>
					     </tr>
				     
							    
				    </tbody>
			</table>
   </div>
  </div>		

 

<!--  END of UPPER FORM PART   -->



	 		 
  <table  style="width: 80%;" align="center">
	  <tr>
          <td align="center">  
           
             ${contractupdate}
            
          </td>
      </tr>
   </table>   




<!--  START OF REPORT  PART   -->

<br>
<br>
	 		 
  <table  style="width: 80%;" align="center">
	  <tr>
	  
	     

	     <td align="left"> 
	        <span  style="font-weight:300;font-size:12pt;">Total Contract # </span> <span  style="font-weight:400;font-size:16pt;"><b>${fn:length(contractlist)} </b></span>
	     </td>
	    
	    
		 <td align="right"> 
        		<span onClick="manage_contract('addnew');" id="addnew" class="btn btn-primary" ><i class="fa fa-plus" aria-hidden="true"></i>&nbsp;Add New Contract  </span> 
		 
		  </td>

	   </tr>	
			
 </table>	
<br>


<div class="container" id="printButton">

 <table class="table table-striped table-bordered" border="1" style="width: 100%;" align="center">	
		
	     <tr align="center">
				    
				    <td bgcolor="#0070BA">
					   <span style="color:white;" > <b> 
					    No.	
					     </b></span>					 
					 </td>
					  
					 <td bgcolor="#0070BA" >
					   <span style="color:white;" width="6%"> <b> 
					       Refrence No. 
					     </b></span>					 
					 </td>
					 <td bgcolor="#0070BA" width="25%">
					   <span style="color:white;"> <b> 
					    Description 
					     </b></span>					 
					 </td>
					 <td bgcolor="#0070BA">
					   <span style="color:white;"> <b> 
					      Department  	
					     </b></span>					 
					 </td>
					
					 <td bgcolor="#0070BA">
					   <span style="color:white;"> <b> 
					      Start Date   	
					     </b></span>					 
					 </td>
				     
				     <td bgcolor="#0070BA">
					   <span style="color:white;"> <b> 
					     End Date
					     </b></span>					 
					 </td>
					 
					<td bgcolor="#0070BA">
					   <span style="color:white;"> <b> 
					     Status
					     </b></span>					 
					 </td>
					
					<td bgcolor="#0070BA">
					   <span style="color:white;"> <b> 
					      Update/Remove
					     </b></span>					 
					 </td>
					 
					 				 
					<td bgcolor="#0070BA">
					  
					   <img  src="images/page_white_acrobat.png" > &nbsp;
					   <span style="color:white;">
					     <i class="fa fa-download fa-lg" aria-hidden="true"></i> 
					     </span>					 
					 </td>
		
										 
          </tr>  
          
         <%
		 
         int srno=1;
         
	     %>
          
          
        <c:forEach var="contract" items="${contractlist}">       
        
            	    
			<c:if test="${contract.status == 'Dactive'}"> 
				       <tr align="left" bgcolor="#FEF9E7" style="color:red;"> 
			</c:if>
    
			<c:if test="${contract.status == 'Active'}"> 
			
				      <tr align="left" bgcolor="#FEF9E7" >  
			
			 </c:if>
								    
	     		    <td>
					    <b> 
					       <%=srno++%>.
					     </b>				 
					 </td>
					  
				    <td>
				    
		
				       ${contract.refrence_no}  
				    
										
					 		 
					 </td>
					 
					 
					<td>
					    <a href="#" onclick="return false;" data-toggle="popover" data-trigger="hover"  title="Contract Description" data-content="${contract.contract_description}">
			                <c:set var="string1" value="${fn:substring(contract.contract_description, 0,40)}" />
			                   ${string1}
			             </a>
			     	 </td>
					 
					 
					 
					<td>
					 
					     <c:if test="${contract.department == 'ENG'}">
					          Engineering	      
					      </c:if>
					      
					     <c:if test="${contract.department == 'FIN'}">
					          Finance
					      </c:if>		
					      			 
					     <c:if test="${contract.department == 'GEN'}">
					          General
					      </c:if>							 
					 
					 
					 </td>
					 
					 
					 
					<td>
					      ${contract.start_date}
					 </td>
					<td>
					     ${contract.end_date}
					 </td>
					<td align="center">					  
					     <c:if test="${contract.status == 'Active'}">
		                     <button class="fa fa-check-circle  fa-lg" aria-hidden="true"></i>&nbsp; <span style="color:green;font-weight:bold;font-size:10pt;"> Active</span> 
		                     <!-- <button type="button" class="btn btn-success btn-sm"> Active. </button> -->
		                </c:if>
		          
		          
		            	<c:if test="${contract.status == 'Dactive'}">
		                      <!--  <button type="button" class="btn btn-danger btn-sm"> Expired. </button>-->
		                     <button class="fa fa-times  fa-lg" aria-hidden="true"></i>&nbsp; <span style="color:red;font-weight:bold;font-size:10pt;"> Expired</span> 
		    
		                </c:if>
		          
 
					 </td>
					 
					            
		           <td align="center"> 
		                <span style="font-weight:bold;" onClick="update_contract('${contract.refrence_no}');"  class="btn btn-info btn-sm"><i class="fa fa-pencil-square-o  fa-lg" aria-hidden="true"></i>&nbsp; Edit </span>
		           
		           </td>
	
					 
					 
					 <td>	
					 
						  <c:if test="${contract.getFilesCount() > 0}">					 				    
						    <a href=""><span style="font-weight:600;font-size:9pt;"><i class="fa fa-paperclip fa-lg" aria-hidden="true"></i> ${contract.getFilesCount()} Files.</span></a>					   			 
						 </c:if>
			             
			             <c:if test="${contract.getFilesCount() == 0}">	
			                  				 
                             <a href="#" onclick="return false;" data-toggle="popover" data-trigger="hover"   data-content="No Document attached with this Contract. Please Click Edit Button and Attach File ">
	
			               <i class="fa fa-paperclip fa-lg" aria-hidden="true"></i> &nbsp; <span style="font-weight:600;font-size:9pt;color:red;"> Missing </span>
			                
			                </a>
			  
			             </c:if>			 
					 
					 </td>
							 
	      </tr>     
       
       </c:forEach>
               
 </table>           



</div>

</form>

<br>
<br>
<br>
<br>
<br>

<%@include file="../include/footer.jsp" %>

