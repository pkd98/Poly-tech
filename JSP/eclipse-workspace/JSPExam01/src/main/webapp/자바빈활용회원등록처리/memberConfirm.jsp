<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<jsp:useBean id="member" class="bean.Member" scope="application" />

	<h1>회원 정보 확인</h1>
	<p>
		<jsp:getProperty name="member" property="id" />
	</p>
	<p>
		<jsp:getProperty name="member" property="pw" />
	</p>
	<p>
		<jsp:getProperty name="member" property="name" />
	</p>
	<p>
		<jsp:getProperty name="member" property="email" />
	</p>
</body>
</html>