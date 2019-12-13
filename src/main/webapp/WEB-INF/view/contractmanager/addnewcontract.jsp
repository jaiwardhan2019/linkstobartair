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
	     document.addcontract.refno.value=document.addcontract.refno.value+"-"+document.addcontract.ccompany.value.substring(0,4);
	     document.addcontract.refno.value=document.addcontract.refno.value+"-"+document.addcontract.startDate.value;
	     
	   
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
	  
    if(document.addcontract.ccompany.value == ""){
       alert("Please Enter Contractor Company Detail..");
       document.addcontract.ccompany.focus();
       return false;
	}
    
   if(document.addcontract.ccontract.value == ""){
       alert("Please Enter Contact Detail.. Email id / Phone no ..");
       document.addcontract.ccontract.focus();
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
	
    if(document.addcontract.cdescription.value == ""){
        alert("Please Enter Some detail abbout this Contract.");
        document.addcontract.cdescription.focus();
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


	
</script>



 
  <br>
 
 <div  style="margin-top:60px;" align="center">	
	
		<div class="col-md-12 col-sm-12 col-xs-12"  align="left">
			<i class="fa fa-suitcase fa-2x" aria-hidden="true"></i>&ensp;<span style="font-weight:600;font-size:13pt;">Add New Contracts.</span></a>
	   </div>	
  
  </div>		




 <br>
 <br>

 <body>
   
 <div class="container" align="center">
 
 <div class="col-md-12 col-sm-12 col-xs-12" align="center">
 
 
 
 <form name="addcontract" method="post" enctype="multipart/form-data">
  
      <input type="hidden" name="emailid" id="emailid" value="<%=request.getParameter("emailid")%>">
      <input type="hidden" name="password" id="password" value="<%=request.getParameter("password")%>">
      
         
          <table class="table table-striped table-bordered" border="1" style="width: 35%;" align="center">	    
    			<tbody>				     
				     <tr align="center">
					 <td  bgcolor="#0070BA">
					   <span style="color:white;"> <i class="fa fa-suitcase fa-lg" aria-hidden="true"></i> &nbsp;<b>
					    New Contract  &nbsp;&nbsp;
					   </b></span>					 
					 </td>
				     </tr>
			
			
			   <tr>
					<td align="left" bgcolor="white" >
					 
					
				     <div class="form-group">
							<label >Department.</label>
							<div class="input-group">
								<span class="input-group-addon"><i class="fa fa-universal-access" aria-hidden="true"></i></span>								
										<select id="department" name="department" class="form-control" onchange="bulit_ref_no()" >										
											<option value="GEN"> General Contract - </option>	
											<option value="ENG" > Engineering </option>
											<option value="FIN" > Finance </option>												
										</select>
							</div>	
						</div>
				
				
					<div class="form-group">
							<label  >Sub Depart.</label>
							<div class="input-group">
								<span class="input-group-addon"><i class="fa fa-university" aria-hidden="true"></i></i></span>							
									
										<select  id="subdepartment" name="subdepartment" class="form-control" onchange="bulit_ref_no()" >		
											<option value="ENG1"> - ENG One  - </option>	
											<option value="ENG2"> - ENG Two -  </option>
											
										</select>
							</div>
				    </div>
				    
				    
				    <div class="form-group">
							<label  >Contractor Company Detail.</label>
							<div class="input-group col-xs-12" >
								<span class="input-group-addon"><i class="fa fa-industry" aria-hidden="true"></i></span>
										<input type="text" size="5"  name="ccompany" id="ccompany" class="form-control" onkeypress="bulit_ref_no()" >										
							</div>
				    </div>
				    
				    <div class="form-group">
							<label  >Contractor Contact Detail.</label>
							<div class="input-group">
								<span class="input-group-addon"><i class="fa fa-envelope-o" aria-hidden="true"></i>
								 <br><br><i class="fa fa-phone-square" aria-hidden="true"></i></span>
										<textarea rows="02" name="ccontract"  id="ccontract" class="form-control" placeholder="fullname@email.com"></textarea>										
							</div>
				    </div>						
					
					<div class="form-group">
							<label  >Ref No.</label> 
							<!-- 
							&nbsp;&nbsp;<i class="fa fa-hand-o-right" aria-hidden="true"></i>&nbsp;<span style="font-weight:600;font-size:8pt;color:blue">
							&nbsp;&nbsp;Sample:&nbsp;&nbsp;(ENG/ELE/SUPNAME/DD-MM-YYYY)</span> 
							 -->
							<div class="input-group">
								<span class="input-group-addon"><i class="fa fa-strikethrough fa-lg" aria-hidden="true"></i></span>
										<input type="text"   name="refno" id="refno" class="form-control" readonly >										
							</div>
				    </div>
	
			                   
	
	                    <div class="form-group">
							<label for="startDate">Contract Start Date:</label>
							<div class="input-group">
								<span class="input-group-addon"><i class="fa fa-calendar"></i></span>								
								<input  type="date" id="startDate" name="startDate" class="form-control datepicker" maxlength="12"  onchange="bulit_ref_no()"  placeholder="(DD/MM/YYYY)"/>
							</div>	
						</div>
						
				       <div class="form-group">
							<label for="endDate">Contract  End Date:</label>
							<div class="input-group">
								<span class="input-group-addon"><i class="fa fa-calendar"></i></span>
								
								<input type="date" id="endDate" name="endDate" class="form-control datepicker" maxlength="12"  placeholder="(DD/MM/YYYY)"/>
								
							</div>
						</div>

				
					<div class="form-group">
							<label> Contract Description.</label>
							<div class="input-group">
								<span class="input-group-addon"><i class="fa fa-text-height fa-lg" aria-hidden="true"></i></i></span>							
									<textarea rows="05" name="cdescription"  id="cdescription" class="form-control"></textarea>
											
							</div>
				    </div>
						

				
					<div class="form-group">
							<label> Attach File. </label>
							<div class="input-group"> 
								<span class="input-group-addon"><i class="fa fa-paperclip fa-lg" aria-hidden="true"></i></span>							
									 <input type="file" id="cfile"  name="cfile"   class="form-control"/>
							</div>
				   </div>
						
				
					
						</td>
						
				  </tr>	
						 
				     
				    <tr align="center"> 
				     					
						<td  bgcolor="white">			                   
			                   <span onClick="contract_home();" id="addnew" class="btn btn-primary" > &nbsp;Back&nbsp; <i class="fa fa-home" aria-hidden="true"></i>  </span>  
			                   &nbsp;&nbsp;&nbsp;
			                   <span onClick="manage_contract('addnew');" id="addnew" class="btn btn-primary" >&nbsp;Add Contract &nbsp; <i class="fa fa-plus" aria-hidden="true"></i> </span>
                               
		 			     </td>
				     </tr>
			
			
			
				     <tr align="center"> 
				     					
						<td  bgcolor="white">			                   
			
			                <span style="display:none" id="uploadstatus" class="btn btn-success btn-sm" > <i class="fa fa-spinner fa-pulse fa-2x"></i> &nbsp; <b> Saving Contract.. </b> </span> 
            
            <!--       		                              
							<div class="progress" style="display:none" id="uploadstatus">
							
							  <div class="progress-bar progress-bar-striped active" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width:100%">
							    <b>Updating..</b>&nbsp;&nbsp;<i class="fa fa-spinner fa-pulse fa-lg"></i>
							  </div>
							</div>
                 -->             
                    
			        
			            </td>
			         
			         </tr> 
							    
				    </tbody>
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

