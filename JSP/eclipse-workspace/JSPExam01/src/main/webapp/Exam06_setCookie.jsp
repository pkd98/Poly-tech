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
	Cookie cookie = new Cookie("name", "pkd");
	cookie.setMaxAge(1800); // 3분
	response.addCookie(cookie);
	
	out.println(cookie.getMaxAge());
	
	%>

    <a href="Exam06_getCookie.jsp">쿠키 보기 </a>
    

</body>
</html>