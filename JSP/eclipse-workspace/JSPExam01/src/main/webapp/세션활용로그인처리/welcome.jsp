<%@page import="java.util.Enumeration"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>

	<%
	String sessionId = (String) session.getAttribute("id");

	if (sessionId == null) {
	    out.println("비정상 접근");
	} else {
	    out.println(sessionId + "님 반갑습니다.<br/><br/>");
	}
	%>

	<a href="logout.jsp">로그아웃</a>

</body>
</html>