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
		에러 유형 :
		<%=exception.getClass().getName()%>
	</p>
	<p>
		에러 메시지 :
		<%=exception.getMessage()%>
	</p>
	<p>
		에러 유형, 메시지 :
		<%=exception.toString()%>-
	</p>
</body>
</html>