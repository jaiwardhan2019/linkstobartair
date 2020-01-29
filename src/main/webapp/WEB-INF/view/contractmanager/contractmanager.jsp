<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<jsp:include page="../include/header.jsp" />


<head>
    <title> StobartAir Contract Manager </title>    
</head>




<script type="text/javascript">



function print_report(){
		var print_div = document.getElementById("printareareport");
		var print_area = window.open();
		print_area.document.write(print_div.innerHTML);
		print_area.document.close();
		print_area.focus();
		print_area.print();
		print_area.close();
}




function manage_contract(event){    
 	    document.getElementById("searchbutton").innerHTML = "<i class='fa fa-refresh fa-spin fa-lx' aria-hidden='true'></i>&nbsp;&nbsp;Searching..";
 	    document.contract.method="POST"
	    document.contract.action="contractManager?event="+event;
        document.contract.submit();
	    return true;
	
}//---------- End Of Function  ------------------


function update_contract(contractref,department,subdepartment){
            
        document.contract.refno.value=contractref;
        document.contract.departmentselected.value=department;   
        document.contract.subdepartmentselected.value=subdepartment;              
        document.contract.method="POST"
	    document.contract.action="contractManager?event=view";
        document.contract.submit();
	    return true;

}





//*** Here this function will update data in the form to database and write back to the DIV 
function Zip_Folder_Download_(contractrefno,srno){

         document.getElementById("downloadstatus"+srno).innerHTML = "<i class='fa fa-cog fa-spin fa-2x fa-fw'></i>&nbsp;Downloading";

         $.ajax({
        
     		  url:'zipfolderanddownload/'+contractrefno,
			  type:"GET",
			  success : function(result)
			  {
					//document.getElementById("downloadstatus").style.display = "none";
					window.location = contractrefno+".zip";
					document.getElementById("downloadstatus"+srno).innerHTML = "&nbsp;&nbsp;<img  src='images/zip.png' >";  
	
				}// ------ END OF SUCCESS ----  
	
       }); //----- END OF AJAX FUNCTION ------- 


}//-------- END OF FUNCTION ---------------



function view_contract(refno){
	
	    document.contract.refno.value=refno;
	    document.contract.action="contractManager?event=showcontract";
	    document.contract.submit();
	    return true;
}




function contract_home(event){    
	    document.updatecontract.method="POST"
	    document.updatecontract.action="contractManager";
        document.updatecontract.submit();
	    return true;
	
}//---------- End Of Function  ------------------


	
</script>



  <br>
 
 <div  style="margin-top:60px;" align="center" id="printButton">	
	
		<div class="col-md-12 col-sm-12 col-xs-12"  align="left">
			<i class="fa fa-suitcase fa-2x" aria-hidden="true"></i>&ensp;<span style="font-weight:600;font-size:13pt;">Stobart Air Contracts</span></a>
	   </div>	
  
  </div>		




 <br>
 <br>



 <div class="container" align="center">
 
 <div class="col-md-12 col-sm-12 col-xs-12" align="center" id="printButton">
 
 <form name="contract" id="contract" method="post">  
  
      <input type="hidden" name="emailid" id="emailid" value="<%=request.getParameter("emailid")%>">
      <input type="hidden" name="password" id="password" value="<%=request.getParameter("password")%>">
      <input type="hidden" name="refno" id="refno" value="">
      <input type="hidden" name="departmentselected" id="departmentselected" value="null">
      <input type="hidden" name="subdepartmentselected" id="subdepartmentselected" value="null">
      
     
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
							<label for="department">Department</label>
							<div class="input-group">
								<span class="input-group-addon"><i class="fa fa-universal-access" aria-hidden="true"></i></span>								
										<select id="department" name="department" class="form-control" onChange="manage_contract('search');" >
											<option value="ALL"> -  All - </option> 
										        	${departmentlist}
										</select>
							</div>	
						</div>
				
				
					<div class="form-group">
							<label  >Sub Department</label>
							<div class="input-group">
								<span class="input-group-addon"><i class="fa fa-university" aria-hidden="true"></i></i></span>							
									
										<select  id="subdepartment" name="subdepartment" class="form-control" >
										      <option value="ALL"> -  All - </option> 
                                                 ${subdepartmentlist}
											 
										</select>
							</div>
						</div>						
							 
						<div class="col-xs-14">
								<label> Contract Detail</label>
								<div class="input-group">
									<span class="input-group-addon"><i class="fa fa-text-height fa-lg" aria-hidden="true"></i></i></span>							
										<textarea rows="02"  name="cdescription"  id="cdescription" class="form-control">${cdescription}</textarea>
												
								</div>
					    </div>
					    
					    
		               <div class="checkbox disabled">
		               
  				              <label><input type="checkbox" id="Active" name="Active"  value="Active" ${Active}> <span class="label label-success"><i class="fa fa-check-circle  fa-lg" aria-hidden="true"></i><b> Active.</b></span></label>&nbsp; &nbsp; 
						      <label><input type="checkbox" id="Dactive" name="Dactive" value="Dactive" ${Dactive}><span class="label label-danger"><i class="fa fa-times  fa-lg" aria-hidden="true"></i><b> Expired.</b></span></label>&nbsp; &nbsp; 						      
						      <label><input type="checkbox" id="Archived" name="Archived"  value="Archived" ${Archived}> <span class="label label-warning"><i class="fa fa-archive  fa-lg" aria-hidden="true"></i><b> Archived.</b></span></label>
						      
					    </div>
							
					    <div align="center">
					        
				          	<span id="searchbutton" onClick="manage_contract('search');"  class="btn btn-primary" ><i  class="fa fa-search" aria-hidden="true"></i>&nbsp;&nbsp;Search </span> 
					    
					    </div>
					    
					    
					    	
				   </td>
						
					     
							    
				    </tbody>
			</table>
   </div>
  </div>		

 
   <table  style="width: 80%;" align="center" id="printButton">
	       <tr> 
	       <td align="center">      
	               ${contractupdate}
           </td>
           </tr>
   </table>
<!--  END of UPPER FORM PART   -->


<!--  START OF REPORT  PART   -->

<br>
<br>
	 		 
  <table  style="width: 80%;" align="center" id="printButton">
	  <tr>
	  
	
	     <td align="left"> 
	        <span  style="font-weight:300;font-size:12pt;">Total Contract # </span> <span  style="font-weight:400;font-size:16pt;">
	              <b>${fn:length(contractlist)} </b> 
	              
	                </span>
	              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	              <span  style="font-weight:300;font-size:08pt;color:blue;"> 
	              <b> Note:</b> In order to View / Search Contract please make sure your User Id have Authorisation to the (Dept./Sub Dept.) in subject.   
	              </span>

	              
	     </td>
	     
		 <td align="right"> 
		        <button   onClick="print_report();" id="addnew" type="button" class="btn btn-default btn-sm"> <b> Print </b> &nbsp;<i class="fa fa-print fa-lg" aria-hidden="true"></i></button> 
		        &nbsp;&nbsp;&nbsp;
		        <button   onClick="manage_contract('addnew');" id="addnew" type="button" class="btn btn-primary btn-sm"> <b> Add New </b> &nbsp;<i class="fa fa-plus fa-lg" aria-hidden="true"></i></button>
		  </td>

	   </tr>	
			
 </table>	

<br>

<div class="container">
       
       <c:set var = "rowcount"  value = "${fn:length(contractlist)}"/>
       <c:if test = "${rowcount == 0}">
        <table class="table" border="0" style="width: 100%;" align="center">	       
          <tr>          
           <td colspan="9" align="center">
                     <span style="color:blue;font-size:10pt;"> Sorry No Contract found&nbsp;!!&nbsp;&nbsp;<i class="fa fa-frown-o  fa-lg"> </i>
                      <br> Please change Filter or Check your Authorisation with Admin..</span>              
            </td>
          </tr>
          </table>	
        </c:if>    


<c:if test = "${rowcount > 0}">
 <table class="table table-striped table-bordered" border="1" style="width: 100%;" align="center">	
		
	     <tr align="center">
				    
				    <td bgcolor="#0070BA">
					   <span style="color:white;" > <b> 
					    No
					     </b></span>					 
					 </td>
					  
					 <td bgcolor="#0070BA" >
					   <span style="color:white;" > <b> 
					       Reference No 
					     </b></span>					 
					 </td>
	 
	 			 <td bgcolor="#0070BA">
					   <span style="color:white;"> <b> 
					      Department  	
					     </b></span>					 
					 </td>
	
					 <td bgcolor="#0070BA" width="28%">
					   <span style="color:white;"> <b> 
					    Detail
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
					      Update 
					     </b></span>					 
					 </td>
					 
					 				 
					<td bgcolor="#0070BA">
					
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
				       <tr align="left"  style="color:red;"> 
			</c:if>
    
			<c:if test="${contract.status == 'Active'}"> 
			
				      <tr align="left"  >  
			
			 </c:if>
			<c:if test="${contract.status == 'Archived'}"> 
				       <tr align="left"  style="color:blue;"> 
			</c:if>							    
	     		    <td>
					    <b> 
					       <%=srno++%>.
					     </b>				 
					 </td>
					  
				    <td>
				    
		           <a  href="javascript:void();" onClick="view_contract('${contract.refrence_no}');">					   			 
							    
				       ${contract.refrence_no} 		
				       
				       
				       <!--
				        Expire in : 	
				        ${contract.noofDaysToExpire(contract.end_date)} 	
				        -->
				       				        	
				   </a>    	       
				       
		                <c:set var="contractage" value="${contract.getContractAge(contract.start_date)}" />		                
		                <c:if test = "${contractage < 30}">        
                           &nbsp;<span class="label label-success">New <i class="fa fa-check" aria-hidden="true"></i></span>
                        </c:if> 		    
						 				
					 		 
					 </td>
					 
					 
					<td>	
	
				    <a href="#" onclick="return false;" data-toggle="popover" data-trigger="hover"  title="SUB DEPARTMENT" data-content="${contract.subdepartment}">
					  ${contract.department}  				 
	                </a> 				     
					 </td>
					 
					<td width="28%">
					    <a href="#" onclick="return false;" data-toggle="popover" data-trigger="hover"  title="Contract Description" data-content="${contract.contract_description}">
			                <c:set var="string1" value="${fn:substring(contract.contract_description, 0,40)}" />
			                   ${string1}
			             </a>
			     	 </td>
					 
					 
					 
					 
					 
					<td>
				
						<c:set var="startdate" value="${contract.start_date}" />
						<fmt:parseDate value="${startdate}" var="parsedCurrentDate" pattern="yyyy-MM-dd" />
				        <fmt:formatDate type = "date"  value = "${parsedCurrentDate}" />
                         
					 
					 </td>
					
					
					<td>     		      
						<c:set var="enddate" value="${contract.end_date}" />
						<fmt:parseDate value="${enddate}" var="parsedEndDate" pattern="yyyy-MM-dd" /> 
				       <fmt:formatDate type = "date"  value = "${parsedEndDate}" />
					     
  				   </td>
					 
					 
					 
					 
					 
					 
					<td align="center">					  
					     <c:if test="${contract.status == 'Active'}">
		                            &nbsp;<span class="label label-success"><i class="fa fa-check-circle  fa-lg" aria-hidden="true"></i>&nbsp; <b> Active.</b></span>
		                     
		                </c:if>
		          
		          
		            	<c:if test="${contract.status == 'Dactive'}">
			                       
			                         &nbsp;<span class="label label-danger"><i class="fa fa-times  fa-lg" aria-hidden="true"></i>&nbsp; <b> Expired.</b></span>
		                </c:if>
		          
	          
		            	<c:if test="${contract.status == 'Archived'}">
			                       
			                         &nbsp;<span class="label label-warning"><i class="fa fa-archive  fa-lg" aria-hidden="true"></i>&nbsp; <b> Archived.</b></span>
		                </c:if>
		          
 
					 </td>
					 
					            
		           <td align="center"> 
		      
		            <c:if test="${contract.is_admin == 'Y'}">
		               <!--  <button type="button" onClick="update_contract('${contract.refrence_no}','${contract.department_code}','${contract.subdepartment_code}');"  class="btn btn-info btn-sm"><i class="fa fa-pencil-square-o  fa-lg" aria-hidden="true"></i>&nbsp; Edit</button> -->
	                     <a href="javascript:void();"><span class="label label-info"  onClick="update_contract('${contract.refrence_no}','${contract.department_code}','${contract.subdepartment_code}');" ><i   class="fa fa-pencil-square-o" aria-hidden="true" ></i>&nbsp; <b>  Edit. </b></span></a>
	
		            </c:if>
		            
		            <c:if test="${contract.is_admin == 'N'}">
		              
		               <!--  <button type="button" onClick="update_contract('${contract.refrence_no}','${contract.department_code}','${contract.subdepartment_code}');"  class="btn btn-info btn-sm" disabled ><i class="fa fa-pencil-square-o  fa-lg" aria-hidden="true"></i>&nbsp; Edit</button>  -->
		              
		               <a href="#"  data-placement="top" onclick="return false;" data-toggle="popover" data-trigger="hover"   data-content="You Dont Have Admin Right To This Department Contracts , In order to Update this Please contact your Manager.">
		                 <span class="label label-danger"><i  class="fa fa-times" aria-hidden="true" ></i>&nbsp; <b>  Edit. </b></span>
	                   </a>
		                
		            </c:if>
		            
		            
		            
		           </td>
	
					 
					 
					 <td >	
					 
						  <c:if test="${contract.getFilesCount() > 0}">					 				    
						     <img  src="images/page_white_acrobat.png">&nbsp; <a data-placement="top"  data-toggle="popover" data-trigger="hover"  data-content="Click to ZIP and Download"  href="javascript:void();" onClick="Zip_Folder_Download_('${contract.refrence_no}','<%=srno%>');"><span id="downloadstatus<%=srno%>" style="font-weight:600;font-size:9pt;">${contract.getFilesCount()} Files.</span></a>					   			 
							    
						 </c:if>
			             
			             <c:if test="${contract.getFilesCount() == 0}">	
			                  				 
                             <a data-placement="top" href="#" onclick="return false;" data-toggle="popover" data-trigger="hover"   data-content="No Document attached with this Contract. Please Click Edit Button and Attach File ">
	
			               <span style="font-weight:600;font-size:9pt;color:red;"> Missing </span>
			                
			                </a>
			  
			             </c:if>			 
					 
					 </td>
							 
	      </tr>     
       
       </c:forEach>
               
 </table>           

</c:if>

</div>

</form>

<br>
<br>
<br>
<br>
<br>

<%@include file="../include/footer.jsp" %>





<body >

<!-- THIS IS FOR PRINTING AREA  

<div id="printareareport" style="display:none">

 --> 
 
	
 
 
<div  id="printareareport"  style="display:none">

				<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
				
				<br>
				    <br>
		    <br>
				    <br>	    
				    			    
					 <table class="myTable"  style="width: 100%;" align="center">	
			
			            <tr>
				            
			            <td align="left">
			              <img  src="images/re1.png">   
			            </td>
	
			            <td colspan="5" align="left">
			            <h1><b> Contract Report.</b></h1> 
			            
			            </td>
			            
			            </tr>
                  </table>
				    <br>
				    <br>
				    <br>
				    <br>	    
				    
					   <table class="myTable" style="width:100%;border:1px solid black;border-collapse:collapse;cellspacing:20;">
								<tr>
									<td ><b>No.</b></td>
									<td ><b>Refrence No</b></td>
									<td ><b>Department</b></td>
									<td ><b>Detail.</b></td>
									<td ><b>Start Date.</b></td>
									<td ><b>End Date.</b></td>
									<td ><b>Status.</b></td>
						        </tr>
	         <%
		 
         int srno1=1;
         
	     %>
          
          
        <c:forEach var="contract" items="${contractlist}">       
        
    
			<tr align="left">
			
									    
	     		    <td  style="border:1px solid black;font-size:10pt;">		
					    <b> 
					       <%=srno1++%>.
					     </b>				 
					 </td>
					  
				    <td  style="border:1px solid black;font-size:10pt;">		
				    
		
				       ${contract.refrence_no} 			       
				       
					 		 
					 </td>
					 
					 
					<td  style="border:1px solid black;font-size:10pt;">		
	
					  ${contract.department}  				 
					 </td>
					 
					<td  style="border:1px solid black;font-size:10pt;">		
			                <c:set var="string1" value="${fn:substring(contract.contract_description, 0,30)}" />
			                   ${string1}
			     	 </td>
					 
					 
					 
					 
					 
					<td  style="border:1px solid black;font-size:10pt;">		
				
						<c:set var="startdate" value="${contract.start_date}" />
						<fmt:parseDate value="${startdate}" var="parsedCurrentDate" pattern="yyyy-MM-dd" />
				        <fmt:formatDate type = "date"  value = "${parsedCurrentDate}" />
                         
					 
					 </td>
					
					
					<td  style="border:1px solid black;font-size:10pt;">		   		      
						<c:set var="enddate" value="${contract.end_date}" />
						<fmt:parseDate value="${enddate}" var="parsedEndDate" pattern="yyyy-MM-dd" /> 
				       <fmt:formatDate type = "date"  value = "${parsedEndDate}" />
					     
  				   </td>
					 
					 
					 
					 
					 
					 
					<td  style="border:1px solid black;font-size:10pt;">					  
					     ${contract.status}
 
					 </td>
					 
					            
							 
	      </tr>     
       
       </c:forEach>
	
	
						
					</table>
					
					
			</div>
				
	</div>
    
	

</body>












