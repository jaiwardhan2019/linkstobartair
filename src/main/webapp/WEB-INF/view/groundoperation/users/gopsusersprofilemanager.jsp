<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="../../include/gopsheader.jsp" />

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Manage Ground Ops Users Profile </title>
</head>




<script type="text/javascript">

	function calRefisReport_One(reportname,category){
		document.refieUser.method="POST";
		document.refieUser.action=reportname+"?user="+document.refieUser.user.value;
	    document.refieUser.submit();
		return true;
	}

	function updateUserProfile(reportname,useremail){
		document.refieUser.method="POST";
		document.refieUser.operation.value="update"
		document.refieUser.action=reportname+"?cat=update&user="+useremail;
	    document.refieUser.submit();
		return true;
	}
	
</script>

<body>
	<!-- Body Banner -->
	<div class="container" align="center">

		<!----------------- RIGHT CONTENT -------------------->
		<div class="col-md-12 col-sm-12 col-xs-12" align="center">

			<form method="post" name="refieUser" id="refieUser" onSubmit="return calRefisReport_One('gopsusersprofilemanager','Manage Ground Ops Users Profile');";>

	            <input type="hidden" id="profilelist" name="profilelist" value="${profilelist}">
				<input 	type="hidden" name="usertype" value="${usertype}"> 
				<input 	type="hidden" name="operation" id="operation" value=""> 
				<input 	type="hidden" name="userid" id="userid" value="${gopsuserdetail.username}">

				<table  style="width:80%;" align="center">  
				
 			     <tr>	  
					   <td width="50%" align="left"> <font size="4"><b>Manage Ground Ops Users Profile</b></font></td>
					   <td align="right" width="35%">						
							<input autofocus  type="text"  name="user"  id="user"  class="form-control"    placeholder="Enter First Name or Last Name"/>
						</td>
					    <td align="left"> 
					         &nbsp; &nbsp;<span onClick="calRefisReport_One('gopsusersprofilemanager','Manage Ground Ops Users Profile');" id="buttonDemo1" class="btn btn-primary" ><i class="fa fa-search" aria-hidden="true"></i>&nbsp;&nbsp;Search </span> 
					 	</td>
					</tr>
			   </table>
 		      <br>
 		      
			  <table  style="width:80%;" align="right">
			  <tr>		
					     </tr>
	
				</table>

<br> 
  <table class="table table-bordered" border="1" style="width: 80%;background:white;" align="center">	
		
	     <tr align="center">
				    
				    <td bgcolor="#0070BA">
					   <span style="color:white;" > <b> 
					    No.	
					     </b></span>					 
					 </td>
					  
					 <td bgcolor="#0070BA">
					   <span style="color:white;"> <b> 
					      Name 	
					     </b></span>					 
					 </td>
					 <td bgcolor="#0070BA">
					   <span style="color:white;"> <b> 
					    Email 	
					     </b></span>					 
					 </td>
					 <td bgcolor="#0070BA">
					   <span style="color:white;"> <b> 
					      Active 	
					     </b></span>					 
					 </td>
					
					 <td bgcolor="#0070BA">
					   <span style="color:white;"> <b> 
					      Admin . 	
					     </b></span>					 
					 </td>
				     
				     <td bgcolor="#0070BA">
					   <span style="color:white;"> <b> 
					      User Type.
					     </b></span>					 
					 </td>
          </tr>
           <%int ctr=1;%>
           <c:forEach var="linkusers" items="${linkuserlist}"> 
           
		               
		   <tr>
		          
		          <td><%=ctr%></td>
		          
		          <td><i class="fa fa-user-circle-o" aria-hidden="true"></i> &nbsp; <a href="javascript:void();" onClick="updateUserProfile('gopsusersprofilemanager','${linkusers.emailId}');" > ${linkusers.firstName}&nbsp;${linkusers.lastName} </a></td>
		         
		          <td>${linkusers.emailId}</td>
		         
		          <td align="center"> 
		          
		             
	            	    <c:if test="${linkusers.activeStatus == 'Active'}">
		                     <i class="fa fa-check-circle  fa-lg" aria-hidden="true"></i>&nbsp; <span style="color:green;font-weight:bold;"> Yes </span>
		                </c:if>
		          
		          
		            	<c:if test="${linkusers.activeStatus == 'Dactive'}">
		                    <i class="fa fa-times  fa-lg" aria-hidden="true"></i>&nbsp;  <span style="color:red;font-weight:bold;"> No </span>
		                </c:if>
		          
		          
		          </td>
		          
		          <td align="center"> 
		            
	            	    <c:if test="${linkusers.adminStatus == 'Y'}">
		                     <i class="fa fa-check-circle  fa-lg" aria-hidden="true"></i>&nbsp; <span style="color:green;font-weight:bold;"> Yes 
		                     </span>
		                </c:if>
		          
		          
		            	<c:if test="${linkusers.adminStatus == 'N'}">
		                    <i class="fa fa-times  fa-lg" aria-hidden="true"></i>&nbsp;  <span style="color:red;font-weight:bold;"> No  </span>
		                </c:if>
		          
		           
		          </td>
		           
		           <td align="center">  
		         
		                   <i class="fa fa-user-circle-o" aria-hidden="true"></i>&nbsp;
		                   <c:if test="${linkusers.stobart_external_user == 'I'}">
		                     <span style="color:blue;font-weight:bold;"> Stobart 
		                     </span>
		                   </c:if>
	                      <c:if test="${linkusers.stobart_external_user == 'E'}">
		                     <span style="color:green;font-weight:bold;"> External (G.H.) 
		                     </span>
		                   </c:if>
		        
		               
		           </td>
		          
		          </tr>
		         
		           <%
		           ctr++;
		           %>
           
           </c:forEach>
          


				<tr>

					<td colspan="6" align="center">
						<%
							if (ctr == 1) {
						%> Sorry There is no User Found based on your
						search criteria..!! <br> Please try again.!! <%
							}
						%>

					</td>
				</tr>
          
         </table> 
 				
             </form>
 
        </div>
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
