<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="../include/header.jsp" />

<head>
    <title> Dashboard | Crew Briefing. </title>    
</head>


<script src="https://canvasjs.com/assets/script/canvasjs.min.js"></script>

<script type="text/javascript">


// ------------ This will get the PPS Token Code from Database and built a URL and open in a new windows
function open_crew_breifing_page() {
	
	 if(document.getElementById("crewid").value == ""){ 
		 $('#crewstatus').text("Select Crew Member Frome List");
		 document.crewform.crewid.focus();
		 return false;
	  }
	
     document.getElementById("operation").value="viewcrewdetail";
     var urlStr = document.getElementById("callingurl").value+document.getElementById("crewid").value+"&Code=";
     var callingurl="ajaxrest/getCrewToken";
     $.ajax({
			type : 'GET',
			url : callingurl,
			success : function(result) {
	        urlStr = urlStr+result+"&format=https";
            window.open(urlStr,"","width=1200, height=700");
			},

			error : function(result) {
	         //alert("Seems Like Login Token is finish \n Please Check the Balance Under Token Maintenance on the next Tab.");
	         $('#crewstatus').text("Seems Like Login Token is finish !! Please Check the Balance Under Token Maintenance on the next Tab.");
			},

	  });    
}





function uploade_progress() {
    var e = document.getElementById("upload");
    if(e.style.display == 'block')
       e.style.display = 'none';
    else
       e.style.display = 'block';

    var e1 = document.getElementById("uploadprogress");
    if(e1.style.display == 'block')
        e1.style.display = 'none';
     else
        e1.style.display = 'block';    
 }


function Validate_File_Type(filePath) {

	var allowedExtensions = /(\.txt)$/i;

	if (!allowedExtensions.exec(filePath)) {
		 //alert('Invalid file type\n You have to select .TXT File Only..!!');
		 $('#tokenupdatestatus').text('Invalid file type\n You have to select .TXT File Only..!!');
		document.crewform.cfile.focus();
		return false;
	} else {
		return true;
	}
}




function Upload_PPS_Token_File() {

	if (document.crewform.cfile.value == "") {
		//alert("Please Select File..");
		 $('#tokenupdatestatus').text("Please Select a .txt file content with token..");
		document.crewform.cfile.focus();
		return false;
	}
	if (Validate_File_Type(document.crewform.cfile.value)) {
		uploade_progress();
		
		document.getElementById("message").innerHTML = "<font style='color:blue;'>&nbsp;&nbsp;&nbsp; Back Ground job is started for this .. if you like can leave this page and move on to other job</font>";
	
		var formData = new FormData();
          formData.append('cfile', $('input[type=file]')[0].files[0]);
          console.log("form data " + formData);
          $.ajax({
              url : 'ajaxrest/loadtokentodatabase?profilelist='+document.getElementById("profilelist").value,
              data : formData,
              processData : false,
              contentType : false,
              type : 'POST',
              success : function(data) {                  
                  document.crewform.tokenbalance.focus();
                  document.crewform.cfile.value="";
                  uploade_progress();
          		  document.getElementById("message").innerHTML = "<font style='color:blue;'>&nbsp;&nbsp;&nbsp;<b> "+(data-document.crewform.tokenbalance.value)+" </b> </font># Token Loaded to the Database ";
          		  document.crewform.tokenbalance.value=data;

              }
          });
		
    	

	}
	
}//---------- End Of Function  ------------------






</script>



<body>

 <form name="crewform" id="crewform" enctype="multipart/form-data">

  <input type="hidden" id="profilelist" name="profilelist" value="${profilelist}">
  
  <input type="hidden" name="usertype" value="${usertype}">
  <input type="hidden" name="operation" id="operation" value="">
  <input type="hidden" id="callingurl" name="callingurl" value="https://www.crewbriefing.com/Login.aspx?username=REA">

<br>


 <div  style="margin-top:60px;" align="center">	
	
		<div class="col-md-12 col-sm-12 col-xs-12"  align="left">
			<i class="fa fa-hashtag" aria-hidden="true"></i>&nbsp;<span style="font-weight:600;font-size:13pt;">PPS Crew Briefing Integration:</span></a>
	   </div>	
  
  </div>		
	
<br>
<br>
<br>
<br>
<br>
		
	<div class="row" align="center">
	

		<div  align="center" style="width:55%;">
			
			  <p id="message" align="center"> </p>
			
			<div class="panel panel-primary" style="background:rgba(255,255,255);">
		
		
				<div class="row">
				<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
			
					<ul class="nav nav-pills nav-justified">
						<li class="active"><a data-toggle="pill" href="#dynamicmenu1">Briefing Search</a></li>
						<li><a data-toggle="pill" href="#dynamicmenu2">Token Maintenance</a></li>
						<!-- <li><a data-toggle="pill" href="#dynamicmenu3">Config Update</a></li> -->
					</ul>


					<!-- FIRST TAB -->					
					<div class="tab-content">
						<div id="dynamicmenu1" align="left" class="tab-pane fade in active">
						<br>
										
				       <table class="table table-bordered" border="1" style="width: 50%;" align="center">	    
				    			<tbody>				     
							     
			     		     <tr>
								   <td style="padding: 05px;">								          
								   			   <label>Crew Member </label>
									
								   </td>
							   </tr>
							
							   <tr>
									<td align="left" style="padding: 05px;">
									 
									     <div class="col-xs-20">
											<div class="input-group">
											
												<span class="input-group-addon"><i class="fa fa-user-circle-o" aria-hidden="true"></i></span>								
														<select id="crewid" name="crewid" class="form-control"  >
														 <option value="">----------- Select Crew Member ---------</option>
															 <c:forEach var="caplst" items="${captionlist}"> 
											                    <option value="${caplst.getCrewid()}"> ${caplst.getPosition()} - (${caplst.getCrewid()}) - ${caplst.getCrewName()}</option>
											                </c:forEach>
									
													    
													    
													    </select>
													    
												</div>	
											</div>
							              
							              </td>	               
							   </tr>
		
							   <tr>
								   <td align="center" style="padding: 05px;">
								   		 <span onclick="open_crew_breifing_page();" id="buttonDemo1" class="btn btn-primary"><i class="fa fa-search" aria-hidden="true"></i>&nbsp; &nbsp; Search </span>
						                  			
								   </td>
							   </tr>
		                	</table>
								<p  style="color:blue;font-size:12px;" id="crewstatus" align="center">  </p>
								<br>
								<br>
								<br><br>
						</div>
					
						
					
					<!-- SECOND  TAB -->
					<div id="dynamicmenu2" class="tab-pane fade">
				       <table class="table table-bordered" border="1" style="width: 50%;" align="center">	    
				    		
				    		<tbody>				     
							     
			     		      <tr>
								   <td style="padding: 05px;align:center;">								          
								   		<label>Update Crew Briefing Auto Logon Tokens: </label>
									
								   </td>
							   </tr>
							
							
								<tr> 								
									<td>									
										<div class="input-group">
											<span class="input-group-addon"><i class="fa fa-text-height fa-lg" aria-hidden="true"></i>&nbsp;Token Balance</span>	
											<input readonly type="text" name="tokenbalance" id="tokenbalance" class="form-control" value="${tokenbalance}">
										</div>								
									
									</td>
								</tr>
			
							<!-- 
								<tr> 
								
									<td>
									
										<div class="input-group">
											<span class="input-group-addon"><i class="fa fa-text-height fa-lg" aria-hidden="true"></i>&nbsp;Low Level</span>	
											<input  readonly type="text" name="flightno" id="flightno" class="form-control" value="100">					
															
										</div>
									
									</td>
								</tr>
							 -->

							   <tr>
									<td align="left" style="padding: 05px;">
									
									 			<div class="col-xs-05">
									
													<div class="input-group"> 
														<span class="input-group-addon"><i class="fa fa-paperclip fa-lg" aria-hidden="true"></i>&nbsp;&nbsp;<b>Upload New Token</b></span>							
															 <input type="file"  id="cfile"  name="cfile"   class="form-control"/>
													 </div>
														 
										        </div>
													              
							              </td>	               
							   </tr>
		
							   <tr>
								   <td align="center" style="padding: 05px;">
								      
								      <span style="display:block;width:50%" onClick="Upload_PPS_Token_File();" id="upload" class="btn btn-primary" >Load Token  </span>  
                                        
	               				        <span style="display:none" id="uploadprogress">
			 				                <div class="progress-bar progress-bar-striped active" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width:100%">
									         <b> Loading token  is in progress.. will take a while to finish....</b>&nbsp;&nbsp;<i class="fa fa-spinner fa-pulse fa-2x"></i>
									         </div>
			       				        </span>
		  
	                                        
                                        			
								   </td>
							   </tr>
		                	
		                	</table>						
							<span style="color:blue;font-size:12px;" id="tokenupdatestatus" align="center"> Note: Only .TXT file is allowed  with the Token content separated with <b>,</b> <br> 
							               Example : The content of file should be in this fashion =>  3550881218<b>,</b>35509E518B  </p>
							
							
						</div>
						
						
						
						
						
						
					</div>
				</div>
			</div>
		</div>
	</div>	
		
		
		
		
		
		
				</div>
			
		</div>
 </div>
 
 </form>
</body>
<br>
<br>
<br>
<br>
<br>

<%@include file="../include/footer.jsp" %>




