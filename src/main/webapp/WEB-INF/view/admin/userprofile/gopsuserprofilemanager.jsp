<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="../../include/adminheader.jsp" />

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Link | Manage Ground Ops User Profile  </title>
</head>



<script type="text/javascript">
	


function updateUser(){

        if(confirm("Are you sure about this Profile Changes.?!")){
      	      document.linkuser.method="POST"
    		  document.linkuser.action="updateGopsProfileToDataBase?emailid=${emailid}";
    	      document.linkuser.submit();
    		  return true;

         }
          

}



function  UserSearch(){

	      document.linkuser.method="POST"
		  document.linkuser.action="profilemanager?emailid=${emailid}";
	      document.linkuser.submit();
		  return true;
         

	
}






function remove_user_Profile(){
			
		if(confirm("Are you sure about Removing Thesse Profile for User?!")){
		      document.linkuser.method="POST"
			  document.linkuser.action="removegopsprofile?emailid=${emailid}";
		      document.linkuser.submit();
			  return true;
		
		 }
		

} //-------- End Of Function 



///------------ Select All Check Box -----------------------------
function getcheckboxesGops() {
    var node_list = document.getElementsByTagName('input');
    var checkboxes = [];
    for (var i = 0; i < node_list.length; i++) 
    {
        var node = node_list[i];
        //if(node.getAttribute('type') == 'checkbox') 
        if(node.getAttribute('id') == 'gopsprofile')             
        {
            checkboxes.push(node);
        }


        
    } 
    return checkboxes;
}

function selectallGroundOpsProfile(source) {
  checkboxes = getcheckboxesGops();
  for(var i=0, n=checkboxes.length;i<n;i++) 
  {
    checkboxes[i].checked = source.checked;
  }
}












function getcheckboxesUser() {
    var node_list = document.getElementsByTagName('input');
    var checkboxes = [];
    for (var i = 0; i < node_list.length; i++) 
    {
        var node = node_list[i];
        //if(node.getAttribute('type') == 'checkbox') 
        if(node.getAttribute('id') == 'userprofile')             
        {
            checkboxes.push(node);
        }


        
    } 
    return checkboxes;
}


function selectallUserProfile(source) {
  checkboxes = getcheckboxesUser();
  for(var i=0, n=checkboxes.length;i<n;i++) 
  {
    checkboxes[i].checked = source.checked;
  }
}







</script>

<style>

tr:nth-child(even) {
  background-color: #F8F9F9;
}

</style>



<body>

<br>
<br><br>
<br>


 <div   align="center">	
	
		<div class="col-md-12 col-sm-12 col-xs-12"  align="left">
			<i class="fa fa-users" aria-hidden="true"></i>&ensp;<span style="font-weight:600;font-size:13pt;">Manage Ground Ops Users Profile  </span></a>
	   </div>	
  
  </div>		
	
<br>

<!-- Body Banner -->
<div class="container" align="center">
 
<br>
<br>
 
 <span style="color:blue;align:center;font-size:18px;" > ${status} </span>
 

<div class="col-md-12 col-sm-12 col-xs-12" align="center">
<form method="post" name="linkuser" id="linkuser">  
 
  <input type="hidden" name="emailid"  id="emailid"  value="${emailid}">
  <input type="hidden" name="userid"  id="userid"  value="${linkuserdetail.getEmailId()}">
   <input type="hidden" name="application"  id="application"  value="gops">
		 
  <table class="table table-striped table-bordered" border="1" style="width: 80%;" align="center">	
		
	     <tr align="center">
				    
				    <td bgcolor="#0070BA" width="50%">
					   <span style="color:white;" > <b> 
					         ${linkuserdetail.getEmailId()} &nbsp;&nbsp;&nbsp;Existing Profile 
					     </b></span>					 
					 </td>
					  
					 <td bgcolor="#0070BA"  width="50%">
					   <span style="color:white;"> <b> 
					       Ground Ops Profile
					     </b></span>					 
					 </td>

          </tr>
          
          
          <tr>
		          
		          <td> 
		          
		                     <table class="table"   width="50%" align="center">
		                         
		                          <tr>
		                             <td colspan="2" align="right">		                             
		                               <span class="label label-warning" style="font-size:12px;">  Select All&nbsp;<input type="checkbox" onClick="selectallUserProfile(this)"/>  </span>
		                             </td>
		                          </tr>		                     
                                   
                                   ${userprofilelist}
                                   
                                   
                              </table>
                              
                              
                              
                              
		          </td>
		          
		          
	   
		          
		          <td> 
		          
		                      <table class="table"  width="20%" align="center">    
		                           <tr>
		                             <td colspan="2" align="right">		                             
		                               <span class="label label-warning" style="font-size:12px;">  Select All &nbsp;<input type="checkbox" onClick="selectallGroundOpsProfile(this)"/> </span>
		                             </td>
		                          </tr>		                     

                                    ${gopsprofilelist}
             
                              </table>

		          
		          </td>
	
          </tr>           
          
   </table>       

  <table  style="width: 80%;" align="center">	
     <tr>
     
	     <td align="center"> 
	         <span onClick="remove_user_Profile();" class="btn btn-danger"><i class="fa fa-trash-o fa-fw"></i> Remove Profile </span>
	     </td>
	     
	     
	     <td align="center"> 	      
	      
	      <span onClick="UserSearch();"  class="btn btn-primary"  > <i class="fa fa-search-plus" aria-hidden="true"></i> Back To Search  </span>
	        
	     </td>
	     
	     
	     <td align="center"> 
	     
	              <span onClick="updateUser();"  class="btn btn-success"><i class="fa fa-plus" aria-hidden="true"></i> Update Profile </span>
	            
	            
	     </td>
	     
     </tr>
  
  
  </table>   
  
  
      
   
 </form>

</div>
</div>


<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
         
  	 	 



</body>
</html>
<jsp:include page="../../include/adminfooter.jsp" />
