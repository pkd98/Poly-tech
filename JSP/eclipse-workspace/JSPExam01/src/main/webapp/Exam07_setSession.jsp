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
	// ���� ���� ���� ���� �����
	session.setAttribute("memberId", "user01");
	session.setAttribute("memberPw", "1234");
	session.setMaxInactiveInterval(60 * 60);

	out.println("������ �����Ǿ����ϴ�. <br/><br/>");
	%>

	<a href="Exam07_getSession.jsp"> ���� ���� </a>


</body>
</html>