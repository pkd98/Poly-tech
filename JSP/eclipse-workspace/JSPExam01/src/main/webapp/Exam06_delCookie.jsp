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
	Cookie[] cookies = request.getCookies();

	if (cookies != null) {
	    for (Cookie cookie : cookies) {
	        cookie.setMaxAge(0); // ��Ű ������ 0���� �����Ͽ� ����
	        response.addCookie(cookie);
	    }
	}
	
	%>

	<a href="Exam06_getCookie.jsp">��Ű ���� </a>

</body>
</html>