<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<jsp:include page="../include/header.jsp" />


<head>
    <title> Stobart Air Invoice Conversion tool </title>    
</head>

<script src="https://canvasjs.com/assets/script/canvasjs.min.js"></script>
<script type="text/javascript">




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
        alert("Please Enter Some Detail About This Contract.");
        document.addcontract.cdescription.focus();
        return false;
 	}

    if(document.addcontract.department.value == "00"){
    	alert("Pelase select Department"); 
    	document.addcontract.department.focus();
    	return false;
    }
 	
    if(document.addcontract.startDate.value == ""){
        alert("Please Select Contract Start Date");
        document.addcontract.startDate.focus();
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
			<i class="fa fa-file-excel-o fa-2x" aria-hidden="true"></i>&ensp;<span style="font-weight:600;font-size:13pt;">Invoice Conversion Tool.</span></a>
	   </div>	
  
  </div>		




 <br>
 <br>
 <br>

 <body>
   
 <div class="container" align="center">
 
 <div class="col-md-12 col-sm-12 col-xs-12" align="center">
 
 
 
 <form name="addcontract" id="addcontract" method="post" enctype="multipart/form-data">
  
      <input type="hidden" name="emailid" id="emailid" value="<%=request.getParameter("emailid")%>">
      <input type="hidden" name="password" id="password" value="<%=request.getParameter("password")%>">
      <input type="hidden" name="event" id="event" value="">    
         
      <table class="table table-striped table-bordered" border="1" style="width: 55%;" align="center">	    
    		<tbody>				     
			     <tr align="center">
					 <td  bgcolor="#0070BA" colspan="2">
					   <span style="color:white;"> <i class="fa fa-file-excel-o" aria-hidden="true"></i> &nbsp;<b>
					    Convert XML to EXCEL &nbsp;&nbsp;
					   </b></span>					 
					 </td>
			     </tr>
			
	           
	           <tr>
							<td align="left" bgcolor="white" width="20%">
								<div>
									<label>Supplier </label>
							</td>

							<td align="left" bgcolor="white" width="80%">
				      <div >
							<div class="input-group">
								<span class="input-group-addon"><i class="fa fa-truck" aria-hidden="true"></i></span>
										<select  id="subdepartment" name="subdepartment" class="form-control">	
										
										    <option value="SHELL"> -- SHELL--</option>
										    <option value="WFS"> -- World Fuel--</option>
										    										
											
										</select>
							</div>
				      </div>	               
	               
	               </td>
	           
	           
	           </tr>
	           
	 	          
	


	           <tr>
	              <td align="left" bgcolor="white" width="20%">
				
					<div >
							<label> Select File </label>
				   </div>
				  
				  </td>
				  
                 <td align="left" bgcolor="white" width="80%">	
     		         
			         			<div class="input-group"> 
								<span class="input-group-addon"><i class="fa fa-paperclip fa-lg" aria-hidden="true"></i></span>							
									 <input type="file"  id="cfile" multiple name="cfile"   class="form-control"/>
							</div>
		
      			 </td>
				
				  
	           </tr>
	          
	           <tr align="center" >
				     					
						<td  bgcolor="white" colspan="2">	
						       <span onClick="contract_home();" id="addnew" class="btn btn-primary" > &nbsp;Contract &nbsp;<i class="fa fa-home" aria-hidden="true"></i>  </span>  
						       &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;
			                   <span onClick="manage_contract('addnew');" id="addnew" class="btn btn-success" >&nbsp;Save Contract &nbsp; <i class="fa fa-plus" aria-hidden="true"></i> </span>
                               
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

