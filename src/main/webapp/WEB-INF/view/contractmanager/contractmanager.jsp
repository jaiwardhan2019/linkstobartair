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





	
</script>
 
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
</form>
 

<!--  END of UPPER FORM PART   -->






<!--  START OF REPORT  PART   -->

<br>
<br>
	 		 
  <table  style="width: 80%;" align="center">
	  <tr>
	  
	     <td align="right">
	       
	       <span style="font-weight:600;font-size:12pt;color:${col}">  ${contractupdate}   </span>
	      
	       
	     
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
					   <span style="color:white;" width="10%"> <b> 
					       Contract Refrence No. 
					     </b></span>					 
					 </td>
					 <td bgcolor="#0070BA" width="30%">
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
					   <span style="color:white;">
					     <i class="fa fa-download fa-lg" aria-hidden="true"></i> 
					     </span>					 
					 </td>
		
										 
          </tr>  
          
         <%
		 
         int srno=1;
         
	     %>
          
          
        <c:forEach var="contract" items="${contractlist}">       	
	     <tr align="center" bgcolor="#FEF9E7">
				    
				    <td>
					    <b> 
					       <%=srno++%>
					     </b>				 
					 </td>
					  
				    <td>
					      ${contract.refrence_no} 
					 		 
					 </td>
					<td>
					       ${contract.contract_description} 
					 </td>
					<td>
					      Engineering 
					 </td>
					<td>
					      26-Jan-2019  
					 </td>
					<td>
					      26-Jan-2020  
					 </td>
					<td>					  
					      Active	 
					 </td>
					 
					 <td>					    
					    <a href=""><span style="font-weight:600;font-size:8pt;"><i class="fa fa-paperclip fa-lg" aria-hidden="true"></i> 3 Files.</span></a>					   			 
					 </td>
							 
	      </tr>     
       
       </c:forEach>
               
 </table>           



</div>


<br>
<br>
<br>
<br>
<br>

<%@include file="../include/footer.jsp" %>

