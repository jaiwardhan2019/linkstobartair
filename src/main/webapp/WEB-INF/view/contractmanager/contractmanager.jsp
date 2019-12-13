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
            
        document.contract.refno.value=contractref;
        document.contract.method="POST"
	    document.contract.action="contractManager?event=view";
        document.contract.submit();
	    return true;

}

	
</script>


	

<style>

tr:nth-child(even) {
  background-color: #EAEDED;
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
      <input type="hidden" name="refno" id="refno" value="">
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
					
					       
					               
					       <span onClick="manage_contract('search');"  class="btn btn-primary" ><i class="fa fa-search" aria-hidden="true"></i>&nbsp;&nbsp;Search </span> 
					 
					           
					
					       
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
	        <span  style="font-weight:300;font-size:12pt;">Total Contract # </span> <span  style="font-weight:400;font-size:16pt;">
	              <b>${fn:length(contractlist)} </b>
	              
	              <!-- <button type="button" class="btn btn-primary">Total Contract <span class="badge">${fn:length(contractlist)}</span></button> -->
	              
	              </span>
	     </td>
	    
	    
		 <td align="right"> 
 		        <button onClick="manage_contract('addnew');" id="addnew" type="button" class="btn btn-primary btn-sm"><i class="fa fa-plus" aria-hidden="true"></i>&nbsp; <b> New Contract </b></button>
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
          
         
       <c:set var = "rowcount"  value = "${fn:length(contractlist)}"/>
       <c:if test = "${rowcount == 0}">        
          <tr>
          
           <td colspan="9" align="center">

                     <span style="color:red;font-weight:bold;font-size:12pt;"> Sorry No Contract found&nbsp;!!&nbsp;&nbsp;<i class="fa fa-frown-o  fa-2x"> </i>
                      <br> Please change Filter or Check your Authorisation with Admin..</span>
              
            </td>
          </tr>
        </c:if>    
           
          
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
				    
		
				       ${contract.refrence_no}  &nbsp;<span class="label label-success">New</span>
				    
										
					 		 
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
		                     <button type="button" class="btn btn-success btn-sm"><i class="fa fa-check-circle  fa-lg" aria-hidden="true"></i>&nbsp; <b> Active.</b> </button>
		                     
		                </c:if>
		          
		          
		            	<c:if test="${contract.status == 'Dactive'}">
			                        <button type="button" class="btn btn-danger btn-sm"> <i class="fa fa-times  fa-lg" aria-hidden="true"></i>&nbsp;  <b>Expired.</b> </button>
		                </c:if>
		          
 
					 </td>
					 
					            
		           <td align="center"> 
		                <span style="font-weight:bold;" onClick="update_contract('${contract.refrence_no}');"  class="btn btn-info btn-sm"><i class="fa fa-pencil-square-o  fa-lg" aria-hidden="true"></i>&nbsp; Edit </span>
		           
		           </td>
	
					 
					 
					 <td>	
					 
						  <c:if test="${contract.getFilesCount() > 0}">					 				    
						    <a href="javascript:void();" onClick="alert('Under Construction');"><span style="font-weight:600;font-size:9pt;"><i class="fa fa-paperclip fa-lg" aria-hidden="true"></i> ${contract.getFilesCount()} Files.</span></a>					   			 
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

