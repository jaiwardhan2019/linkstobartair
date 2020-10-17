<!--  
http://localhost:8080/linkstobartair/fileuploadtest
-->

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>File Upload to Database Demo</title>
</head>
<body>
	<center>
		<h1>File Upload to Database </h1>
		<form method="post" action="uploadServlet" enctype="multipart/form-data">
			<table border="0">
				<tr>
					<td>File Name : </td>
					<td><input type="text" name="firstName" size="50"/></td>
				</tr>
				<tr>
					<td>File Description: </td>
					<td><input type="text" name="lastName" size="50"/></td>
				</tr>
				<tr>
					<td>File: </td>
					<td><input  type="file"  id="photo"  name="photo"  size="50"/></td>
				</tr>
				<tr>
					<td colspan="2" align="center">
						<input type="submit" value="Add To Database">
					</td>
				</tr>
				
				<tr>				
				    <td colspan="2" align="center">				 
				        ${status}				 
				    </td>				
				</tr>
				<!-- 
				<tr>				
				    <td colspan="2" align="center">				 
				        <a href="viewDownloadServlet?docid=17"> View Download File </a>	 
				    </td>				
				</tr>
				 -->
			</table>
			<br>
			<br><br>
			
			<table width="40%" border="1">
			<tr>
				<td width="40%"  align="center">
				   FileName 
				</td>
				
				<td width="50%"  align="left">
				    <a href="">File Description </a>  
				</td>			
				
				<td width="10%" align="right">			   
				     <a href=""> Remove </a>
				</td>
			
			</tr>
				<tr>
				<td width="40%"  align="center">
				   FileName 
				</td>
				
				<td width="50%"  align="left">
				    <a href="">File Description </a>  
				</td>			
				
				<td width="10%" align="right">			   
				     <a href=""> Remove </a>
				</td>
			
			</tr>
			
				<tr>
				<td width="40%"  align="center">
				   FileName 
				</td>
				
				<td width="50%"  align="left">
				    <a href="">File Description </a>  
				</td>			
				
				<td width="10%" align="right">			   
				     <a href=""> Remove </a>
				</td>
			
			</tr>
			
				<tr>
				<td width="40%"  align="center">
				   FileName 
				</td>
				
				<td width="50%"  align="left">
				    <a href="">File Description </a>  
				</td>			
				
				<td width="10%" align="right">			   
				     <a href=""> Remove </a>
				</td>
			
			</tr>
			
				<tr>
				<td width="40%"  align="center">
				   FileName 
				</td>
				
				<td width="50%"  align="left">
				    <a href="">File Description </a>  
				</td>			
				
				<td width="10%" align="right">			   
				     <a href=""> Remove </a>
				</td>
			
			</tr>
			
				<tr>
				<td width="40%"  align="center">
				   FileName 
				</td>
				
				<td width="50%"  align="left">
				    <a href="">File Description </a>  
				</td>			
				
				<td width="10%" align="right">			   
				     <a href=""> Remove </a>
				</td>
			
			</tr>
			
			
			</table>
			
			
			
		</form>
	</center>
</body>
</html>