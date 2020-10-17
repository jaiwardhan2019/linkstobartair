<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>

<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>




<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE html 
     PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
     "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">

${pageContext.request.contextPath}





<br>
<%=application.getContextPath()%>


<br>
Display Env Varriable 
<br>

Here is log directory ${catalina.home}

<br>

 <h2><a href="/download.do">Click here to download file</a></h2>
 
 <br>
 
 Click on the link to download:<a href="DownloadServlet">Download a File</a> 
 
 <br>
 
Hask Key Object : 



<c:forEach var="entry" items="${profilelist}">
  Key: <c:out value="${entry.key}"/>
  Value: <c:out value="${entry.value}"/>
  <br>
</c:forEach>
 
 
 
 Here is now  AJAX  Example :  ${alreadySaved}
 
 

 
 <security:authorize ifAnyGranted="ROLE_ADMIN">
    <tr>
        <td colspan="2">
            <input type="submit" value="<spring:message code="label.add"/>"/>
             HIIIIIIIIIIIIIIII
        </td>
    </tr>
</security:authorize>
 
<br>
 
 Click on the link to download:<a href="DownloadServlet">Download a File</a> 
 
 <br>
 
 
 
