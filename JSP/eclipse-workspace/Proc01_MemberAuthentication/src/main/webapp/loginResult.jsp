<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>

<p> <%= session.getAttribute("name") %>�� �ȳ��ϼ���<br><br> </p>

<a href="modify.jsp">��������</a>
<a href="logout.jsp">�α׾ƿ�</a>

</body>
</html>