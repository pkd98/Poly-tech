<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>

	<!-- bean 사용 -->
	<jsp:useBean id="student" class="bean.Student" scope="page" />

	<!-- student bean의 name 속성에 pkd 삽입 -->
	<jsp:setProperty name="student" property="name" value="pkd" />
    <% student.setStudentNumber(123); %>

	<!--  student bnean의 name 속성 값 가져오기 -->
	<jsp:getProperty name="student" property="name" />
	<%=student.getStudentNumber()%>

</body>
</html>