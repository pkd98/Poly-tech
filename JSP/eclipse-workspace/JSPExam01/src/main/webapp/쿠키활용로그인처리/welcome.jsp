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
	    out.println("������ ����");
	} else {
	    for (int i = 0; i < cookies.length; i++) {
	        if (cookies[i].getName().equals("id") || cookies[i].getValue().equals(id)) {
	    out.println(cookies[i].getValue() + "�� �ݰ����ϴ�.<br/><br/>");
	    state = true;
	        }
	    }
	    if (!state) {
	        out.println("������ ����");
	    }
	}
	%>

	<a href="logout.jsp">�α׾ƿ�</a>

</body>
</html>