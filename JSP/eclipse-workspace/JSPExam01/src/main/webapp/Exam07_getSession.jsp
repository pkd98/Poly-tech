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

	    out.println("���Ǹ� : " + name + "<br/>");
	    out.println("���ǰ� : " + value + "<br/>");
	    out.println("��ȿ�Ⱓ : " + session.getMaxInactiveInterval() + "<br/><br/>");
	}
	%>


	<a href="Exam07_setSession.jsp"> ���� ���� </a>
	<a href="Exam07_delSession.jsp"> ���� ����</a>

</body>
</html>