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



function contract_home(event){    
	    document.addcontract.method="POST"
	    document.addcontract.action="contractManager";
        document.addcontract.submit();
	    return true;
	
}//---------- End Of Function  ------------------

function toggle_visibility(id) {
    var e = document.getElementById(id);
    if(e.style.display == 'block')
       e.style.display = 'none';
    else
       e.style.display = 'block';
 }



function manage_contract(event){    

	 
	   
    
        document.addcontract.method="POST"
	    document.addcontract.action="addcontracttodatabase";
        document.addcontract.submit();
	    return true;
	
/*
	  
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
	
    if(document.addcontract.comment.value == ""){
        alert("Please Enter Some detail ");
        document.addcontract.comment.focus();
        return false;
 	}
 	
    if(document.addcontract.cfile.value == ""){
        alert("Please Select File..");
        document.addcontract.cfile.focus();
        return false;
 	}
 	
	else
    {
        document.addcontract.method="POST"
	    document.addcontract.action="contractManager?event="+event;
        document.addcontract.submit();
	    return true;
	    
    }    
	*/
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
										<select id="department" name="department" class="form-control" onchange="showOtherdDateCaption()" >
											<option value="ALL"> ------ ALL ------ </option>	
											<option value="GEN"> General Contract - </option>	
											<option value="ENG"> Engineering </option>
											<option value="FIN"> Finance </option>												
										</select>
							</div>	
						</div>
				
				
					<div class="form-group">
							<label  >Sub Depart.</label>
							<div class="input-group">
								<span class="input-group-addon"><i class="fa fa-university" aria-hidden="true"></i></i></span>							
									
										<select  id="subdepartment" name="subdepartment" class="form-control" >
											<option value="GEN"> - General Contract - </option>	
											<option value="ENG1"> Sub - Engineering </option>
											
										</select>
							</div>
				    </div>
				    
				    
				    <div class="form-group">
							<label  >Contractor Company Detail.</label>
							<div class="input-group">
								<span class="input-group-addon"><i class="fa fa-industry" aria-hidden="true"></i></span>
										<input type="text"   name="ccompany" id="ccompany" class="form-control" >										
							</div>
				    </div>
				    
				    <div class="form-group">
							<label  >Contractor Contact Detail.</label>
							<div class="input-group">
								<span class="input-group-addon"><i class="fa fa-envelope-o" aria-hidden="true"></i></span>
										<textarea rows="03" name="ccontract"  id="ccontract" class="form-control"></textarea>										
							</div>
				    </div>						
					
					<div class="form-group">
							<label  >Ref No.</label> &nbsp;&nbsp;<i class="fa fa-hand-o-right" aria-hidden="true"></i>&nbsp;<span style="font-weight:600;font-size:8pt;color:blue">
							&nbsp;&nbsp;Sample:&nbsp;&nbsp;(ENG/ELE/SUPNAME/DD-MM-YYYY)</span> 
							<div class="input-group">
								<span class="input-group-addon"><i class="fa fa-strikethrough fa-lg" aria-hidden="true"></i></span>
										<input type="text"   name="refno" id="refno" class="form-control" >										
							</div>
				    </div>
	
			                   
	
	                    <div class="form-group">
							<label for="startDate">Contract Start Date:</label>
							<div class="input-group">
								<span class="input-group-addon"><i class="fa fa-calendar"></i></span>								
								<input type="date" id="startDate" name="startDate" class="form-control datepicker" maxlength="12"   placeholder="(DD/MM/YYYY)"/>
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
									 <input type="file"   name="file"   class="form-control"/>
							</div>
				   </div>
						
				
					
						</td>
						
				  </tr>	
						 
				     
				    <tr align="center"> 
				     					
						<td  bgcolor="white">			                   
			                   <span onClick="contract_home();" id="addnew" class="btn btn-primary" > &nbsp;Back&nbsp; <i class="fa fa-home" aria-hidden="true"></i>  </span>  
			                   &nbsp;&nbsp;&nbsp;
			                   <span onClick="toggle_visibility('uploadstatus');manage_contract('addnew');" id="addnew" class="btn btn-primary" >&nbsp;Add Contract &nbsp; <i class="fa fa-plus" aria-hidden="true"></i> </span>
                               &nbsp;                                
                              <span style="display:none" id="uploadstatus" class="btn btn-success btn-sm" > <i class="fa fa-spinner fa-pulse fa-2x"></i> &nbsp;Uploading  </span> 
                          
                                  
			                   
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

