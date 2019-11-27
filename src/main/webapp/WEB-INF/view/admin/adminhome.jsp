<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="../include/adminheader.jsp" />
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Link | Administration. </title>
</head>
     
<script type="text/javascript">


function goto_admin_home(){
	     alert("Hi there ");	 
	    document.businessarea.action="adminhome"; 
	    document.businessarea.submit();
}


</script>



<body>
<br>
<br>

<br>
<br>
<br>
<br>
<br>




<div class="container" align="center">

         <img src="<c:url value="images/bodyback1.jpg"/>" >
</div>
</body>
</html>
<br>
<br>
<br>
<br>
<br>
<br>




<%@include file="../include/adminfooter.jsp" %>

