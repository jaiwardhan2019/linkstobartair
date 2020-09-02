<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<jsp:include page="../include/header.jsp" />


<head>
    <title> Stobart Air Invoice Conversion tool  XML to EXCEL </title>    
</head>

<script src="https://canvasjs.com/assets/script/canvasjs.min.js"></script>

<script type="text/javascript">

function contract_home(event){    
	    document.convertinvoice.method="POST"
	    document.convertinvoice.action="contractManager";
        document.convertinvoice.submit();
	    return true;
	
}//---------- End Of Function  ------------------


function search_progress() {
    var e = document.getElementById("convertbtn");
    if(e.style.display == 'block')
       e.style.display = 'none';
    else
       e.style.display = 'block';

    var e1 = document.getElementById("searchbutton1");
    if(e1.style.display == 'block')
        e1.style.display = 'none';
     else
        e1.style.display = 'block';    
 }



	function Validate_Xml_File(filePath) {
	
		var allowedExtensions = /(\.xml)$/i;

		if (!allowedExtensions.exec(filePath)) {
			alert('Invalid file type\n You have to select XML File Only..!!');		
			return false;
		} else {
			return true;
		}
	}

	
	
	
	
	
	
	function Convert_Invoice() {

		// document.getElementById("convertbtn").innerHTML = "<i class='fa fa-refresh fa-spin fa-lx' aria-hidden='true'></i>&nbsp;&nbsp;Converting..&nbsp;&nbsp;";
		if (document.convertinvoice.supplier.value == "all") {
			alert("Please Select Supplier.");
			document.convertinvoice.supplier.focus();
			return false;
		}
		if (document.convertinvoice.cfile.value == "") {
			alert("Please Select File..");
			document.convertinvoice.cfile.focus();
			return false;
		}
		if (Validate_Xml_File(document.convertinvoice.cfile.value)) {
			search_progress();
			document.convertinvoice.method = "POST"
			document.convertinvoice.action = "convertXmltoExcelandDownload";
			document.convertinvoice.submit();
			return true;
		}

	}//---------- End Of Function  ------------------
</script>



 
 <br>
 
 <div  style="margin-top:60px;" align="center">	
	
		<div class="col-md-12 col-sm-12 col-xs-12"  align="left">
			<i class="fa fa-cogs fa-2x" aria-hidden="true"></i>&ensp;&ensp;<span style="font-weight:600;font-size:13pt;">Invoice Conversion Tool.</span></a>
	   </div>	
  
  </div>		




 <br>
 <br>
 <br>

 <body>
   
 <div class="container" align="center">
 
 <div class="col-md-12 col-sm-12 col-xs-12" align="center">
 
 
 
 <form name="convertinvoice" id="convertinvoice" method="post" enctype="multipart/form-data">
  
      <input type="hidden" name="emailid" id="emailid" value="<%=request.getParameter("emailid")%>">
      <input type="hidden" name="password" id="password" value="<%=request.getParameter("password")%>">
 
         
      <table class="table table-striped table-bordered" border="1" style="width: 50%;" align="center">	    
    		<tbody>				     
			     <tr align="center">
					 <td  bgcolor="#0070BA" colspan="2">
					   <span style="color:white;"> <i class="fa fa-file-excel-o" aria-hidden="true"></i> &nbsp;<b>
					    Convert XML to EXCEL &nbsp;&nbsp;
					   </b></span>					 
					 </td>
			     </tr>
			
	           
	           <tr>
							<td align="right" bgcolor="white" width="40%">
							
									<label>Vendor / Supplier </label>
							</td>

							<td align="left" bgcolor="white" width="80%">
				      <div >
							<div class="input-group">
								<span class="input-group-addon"><i class="fa fa-truck" aria-hidden="true"></i></span>
										<select  id="supplier" name="supplier" class="form-control">	
										    <option value="all"> ---- SELECT---</option>
										    <option value="shell"> SHELL</option>
										    <option value="wfs">World Fuel Supplier</option>
										</select>
							</div>
				      </div>	               	               
	               </td>
	           </tr>
	           

	           <tr>
	              <td align="right" bgcolor="white" width="40%">				    
					<div><label>Add XML File </label></div>				  
				  </td>
				  
                 <td align="right" bgcolor="white" width="60%">     		         
			         	<div class="input-group"> 
								<span class="input-group-addon"><i class="fa fa-paperclip fa-lg" aria-hidden="true"></i></span>							
									 <input type="file"  id="cfile" multiple name="cfile"   class="form-control"/>
						</div>
				 </td>				
				  
	           </tr>
	          
	                <tr align="center" >
				     					
						<td  bgcolor="white" colspan="2">	
						
					        <span style="display:block" id="convertbtn">
					           <input type="button"  class="btn btn-primary" value="Convert Invoice" onclick="Convert_Invoice();" /> 
					        </span>
					        
					        <span style="display:none" id="searchbutton1">
					                <div class="progress-bar progress-bar-striped active" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width:100%">
							         <b>Converting File please wait....</b>&nbsp;&nbsp;<i class="fa fa-spinner fa-pulse fa-2x"></i>
							         </div>
					        </span>
			 			     </td>
				     </tr>
				     			
					 <c:if test="${fn:length(status) > 1}">
					 
					     ${status}
					 
					 </c:if>
					 
					 
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

