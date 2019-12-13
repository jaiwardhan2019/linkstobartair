<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="../../include/adminheader.jsp" />

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Link | Update Users Profile For Contract Management  </title>
</head>



<script type="text/javascript">
	
// https://html5-tutorial.net/forms/checkboxes/  <<-- For Validation 

function updateUser(){

        if(confirm("Are you sure about this Profile Changes.?!")){
      	      document.linkuser.method="POST"
    		  document.contractuser.action="showcontractaccessprofile?emailid=${emailid}";
    	      document.contractuser.submit();
    		  return true;

         }
          

}




function remove_user_Profile(){
			
		if(confirm("Are you sure about Removing Thesse Profile for User?!")){
		      document.contractuser.method="POST"
			  document.contractuser.action="showcontractaccessprofile?emailid=${emailid}";
		      document.contractuser.submit();
			  return true;
		
		 }
		

} //-------- End Of Function 





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
			<i class="fa fa-users" aria-hidden="true"></i>&ensp;<span style="font-weight:600;font-size:13pt;">Manage User Access to Contract </span></a>
	   </div>	
  
  </div>		
	
<br>
<br>

 	

<!-- Body Banner -->
<div class="container" align="center">
     	
  
    <span align="center">   <H3> Manage  Profile : Jai Wardhan  </H3> </span>				           
	
 
     	
<!----------------- RIGHT CONTENT MAIN BODY  -------------------->
<div class="col-md-12 col-sm-12 col-xs-12" align="center">

<form method="post" name="contractuser" id="contractuser">   
   
   
 	 	 
  <table class="table table-striped table-bordered" border="1" style="width: 60%;" align="center">	
	     
   <tr>
          	 <td  bgcolor="#0070BA" width="50%">
					   <span style="color:white;"> <b>
					    Main Department
					   </b></span>					 
					 </td>
			
			 <td  bgcolor="#0070BA" width="50%">
					   <span style="color:white;"> <b>
					    Sub Department
					   </b></span>					 
					 </td>
			 
      	 	
   </tr>
   
   <tr>
   
    <td width="50%">
    	     <div class="form-group">
							<div class="input-group">
								<span class="input-group-addon"><i class="fa fa-universal-access" aria-hidden="true"></i></span>								
										<select id="department" name="department" class="form-control" onchange="bulit_ref_no()" >										
											<option value="GEN"> General Contract - </option>	
											<option value="ENG" > Engineering </option>
											<option value="FIN" > Finance </option>												
										</select>
							</div>	
						</div>
				
			
    
    
    </td>
    
 <td width="50%">
    				<div class="form-group">
							<div class="input-group">
								<span class="input-group-addon"><i class="fa fa-university" aria-hidden="true"></i></i></span>							
									
										<select  id="subdepartment" name="subdepartment" class="form-control" onchange="bulit_ref_no()" >		
											<option value="ENG1"> - ENG One  - </option>	
											<option value="ENG2"> - ENG Two -  </option>
											
										</select>
							</div>
				    </div>
	
    </td>
    
    
   
   </tr>
   
   
  
      
  </table> 
         
  	 	 
  <table  style="width: 60%;" align="center">	
  
     <tr>
     
	     <td align="center"> 
	         
	         &nbsp;&nbsp;<span onClick="UserSearch();"  class="btn btn-primary"  > <i class="fa fa-search-plus" aria-hidden="true"></i> User Search  </span>
	     
	         &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	         <span onClick="updateUser();"  class="btn btn-success"><i class="fa fa-plus" aria-hidden="true"></i> Add Access </span>
	            
	            
	     </td>
	     
     </tr>
  
  
  </table>       
         
       </div>
        
      </div>  



<br>
<br>

		<table   class="table table-striped table-bordered" style="width: 50%;" align="center">								
	
			<tr> 
				<td align="left" width="5%"><b>1.</b>&nbsp;</td>
				
			    <td> Engineering </td>
			    
			    <td> Electrical</td>
			    
				
				<td align="left" width="12%">
				 <span style="font-weight:600;font-size:9pt;color:red">
				   <i class="fa fa-trash-o" aria-hidden="true"></i><a href="">&nbsp;Remove</a>
				 </span>  
				 </td>
			</tr>
			<tr> 
				<td align="left" width="5%"><b>1.</b>&nbsp;</td>
				
			    <td> Engineering </td>
			    
			    <td> Electrical</td>
			    
				
				<td align="left" width="12%">
				 <span style="font-weight:600;font-size:9pt;color:red">
				   <i class="fa fa-trash-o" aria-hidden="true"></i><a href="">&nbsp;Remove</a>
				 </span>  
				 </td>
			</tr>
			<tr> 
				<td align="left" width="5%"><b>1.</b>&nbsp;</td>
				
			    <td> Engineering </td>
			    
			    <td> Electrical</td>
			    
				
				<td align="left" width="12%">
				 <span style="font-weight:600;font-size:9pt;color:red">
				   <i class="fa fa-trash-o" aria-hidden="true"></i><a href="">&nbsp;Remove</a>
				 </span>  
				 </td>
			</tr>
			<tr> 
				<td align="left" width="5%"><b>1.</b>&nbsp;</td>
				
			    <td> Engineering </td>
			    
			    <td> Electrical</td>
			    
				
				<td align="left" width="12%">
				 <span style="font-weight:600;font-size:9pt;color:red">
				   <i class="fa fa-trash-o" aria-hidden="true"></i><a href="">&nbsp;Remove</a>
				 </span>  
				 </td>
			</tr>
			
		</table>







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

