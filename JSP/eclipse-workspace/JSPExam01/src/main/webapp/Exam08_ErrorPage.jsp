<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<%@ page isErrorPage="true"%>

	<%
	response.setStatus(200);
	%>
	<p>
		���� ���� :
		<%=exception.getClass().getName()%>
	</p>
	<p>
		���� �޽��� :
		<%=exception.getMessage()%>
	</p>
	<p>
		���� ����, �޽��� :
		<%=exception.toString()%>-
	</p>
</body>
</html>