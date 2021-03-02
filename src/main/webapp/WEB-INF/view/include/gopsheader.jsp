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

String[] userProfileList   =  request.getAttribute("profilelist").toString().split("#");
String userFullEmailid     =  userProfileList[0];
String userPassword        =  userProfileList[1];
if(userFullEmailid.length() < 2){response.sendRedirect("index");}
String[] userFirstLastName  = userFullEmailid.split("@");
String userLoginId          = userFirstLastName[0];
// Url Encoding 
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


		
<form name="alfresco" id="alfresco" method="POST">	 
	 <input  type="hidden" name="loginid_a" value="<%=userFirstLastName[0]%>">
     <input  type="hidden"  name="pass_a" value="<%=userPassword%>">
</form>	



<form name="refisheader" id="refisheader">

    <input type="hidden" name="usertype" value="${usertype}">

    <input id="username" type="hidden" name="username" value="<%=userLoginId%>">
    <input type="hidden" id="password" name="password" value="<%=userPassword%>">
    <input type="hidden" id="profilelist" name="profilelist" value="${profilelist}">




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
 		  
    <div class="navbar-header navbar-right">
        <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
        </button>
        <a class="navbar-brand" href=""></a>
    </div>

 
    <!-- Collect the nav links, forms, and other content for toggling -->
    <div class="collapse navbar-collapse" id="myNavbar">
        <ul class="nav navbar-nav navbar-right">
	
	
      <c:if test="${usertype == 'I'}">
             <li class="dropdown">
                <a href="javascript:void();" onClick="calHomePage();" style="font-size:9pt;font-weight:600;color:#FDFEFE;" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"><i class="fa fa-home fa-lg" aria-hidden="true"></i></a>
            </li>
      </c:if>
 
     
    
			  
			   <!-- FIRST MENU -->		
					
				   <c:if test = "${fn:contains(profilelist, 'Reports')}"> 
				         <li class="dropdown">
						 
							  <a href="adminhome" onmouseover="this.click()" style="font-size:09pt;font-weight:600;color:#FDFEFE;" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"> <i class="fa fa-plane" aria-hidden="true"></i> &nbsp;Reports <span class="caret"></span></a>
					
							  
								  <ul class="dropdown-menu" style="left:0;width:200px;">
					                 <c:if test = "${fn:contains(profilelist, 'Flight_Report')}">     
					   		               <li style="margin-top:3px;margin-bottom:3px;"><a href="javascript:void();" onClick="calFlightReport('flightreport?airlinecode=ALL&airportcode=ALL&flightno=');"  style="font-size:09pt;color:black;"><img src="images/database.png">&nbsp;&nbsp;Flight Report (MayFly)</a></li>
									 </c:if>		     
									 
									 <c:if test = "${fn:contains(profilelist, 'Reliablity')}"> 
									         <li style="margin-top:3px;margin-bottom:3px;"><a href="javascript:void();" onClick="calFlightReport('reliablityflightreport?airlinecode=ALL&airportcode=ALL&delayCodeGroupCode=ALL&tolerance=0&flightno=');"  style="font-size:09pt;color:black;"><img src="images/database.png">&nbsp;&nbsp;Reliability Report</a></li>
									    </c:if> 
									    
									  <c:if test = "${fn:contains(profilelist, 'DelayReport')}">  
									         <li style="margin-top:3px;margin-bottom:3px;"><a href="javascript:void();" onClick="calFlightReport('delayflightreport?airlinecode=ALL&airportcode=ALL&tolerance=0&delayCodeGroupCode=ALL&flightno=');"  style="font-size:09pt;color:black;"><img src="images/database.png">&nbsp;&nbsp;Delay Reports</a></li>
									    </c:if> 
									    
									     <c:if test = "${fn:contains(profilelist, 'OtpReport')}"> 					     
									        <li style="margin-top:3px;margin-bottom:3px;"><a href="javascript:void();" onClick="calFlightReport('otpflightreport?airlinecode=ALL&airportcode=ALL&tolerance=0&delayCodeGroupCode=ALL');"   style="font-size:09pt;color:black;"><img src="images/database.png">&nbsp;&nbsp;OTP Report</a></li>
									     </c:if> 
									     
							    </ul>	 
							      
						</li>
						
				</c:if>
						
			 <!--END OF FIRST MENU -->
			 				
				  
					
		    
		   <c:if test = "${fn:contains(profilelist, 'GCIGCMGCR')}">  
				<li class="dropdown">		 
					   <a onmouseover="this.click()" style="font-size:9pt;font-weight:600;color:#FDFEFE;" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"><i class="fa fa-file-text-o" aria-hidden="true"></i>&nbsp;GCI /GCM /GCR&nbsp;<span class="caret"></span></a>
				   	   <ul class="dropdown-menu" style="left:0;width:200px;"> 		    	 
		 		   	    	<li style="margin-top:3px;margin-bottom:3px;"><a href="javascript:void();" onClick="calDocumentReport('listdocuments?cat=GCI&operation=view');"  style="font-size:09pt;color:black;"><img src="images/folder.png">  &nbsp;&nbsp;Ground Crew Instructions &nbsp; </a></li>	 					   
		 		   	    	<li style="margin-top:3px;margin-bottom:3px;"><a href="javascript:void();" onClick="calDocumentReport('listdocuments?cat=GCM&operation=view');"  style="font-size:09pt;color:black;"><img src="images/folder.png"> &nbsp;&nbsp;Ground Crew Memos &nbsp; </a></li>		    	
		 		   	    	<li style="margin-top:3px;margin-bottom:3px;"><a href="javascript:void();" onClick="calDocumentReport('listdocuments?cat=GCR&operation=view');"  style="font-size:09pt;color:black;"><img src="images/folder.png"> &nbsp;&nbsp;Ground Crew Reminders &nbsp; </a></li>		    	
		 		    	        
			            </ul>					  
				</li>
			  </c:if> 
			    
			    
	    
	   
   
   <c:if test = "${fn:contains(profilelist, 'Manuals')}">  
	    <li class="dropdown">	 
	  	    <a onmouseover="this.click()" style="font-size:9pt;font-weight:600;color:#FDFEFE;" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"><i class="fa fa-file-text-o" aria-hidden="true"></i>&nbsp;Manuals&nbsp;<span class="caret"></span></a>
	  	   	   <ul class="dropdown-menu" style="left:0;width:200px;">	  	   	          
      		   	    	<li style="margin-top:3px;margin-bottom:3px;"><a href="javascript:void();" onClick="calDocumentReport('listdocuments?cat=MAND&operation=view');"  style="font-size:09pt;color:black;"><img src="images/folder.png"> &nbsp;&nbsp;De-Icing Manuals &nbsp; </a></li>		    	
      		   	    	<li style="margin-top:3px;margin-bottom:3px;"><a href="javascript:void();" onClick="calDocumentReport('listdocuments?cat=MANG&operation=view');"  style="font-size:09pt;color:black;"><img src="images/folder.png"> &nbsp;&nbsp;Ground Ops Manual &nbsp; </a></li>		    	
 	                      	          	        
            </ul>		  	   
		</li>

      </c:if>	 
         

	   
   <c:if test = "${fn:contains(profilelist, 'safetycompliance')}">  
	  
		    <li class="dropdown">	 
		
		  	    <a onmouseover="this.click()" style="font-size:9pt;font-weight:600;color:#FDFEFE;" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"><i class="fa fa-file-text-o" aria-hidden="true"></i>&nbsp;Safety / Security / Compliance<span class="caret"></span></a>
		  	   	  
		  	   	   <ul class="dropdown-menu" style="left:0;width:227px;">	  	   	   
		  	   	   
				   	      <li style="margin-top:3px;margin-bottom:3px;"><a href="javascript:void();" onClick="calDocumentReport('listdocuments?cat=SCM&operation=view');"  style="font-size:09pt;color:black;"><img src="images/folder.png"> &nbsp;&nbsp;Compliance Monitoring &nbsp; </a></li>		    	
				   	      <li style="margin-top:3px;margin-bottom:3px;"><a href="javascript:void();" onClick="calDocumentReport('listdocuments?cat=SGO&operation=view');"  style="font-size:09pt;color:black;"><img src="images/folder.png"> &nbsp;&nbsp;Ground Ops Safety Statistics &nbsp; </a></li>		    	
		 	   	         <!--  <li style="margin-top:3px;margin-bottom:3px;"><a href="javascript:void();" onClick="calDocumentReport('listdocuments?cat=dgopm&operation=view&alfresco=YES');"  style="font-size:09pt;color:black;"><img src="images/folder.png"> &nbsp;Ground Ops Manual </a></li> -->	 
				   	      <li style="margin-top:3px;margin-bottom:3px;"><a href="javascript:void();" onClick="calDocumentReport('listdocuments?cat=SSB&operation=view');"  style="font-size:09pt;color:black;"><img src="images/folder.png"> &nbsp;&nbsp;Safety Bulletins &nbsp; </a></li>		    	
				   	      <li style="margin-top:3px;margin-bottom:3px;"><a href="javascript:void();" onClick="calDocumentReport('listdocuments?cat=SSM&operation=view');"  style="font-size:09pt;color:black;"><img src="images/folder.png"> &nbsp;&nbsp;Safety Manual &nbsp; </a></li>	
						  <li class="dropdown-submenu" style="margin-top:3px;margin-bottom:3px;">
								<a class="test" tabindex="-1"  style="font-size:09pt;"><img src="images/folder.png"> &nbsp;&nbsp;Security &nbsp;&nbsp;<i class="fa fa-caret-right" style="font-size:14px"></i>&nbsp;</a>
									<ul class="dropdown-menu" style="width:200px;">
									        <li><a class="navclass"  href="javascript:void();" onClick="calDocumentReport('listdocuments?cat=SSEP&operation=view&alfresco=YES');" style="font-size:09pt;"><img src="images/folder.png">&nbsp;Security Programme  </a></li>
									         <li><a class="navclass"  href="javascript:void();" onClick="calDocumentReport('listdocuments?cat=SSEN&operation=view&alfresco=YES');" style="font-size:09pt;"><img src="images/folder.png">&nbsp;Security Notice</a></li>
									         <li><a class="navclass"  href="javascript:void();" onClick="calDocumentReport('listdocuments?cat=SSEI&operation=view&alfresco=YES');" style="font-size:09pt;"><img src="images/folder.png">&nbsp;Security Instructions</a></li>
									         <li><a class="navclass"  href="javascript:void();" onClick="calDocumentReport('listdocuments?cat=SSEF&operation=view&alfresco=YES');" style="font-size:09pt;"><img src="images/folder.png">&nbsp;Security Forms</a></li>
									</ul>
									 
						  </li>
								    	
				  
				     </ul>		  	   
			</li>
		
      </c:if>
      
      
    <c:if test = "${fn:contains(profilelist, 'traning')}">  
		    <li class="dropdown">	 
		  	    <a onmouseover="this.click()" style="font-size:9pt;font-weight:600;color:#FDFEFE;" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"><i class="fa fa-file-text-o" aria-hidden="true"></i>&nbsp;Training  &nbsp;<span class="caret"></span></a>
		  	   	   <ul class="dropdown-menu" style="left:0;width:250px;">
	 		    	       <li style="margin-top:3px;margin-bottom:3px;"><a href="javascript:void();" onClick="calDocumentReport('listdocuments?cat=trd&operation=view');"  style="font-size:09pt;color:black;"><img src="images/folder.png"> &nbsp;Dispatch and Load Control </a></li>
			    	       <li style="margin-top:3px;margin-bottom:3px;"><a href="javascript:void();" onClick="calDocumentReport('listdocuments?cat=trbg&operation=view');"  style="font-size:09pt;color:black;"><img src="images/folder.png"> &nbsp;Baggage Tracing General </a></li>
			    	       <li style="margin-top:3px;margin-bottom:3px;"><a href="javascript:void();" onClick="calDocumentReport('listdocuments?cat=tras&operation=view');"  style="font-size:09pt;color:black;"><img src="images/folder.png"> &nbsp;Aer Lingus Airport Service Guide </a></li>
			    	       <li style="margin-top:3px;margin-bottom:3px;"><a href="javascript:void();" onClick="calDocumentReport('listdocuments?cat=trac&operation=view');"  style="font-size:09pt;color:black;"><img src="images/folder.png"> &nbsp;Aer Lingus Check-in and Boarding </a></li>
			    	       <li style="margin-top:3px;margin-bottom:3px;"><a href="javascript:void();" onClick="calDocumentReport('listdocuments?cat=trar&operation=view');"  style="font-size:09pt;color:black;"><img src="images/folder.png"> &nbsp;Aer Lingus Reservations </a></li>
			    	       <li style="margin-top:3px;margin-bottom:3px;"><a href="javascript:void();" onClick="calDocumentReport('listdocuments?cat=trs&operation=view');"  style="font-size:09pt;color:black;"><img src="images/folder.png"> &nbsp;Stobart Air Training Modules </a></li>
	
		             </ul>		  	   
			</li>
    	</c:if>	
			
   
      <c:if test = "${fn:contains(profilelist, 'weightstatement')}">  
          
		    <li class="dropdown">		 
			  <a href="javascript:void();" onClick="calDocumentReport('wtstatement?airlinecode=ALL&airlinereg=ALL');" style="font-size:9pt;font-weight:600;color:#FDFEFE;" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"><i class="fa fa-file-text-o" aria-hidden="true"></i>&nbsp;Weight Statements</a>
			</li>
		</c:if>		
	
	
    <c:if test = "${fn:contains(profilelist, 'documentation')}">  
    		
	    <li class="dropdown">	 
		  <a href="adminhome"  onmouseover="this.click()" style="font-size:9pt;font-weight:600;color:#FDFEFE;" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"><i class="fa fa-file-text-o" aria-hidden="true"></i>&nbsp;Documentation&nbsp;<span class="caret"></span></a>
		  
			   <ul class="dropdown-menu" style="left:0;width:250px;">
 		    	<li style="margin-top:3px;margin-bottom:3px;"><a href="javascript:void();" onClick="calDocumentReport('listdocuments?cat=dchm&operation=view&alfresco=YES');"  style="font-size:09pt;color:black;"><img src="images/folder.png"> &nbsp;Catering - HAACP Manual</a></li>
		    	<!-- 
		    	<li style="margin-top:3px;margin-bottom:3px;"><a href="javascript:void();" onClick="calDocumentReport('listdocuments?cat=diam&operation=view&alfresco=YES');"  style="font-size:09pt;color:black;"><img src="images/folder.png"> &nbsp;De-icing & Anti-Icing Manual</a></li>	 
		     	<li style="margin-top:3px;margin-bottom:3px;"><a href="javascript:void();" onClick="calDocumentReport('listdocuments?cat=dcompm&operation=view');"  style="font-size:09pt;color:black;"><img src="images/folder.png"> &nbsp;Compliance Monitoring </a></li>	 
		    	 --> 	
			    <li style="margin-top:3px;margin-bottom:3px;"><a href="javascript:void();" onClick="calDocumentReport('listdocuments?cat=dcle&operation=view');"  style="font-size:09pt;color:black;"><img src="images/folder.png"> &nbsp;Cleaning </a></li>		    	
		    	<li style="margin-top:3px;margin-bottom:3px;"><a href="javascript:void();" onClick="calDocumentReport('listdocuments?cat=dqrd&operation=view');"  style="font-size:09pt;color:black;"><img src="images/folder.png"> &nbsp;Quick Reference Documents </a></li>		    	
		    	<li style="margin-top:3px;margin-bottom:3px;"><a href="javascript:void();" onClick="calDocumentReport('listdocuments?cat=derp&operation=view');"  style="font-size:09pt;color:black;"><img src="images/folder.png"> &nbsp;Emergency Response Plan </a></li>	
		    	<li style="margin-top:3px;margin-bottom:3px;"><a href="javascript:void();" onClick="calDocumentReport('listdocuments?cat=dalso&operation=view');"  style="font-size:09pt;color:black;"><img src="images/folder.png"> &nbsp;Aer Lingus Station Overview </a></li>	
		    	<li style="margin-top:3px;margin-bottom:3px;"><a href="javascript:void();" onClick="calDocumentReport('listdocuments?cat=dcls&operation=view');"  style="font-size:09pt;color:black;"><img src="images/folder.png"> &nbsp;Computerised Loading-System</a></li>	
		    	<li style="margin-top:3px;margin-bottom:3px;"><a href="javascript:void();" onClick="calDocumentReport('listdocuments?cat=dseat&operation=view');"  style="font-size:09pt;color:black;"><img src="images/folder.png"> &nbsp;Seat Maps</a></li>	
                
                     
                <!-- 
		    	<li style="margin-top:3px;margin-bottom:3px;"><a  href="AerLingusStationOverview.pdf" target="_new"  style="font-size:09pt;color:black;"><img src="pdf.png"> &nbsp;Aer Lingus Station Overview </a></li>	
		    	<li style="margin-top:3px;margin-bottom:3px;"><a  href="StatusofComputerisedLoadsystems.pdf" target="_new"  style="font-size:09pt;color:black;"><img src="pdf.png"> &nbsp;Computerised Loading-System </a></li>	
		    	 -->
		    	    	
		       </ul>
					  
		</li>
	</c:if>
		
		  		
    <c:if test = "${fn:contains(profilelist, 'forms')}">  
    		
		<li class="dropdown">
		 
			  <a href="forms" onmouseover="this.click()" style="font-size:9pt;font-weight:600;color:#FDFEFE;" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"><i class="fa fa-file-text-o" aria-hidden="true"></i>&nbsp;&nbsp;Forms&nbsp;<span class="caret"></span></a>
			  
				   <ul class="dropdown-menu" style="left:0;width:160px;">
				    
				    	<li style="margin-top:3px;margin-bottom:3px;"><a href="javascript:void();" onClick="calDocumentReport('listdocuments?cat=formsei&operation=view');"  style="font-size:09pt;color:black;"><img src="images/folder.png"> &nbsp;Aer Lingus</a></li>
				     	<!--  <li style="margin-top:3px;margin-bottom:3px;"><a href="javascript:void();" onClick="calDocumentReport('listdocuments?cat=formsbe&operation=view');"  style="font-size:09pt;color:black;"><img src="images/folder.png"> &nbsp;FlyBe</a></li> -->
				    	<li style="margin-top:3px;margin-bottom:3px;"><a href="javascript:void();" onClick="calDocumentReport('listdocuments?cat=formsre&operation=view');"  style="font-size:09pt;color:black;"><img src="images/folder.png"> &nbsp;Stobart Air</a></li>
				    	<li style="margin-top:3px;margin-bottom:3px;"><a href="javascript:void();" onClick="calDocumentReport('listdocuments?cat=formdnotices&operation=view');"  style="font-size:09pt;color:black;"><img src="images/folder.png"> &nbsp;Disruption Notices</a></li>
				    	<!-- <li style="margin-top:3px;margin-bottom:3px;"><a href="javascript:void();" onClick="calDocumentReport('listdocuments?cat=formsei&operation=view');"  style="font-size:09pt;color:black;"><img src="images/folder.png"> &nbsp;Disruption Notices</a></li>  -->
				    
				    </ul>
						  
			</li>
	
	 </c:if>

	
		
	
    <c:if test = "${fn:contains(profilelist, 'gopsadmin')}">  
    		
				 <li class="dropdown">
				 
					  <a href="refisadmin" onmouseover="this.click()" style="font-size:9pt;font-weight:600;color:#FDFEFE;" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"><i class="fa fa-user-md" aria-hidden="true"></i>&nbsp;&nbsp;Admin <span class="caret"></span></a>
					  
						  <ul class="dropdown-menu" style="left:0;width:200px;">
					       		<c:if test = "${fn:contains(profilelist, 'ManageUsers')}">  
					       			<li style="margin-top:3px;margin-bottom:3px;"><a href="javascript:void();" onClick="calRefisReport('managegopssuser','Manage Refis Users');" style="font-size:09pt;color:black;"><img src="images/folder.png"> &nbsp;REFIS User Manager</a></li> 
					       		</c:if>
					       		<c:if test = "${fn:contains(profilelist, 'profileManager')}">  
					       			<li style="margin-top:3px;margin-bottom:3px;"><a href="javascript:void();" onClick="calRefisReport('gopsusersprofilemanager','Manage Ground Ops Users Profile');" style="font-size:09pt;color:black;"><img src="images/folder.png"> &nbsp;User Profile  Manager</a></li>
					       		</c:if>
					       		
					       		<c:if test = "${fn:contains(profilelist, 'ManageSmscontact')}"> 
					       			<li style="margin-top:3px;margin-bottom:3px;"><a href="javascript:void();" onClick="calRefisReport('managesmscontacts','SMS Report Users');" style="font-size:09pt;color:black;"><img src="images/folder.png"> &nbsp;SMS Contacts Manager</a></li>
                                </c:if>	
                                <c:if test = "${fn:contains(profilelist, 'AirlineDataManager')}"> 
                                	<li style="margin-top:3px;margin-bottom:3px;"><a href="javascript:void();" onClick="calRefisReport('manageairlinedata');"  style="font-size:09pt;color:black;"><img src="images/folder.png"> &nbsp;Airline Data Manager</a></li>
                                </c:if>	
                                
                               	<li style="margin-top:3px;margin-bottom:3px;"><a href="javascript:void();" onClick="calDocumentReport('listdocuments?cat=logo&operation=view');"  style="font-size:09pt;color:black;"><img src="images/folder.png"> &nbsp;Company Logo </a></li>
                               	
					       		<!-- 
				       		    <li style="margin-top:3px;margin-bottom:3px;"><a href="javascript:void();" onClick="calRefisReport('managecrewbriefing','PPS Crew Briefing Integration');" style="font-size:09pt;color:black;"><img src="images/folder.png"> &nbsp;Crew Briefing Manager </a></li>
					       		<li style="margin-top:3px;margin-bottom:3px;"><a href="javascript:void();" onClick="alert('Under Construction');"  style="font-size:09pt;color:black;"><img src="images/folder.png"> &nbsp;Crew Flight Reports</a></li>
					       		 -->
					      </ul>
								  
					</li>
         </c:if>
         
         
         
         
			<li class="dropdown">
					  <a href="#" onmouseover="this.click()" style="font-size:09pt;font-weight:600;color:#FDFEFE;" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"> <i class="fa fa-user-circle"></i>&nbsp;&nbsp;<%=userLoginId%>&nbsp;<span class="caret"></span></a>
					  <ul class="dropdown-menu" style="left:0;width:200px;">
					      <li style="margin-top:0px;margin-bottom:0px;"><a href="logout" style="font-size:09pt;color:black;"><i class="fa fa-sign-out" aria-hidden="true"></i>&nbsp;&nbsp;Logout</a></li>
					  
					  </ul>
			 </li>	
			
		</ul>
		 
		  </div>
		
      </div>


 


</nav>




<!-- End of  Menu  --->	 
<br>
<br>
<br>



<div class="col-md-5 col-sm-5 col-xs-12" >
  
  <c:if test="${usertype == 'I'}">
     <a onclick="cal_groundops_home('I');" href="javascript:void();"> <span style="font-weight:600;color:#0071ba;"><i class="fa fa-home"></i> Ground Operations</span></a>
  </c:if>
  
  <c:if test="${usertype == 'E'}">
    <a onclick="cal_groundops_home('E');" href="javascript:void();"> <span style="font-weight:600;color:#0071ba;"><i class="fa fa-home"></i> Ground Operations</span></a> 
  </c:if>
  

 </div>
 
  <div class="col-md-7 col-sm-7 col-xs-12" align="right">
      
      <table width="30%"> 
        <tr>
          <td>
              <input autofocus="" type="text" name="myInput" id="myInput" class="form-control" placeholder="Search Documents..">
               <button type="submit"  hidden="hidden" id="myBtn" onclick="calDocumentReport('searchdocuments')"><i class="fa fa-search"></i></button>
         </td>
        </tr>
      </table>
       <br>   
 </div>
 
 </form>
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

   