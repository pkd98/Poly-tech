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
	    out.println("��Ű ����");
	} else {
	    for (int i = 0; i < cookies.length; i++) {
	        out.println("��Ű�� : " + cookies[i].getName() + "<br/>");
	        out.println(" �� : " + cookies[i].getValue() + "<br/>");
	        out.println("��ȿ�Ⱓ : " + cookies[i].getMaxAge() + "�� <br/>");
	        out.println("<br/><br/>");
	    }
	}
	%>

	<a href="Exam06_setCookie.jsp">��Ű ���� </a>
	<a href="Exam06_delCookie.jsp"> ��Ű ����</a>


</body>
</html>