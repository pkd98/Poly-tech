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
	// 복수 개의 다중 세션 만들기
	session.setAttribute("memberId", "user01");
	session.setAttribute("memberPw", "1234");
	session.setMaxInactiveInterval(60 * 60);

	out.println("세션이 생성되었습니다. <br/><br/>");
	%>

	<a href="Exam07_getSession.jsp"> 세션 보기 </a>


</body>
</html>