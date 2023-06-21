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
	int i = 10;
	String str = "ABCDEF";
	%>

	<%!public int sum(int x, int y) {
        return x + y;
    }%>

	<%
	out.println("i = " + i + "<br />");
	out.println("str = " + str + "<br />");
	out.println("sum = " + sum(1, 9) + "<br />");
	%>

</body>
</html>