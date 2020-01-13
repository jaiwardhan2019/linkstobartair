<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<jsp:include page="../include/header.jsp" />


<head>
    <title> Stobart Contract Manager </title>    
</head>

<script src="https://canvasjs.com/assets/script/canvasjs.min.js"></script>
<script type="text/javascript">


//https://www.codejava.net/coding/upload-files-to-database-servlet-jsp-mysql 
//https://www.codejava.net/java-ee/servlet/apache-commons-fileupload-example-with-servlet-and-jsp
//https://javarevisited.blogspot.com/2013/07/ile-upload-example-in-servlet-and-jsp-java-web-tutorial-example.html



function bulit_ref_no(){
	
      	 document.addcontract.refno.value=document.addcontract.department.value;

	 	 document.addcontract.refno.value=document.addcontract.refno.value+"-"+document.addcontract.subdepartment.value;

		 document.addcontract.refno.value=document.addcontract.refno.value+"-"+document.addcontract.ccompany.value.substring(0,4).trim();

	     document.addcontract.refno.value=document.addcontract.refno.value+"-"+document.addcontract.startDate.value.trim();
	     
	   
}


function contract_home(event){    
	    document.addcontract.method="POST"
	    document.addcontract.action="contractManager";
        document.addcontract.submit();
	    return true;
	
}//---------- End Of Function  ------------------

function toggle_visibility() {
    var e = document.getElementById("uploadstatus");
    if(e.style.display == 'block')
       e.style.display = 'none';
    else
       e.style.display = 'block';
 }



function manage_contract(event){    

    if(document.addcontract.cdescription.value.trim() == ""){
        alert("Please Enter Some detail abbout this Contract.");
        document.addcontract.cdescription.focus();
        return false;
 	}
 	
    if(document.addcontract.startDate.value == ""){
        alert("Please Select Contract Start Date");
        document.addcontract.startDate.focus();
        return false;
 	}
     
     if(document.addcontract.endDate.value == ""){
        alert("Please Select Contract End Date");
        document.addcontract.endDate.focus();
        return false;
 	}
 	
   if(document.addcontract.ccompany.value.trim() == ""){
       alert("Please Enter Contractor Company Detail..");
       document.addcontract.ccompany.focus();
       return false;
	}
    
   if(document.addcontract.ccontract.value.trim() == ""){
       alert("Please Enter Contact Detail.. Email id / Phone no ..");
       document.addcontract.ccontract.focus();
       return false;
	}
 	
    if(document.addcontract.cfile.value == ""){
        alert("Please Select File..");
        document.addcontract.cfile.focus();
        return false;
 	}
 	
	else
    {


		toggle_visibility();
        document.addcontract.method="POST"
	    document.addcontract.action="addcontracttodatabase";
        document.addcontract.submit();
	    return true;
		    
    }    
	
}//---------- End Of Function  ------------------




function Load_Subdepartment(){
	  
	    document.addcontract.departmentselected.value=document.addcontract.department.value;	
	    document.addcontract.event.value="addnew";  
        document.addcontract.method="POST";
	    document.addcontract.action="contractManager";
        document.addcontract.submit();
	    return true;

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

 <body>
   
 <div class="container" align="center">
 
 <div class="col-md-12 col-sm-12 col-xs-12" align="center">
 
 
 
 <form name="addcontract" id="addcontract" method="post" enctype="multipart/form-data">
  
      <input type="hidden" name="emailid" id="emailid" value="<%=request.getParameter("emailid")%>">
      <input type="hidden" name="password" id="password" value="<%=request.getParameter("password")%>">
       <input type="hidden" name="departmentselected" id="departmentselected" value="">
       <input type="hidden" name="subdepartmentselected" id="subdepartmentselected" value="">    
       <input type="hidden" name="event" id="event" value="">    
         
      <table class="table table-striped table-bordered" border="1" style="width: 65%;" align="center">	    
    		<tbody>				     
			     <tr align="center">
					 <td  bgcolor="#0070BA" colspan="2">
					   <span style="color:white;"> <i class="fa fa-suitcase fa-lg" aria-hidden="true"></i> &nbsp;<b>
					    Add New Contract &nbsp;&nbsp;
					   </b></span>					 
					 </td>
			     </tr>
			
			
			   <tr>
                
                  <td align="left" bgcolor="white" width="50%">
					<div class="col-xs-12">
							<label> Contract Detail.</label>
							<div class="input-group">
								<span class="input-group-addon"><i class="fa fa-text-height fa-lg" aria-hidden="true"></i></i></span>							
									<textarea rows="04" name="cdescription"  id="cdescription" class="form-control">${cdescription}</textarea>
											
							</div>
				    </div>
				    
	    
		                
	                </td>
	 				
				            
	              <td align="left" bgcolor="white" width="50%">
	              	  <c:set var = "now" value = "<%=new java.util.Date()%>" />
				      
	              
					<div class="col-xs-12">
							<label  >Ref No.</label>  
							<div class="input-group">
								<span class="input-group-addon"><i class="fa fa-strikethrough fa-lg" aria-hidden="true"></i></span>
										<input type="text"   name="refno" id="refno" class="form-control" readonly value="CS_<fmt:formatDate pattern = "ddMMyyyyhhmmss" value = "${now}"/>" >										
							</div>
				    </div>
				    
                        
				    
				    
	                </td>
      	                
	           </tr>
	           
	           
	           
	           <tr>
	               <td align="left" bgcolor="white" width="50%">
					     <div class="col-xs-12">
							<label >Department.</label>
							<div class="input-group">
								<span class="input-group-addon"><i class="fa fa-universal-access" aria-hidden="true"></i></span>								
										<select id="department" name="department" class="form-control" onchange="Load_Subdepartment();">	
		                                          ${departmentlist}						
										</select>
							</div>	
						</div>
	               
	               
	               </td>
	               
	               <td align="left" bgcolor="white" width="50%">
				      <div class="col-xs-12">
							<label  >Sub Depart.</label>
							<div class="input-group">
								<span class="input-group-addon"><i class="fa fa-university" aria-hidden="true"></i></i></span>							
									
										<select  id="subdepartment" name="subdepartment" class="form-control">	
										       ${subdepartmentlist}
											
										</select>
							</div>
				    </div>
	               
	               
	               </td>
	           
	           
	           </tr>
	           
	           
	           <tr>
		           <td align="left" bgcolor="white" width="50%">
                    <div class="col-xs-12">
							<label for="startDate">Start Date:</label>
							<div class="input-group">
								<span class="input-group-addon"><i class="fa fa-calendar"></i></span>								
								<input type="date" id="startDate" name="startDate" class="form-control datepicker" maxlength="12"  value="${startDate}"/>
							</div>	
						</div>
		           
		           
		           </td>
		           
		           
		           <td align="left" bgcolor="white" width="50%">
						
				       <div class="col-xs-12">
							<label for="endDate">End Date:</label>
							<div class="input-group">
								<span class="input-group-addon"><i class="fa fa-calendar"></i></span>
								
								<input type="date" id="endDate" name="endDate" class="form-control datepicker" maxlength="12" value="${endDate}" />
								
							</div>
						</div>
		           
		           
		           </td>
		           
	           </tr>
	           
	           
	           <tr>
	           
				  
				  <td align="left" bgcolor="white" width="50%">
					    <div class="col-xs-12">
							<label  >Contractor Company Name.</label>
							<div class="input-group col-xs-12" >
								<span class="input-group-addon"><i class="fa fa-industry" aria-hidden="true"></i></span>
									<textarea rows="03" name="ccompany"  id="ccompany" class="form-control">${ccompany}</textarea>  										
							</div>
				    </div>
				    				  
				  
				  
				  </td>
	           
				  
				  
				  
				  
				  <td align="left" bgcolor="white" width="50%">
				    <div class="col-xs-12">
							<label  >Contractor Contact.</label>
							<div class="input-group">
								<span class="input-group-addon"><i class="fa fa-envelope-o" aria-hidden="true"></i>
								 <br><br><i class="fa fa-phone-square" aria-hidden="true"></i></span>
										<textarea rows="03" name="ccontract"  id="ccontract" class="form-control" placeholder="fullname@email.com">${ccontract}</textarea>										
							</div>
				    </div>						
				  
				  
				  </td>
				  
	           </tr>
	           



	           <tr>
	              <td align="left" bgcolor="white" width="50%">
				
					<div class="col-xs-08">
							<label> Attach File. </label>
							<div class="input-group"> 
								<span class="input-group-addon"><i class="fa fa-paperclip fa-lg" aria-hidden="true"></i></span>							
									 <input type="file"  id="cfile"  name="cfile"   class="form-control"/>
							</div>
				   </div>
				  
				  </td>
				  
                 <td align="left" bgcolor="white" width="50%">	
     		         
			         </span> 
      			 </td>
				
				  
	           </tr>


		     
				    <tr align="center" > 
				     					
						<td  bgcolor="white" colspan="2">	
						       <span onClick="contract_home();" id="addnew" class="btn btn-primary" > &nbsp;Contract &nbsp;<i class="fa fa-home" aria-hidden="true"></i>  </span>  
						       &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;
			                   <span onClick="manage_contract('addnew');" id="addnew" class="btn btn-success" >&nbsp;Add Contract &nbsp; <i class="fa fa-plus" aria-hidden="true"></i> </span>
                               
		 			     </td>
				     </tr>
			
			
			
							    
				    </tbody>
			</table>
	        
	        <table  border="0" width="65%" align="center">
			     <tr align="center"> 
				     					
						<td  bgcolor="white" colspan="2">			                   
			            
			               <span style="display:none" id="uploadstatus"  >			         
	 		                  <div  class="progress-bar progress-bar-striped active" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" style="width:100%">
							         <b>Saving Contract..</b>&nbsp;&nbsp;<i class="fa fa-spinner fa-pulse fa-lg"></i>
			                  </div>
	
	           
			        
			            </td>
			         
			         </tr> 
		        
	        </table>	    
	  
	
			
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

