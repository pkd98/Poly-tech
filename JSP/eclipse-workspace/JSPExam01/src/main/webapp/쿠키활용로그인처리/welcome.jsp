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
	String id = request.getParameter("id");
	String pw = request.getParameter("pw");
	boolean state = false;
	if (cookies.length == 0) {
	    out.println("비정상 접근");
	} else {
	    for (int i = 0; i < cookies.length; i++) {
	        if (cookies[i].getName().equals("id") || cookies[i].getValue().equals(id)) {
	    out.println(cookies[i].getValue() + "님 반갑습니다.<br/><br/>");
	    state = true;
	        }
	    }
	    if (!state) {
	        out.println("비정상 접근");
	    }
	}
	%>

	<a href="logout.jsp">로그아웃</a>

</body>
</html>