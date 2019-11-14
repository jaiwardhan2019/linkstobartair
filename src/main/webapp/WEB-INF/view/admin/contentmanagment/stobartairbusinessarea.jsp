<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="../../include/adminheader.jsp" />

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Link | Administration. </title>
</head>
     
<script type="text/javascript">



function showBusinessArea(cat){
		document.businessarea.cat.value=cat;
		document.businessarea.method="POST";
		document.businessarea.action="showbusiness_area_content";
	    document.businessarea.submit();
}


function updateBusinessArea(){
	
	   if(confirm('Are you sure about this changes?')){
			document.businessarea.method="POST";
			document.businessarea.action="updatebusiness_area_content";
		    document.businessarea.submit();
			return true;
	   }else{return false;}
}

function goto_admin_home(){
	     alert("Hi there ");	 
	    document.businessarea.action="adminhome"; 
	    document.businessarea.submit();
}


</script>



<body>
<br>
<br>

 <div  style="margin-top:60px;" >	
	
		<div class="col-md-5 col-sm-5 col-xs-12" style="color:#005da8;" align="center">
			<i class="fa fa-sitemap fa-2x "></i>&ensp;<span style="font-weight:600;font-size:13pt;color:#005da8;">Manage Stobart Air Business Area Content : >> </span></a>
	   </div>	
  
  </div>		
	

<br>
<br>
<br>
<div class="container" align="left">

			<div class="row" align="left" >
				<div class="col-sm-4">
					<aside>
						<ul class="aside_listing">						
				
								<li class="dropdown" >
								<a href="javascript:void();"> All Operations</a>
								
								<ul class="aside_listing_sub">							
									
									<li><a href="javascript:void();" onClick="showBusinessArea('1');">Cabin Operations</a></li>
							        <li><a href="javascript:void();" onClick="showBusinessArea('2');">Crew Planning</a></li>
                                    <li><a href="javascript:void();" onClick="showBusinessArea('3');">Ground Operations</a></li>
							        <li><a href="javascript:void();" onClick="showBusinessArea('4');">Flight Operations</a></li>
							        <li><a href="javascript:void();" onClick="showBusinessArea('5');">Operations Control Centre</a></li>
							        <li><a href="javascript:void();" onClick="showBusinessArea('6');">Safety and Compliance</a></li>
								</ul>
							
							</li>
							
						  <li>
								<a href="javascript:void();" onClick="showBusinessArea('7');">Commercial</a>
								
						 </li>
		
		             
						 <li>
								<a href="javascript:void();" onClick="showBusinessArea('8');">Human Resources</a>
								
						  </li>	
						
						<li><a href="javascript:void();" onClick="showBusinessArea('9');">Maintenance & Engineering</a></li> 
						<li><a href="javascript:void();" onClick="showBusinessArea('10');">Finance </a></li> 
						
						</ul>
					</aside>
					
					</div>
				
					  <div class="col-sm-8" align="center">
				  <form name="businessarea" id="businessarea"  method="POST" action="updatebusiness_area_content">
				  <input type="hidden" id="emailid" name="emailid" value="<%=request.getParameter("emailid")%>"> 
				   <input type="hidden" id="cat" name="cat" value="${cat}">
						<% if(request.getAttribute("cat").equals("img")){ %>
						
						    
							         <img src="<c:url value="images/orgchart.png"/>" width="80%">
							         
				
			            <% 
			            }
						else
						{
			            %>
											
							 	
                           
				          <textarea id="content" name="content"  rows="30" style="width: 110%;">
                                  ${content}
                          </textarea>
				      
				          <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					      	  <input type="submit"  class="btn btn-primary" value=" Update Content "  onclick="confirm('Are you sure about this Changes ?');" >
	               
	                    
					
				<%	
	            }
	            %>        
	                    
	                  </form>	       
				</div>
				 
		</div>
  </div>
	
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
<script>
 
document.addEventListener("touchstart", function() {},false);

var mobileHover = function () {
    $('*').on('touchstart', function () {
        $(this).trigger('hover');
    }).on('touchend', function () {
        $(this).trigger('hover');
    });
};

mobileHover();



</script>


<%@include file="../../include/adminfooter.jsp" %>

