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

	    out.println("技记疙 : " + name + "<br/>");
	    out.println("技记蔼 : " + value + "<br/>");
	    out.println("蜡瓤扁埃 : " + session.getMaxInactiveInterval() + "<br/><br/>");
	}
	%>


	<a href="Exam07_setSession.jsp"> 技记 积己 </a>
	<a href="Exam07_delSession.jsp"> 技记 昏力</a>

</body>
</html>