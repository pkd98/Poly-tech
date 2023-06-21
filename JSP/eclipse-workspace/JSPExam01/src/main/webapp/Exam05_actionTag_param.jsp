<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>

	<jsp:forward page="Exam05_actionTag_include.jsp">
		<jsp:param name="id" value="test" />
		<jsp:param name="passWd" value="1234" />
	</jsp:forward>

</body>
</html>