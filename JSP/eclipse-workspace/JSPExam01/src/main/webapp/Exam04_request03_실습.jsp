<%@page import="java.time.LocalDate"%>
<%@page import="java.util.Date"%>
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
	int responseYear = Integer.parseInt(request.getParameter("birthYear"));
	LocalDate now = LocalDate.now();

	if (now.getYear() - responseYear >= 20) {
	    response.sendRedirect("pass.jsp?age=" + (now.getYear() - responseYear));
	} else {
	    response.sendRedirect("notpass.jsp?age=" + (now.getYear() - responseYear));
	}
	%>

</body>
</html>