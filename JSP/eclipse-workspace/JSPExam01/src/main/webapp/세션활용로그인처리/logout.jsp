

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
	if (session != null) {
	    session.invalidate();
	    response.sendRedirect("login.jsp");

	} else {
	    out.println("�߸��� �����Դϴ�.");
	}
	%>
</body>
</html>