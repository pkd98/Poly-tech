<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>

<p> <%= session.getAttribute("name") %>님 안녕하세요<br><br> </p>

<a href="modify.jsp">정보수정</a>
<a href="logout.jsp">로그아웃</a>

</body>
</html>