<%@page import="java.util.*"%>
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
	Enumeration enumeration = session.getAttributeNames();

	while (enumeration.hasMoreElements()) {
	    String name = enumeration.nextElement().toString();
	    String value = session.getAttribute(name).toString();

	    out.println("세션명 : " + name + "<br/>");
	    out.println("세션값 : " + value + "<br/>");
	    out.println("유효기간 : " + session.getMaxInactiveInterval() + "<br/><br/>");
	}
	%>


	<a href="Exam07_setSession.jsp"> 세션 생성 </a>
	<a href="Exam07_delSession.jsp"> 세션 삭제</a>

</body>
</html>