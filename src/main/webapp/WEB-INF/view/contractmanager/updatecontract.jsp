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
	    document.updatecontract.method="POST"
	    document.updatecontract.action="contractManager";
        document.updatecontract.submit();
	    return true;
	
}//---------- End Of Function  ------------------

function toggle_visibility(id) {
    var e = document.getElementById(id);
    if(e.style.display == 'block')
       e.style.display = 'none';
    else
       e.style.display = 'block';
 }



function remove_contract(){

	    if(confirm("Are you Sure about removing this Contract From Database..??\n Note: Once you confirm then these file and data will be removed from the System..")){
	    	document.updatecontract.method="POST"
     	    document.updatecontract.action="contractManager?event=remove";
	        document.updatecontract.submit();
	  	    return true;
		}
	  
        	    
}


function manage_contract(event){

        document.updatecontract.method="POST"
	    document.updatecontract.action="contractManager?event="+event;
        document.updatecontract.submit();
	    return true;
	
/*
	  
    if(document.updatecontract.startDate.value == ""){
       alert("Please Select Contract Start Date");
       document.updatecontract.startDate.focus();
       return false;
	}
    
    if(document.updatecontract.endDate.value == ""){
       alert("Please Select Contract End Date");
       document.updatecontract.endDate.focus();
       return false;
	}
	
    if(document.updatecontract.comment.value == ""){
        alert("Please Enter Some detail ");
        document.updatecontract.comment.focus();
        return false;
 	}
 	
    if(document.updatecontract.cfile.value == ""){
        alert("Please Select File..");
        document.updatecontract.cfile.focus();
        return false;
 	}
 	
	else
    {
        document.updatecontract.method="POST"
	    document.updatecontract.action="contractManager?event="+event;
        document.updatecontract.submit();
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
 
 
 
 <form name="updatecontract" id="updatecontract" method="post" >
  
      <input type="hidden" name="emailid" id="emailid" value="<%=request.getParameter("emailid")%>">
      <input type="hidden" name="password" id="password" value="<%=request.getParameter("password")%>">
      
         
          <table class="table table-striped table-bordered" border="1" style="width: 35%;" align="center">	    
    			<tbody>				     
				     <tr align="center">
					 <td  bgcolor="#0070BA">
					   <span style="color:white;"> <i class="fa fa-suitcase fa-lg" aria-hidden="true"></i> &nbsp;<b>
					    Update Contract  &nbsp;&nbsp;
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
									
										<select  id="subdepartment" name="subdepartment" class="form-control" >
											<option value="ENG1"> - ENG One  - </option>	
											<option value="ENG2"> - ENG Two -  </option>
											
										</select>
							</div>
				    </div>
				    
				    
				    <div class="form-group">
							<label  >Contractor Company Detail.</label>
							<div class="input-group col-xs-12" >
								<span class="input-group-addon"><i class="fa fa-industry" aria-hidden="true"></i></span>
										<input type="text" size="5"  name="ccompany" id="ccompany" class="form-control" value="${contractdetail.contractor_name}">										
							</div>
				    </div>
				    
				    <div class="form-group">
							<label  >Contractor Contact Detail.</label>
							<div class="input-group">
								<span class="input-group-addon"><i class="fa fa-envelope-o" aria-hidden="true"></i>
								 <br><br><i class="fa fa-phone-square" aria-hidden="true"></i></span>
										<textarea rows="02" name="ccontract"  id="ccontract" class="form-control" placeholder="fullname@email.com"> ${contractdetail.contractor_contact_detail}</textarea>										
							</div>
				    </div>						
					
					<div class="form-group">
							<label  >Ref No.</label> <span style="font-weight:600;font-size:8pt;color:blue">
							&nbsp;&nbsp;This cant be modified</span> 
							<div class="input-group">
								<span class="input-group-addon"><i class="fa fa-strikethrough fa-lg" aria-hidden="true"></i></span>
										<input type="text"   name="refno" id="refno" class="form-control" readonly  value="${contractdetail.refrence_no}">										
							</div>
				    </div>
	
			                   
	
	                    <div class="form-group">
							<label for="startDate">Contract Start Date:</label>
							<div class="input-group">
								<span class="input-group-addon"><i class="fa fa-calendar"></i></span>								
								<input type="date" id="startDate" name="startDate" class="form-control datepicker" maxlength="12"  value="${contractdetail.start_date}" />
							</div>	
						</div>
						
				       <div class="form-group">
							<label for="endDate">Contract  End Date:</label>
							<div class="input-group">
								<span class="input-group-addon"><i class="fa fa-calendar"></i></span>
								
								<input type="date" id="endDate" name="endDate" class="form-control datepicker" maxlength="12" value="${contractdetail.end_date}"/>
								
							</div>
						</div>

				
					<div class="form-group">
							<label> Contract Description.</label>
							<div class="input-group">
								<span class="input-group-addon"><i class="fa fa-text-height fa-lg" aria-hidden="true"></i></i></span>							
									<textarea rows="05" name="cdescription"  id="cdescription" class="form-control">${contractdetail.contract_description}</textarea>
											
							</div>
				    </div>
				    
					
					<div class="form-group">
							<label>Already attached File. </label>							
							<span style="font-weight:400;font-size:9pt;">							
							<table align="left"  class="table table-striped table-bordered">							
							<% 							
							int filecount=1;							
							%>
							 <c:forEach var="filelist" items="${filelist}">       
							<tr> 
								<td align="left" width="85%"><b><%=filecount++%></b>.&nbsp; <img  src="images/page_white_acrobat.png">&nbsp; ${filelist} </td>
								<td align="left">
								 <span style="font-weight:600;font-size:9pt;color:red">
								   <i class="fa fa-trash-o" aria-hidden="true"></i><a href="">&nbsp;Del</a>
								 </span>  
								 </td>
							</tr>
						  </c:forEach>
							
							</table>
							</span>
				   </div>
				   <br>
		
				
					<div class="form-group">
							<label> Attach More File. </label>
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
			                   <span onClick="remove_contract();" id="addnew" class="btn btn-danger" >&nbsp;Remove &nbsp; <i class="fa fa-trash-o" aria-hidden="true"></i> </span>
			                   &nbsp;&nbsp;&nbsp;
			                   <span onClick="toggle_visibility('uploadstatus');manage_contract('update');" id="addnew" class="btn btn-success" >&nbsp;Update &nbsp; <i class="fa fa-pencil-square-o" aria-hidden="true"></i> </span>
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

