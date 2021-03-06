<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
 
<script>


    /*--- THIS PIECE OF CODE WILL DISABLE THE MOUSE RIGHT CLICK ------------ 	
    var isNS = (navigator.appName == "Netscape") ? 1 : 0;
	if(navigator.appName == "Netscape") document.captureEvents(Event.MOUSEDOWN||Event.MOUSEUP);

	function mischandler(){
	    return false;
	}

	function mousehandler(e){
	var myevent = (isNS) ? e : event;
	var eventbutton = (isNS) ? myevent.which : myevent.button;
	if((eventbutton==2)||(eventbutton==3)) return false;
	}

	document.oncontextmenu = mischandler;
	document.onmousedown = mousehandler;
	document.onmouseup = mousehandler;
*/
</script>


    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
 
  
    <!-- Bootstrap Core CSS --> 
    <link href="<c:url value="css/bootstrap.min.css"/>" rel="stylesheet">	
    
    
    
	<link rel="stylesheet" href="<c:url value="css/freelancer.css"/>">
    <link rel="stylesheet" href="<c:url value="css/superfish.css"/>">
    
    
    
	
	<!-- FontAwesome FA FA ICONS -->
	<link rel="stylesheet" href="css/font-awesome.min.css">
	
	<link rel="stylesheet" href="css/custom-style.css">
	
		
	
		
	<!-- Favicon -->
<link rel="icon"   href="<c:url value="images/favicon.png"/>">



</head>


<% 
String fullemail            = request.getAttribute("emailid").toString();
String password             = request.getAttribute("password").toString();
if(fullemail.trim().length() < 2){response.sendRedirect("index");}
String[] FirstName_LastName = fullemail.split("@");
String user_login_id        = FirstName_LastName[0];
//https://stackoverflow.com/questions/5053975/how-to-encode-a-string-representing-url-path-with-jstl

%>



<script type="text/javascript">

function calHomePage(){

	document.refisheader.method="POST";
	document.refisheader.action="HomePage";
    document.refisheader.submit();
	return true;
}



function calRefisReport(reportname,category){
	document.refisheader.method="POST";
	document.refisheader.action=reportname+"?cat="+category;
    document.refisheader.submit();
	return true;
}


function cal_groundops_home(usertype){	
	document.refisheader.method="POST";
	document.refisheader.action="groundopsHomePage?cat=home&usertype="+usertype;	
    document.refisheader.submit();
	return true;
}

  
  
  

function calFlightReport(reportname){
	   
		 document.refisheader.method="POST";
		 document.refisheader.action=reportname;
	     document.refisheader.submit();
		 return true;
}



function calDocumentReport(reportname){
		 document.refisheader.method="POST";
		 document.refisheader.action=reportname;
	     document.refisheader.submit();
		 return true;
}



function Calqpulse(){		
	
	document.refisheader.action="loginqpulse"
	document.refisheader.method="POST";
	document.refisheader.target="_blank"
	document.refisheader.submit();
	return true;
	
}// End of function





function CalKeyContact(){		
	
	document.refisheader.action="groundopskeycontact"
	document.refisheader.method="POST";
	document.refisheader.submit();
	return true;
	
}// End of function





function CalGopsSmsUserManager(){		
	
	document.refisheader.action=urlname;
	document.refisheader.method="smsusermanager";
	document.refisheader.submit();
	return true;
	
}// End of function




function CalAlfresco(){
	
	document.alfresco.action="logonalfresco";
	document.alfresco.method="POST"
	document.alfresco.target="_blank"
    document.alfresco.submit();
	return true;
}

</script>







<% 
String userName = request.getParameter("emailid");
String[] user  = userName.split("@");
%>

		
<form name="alfresco" id="alfresco" method="POST">	 
	 <input  type="hidden" name="loginid_a" value="<%=user[0]%>">
     <input  type="hidden"  name="pass_a" value="<%=request.getParameter("password")%>">
</form>	



<form name="refisheader" id="refisheader">
    <input type="hidden" name="emailid" value="<%=request.getParameter("emailid")%>">
    <input type="hidden" id="password" name="password" value="<%=request.getParameter("password")%>">
    <input type="hidden" name="usertype" value="${usertype}">
    <!-- Will be user for the Qpulse -->
    <input id="username" type="hidden" name="username" value="<%=FirstName_LastName[0]%>">




<!-- Menu --->	 
<nav class="navbar navbar-default navbar-fixed-top panel-shadow">

<div class="container-fluid" style="background:#0071ba;" >
   
	
    <div class="navbar-header">
    
       <c:if test="${usertype == 'I'}">   
	        
			<a href="javascript:void();" onClick="calHomePage();"  class="navbar-brand" data-toggle="tooltip" data-placement="right" title="Link Home Page" style="margin-left:3px;margin-top:04px;padding:0px;" >
				<img src="images/logo-menu-new.png" alt="Link Home Page" class="img-responsive" style="margin-top:-px;" />
		    </a>
       
       </c:if>
 	 	
 	   <c:if test="${usertype == 'E'}">
			<span class="navbar-brand" data-toggle="tooltip" data-placement="right" title="Link Home Page" style="margin-left:3px;margin-top:04px;padding:0px;" >
				<img src="images/logo-menu-new.png" alt="Link Home Page" class="img-responsive" style="margin-top:-px;" />
		    </span>
       </c:if>
 	
 	
 	
    </div>


 <!-- Collect the nav links, forms, and other content for toggling -->
  <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1" >
    
<ul class="nav navbar-nav navbar-right">
		
      <c:if test="${usertype == 'I'}">
             <li class="dropdown">
                <a href="javascript:void();" onClick="calHomePage();" style="font-size:9pt;font-weight:600;color:#FDFEFE;" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"><i class="fa fa-home fa-lg" aria-hidden="true"></i>&nbsp;&nbsp;Link Home</a>
            </li>
      </c:if>
 
    
    
    <c:if test="${profilelist.Flight_Report  == 'Y'}">        </c:if>	 
    
         <!-- FIRST MENU -->		
	     <li class="dropdown">
		 
			  <a href="adminhome" onmouseover="this.click()" style="font-size:09pt;font-weight:600;color:#FDFEFE;" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"> <i class="fa fa-plane" aria-hidden="true"></i> &nbsp;Reports <span class="caret"></span></a>
	
			  
				  <ul class="dropdown-menu" style="left:0;width:200px;">
				        
				        <!-- 
				        <c:if test="${profilelist.Flight_Report  == 'Y'}">   
				            <li style="margin-top:3px;margin-bottom:3px;"><a href="javascript:void();" onClick="calFlightReport('flightreport?airlinecode=ALL&airportcode=ALL&flightno=');"  style="font-size:09pt;"><img src="images/database.png">&nbsp;&nbsp;Flight Report (MayFly)</a></li>
					    </c:if>
					     -->

   		               <li style="margin-top:3px;margin-bottom:3px;"><a href="javascript:void();" onClick="calFlightReport('flightreport?airlinecode=ALL&airportcode=ALL&flightno=');"  style="font-size:09pt;"><img src="images/database.png">&nbsp;&nbsp;Flight Report (MayFly)</a></li>
					     
					    <c:if test="${profilelist.Reliablity  == 'Y'}"> 
					         <li style="margin-top:3px;margin-bottom:3px;"><a href="javascript:void();" onClick="calFlightReport('reliablityflightreport?airlinecode=ALL&airportcode=ALL&delayCodeGroupCode=ALL&tolerance=0&flightno=');"  style="font-size:09pt;"><img src="images/database.png">&nbsp;&nbsp;Reliability Report</a></li>
					    </c:if> 
					    
					    <c:if test="${profilelist.DelayReport  == 'Y'}"> 
					         <li style="margin-top:3px;margin-bottom:3px;"><a href="javascript:void();" onClick="calFlightReport('delayflightreport?airlinecode=ALL&airportcode=ALL&tolerance=0&delayCodeGroupCode=ALL&flightno=');"  style="font-size:09pt;"><img src="images/database.png">&nbsp;&nbsp;Delay Report</a></li>
					    </c:if> 
					    
					     <c:if test="${profilelist.OtpReport  == 'Y'}"> 					     
					        <li style="margin-top:3px;margin-bottom:3px;"><a href="javascript:void();" onClick="calFlightReport('otpflightreport?airlinecode=ALL&airportcode=ALL&tolerance=0&delayCodeGroupCode=ALL');"   style="font-size:09pt;"><img src="images/database.png">&nbsp;&nbsp;OTP Report</a></li>
					     </c:if> 
					     
					    
				    <!-- 	    
					     <c:if test="${profilelist.Daily_Summary  == 'Y'}"> 					     
					        <li style="margin-top:3px;margin-bottom:3px;"><a href="javascript:void();" onClick="alert('Under Construction');"   style="font-size:09pt;"><img src="images/database.png">&nbsp;&nbsp;Daily Summary Report</a></li>
					     </c:if> 
					     
					 
					 
					     <c:if test="${profilelist.Voyager  == 'Y'}">  
					        <li style="margin-top:3px;margin-bottom:3px;"><a href="javascript:void();" onClick="calFlightReport('voyagerReport?airlineCode=ALL');" style="font-size:09pt;"><i class="fa fa-database" aria-hidden="true"></i>&nbsp;&nbsp;Voyager Report</a></li>
				         </c:if> 
					      -->
			     </ul>	 
			      
		</li>
		

		
		
	  
	   <c:if test="${profilelist.GCIGCMGCR  == 'Y'}">       </c:if> 
		<li class="dropdown">		 
			   <a onmouseover="this.click()" style="font-size:9pt;font-weight:600;color:#FDFEFE;" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"><i class="fa fa-file-text-o" aria-hidden="true"></i>&nbsp;GCI /GCM /GCR&nbsp;<span class="caret"></span></a>
		   	   <ul class="dropdown-menu" style="left:0;width:200px;">
 		    	        
	              	   <li class="dropdown-submenu" style="margin-top:3px;margin-bottom:3px;">
			 		        <a class="test" tabindex="-1"  style="font-size:09pt;"><img src="images/folder.png"> &nbsp;&nbsp;Ground Crew Instructions.&nbsp;<i class="fa fa-caret-right" style="font-size:14px"></i>&nbsp;</a>
							<ul class="dropdown-menu">
							        <li><a class="navclass" href="javascript:void();" onClick="calDocumentReport('listdocuments?cat=UKGCI&operation=view');" style="font-size:09pt;"><img src="images/folder.png"> &nbsp; G-Reg Documents  </a></li>
                                    <li><a class="navclass" href="javascript:void();" onClick="calDocumentReport('listdocuments?cat=IEGCI&operation=view');" style="font-size:09pt;"><img src="images/folder.png"> &nbsp; EI-Reg Documents</a></li>
    
							</ul>
			 		  
			 		    </li>
				   
 		    	        
	              	   <li class="dropdown-submenu" style="margin-top:3px;margin-bottom:3px;">
			 		        <a  class="test" tabindex="-1"  style="font-size:09pt;"><img src="images/folder.png"> &nbsp;&nbsp;Ground Crew Memo.&nbsp;<i class="fa fa-caret-right" style="font-size:14px"></i>&nbsp;</a>
							<ul class="dropdown-menu">
							        <li><a class="navclass" href="javascript:void();" onClick="calDocumentReport('listdocuments?cat=UKGCM&operation=view');" style="font-size:09pt;"><img src="images/folder.png"> &nbsp; G-Reg Documents  </a></li>
                                    <li><a class="navclass" href="javascript:void();" onClick="calDocumentReport('listdocuments?cat=IEGCM&operation=view');" style="font-size:09pt;"><img src="images/folder.png"> &nbsp; EI-Reg Documents</a></li>
    
							</ul>
			 		  
			 		    </li>
				   
 		    	        
	              	   <li class="dropdown-submenu" style="margin-top:3px;margin-bottom:3px;">
			 		        <a class="test" tabindex="-1"  style="font-size:09pt;"><img src="images/folder.png"> &nbsp;&nbsp;Ground Crew Reminders.&nbsp;<i class="fa fa-caret-right" style="font-size:14px"></i>&nbsp;</a>
							<ul class="dropdown-menu">
							        <li><a class="navclass"  href="javascript:void();" onClick="calDocumentReport('listdocuments?cat=UKGCR&operation=view');" style="font-size:09pt;"><img src="images/folder.png"> &nbsp; G-Reg Documents  </a></li>
                                    <li><a class="navclass"  href="javascript:void();" onClick="calDocumentReport('listdocuments?cat=IEGCR&operation=view');" style="font-size:09pt;"><img src="images/folder.png"> &nbsp; EI-Reg Documents</a></li>
    
							</ul>
			 		  
			 		    </li>
	         
	            </ul>		  	   
		  	    						  
		</li>
	
	    
	    
	    
	   
	  <c:if test="${profilelist.Manuals  == 'Y'}">  	 	</c:if>	
	    <li class="dropdown">	 
	  	    <a onmouseover="this.click()" style="font-size:9pt;font-weight:600;color:#FDFEFE;" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"><i class="fa fa-file-text-o" aria-hidden="true"></i>&nbsp;Manuals&nbsp;<span class="caret"></span></a>
	  	   	   <ul class="dropdown-menu" style="left:0;width:200px;">
	  	   	          
	  	   	          	        
	              	   <li class="dropdown-submenu" style="margin-top:3px;margin-bottom:3px;">
			 		        <a class="test" tabindex="-1"  style="font-size:09pt;"><img src="images/folder.png"> &nbsp;&nbsp;De-Icing Manuals.&nbsp;<i class="fa fa-caret-right" style="font-size:14px"></i>&nbsp;</a>
							<ul class="dropdown-menu">
							        <li><a class="navclass"  href="javascript:void();" onClick="calDocumentReport('listdocuments?cat=UKMAND&operation=view');" style="font-size:09pt;"><img src="images/folder.png"> &nbsp; G-Reg Documents  </a></li>
                                    <li><a class="navclass"  href="javascript:void();" onClick="calDocumentReport('listdocuments?cat=IEMAND&operation=view');" style="font-size:09pt;"><img src="images/folder.png"> &nbsp; EI-Reg Documents</a></li>
    
							</ul>
			 		  
			 		    </li>
	        
	  	   	          	        
	              	   <li class="dropdown-submenu" style="margin-top:3px;margin-bottom:3px;">
			 		        <a class="test" tabindex="-1"  style="font-size:09pt;"><img src="images/folder.png"> &nbsp;&nbsp;Ground Ops Manual.&nbsp;<i class="fa fa-caret-right" style="font-size:14px"></i>&nbsp;</a>
							<ul class="dropdown-menu">
							        <li><a class="navclass"  href="javascript:void();" onClick="calDocumentReport('listdocuments?cat=UKMANG&operation=view');" style="font-size:09pt;"><img src="images/folder.png"> &nbsp; G-Reg Documents  </a></li>
                                    <li><a class="navclass"  href="javascript:void();" onClick="calDocumentReport('listdocuments?cat=IEMANG&operation=view');" style="font-size:09pt;"><img src="images/folder.png"> &nbsp; EI-Reg Documents</a></li>
    
							</ul>
			 		  
			 		    </li>
	            </ul>		  	   
		</li>

       
         

	
	
	  <c:if test="${profilelist.safetycompliance  == 'Y'}"> 	
	    <li class="dropdown">	 
	  	    <a onmouseover="this.click()" style="font-size:9pt;font-weight:600;color:#FDFEFE;" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"><i class="fa fa-file-text-o" aria-hidden="true"></i>&nbsp;Safety Compliance &nbsp;<span class="caret"></span></a>
	  	   	   <ul class="dropdown-menu" style="left:0;width:200px;">
	              	   <li class="dropdown-submenu" style="margin-top:3px;margin-bottom:3px;">
			 		        <a class="test" tabindex="-1"  style="font-size:09pt;"><img src="images/folder.png"> &nbsp;&nbsp;Compliance Monitoring.&nbsp;<i class="fa fa-caret-right" style="font-size:14px"></i>&nbsp;</a>
							<ul class="dropdown-menu">
							        <li><a class="navclass"  href="javascript:void();" onClick="calDocumentReport('listdocuments?cat=UKSCM&operation=view');" style="font-size:09pt;"><img src="images/folder.png"> &nbsp; G-Reg Documents  </a></li>
                                    <li><a class="navclass"  href="javascript:void();" onClick="calDocumentReport('listdocuments?cat=IESCM&operation=view');" style="font-size:09pt;"><img src="images/folder.png"> &nbsp; EI-Reg Documents</a></li>
							</ul>
			 		  
			 		    </li>
 		    	       
	              	   <li class="dropdown-submenu" style="margin-top:3px;margin-bottom:3px;">
			 		        <a class="test" tabindex="-1"  style="font-size:09pt;"><img src="images/folder.png"> &nbsp;&nbsp;Ground Ops Statistics.&nbsp;<i class="fa fa-caret-right" style="font-size:14px"></i>&nbsp;</a>
							<ul class="dropdown-menu">
							        <li><a class="navclass"  href="javascript:void();" onClick="calDocumentReport('listdocuments?cat=UKSGO&operation=view');" style="font-size:09pt;"><img src="images/folder.png"> &nbsp; G-Reg Documents  </a></li>
                                    <li><a class="navclass"  href="javascript:void();" onClick="calDocumentReport('listdocuments?cat=IESGO&operation=view');" style="font-size:09pt;"><img src="images/folder.png"> &nbsp; EI-Reg Documents</a></li>
							</ul>
			 		  
			 		    </li>
 		    	    
 		    	       <li class="dropdown-submenu" style="margin-top:3px;margin-bottom:3px;">
			 		        <a class="test" tabindex="-1"  style="font-size:09pt;"><img src="images/folder.png"> &nbsp;&nbsp;Safety Bulletins.&nbsp;<i class="fa fa-caret-right" style="font-size:14px"></i>&nbsp;</a>
							<ul class="dropdown-menu">
							        <li><a class="navclass"  href="javascript:void();" onClick="calDocumentReport('listdocuments?cat=UKSSB&operation=view');" style="font-size:09pt;"><img src="images/folder.png"> &nbsp; G-Reg Documents  </a></li>
                                    <li><a class="navclass"  href="javascript:void();" onClick="calDocumentReport('listdocuments?cat=IESSB&operation=view');" style="font-size:09pt;"><img src="images/folder.png"> &nbsp; EI-Reg Documents</a></li>
							</ul>
			 		  
			 		    </li>
 
 		    	       <li class="dropdown-submenu" style="margin-top:3px;margin-bottom:3px;">
			 		        <a class="test" tabindex="-1"  style="font-size:09pt;"><img src="images/folder.png"> &nbsp;&nbsp;Safety Manual.&nbsp;<i class="fa fa-caret-right" style="font-size:14px"></i>&nbsp;</a>
							<ul class="dropdown-menu">
							        <li><a class="navclass"  href="javascript:void();" onClick="calDocumentReport('listdocuments?cat=UKSSM&operation=view');" style="font-size:09pt;"><img src="images/folder.png"> &nbsp; G-Reg Documents  </a></li>
                                    <li><a class="navclass"  href="javascript:void();" onClick="calDocumentReport('listdocuments?cat=IESSM&operation=view');" style="font-size:09pt;"><img src="images/folder.png"> &nbsp; EI-Reg Documents</a></li>
							</ul>
			 		  
			 		    </li>
		    	        
		    	        <li style="margin-top:3px;margin-bottom:3px;"><a href="javascript:void();" onClick="calDocumentReport('listdocuments?cat=SSEP&operation=view&alfresco=YES');"  style="font-size:09pt;color:black;"><img src="images/folder.png"> &nbsp;Security Programme</a></li>
		
		
	
		             </ul>		  	   
		</li>
      </c:if>
      
      
     <c:if test="${profilelist.traning  == 'Y'}"> 	
	    <li class="dropdown">	 
	  	    <a onmouseover="this.click()" style="font-size:9pt;font-weight:600;color:#FDFEFE;" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"><i class="fa fa-file-text-o" aria-hidden="true"></i>&nbsp;Training  &nbsp;<span class="caret"></span></a>
	  	   	   <ul class="dropdown-menu" style="left:0;width:250px;">
 		    	       <li style="margin-top:3px;margin-bottom:3px;"><a href="javascript:void();" onClick="calDocumentReport('listdocuments?cat=trd&operation=view');"  style="font-size:9pt;"><img src="images/folder.png"> &nbsp;Dispatch and Load Control.</a></li>
		    	       <li style="margin-top:3px;margin-bottom:3px;"><a href="javascript:void();" onClick="calDocumentReport('listdocuments?cat=trbg&operation=view');"  style="font-size:9pt;"><img src="images/folder.png"> &nbsp;Baggage Tracing General.</a></li>
		    	       <li style="margin-top:3px;margin-bottom:3px;"><a href="javascript:void();" onClick="calDocumentReport('listdocuments?cat=tras&operation=view');"  style="font-size:9pt;"><img src="images/folder.png"> &nbsp;Aer Lingus Airport Service Guide.</a></li>
		    	       <li style="margin-top:3px;margin-bottom:3px;"><a href="javascript:void();" onClick="calDocumentReport('listdocuments?cat=trac&operation=view');"  style="font-size:9pt;"><img src="images/folder.png"> &nbsp;Aer Lingus Checking and Boarding.</a></li>
		    	       <li style="margin-top:3px;margin-bottom:3px;"><a href="javascript:void();" onClick="calDocumentReport('listdocuments?cat=trar&operation=view');"  style="font-size:9pt;"><img src="images/folder.png"> &nbsp;Aer Lingus Reservations.</a></li>
		    	       <li style="margin-top:3px;margin-bottom:3px;"><a href="javascript:void();" onClick="calDocumentReport('listdocuments?cat=trs&operation=view');"  style="font-size:9pt;"><img src="images/folder.png"> &nbsp;Stobart Air Traning Modules.</a></li>

	             </ul>		  	   
		</li>
    	</c:if>	
			
     <c:if test="${profilelist.weightstatement  == 'Y'}"> 	 	</c:if>		  
	    <li class="dropdown">
	 
		  <a href="javascript:void();" onClick="calDocumentReport('wtstatement?airlinecode=ALL&airlinereg=ALL');" style="font-size:9pt;font-weight:600;color:#FDFEFE;" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"><i class="fa fa-file-text-o" aria-hidden="true"></i>&nbsp;Weight Statements</a>
		  
					  
		</li>

	
	  <c:if test="${profilelist.documentation  == 'Y'}">
    		
	    <li class="dropdown">	 
		  <a href="adminhome"  onmouseover="this.click()" style="font-size:9pt;font-weight:600;color:#FDFEFE;" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"><i class="fa fa-file-text-o" aria-hidden="true"></i>&nbsp;Documentation&nbsp;<span class="caret"></span></a>
		  
			   <ul class="dropdown-menu" style="left:0;width:200px;">
 		    	<li style="margin-top:3px;margin-bottom:3px;"><a href="javascript:void();" onClick="calDocumentReport('listdocuments?cat=dchm&operation=view&alfresco=YES');"  style="font-size:9pt;"><img src="images/folder.png"> &nbsp;Catering - HAACP Manual</a></li>
		    	<li style="margin-top:3px;margin-bottom:3px;"><a href="javascript:void();" onClick="calDocumentReport('listdocuments?cat=diam&operation=view&alfresco=YES');"  style="font-size:9pt;"><img src="images/folder.png"> &nbsp;De-icing & Anti-Icing Manual</a></li>	    	
		    	<li style="margin-top:3px;margin-bottom:3px;"><a href="javascript:void();" onClick="calDocumentReport('listdocuments?cat=dgopm&operation=view&alfresco=YES');"  style="font-size:9pt;"><img src="images/folder.png"> &nbsp;Ground Ops Manual </a></li>	 
		    	<li style="margin-top:3px;margin-bottom:3px;"><a href="javascript:void();" onClick="calDocumentReport('listdocuments?cat=dcle&operation=view');"  style="font-size:9pt;"><img src="images/folder.png"> &nbsp;Cleaning </a></li>		    	
		    	<li style="margin-top:3px;margin-bottom:3px;"><a href="javascript:void();" onClick="calDocumentReport('listdocuments?cat=dqrd&operation=view');"  style="font-size:9pt;"><img src="images/folder.png"> &nbsp;Quick Reference Documents </a></li>		    	
		    	<li style="margin-top:3px;margin-bottom:3px;"><a href="javascript:void();" onClick="calDocumentReport('listdocuments?cat=derp&operation=view');"  style="font-size:9pt;"><img src="images/folder.png"> &nbsp;Emergency Response Plan </a></li>	
		    	   	
		       </ul>
					  
		</li>
	</c:if>

		
	  		
 <c:if test="${profilelist.forms  == 'Y'}"> 	 </c:if>	
	<li class="dropdown">
	 
		  <a href="forms" onmouseover="this.click()" style="font-size:9pt;font-weight:600;color:#FDFEFE;" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"><i class="fa fa-file-text-o" aria-hidden="true"></i>&nbsp;&nbsp;Forms&nbsp;<span class="caret"></span></a>
		  
			   <ul class="dropdown-menu" style="left:0;width:160px;">
			    
			    	<li style="margin-top:3px;margin-bottom:3px;"><a href="javascript:void();" onClick="calDocumentReport('listdocuments?cat=formsei&operation=view');"  style="font-size:9pt;"><img src="images/folder.png"> &nbsp;Aer Lingus</a></li>
			     	<!--  <li style="margin-top:3px;margin-bottom:3px;"><a href="javascript:void();" onClick="calDocumentReport('listdocuments?cat=formsbe&operation=view');"  style="font-size:9pt;"><img src="images/folder.png"> &nbsp;FlyBe</a></li> -->
			    	<li style="margin-top:3px;margin-bottom:3px;"><a href="javascript:void();" onClick="calDocumentReport('listdocuments?cat=formsre&operation=view');"  style="font-size:9pt;"><img src="images/folder.png"> &nbsp;Stobart Air</a></li>
			    	<li style="margin-top:3px;margin-bottom:3px;"><a href="javascript:void();" onClick="calDocumentReport('listdocuments?cat=formdnotices&operation=view');"  style="font-size:9pt;"><img src="images/folder.png"> &nbsp;Disruption Notices</a></li>
			    	<!-- <li style="margin-top:3px;margin-bottom:3px;"><a href="javascript:void();" onClick="calDocumentReport('listdocuments?cat=formsei&operation=view');"  style="font-size:9pt;"><img src="images/folder.png"> &nbsp;Disruption Notices</a></li>  -->
			    
			    </ul>
					  
		</li>



	
		
		
	  <c:set var="userid" value="<%=user_login_id %>"/>
			

		 <c:if test="${profilelist.gopsadmin  == 'Y'}"> 	
				 <li class="dropdown">
				 
					  <a href="refisadmin" onmouseover="this.click()" style="font-size:9pt;font-weight:600;color:#FDFEFE;" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"><i class="fa fa-user-md" aria-hidden="true"></i>&nbsp;&nbsp;Admin <span class="caret"></span></a>
					  
						  <ul class="dropdown-menu" style="left:0;width:200px;">
					       		<li style="margin-top:3px;margin-bottom:3px;"><a href="javascript:void();" onClick="calRefisReport('managegopssuser','Manage Refis Users');" style="font-size:9pt;"><img src="images/folder.png"> &nbsp;REFIS User Manager</a></li>
					       		<li style="margin-top:3px;margin-bottom:3px;"><a href="javascript:void();" onClick="calRefisReport('managesmscontacts','SMS Report Users');" style="font-size:9pt;"><img src="images/folder.png"> &nbsp;SMS Contacts Manager</a></li>
                                <li style="margin-top:3px;margin-bottom:3px;"><a href="javascript:void();" onClick="calRefisReport('manageairlinedata');"  style="font-size:9pt;"><img src="images/folder.png"> &nbsp;Airline Data Manager</a></li>
					       		<li style="margin-top:3px;margin-bottom:3px;"><a href="javascript:void();" onClick="calRefisReport('managecrewbriefing','PPS Crew Briefing Integration');" style="font-size:9pt;"><img src="images/folder.png"> &nbsp;Crew Briefing Manager </a></li>
					       		<li style="margin-top:3px;margin-bottom:3px;"><a href="javascript:void();" onClick="calDocumentReport('listdocuments?cat=logo&operation=view');"  style="font-size:9pt;"><img src="images/folder.png"> &nbsp;Company Logo </a></li>
					       		
					       		<!-- 
					       		<li style="margin-top:3px;margin-bottom:3px;"><a href="javascript:void();" onClick="alert('Under Construction');"  style="font-size:9pt;"><img src="images/folder.png"> &nbsp;Crew Flight Reports</a></li>
					       		 -->
					      </ul>
								  
					</li>
         </c:if>
         
         
         
         
			<li class="dropdown">
					  <a href="#" onmouseover="this.click()" style="font-size:09pt;font-weight:600;color:#FDFEFE;" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"> <i class="fa fa-user-circle"></i>&nbsp;&nbsp;${userid}&nbsp;<span class="caret"></span></a>
					  <ul class="dropdown-menu" style="left:0;width:200px;">
					      <li style="margin-top:0px;margin-bottom:0px;"><a href="logout" style="font-size:09pt;"><i class="fa fa-sign-out" aria-hidden="true"></i>&nbsp;&nbsp;Logout</a></li>
					  
					  </ul>
			 </li>	
			
		</ul>
    </div>


</div>	<!-- /.container-fluid -->


</nav>




<!-- End of  Menu  --->	 
<br>
<br>
<br>



<div class="col-md-5 col-sm-5 col-xs-12" >
  
  <c:if test="${usertype == 'I'}">
     <a onclick="cal_groundops_home('I');" href="javascript:void();"> <h5 style="font-weight:600;color:#0071ba;"><i class="fa fa-home"></i> Ground Ops</h5></a>
  </c:if>
  
  <c:if test="${usertype == 'E'}">
    <a onclick="cal_groundops_home('E');" href="javascript:void();"><h5 style="font-weight:600;color:#0071ba;"><i class="fa fa-home"></i> Ground Ops</h5></a> 
  </c:if>
  

 </div>
 
<div  class="col-md-7 col-sm-7 col-xs-12" align="right">
  <!-- 
	<span style="font-weight:300;font-size:12pt;color:black;align:right">	  
	  <span class="label label-default">Menu 1</span>
      <span class="label label-primary">Menu 2</span>
      <span class="label label-success">Menu 3</span>
      <a href="javascript:void();" onClick="Calqpulse();"><span class="label label-success"><i class="fa fa-commenting-o" aria-hidden="true"></i>&nbsp;File A Report</span></a>&nbsp;&nbsp;
      <a href="emergencyresponseplan.pdf"  target="_blank"><span class="label label-danger"><i class="fa fa-volume-control-phone" aria-hidden="true"></i>&nbsp;Emergency Response</span></a>&nbsp;&nbsp;
      <a href="javascript:void();" onClick="CalKeyContact();" ><span class="label label-info"><i class="fa fa-envelope-o" aria-hidden="true"></i>&nbsp;Key Contacts</span></a> &nbsp;&nbsp;
   </span>
   
   <input type="text"  id="myInput" name="myInput" placeholder="Search Document.." >
	-->
 
      
      
      <table width="30%"> 
        <tr>
          <td>
              <input autofocus="" type="text" name="myInput" id="myInput" class="form-control" placeholder="Search Documents..">
               <button type="submit"  hidden="hidden" id="myBtn" onclick="calDocumentReport('searchdocuments')"><i class="fa fa-search"></i></button>
         </td>
        </tr>
      </table>
       <!--
      	<input autofocus  type="text" name="myInput"  id="myInput"  class="form-control"    placeholder="Search Document"/>
      <span id="searchbutton" onclick="manage_contract('search');" class="btn btn-primary btn-sm">&nbsp;&nbsp;<i class="fa fa-search  fa-lg" aria-hidden="true"></i>&nbsp;&nbsp;</span> 
      <button type="submit"  id="myBtn" onclick="calDocumentReport('searchdocuments')"><i class="fa fa-search"></i></button>
	-->
 </div>
 
 </form>
<br>
<br>
<br>
<br>

 
<script>
	var input = document.getElementById("myInput");
	input.addEventListener("keyup", function(event) {
	  if (event.keyCode == 13) {
	   event.preventDefault();
	   document.getElementById("myBtn").click();
	  }
	});
</script>

 
<!-- jQuery -->
   <script src="js/jquery.min.js"></script>  
   <script src="js/bootstrap.min.js"></script>


<style>
body {
  background-image: url('background1.jpg');
  background-repeat: no-repeat;
  background-attachment: fixed;  
  background-size: cover;
}

body1 {
  background-image: url('groundopsbackgroudwithsun.jpg');
  background-repeat: no-repeat;
  background-attachment: fixed;  
  background-size: cover;
}

body1 {
  background-image: url('groundopsbackgroud.jpg');
  background-repeat: no-repeat;
  background-attachment: fixed;  
  background-size: cover;
}

body1 {
  background-image: url('bodyback2.jpg');
  background-repeat: no-repeat;
  background-attachment: fixed;  
  background-size: cover;
}

body1 {
  background-image: url('images/groundopsbackground.jpg');
  background-repeat: no-repeat;
  background-attachment: fixed;  
  background-size: cover;
}

body1 {
  background-image: url('images/refisback.jpg');
  background-repeat: no-repeat;
  background-attachment: fixed;  
  background-size: cover;
}

body1 {
  background-image: url('images/background.jpg');
  background-repeat: no-repeat;
  background-attachment: fixed;  
  background-size: cover;
}



body1 {
  background-image: url('images/groundopsbackground.png');
  background-repeat: no-repeat;
  background-attachment: fixed;  
  background-size: cover;
}


</style>

   