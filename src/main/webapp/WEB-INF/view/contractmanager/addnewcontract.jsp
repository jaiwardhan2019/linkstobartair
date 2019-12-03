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





function manage_contract(event){    

    document.addcontract.method="POST"
	    document.addcontract.action="contractManager?event="+event;
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
 
 <div class="col-md-12 col-sm-12 col-xs-12" align="center" id="printButton">
 
 <form name="addcontract"  enctype="multipart/form-data">  
  
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
											<option value="ALL"> -  All - </option>	
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
											<option value="ALL"> -  All - </option>
											<option value="ENG1"> Sub - Engineering </option>
											
										</select>
							</div>
						</div>
						
					
					<div class="form-group">
							<label  >Ref No.</label>
							<div class="input-group">
								<span class="input-group-addon"><i class="fa fa-strikethrough fa-lg" aria-hidden="true"></i></span>
										<input type="text"  maxlength="4" size="4" name="refno" id="refno" class="form-control"  readonly>										
							</div>
				    </div>
	
			                   
	
	                    <div class="form-group">
							<label for="startDate">Contract Start Date:</label>
							<div class="input-group">
								<span class="input-group-addon"><i class="fa fa-calendar"></i></span>								
								<input type="date" id="startDate" name="startDate" class="form-control datepicker" maxlength="12" max="${todaydate}"  placeholder="(DD/MM/YYYY)"/>
							</div>	
						</div>
						
				       <div class="form-group">
							<label for="endDate">Contract  End Date:</label>
							<div class="input-group">
								<span class="input-group-addon"><i class="fa fa-calendar"></i></span>
								
								<input type="date" id="endDate" name="endDate" class="form-control datepicker" maxlength="12" max="${todaydate}"  placeholder="(DD/MM/YYYY)"/>
								
							</div>
						</div>

				
					<div class="form-group">
							<label> Contract Description.</label>
							<div class="input-group">
								<span class="input-group-addon"><i class="fa fa-text-height fa-lg" aria-hidden="true"></i></i></span>							
									<textarea rows="05" name="comment"  id="comment" class="form-control"></textarea>
											
							</div>
				    </div>
						

				
					<div class="form-group">
							<label> Attach File. </label>
							<div class="input-group"> 
								<span class="input-group-addon"><i class="fa fa-paperclip fa-lg" aria-hidden="true"></i></span>							
									 <input type="file"  size="10" name="cfile"   class="form-control"/>
							</div>
				   </div>
						

				
					
						</td>
						
				  </tr>	
						 
				     
				    <tr align="center"> 
				     					
						<td  bgcolor="white">			                   
			                   <span onClick="contract_home();" id="addnew" class="btn btn-primary" > &nbsp;Contract &nbsp; <i class="fa fa-home" aria-hidden="true"></i>  </span>  
			                   &nbsp;&nbsp;&nbsp;
			                   <span onClick="manage_contract('add');" id="addnew" class="btn btn-primary" >&nbsp;Add Contract &nbsp; <i class="fa fa-plus" aria-hidden="true"></i> </span> 
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

