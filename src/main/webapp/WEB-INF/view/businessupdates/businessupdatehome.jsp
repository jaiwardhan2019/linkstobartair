<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="../include/header.jsp" />

<head>
    <meta charset="utf-8">
    <title> Business Area  | Update </title>    
</head>

<link href="<c:url value="css/businessarea.css"/>" rel="stylesheet">


<script type="text/javascript">



function calBusinessCategory(category){

	document.stobart_businesupdates.cat.value=category;
	document.stobart_businesupdates.method="POST";
	document.stobart_businesupdates.action="businessupdates";
    document.stobart_businesupdates.submit();
	return true;
}


</script>




<body>

<form name="stobart_businesupdates" id="stobart_businesupdates">

<input type="hidden" id="cat" name="cat" value="">
<input type="hidden" id="emailid" name="emailid" value="<%=request.getAttribute("emailid")%>">
<input type="hidden" id="password" name="password" value="<%=request.getAttribute("password")%>">

<br>
   <div class="container-fluid" style="margin-top:60px;">	
	
		<div class="col-md-5 col-sm-5 col-xs-12" style="color:#005da8;">
			<i class="fa fa-sitemap fa-2x pull-left"></i>&ensp;<span style="font-weight:600;font-size:13pt;color:#005da8;">Stobart Air All Business Area : >> </span></a>
	   </div>	
  
  </div>		

   

<br><br>	

<div class="container" align="left">

			<div class="row" align="left" >
				<div class="col-sm-4">
					<aside>
						<ul class="aside_listing">						
				
								<li class="dropdown" >
								<a href="javascript:void();"> All Operations</a>
								
								<ul class="aside_listing_sub">							
									
									<li><a href="javascript:void();" onClick="calBusinessCategory('1');"> Cabin Operations</a></li>
							        <li><a href="javascript:void();" onClick="calBusinessCategory('2');">Crew Planning</a></li>
                                    <li><a href="javascript:void();" onClick="calBusinessCategory('3');">Ground Operations</a></li>
							        <li><a href="javascript:void();" onClick="calBusinessCategory('4');">Flight Operations</a></li>
							        <li><a href="javascript:void();" onClick="calBusinessCategory('5');">Operations Control Centre</a></li>
							        <li><a href="javascript:void();" onClick="calBusinessCategory('6');">Safety and Compliance</a></li>
								</ul>
							
							</li>
							
						  <li>
								<a href="javascript:void();" onClick="calBusinessCategory('7');">Commercial</a>
								
						 </li>
		
		             
						 <li>
								<a href="javascript:void();" onClick="calBusinessCategory('8');">Human Resources</a>
								
						  </li>	
						
						<li><a href="javascript:void();" onClick="calBusinessCategory('9');">Maintenance & Engineering</a></li> 
						<li><a href="javascript:void();" onClick="calBusinessCategory('10');">Finance </a></li> 
						
						</ul>
					</aside>
					
				</div>


</form>	

  <div class="col-sm-8" align="center">
<% 

/*   THIS PART OF CODE WILL DISPLAY THE RELEVENT CONTENT AS PER SELECTION ON THE LEFT HAND SIDE */
if(!request.getAttribute("cat").toString().equals("00")){
%>
     ${content}  	
	   
<%
}else
	{
	
	  %>
	
	         <img src="<c:url value="images/orgchart.png"/>" width="78%">
	
 <% 
 }//--------- End Of If 
 %>
 
	   </div>
  
 
 
					
				</div>
			</div>	
		</div>	
 <br>
 <br>
 
 </body>
 
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


<%@include file="../include/footer.jsp" %>

