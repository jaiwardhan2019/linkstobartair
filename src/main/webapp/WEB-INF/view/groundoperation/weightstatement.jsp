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

function showwtstatement(){
	
	     document.getElementById("searchbutton").innerHTML = "<i class='fa fa-refresh fa-spin fa-lx' aria-hidden='true'></i>&nbsp;&nbsp;Searching..&nbsp;&nbsp;";
	     //<input type="button"  class="btn btn-primary" value="Show Report" onclick="showwtstatement();" />        
	     //search_progress();

		 document.wtstatement.method="POST";
		 document.wtstatement.action="wtstatement";
	     document.wtstatement.submit();
	     return true;
}	

</script>



<body>

 
 <form name="wtstatement" id="wtstatement">   
  
  <input type="hidden" name="emailid" value="<%=request.getParameter("emailid")%>">
  <input type="hidden" name="password" value="<%=request.getParameter("password")%>">
  <input type="hidden" name="usertype" value="${usertype}">
    
    
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
												
												<select id="airportcode" name="airportcode" class="form-control">												
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
							<span id="searchbutton" onClick="showwtstatement();"  class="btn btn-primary" ><i  class="fa fa-search" aria-hidden="true"></i> WT Statement </span> 
		      			
				       </td>
				       
				     </tr>					 
				     		    
				    </tbody>
			</table>
	  </div>
	
</form>
 
   
		
</div>	

	
				
<div class="panel-body">
				
				<table class="table" align="center" style="background:rgba(255,255,255);">	   
		
				
                </table>
                
 </div>               		
 
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




