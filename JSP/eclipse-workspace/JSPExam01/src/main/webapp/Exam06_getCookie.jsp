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

	if (cookies.length == 0) {
	    out.println("쿠키 없음");
	} else {
	    for (int i = 0; i < cookies.length; i++) {
	        out.println("쿠키명 : " + cookies[i].getName() + "<br/>");
	        out.println(" 값 : " + cookies[i].getValue() + "<br/>");
	        out.println("유효기간 : " + cookies[i].getMaxAge() + "초 <br/>");
	        out.println("<br/><br/>");
	    }
	}
	%>

	<a href="Exam06_setCookie.jsp">쿠키 생성 </a>
	<a href="Exam06_delCookie.jsp"> 쿠키 삭제</a>


</body>
</html>