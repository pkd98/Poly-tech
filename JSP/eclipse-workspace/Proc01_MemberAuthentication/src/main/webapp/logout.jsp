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
	if (session != null) {
	    // ���� ����
	    session.invalidate();
	}

	out.println("�α׾ƿ� �Ǿ����ϴ�.");
	%>

</body>
</html>