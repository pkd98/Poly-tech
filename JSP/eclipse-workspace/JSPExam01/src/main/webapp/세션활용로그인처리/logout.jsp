

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
	    out.println("잘못된 접근입니다.");
	}
	%>
</body>
</html>