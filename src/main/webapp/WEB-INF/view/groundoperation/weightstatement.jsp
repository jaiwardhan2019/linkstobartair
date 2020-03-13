<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="../include/groundopsheader.jsp" />

<head>
    <title> Aircraft Weight Statements </title>    
</head>


<script src="https://canvasjs.com/assets/script/canvasjs.min.js"></script>

<script type="text/javascript">






function search_progress() {
    var e = document.getElementById("searchbutton");
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


function showWtstatement(operation){
    var airreg    = document.getElementById("airlinereg").value;
    var aircode   = document.getElementById("airlinecode").value;
      
	if(airreg == "ALL") {
	   alert("Please Select Aircraft Reg");
	   document.getElementById("airlinereg").focus();
	   return false;
	}

	if(aircode == "ALL") {
	   alert("Please Select Airline");
	   document.getElementById("airlinecode").focus();
	   return false;
	 }
	 else
	 {

	   document.getElementById("cat").value  = document.getElementById("airlinereg").value+"-"+document.getElementById("airlinecode").value;
	   document.getElementById("searchbutton").innerHTML = "<i class='fa fa-refresh fa-spin fa-lx' aria-hidden='true'></i>&nbsp;&nbsp;Searching..&nbsp;&nbsp;";
       document.wtstatement.method="POST";
	   document.wtstatement.action="wtstatement?operation="+operation;
	   document.wtstatement.submit();
	   return true;
	   
	 }
	 
}	



function addWtstatement(){
    var airreg    = document.getElementById("airlinereg").value;
    var aircode   = document.getElementById("airlinecode").value;
      
	if(airreg == "ALL") {
	   alert("Please Select Aircraft Reg");
	   document.getElementById("airlinereg").focus();
	   return false;
	}

	if(aircode == "ALL") {
	   alert("Please Select Airline");
	   document.getElementById("airlinecode").focus();
	   return false;
	 }
	 else
	 {

	   document.getElementById("cat").value  = document.getElementById("airlinereg").value+"-"+document.getElementById("airlinecode").value;
	   document.getElementById("searchbutton").innerHTML = "<i class='fa fa-refresh fa-spin fa-lx' aria-hidden='true'></i>&nbsp;&nbsp;Searching..&nbsp;&nbsp;";
       document.wtstatement.method="POST";
	   document.wtstatement.action="addwtstatement";
	   document.wtstatement.submit();
	   return true;
	   
	 }
	 
}	


function showAddingFile(){
    var e1 = document.getElementById("fileadding");
    if(e1.style.display == 'block')
        e1.style.display = 'none';
     else
        e1.style.display = 'block';  
}





</script>



<body>

 
 <form name="wtstatement" id="wtstatement" enctype="multipart/form-data">      
  
  <input type="hidden" name="emailid" value="<%=request.getParameter("emailid")%>">
  <input type="hidden" name="password" value="<%=request.getParameter("password")%>">
  <input type="hidden" name="usertype" value="${usertype}">
  <input type="hidden" name="cat" id="cat" value="">
    <input type="hidden" name="wtstm" id="wtstm" value="YES">
  
    
    
 <div class="container" align="center">
 
 
 
 <div class="col-md-12 col-sm-12 col-xs-12" align="center" >
 
 
       
  <table class="table table-striped table-bordered" border="1" style="width:50%;background:rgba(255,255,255);align:center;">	
   			<tbody>				     
				 <tr align="center">
					 <td  bgcolor="#0070BA" colspan="2">
					   <span style="color:white;">  <i class="fa fa-database fa-lx" aria-hidden="true"></i> &nbsp;<b>
					     Weight Statement  &nbsp;&nbsp; <i class="fad fa-plane-departure"> </i>
					   </b></span>					 
					 </td>
				 </tr>
		            
			    <tr>
	
						<td>
								<div class="col-xs-12">
										<label for="airlineCode">Operating Aircraft Reg:</label>
										<div class="input-group">
											<span class="input-group-addon"><i class="fa fa-plane"></i></span>							
												
												<select id="airlinereg" name="airlinereg" class="form-control">												
													     ${airlinereg}
							                    </select>   
									
									</div>
								</div>
					
					       </td>
	
	
					<td align="left" >
					 
							<div class="col-xs-12">
									<label for="airlineCode">Operating Airline:</label>
									<div class="input-group">
										<span class="input-group-addon"><i class="fa fa-plane"></i></span>
												<select id="airlinecode" name="airlinecode" class="form-control">
								                            	 ${airlinelist}
												</select>
									</div>
								</div>
							
						</td>
						
		
				     					
						 </tr>
					 
					 
				  <tr align="center"> 
				     					
					 <td width="50%">
				             
	                       <img  src="images/${airlinecode}1.png">
								
				       </td>
				       				
					<td width="50%" align="center">
					<br>
							<span id="searchbutton" onClick="showWtstatement('view');"  class="btn btn-primary" ><i  class="fa fa-search" aria-hidden="true"></i> WT Statement </span> 
		      			
				       </td>
				       
				     </tr>					 
				     		    
				    </tbody>
			</table>
	  </div>
	

 
   
		
</div>	

	
				
<div class="panel-body" align="center">	

  <div class="panel pane-default panel-shadow" style="width:43%;align:center;">			
	    
  <table class="table table-striped table-bordered" border="1" style="background:rgba(255,255,255);align:center;">	
    
      <!--  
	
		
		
	   <tr>
	         <td colspan="3" align="center">
	             <span style="color:blue;font-size:10pt;"> Sorry No Document found&nbsp;!!&nbsp;&nbsp;<i class="fa fa-frown-o  fa-lg"> </i>
	             <c:if test="${profilelist.docmanager  == 'Y'}">
	                &nbsp;&nbsp;&nbsp;<a href="javascript:void();" onClick="calDocumentReport('listdocuments?cat=home&operation=update');"><span class="label label-success"> Add New <i class="fa fa-pencil-square-o" aria-hidden="true"></i></span></a>
	             </c:if>
	       </td>
      </tr>	
   
        			
	       <tr style="font-size:09pt">									
				<td width="74%"><img src="pdf.png"> &nbsp; 
				<a href="AircraftWeightStatements/${contract.docCategory}/${contract.docName}" target="_new" >									     
			           GCI 2019.01 Connecting GPU with Anti-Collision Beacons.pdf
                 </a>									      
				</td>									
				<td width="14%">11 Mar 2020</td>
				<td align="center"> WTS </td>	
		    									    
			</tr>
   
      	
  			<tr>
			   <td  align="right" colspan="3">		
				      <a href="javascript:void();" onClick="showwtstatement('update');"><span class="label label-success">Update <i class="fa fa-pencil-square-o" aria-hidden="true"></i></span></a>
				   </td>
	       </tr>
	
    -->	   
   
   
	   <c:set var = "rowcount"  value = "${fn:length(gopsfilelist)}"/>
       <c:if test = "${rowcount == 0}">
	          
	   	   <tr>
		         <td colspan="3" align="center">
		             <span style="color:blue;font-size:10pt;"> Sorry No Document found&nbsp;!!&nbsp;&nbsp;<i class="fa fa-frown-o  fa-lg"> </i>
		             <c:if test="${profilelist.docmanager  == 'Y'}">
		                &nbsp;&nbsp;&nbsp;<a href="javascript:void();" onClick="showAddingFile();"><span class="label label-success"> Add Document <i class="fa fa-pencil-square-o" aria-hidden="true"></i></span></a>
		             </c:if>
		       </td>
	      </tr>	
        
       </c:if>
  
   
    
    
      <c:forEach var="contract" items="${gopsfilelist}">    
         	     		
	       <tr style="font-size:09pt">									
				<td width="74%" ><img src="pdf.png"> &nbsp; 
				     <a href="${contract.docCategory}/${contract.docName}" target="_new" >									     
             	            <c:set var="string1" value=" ${contract.docName}"/>
                                <c:set var="string2" value="${fn:substring(string1, 0,62)}" />
                                ${string2}
	                 </a>									      
				</td>									
				<td width="14%">${contract.docAddedDate}</td>
		         <td align="center">
					
					
					 <c:if test="${profilelist.docmanager  == 'Y'}">
					     <i  class="fa fa-trash" aria-hidden="true"></i>
						  <span style="font-size:9pt;">
	  					     <a style="color:red;" href="javascript:void();" onClick="showWtstatement('remove&docid=${contract.docId}');"> Rem </a>
						 </span>
					 </c:if>
					 
		         </td>
			</tr>
	  </c:forEach>    			
	       			
		       			           
		   <c:if test="${profilelist.docmanager  == 'Y'}">
				 
               <tr style="display:none" id="fileadding">
					<td align="right" colspan="2">
					    <br>
						<div class="col-xs-05">
							<div class="input-group"> 
								<span class="input-group-addon"><i class="fa fa-paperclip fa-lg" aria-hidden="true"></i>&nbsp;&nbsp;<b>Add New</b></span>							
									 <input type="file"  id="gfile"  name="gfile" multiple  class="form-control"/>
							 </div>
								 
				        </div>
				    
						</td>
						<td align="left">
							  <br>															 
                                 <span onClick="addWtstatement('')" id="addnew" class="btn btn-primary" >&nbsp;Upload&nbsp;<i class="fa fa-cloud-upload" aria-hidden="true"></i>  </span>  
						</td>
	       	</tr>
	        	
	     		     	
	       <tr>
		    <td colspan="3">
					    <span style="display:none" id="searchbutton1">
					              <div class="progress-bar progress-bar-striped active" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width:100%">
							        In Progress Please wait... 
							      </div>   
					        </span>
		   </td>
		</tr>	     	
	     	
	     			          						          			
	       </c:if>
      
  </table>
                
 </div>               		
 </div>
 </form>
 
</body>

<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<%@include file="../include/gopsfooter.jsp" %>




