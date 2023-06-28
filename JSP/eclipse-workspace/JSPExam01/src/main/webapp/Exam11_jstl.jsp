<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
  <title>JSTL 예시</title>
</head>
<body>
<!-- set, out 예시 -->
<c:set var="varName" value="홍길동" />
varName : <c:out value="${varName}"/>
<br/>

<!-- remove 예시 -->
<c:remove var="varName"/>
varName 제거 후 : <c:out value="${varName}"/><br/><hr/>

<!-- catch 예시 -->
<c:catch var="error">
<%= 2/0 %>
</c:catch><br/>
<c:out value="${error}"/>
<hr/>

<!-- if 사용 예시 -->
<c:if test="${1+2 == 3}">
    1 + 2 = 3
</c:if><br/>
<c:if test="${1+2 != 3}">
    1 + 2 != 3
</c:if><hr/>

 <!-- choose 사용 예시 -->
<c:set var="varName" value="세종대왕"/>
<c:choose>
    <c:when test="${varName == '홍길동' }">when: 홍길동</c:when>
    <c:otherwise> when: 다른 사람 </c:otherwise>
</c:choose>
<hr/>

<!-- forEach 사용 예 -->
<c:forEach var="fEach" begin="0" end="30" step="3">
    ${fEach}
</c:forEach><p>

<%
List<String> fruits = new ArrayList<String>();

fruits.add("사과");
fruits.add("배");
fruits.add("바나나");
fruits.add("감");
fruits.add("귤");

pageContext.setAttribute("aFruits", fruits);
%>
<ul>
<c:forEach var="result" items="${aFruits}">
    <li>${result }</li>
</c:forEach>

</ul>

<%
pageContext.setAttribute("names", "홍길동, 홍길순, 홍길이");
%>

<ul>
<c:forEach var="nameResult" items="${names}">
    <li>${nameResult}</li>
</c:forEach>
</ul>

<!-- redirect 사용 예 -->
<c:redirect url="Exam11_jstl_param.jsp">
    <c:param name="name" value="홍길동"/>
</c:redirect>

<hr/>


</body>
</html>