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
	    Cookie cookieId = new Cookie("id", id);
	    Cookie cookiePw = new Cookie("pw", pw);

	    cookieId.setMaxAge(1800); // 3분
	    cookiePw.setMaxAge(1800); // 3분

	    response.addCookie(cookieId);
	    response.addCookie(cookiePw);

	    response.sendRedirect("welcome.jsp?id=" + id + "&pw=" + pw);
	} else {
	    response.sendRedirect("login.jsp");
	}
	%>
</body>
</html>