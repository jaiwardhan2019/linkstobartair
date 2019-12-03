<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<jsp:include page="../include/header.jsp" />


<head>
    <title> Stobart Contract Manager </title>    
</head>


<script type="text/javascript">




function showmyVoygerReport(){

	   
	  	  document.voygerReport.method="POST";
		  document.voygerReport.action="voyagerReport";
	      document.voygerReport.submit();
		  return true;
     
		
}//---------- End Of Function  ------------------


function manage_contract(event){    
	    document.contract.method="POST"
	    document.contract.action="contractManager?event="+event;
        document.contract.submit();
	    return true;
	
}//---------- End Of Function  ------------------




function showOtherdDateCaption(){

          

}



	
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
							<label for="startDate">Department.</label>
							<div class="input-group">
								<span class="input-group-addon"><i class="fa fa-universal-access" aria-hidden="true"></i></span>								
										<select id="department" name="department" class="form-control" onchange="showOtherdDateCaption()" >
											<option value="ALL"> -  All - </option>	
										</select>
							</div>	
						</div>
				
				
					<div class="form-group">
							<label  >Sub Depart.</label>
							<div class="input-group">
								<span class="input-group-addon"><i class="fa fa-university" aria-hidden="true"></i></i></span>							
									
										<select  id="crewcode" name="crewcode" class="form-control" >
											<option value="ALL"> -  All - </option>
											
										</select>
							</div>
						</div>
						
					
				
				
				
					
						</td>
						
				  </tr>	
						 
				     
				    <tr align="center"> 
				     					
						<td  bgcolor="white">
					
					       
					               
					       <span onClick="searchUser();" id="buttonDemo1" class="btn btn-primary" ><i class="fa fa-search" aria-hidden="true"></i>&nbsp;&nbsp;Search Contract </span> 
					 
					           
					
					       
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
        		<span onClick="manage_contract('new');" id="addnew" class="btn btn-primary" ><i class="fa fa-plus" aria-hidden="true"></i>&nbsp;Add New Contract  </span> 
		 
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
       	
	     <tr align="center" bgcolor="#FEF9E7">
				    
				    <td>
					    <b> 
					       001. 
					     </b>				 
					 </td>
					  
				    <td>
					      ENG-ELCE-10122019  
					 		 
					 </td>
					<td>
					      Electric Supply && Support to Stobart AirCraft
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
         
 	     <tr align="center" bgcolor="#FEF9E7">
				    
				    <td>
					    <b> 
					       002. 
					     </b>				 
					 </td>
					  
				    <td>
					      Fin-Fuel-10122019  
					 		 
					 </td>
					<td>
					      Fuel Supply Contract  to Stobart AirCraft
					 </td>
					<td>
					      Finance 
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
         	     <tr align="center" bgcolor="#FEF9E7">
				    
				    <td>
					    <b> 
					       003. 
					     </b>				 
					 </td>
					  
				    <td>
					      FAC-ELCE-10122019  
					 		 
					 </td>
					<td>
					      Canteen Food Supply Contract to Stobart Air
					 </td>
					<td>
					      Facility
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
              
            
 </table>           



</div>


<br>
<br>
<br>
<br>
<br>

<%@include file="../include/footer.jsp" %>

