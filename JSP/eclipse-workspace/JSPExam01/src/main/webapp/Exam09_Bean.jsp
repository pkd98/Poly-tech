<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>

	<!-- bean ��� -->
	<jsp:useBean id="student" class="bean.Student" scope="page" />

	<!-- student bean�� name �Ӽ��� pkd ���� -->
	<jsp:setProperty name="student" property="name" value="pkd" />
    <% student.setStudentNumber(123); %>

	<!--  student bnean�� name �Ӽ� �� �������� -->
	<jsp:getProperty name="student" property="name" />
	<%=student.getStudentNumber()%>

</body>
</html>