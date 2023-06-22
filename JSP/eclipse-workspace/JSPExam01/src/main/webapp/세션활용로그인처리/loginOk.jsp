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
	String id = "test";
	String pw = "1234";
	// Member member = new Member("test", "1234");

	String inputId = request.getParameter("id");
	String inputPw = request.getParameter("pw");

	if (id.equals(inputId) && pw.equals(inputPw)) {
	    session.setAttribute("id", inputId);
	    session.setAttribute("pw", inputPw);
	    session.setMaxInactiveInterval(60 * 3); // 3분

	    response.sendRedirect("welcome.jsp?id=" + id + "&pw=" + pw);
	} else {
	    response.sendRedirect("login.jsp");
	}
	%>
</body>
</html>