<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="../../include/gopsheader.jsp" />

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Manage Air Line Account </title>
</head>



<script type="text/javascript">
	


function searchUser(){


	  var userid = document.getElementById("user").value.trim();
      if(userid == ''){
	      alert("Please Enter User First Name , Last Name or Anything you remember.");
	      document.getElementById("user").focus();
	      return false;
	  }
      else
      {

    	  document.airlineAcount.method="POST";
		  document.airlineAcount.action="manageairlinedata";
	      document.airlineAcount.submit();
		  return true;

       }
          
             

}




function remove_airline_data(accountid){
			
		if(confirm("Are you sure about Removing This User ??")){
			   document.airlineAcount.method="POST";
			   document.airlineAcount.operation.value="remove";
			   document.airlineAcount.userinsubject.value=accountid;
			   document.airlineAcount.action="manageairlinedata";
			   document.airlineAcount.submit();
			   return true;		
		 }
	

} //-------- End Of Function 




function update_airline(accountid){
	
	   document.airlineAcount.method="POST"
	   document.airlineAcount.operation.value="updateexisting";
	   document.airlineAcount.userinsubject.value=accountid;
	   document.airlineAcount.action="manageairlinedata";
	   document.airlineAcount.submit();
	   return true;		

} //-------- End Of Function 







function add_new_airline(){
	
	   document.airlineAcount.method="POST"
	   document.airlineAcount.operation.value="addnew";
	   document.airlineAcount.action="manageairlinedata";
	   document.airlineAcount.submit();
	   return true;		

} //-------- End Of Function 







</script>



<body>


<!-- Body Banner -->
<div class="container" align="center" >
	  	
<!----------------- RIGHT CONTENT -------------------->
<div class="col-md-12 col-sm-12 col-xs-12" align="center" >

<form method="post" name="airlineAcount" onSubmit="return searchUser()";>

  <input type="hidden" id="emailid" name="emailid" value="<%=request.getAttribute("emailid")%>">
  <input type="hidden" id="password" name="password" value="<%=request.getAttribute("password")%>">
  <input type="hidden" name="usertype"  value="${usertype}">
  <input type="hidden" name="operation" id="operation" value="">
  <input type="hidden" name="userinsubject" id="userinsubject"  value="">
  
 	<br>
 	
	 		 
  <table  style="width: 100%;" align="center">
	  <tr>
			  <td> <font size="4">Manage Airline  Static Data and SLA</font></td>
		  <td align="right"> 
		      ${operationStatus} &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        		<span onClick="add_new_airline();" id="addnew" class="btn btn-primary" ><i class="fa fa-plane" aria-hidden="true"></i>&nbsp;&nbsp;Add New</span> 
		 
		  </td>

	   </tr>
	
			
 </table>	
	
 	<br>
 	
 	
 	
 	
 	
 	
 		 
  <table class="table table-striped table-bordered" border="1" style="width:100%;background:rgba(255,255,255,0.5);" align="center">	
	
	
		
	     <tr align="center">
				    
				    <td bgcolor="#0070BA">
					   <span style="color:white;" > <b> 
					   IATA Code
					     </b></span>					 
					 </td>
					  
					 <td bgcolor="#0070BA" >
					   <span style="color:white;"> <b> 
					      ICAO Code
					     </b></span>					 
					 </td>
	
					 <td bgcolor="#0070BA" width="15%">
					   <span style="color:white;"> <b> 
					      Name		     
					      </b></span>					 
					 </td>
				     
				     <td bgcolor="#0070BA" width="15%">
					   <span style="color:white;"> <b> 
					      SLA 1 
					      </b></span>					 
					 </td>
					 
					 <td bgcolor="#0070BA" width="15%">
					   <span style="color:white;"> <b> 
					      SLA 2     
					      </b></span>					 
					 </td>
					 
					 
					 <td bgcolor="#0070BA">
					   <span style="color:white;"> <b> 
					    Operational 
					     </b></span>					 
					 </td>
					
					     
				     <td bgcolor="#0070BA" >
					   <span style="color:white;"> <b> 
					       Update /  Remove 
					     </b></span>					 
					 </td>
          </tr>
          
       
      
       

       
           <%int ctr=1;%>
           <c:forEach var="airLineData" items="${listAirline}">          
		     
          
      	  <tr>
		          
		          <td> &nbsp;${airLineData.iata_code}</td>
		          
		          <td>${airLineData.icao_code}</td>
		         
		          <td>
		          
		  		    <a href="#" onclick="return false;" data-toggle="popover" data-trigger="hover"   data-content="${airLineData.comment}"> 
					          
		           
		                            <c:set var="string1" value="${airLineData.airline_name} "/>
                            <c:set var="string2" value="${fn:substring(string1, 0,25)}" />
			                   ${string2}
		
		             
		             </a>    		                    
		          
		          </td>
		          <td>
		
		                <c:set var="string1" value="${airLineData.sla_one} "/>
                            <c:set var="string2" value="${fn:substring(string1, 0,22)}" />
			                   ${string2}
		          
		                                
		          
		          </td>
		          <td>
		 
		                   <c:set var="string1" value="${airLineData.sla_two} "/>
                            <c:set var="string2" value="${fn:substring(string1, 0,22)}" />
		            ${string2}
		          
		          </td>
	
		          <td > &nbsp;&nbsp; 
		           
		              	<c:if test="${airLineData.status == 'Enable'}">
		                     <i class="fa fa-check-circle  fa-lg" aria-hidden="true"></i>&nbsp; <span style="color:green;font-weight:bold;"> Enable</span>
		                </c:if>
		          
		          
		            	 <c:if test="${airLineData.status == 'Disable'}">
		                    <i class="fa fa-times  fa-lg" aria-hidden="true"></i>&nbsp;  <span style="color:red;font-weight:bold;"> Disable  </span>
		                </c:if>
		           
		          </td>
		           
		           <td align="center"> 
		                <span style="font-weight:bold;" onClick="update_airline('${airLineData.id}');"  class="btn btn-info btn-sm"><i class="fa fa-pencil-square-o fa-lg" aria-hidden="true"></i>&nbsp;View / Update</span>
		          
		                &nbsp;
		                <span style="font-weight:bold;" onClick="remove_airline_data('${airLineData.id}');" class="btn btn-danger btn-sm"><i class="fa fa-trash-o fa-fw  fa-lg"></i>Remove</span>
		           
		           </td>
		          
		          </tr>    
                     <%ctr++;%>
           
           </c:forEach>  
          
		           
			      <c:set var = "rowcount"  value = "${fn:length(listAirline)}"/>
			      <c:if test = "${rowcount == 0}">
			      <tr>
		            <td colspan="6" align="center">
			                Sorry There is no Airline Found Please add new .
		             </td>
		          </tr>
		       
      </c:if>
      
          
         </table> 

        </div>
        
        
        
      </div>  

<script>

	$("#user").keyup(function(event){
		if(event.keyCode == 13){
			//$("#buttonDemo1").click();
			 
		}
	});
</script>
  
 </form>
  	 

</body>
</html>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
 <%@include file="../../include/gopsfooter.jsp" %>
