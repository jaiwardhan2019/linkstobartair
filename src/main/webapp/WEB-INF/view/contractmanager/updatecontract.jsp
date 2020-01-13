<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<jsp:include page="../include/header.jsp" />


<head>
    <title> Stobart Air Contract Manager </title>    
</head>

<script src="https://canvasjs.com/assets/script/canvasjs.min.js"></script>
<script type="text/javascript">





function contract_home(event){    
	     document.updatecontract.method="POST"
	     document.updatecontract.action="contractManager";
         document.updatecontract.submit();
	     return true;
	
}//---------- End Of Function  ------------------



function toggle_visibility() {
    var e = document.getElementById("uploadstatus");
    if(e.style.display == 'block')
       e.style.display = 'none';
    else
       e.style.display = 'block';
 }



function remove_contract(){

	    if(confirm("Are you Sure about removing this Contract From Database..??\n Note: Once you confirm then these file and data will be removed from the System..")){
	    	document.updatecontract.method="POST"
	    	document.updatecontract.event.value="remove";
     	    document.updatecontract.action="contractManager";
	        document.updatecontract.submit();
	  	    return true;
		}
	  
        	    
}


function manage_contract(event){

	  
    if(document.updatecontract.ccompany.value == ""){
       alert("Please Enter Contractor Company Detail..");
       document.updatecontract.ccompany.focus();
       return false;
	}
    
   if(document.updatecontract.ccontract.value == ""){
       alert("Please Enter Contact Detail.. Email id / Phone no ..");
       document.updatecontract.ccontract.focus();
       return false;
	}
	  
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
	
    if(document.updatecontract.cdescription.value == ""){
        alert("Please Enter Some detail abbout this Contract.");
        document.updatecontract.cdescription.focus();
        return false;
 	}
 	
    else
    {

    	   if(confirm("Are you Sure about Updating this Contract..??")){
					toggle_visibility();		
			        document.updatecontract.method="POST"
				    document.updatecontract.action="updatecontracttodatabase";
			        document.updatecontract.submit();
				    return true;
    	   }
		    
    }    
	
}//---------- End Of Function  ------------------



function  archive_contract(){


	   if(confirm("You are going to Archive this Contract .. Are you Sure about this..??")){

			    toggle_visibility();
			    document.updatecontract.status.value="Archived";		
		        document.updatecontract.method="POST"
			    document.updatecontract.action="updatecontracttodatabase";
		        document.updatecontract.submit();
			    return true;
	   }
}



function  renew_contract(){


	   if(confirm("Are you Sure about this..??")){

			    toggle_visibility();
			    document.updatecontract.event.value="renew";		
		        document.updatecontract.method="POST";
			    document.updatecontract.action="contractManager";
		        document.updatecontract.submit();
			    return true;
	   }
}





function Remove_File_From_Folder(filename){
	
      
	  
	    if(confirm("Are you Sure about removing this File From Contract.??\n Note: Once you confirm then this file can not be recovered..")){
	    	document.updatecontract.event.value="removefilefromfolder";
	    	document.updatecontract.method="POST";
	    	document.updatecontract.action="contractManager?filename="+filename;
	        document.updatecontract.submit();
	  	    return true;
		}
	


}//--- End of Function ------------



function view_contract(){
	
	    document.updatecontract.departmentselected.value=document.updatecontract.department.value;	
	    document.updatecontract.event.value="view";  
        document.updatecontract.method="POST";
	    document.updatecontract.action="contractManager";
        document.updatecontract.submit();
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
 
 
 
 <form name="updatecontract" id="updatecontract" method="post" enctype="multipart/form-data">
  
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
					    Update   &nbsp;&nbsp;
					   </b></span>					 
					 </td>
			     </tr>
			
			
			   <tr>
                
                  <td align="left" bgcolor="white" width="50%">
					<div class="col-xs-12">
							<label> Contract Detail.</label>
							<div class="input-group">
								<span class="input-group-addon"><i class="fa fa-text-height fa-lg" aria-hidden="true"></i></i></span>							
									<textarea rows="04" name="cdescription"  id="cdescription" class="form-control">${contractdetail.contract_description}</textarea>
											
							</div>
				    </div>
				    
	    
		                
	                </td>
	 				
				            
	              <td align="left" bgcolor="white" width="50%">
					<div class="col-xs-12">
							<label  >Ref No.</label>  
							<div class="input-group">
								<span class="input-group-addon"><i class="fa fa-strikethrough fa-lg" aria-hidden="true"></i></span>
										<input type="text"   name="refno" id="refno" class="form-control" readonly  value="${contractdetail.refrence_no}">										
							</div>
				    </div>
				    <br>
				    <br>
				     <br>
				    &nbsp;&nbsp;&nbsp;&nbsp;<span style="font-weight:600;font-size:8pt;color:blue;">
							&nbsp;&nbsp;${contractupdate}</span>
	                
	                </td>
      	                
	           </tr>
	           
	           
	           
	           <tr>
	               <td align="left" bgcolor="white" width="50%">
					     <div class="col-xs-12">
							<label >Department.</label>
							<div class="input-group">
								<span class="input-group-addon"><i class="fa fa-universal-access" aria-hidden="true"></i></span>								
										<select id="department" name="department" class="form-control" onchange="view_contract()" >										
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
									
										<select  id="subdepartment" name="subdepartment" class="form-control" >
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
								<input type="date" id="startDate" name="startDate" class="form-control datepicker" maxlength="12"  value="${contractdetail.start_date}" />
							</div>	
						</div>
		           
		           
		           </td>
		           
		           
		           <td align="left" bgcolor="white" width="50%">
						
				       <div class="col-xs-12">
							<label for="endDate">End Date:</label>
							<div class="input-group">
								<span class="input-group-addon"><i class="fa fa-calendar"></i></span>
								
								<input type="date" id="endDate" name="endDate" class="form-control datepicker" maxlength="12" value="${contractdetail.end_date}"/>
								
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
									<textarea rows="03" name="ccompany"  id="ccompany" class="form-control" >${contractdetail.contractor_name}</textarea>  										
							</div>
				    </div>
				    				  
				  </td>
				  
				  <td align="left" bgcolor="white" width="50%">
				    <div class="col-xs-12">
							<label  >Contractor Contact.</label>
							<div class="input-group">
								<span class="input-group-addon"><i class="fa fa-envelope-o" aria-hidden="true"></i>
								 <br><br><i class="fa fa-phone-square" aria-hidden="true"></i></span>
										<textarea rows="03" name="ccontract"  id="ccontract" class="form-control" placeholder="fullname@email.com">${contractdetail.contractor_contact_detail}</textarea>										
							</div>
				    </div>						
				  
				  
				  </td>
				  
	           </tr>
	           


	           <tr>
	              <td align="left" bgcolor="white" colspan="2">
		         	
						<label>Already attached File. </label>							
				        <br>
							<span style="font-weight:400;font-size:10pt;">							
				
						<table  align="left"  width="50%" class="table table-striped" style="width:85%;">							
							<% 							
							int filecount=0;							
							%>
								<c:forEach var="filelist" items="${filelist}">       
									 <tr> 
									 	<td align="left" width="80%"><b><%=++filecount%></b>.&nbsp; <img  src="images/page_white_acrobat.png">&nbsp;&nbsp; 
										    <b><a href="${contractdetail.refrence_no}/${filelist}"  target="_blank">  ${filelist}  </a> </b>
										</td>
										<td align="left" width="20%">
										   <span style="font-weight:600;font-size:9pt;color:red">
										      <i class="fa fa-trash-o" aria-hidden="true"></i><a href="javascript:void();" onClick="Remove_File_From_Folder('${filelist}');">&nbsp;Remove </a>
										    </span>  
										 </td>
									  </tr>
								     </c:forEach>
					     
								<% 							
								if(filecount==0){
								%>	
			                        <tr> 
									 	<td align="center" colspan="2">
										
										  <span style="font-weight:600;font-size:9pt;color:red">
										          
										          Please Attach Contract File with it..
										    </span>  
										 </td>
									  </tr>
														
									
									
								<%	
								}							
								%>

					     
								     
								     
								     
								     
								
							</table>
							</span>
				 		  
				  
				  </td>
				  
	           </tr>


	           <tr>
	              <td align="left" bgcolor="white">
				
					<div class="col-xs-12">
							<label> Attach More File. </label>
							<div class="input-group"> 
								<span class="input-group-addon"><i class="fa fa-paperclip fa-lg" aria-hidden="true"></i></span>							
									 <input type="file"  id="cfile"  name="cfile"   class="form-control"/>
							</div>
				   </div>
				  
				  </td>
				  
				  
				  <td align="left" bgcolor="white">
						<div class="col-xs-12">
						  <label>Status.</label>		
								<div class="input-group"> 
									<span class="input-group-addon"><i class="fa fa-thumbs-o-up fa-lg" aria-hidden="true"></i></span>							
										<select id="status" name="status" class="form-control"  >										
												<option value="Active" <c:if test = "${contractdetail.status == 'Active'}"> selected  </c:if> > Active </option>	
												<option value="Dactive" <c:if test = "${contractdetail.status == 'Dactive'}"> selected  </c:if> > Expired </option>
												<option value="Archived" <c:if test = "${contractdetail.status == 'Archived'}"> selected  </c:if> > Archived </option>
																								
											</select>
								</div>
	
						  </div>
				  
				  </td>
				  
	           </tr>
	           


				    <tr align="center"> 
				     					
						<td  bgcolor="white" colspan="2">	
					
						     <%
						     if(request.getParameter("emailid").equals("jai.wardhan@stobartair.com")){
						     %>
			                   <span onClick="remove_contract();" id="addnew" class="btn btn-danger" >&nbsp;Remove &nbsp; <i class="fa fa-trash-o" aria-hidden="true"></i> </span>
								 &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;

                             <%
						     }
                             %>

			                   <span onClick="contract_home();" id="addnew" class="btn btn-primary" > &nbsp;Contract &nbsp;<i class="fa fa-home" aria-hidden="true"></i>  </span>  

			                   &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;  
			                   <span onClick="archive_contract();" id="addnew" class="btn btn-warning" >&nbsp;Archive &nbsp; <i class="fa fa-archive" aria-hidden="true"></i> </span>

			                   &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;   
			                   <span onClick="manage_contract('update');" id="addnew" class="btn btn-success" >&nbsp;Update &nbsp; <i class="fa fa-pencil-square-o" aria-hidden="true"></i> </span>
 		 			     </td>
				     </tr>
	           	           
       	   </tbody>             
     </table>  	   
      
      <table width="65%" align="center" border="0">
      		     <tr align="center" > 
				     					
						<td  bgcolor="white" colspan="2" >			                   
			                 
			                <span style="display:none" id="uploadstatus">   
			                  <div  class="progress-bar progress-bar-striped active" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width:100%">
							         <b>Updating..</b>&nbsp;&nbsp;<i class="fa fa-spinner fa-pulse fa-lg"></i>
			                  </div>
			                 </span> 
    		            </td>
			         
			         </tr> 
		
      
      
      </table>
    
    
    
    
    
    
    
    <br>
    <br>
    <br>
      				 
	  
	
			
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

