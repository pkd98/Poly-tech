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
	    out.println("������ ����");
	} else {
	    out.println(sessionId + "�� �ݰ����ϴ�.<br/><br/>");
	}
	%>

	<a href="logout.jsp">�α׾ƿ�</a>

</body>
</html>