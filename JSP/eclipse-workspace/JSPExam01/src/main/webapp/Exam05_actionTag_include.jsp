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
	String id, passWd;
	id = request.getParameter("id");
	passWd = request.getParameter("passWd");
	%>

	<h1>메인 페이지</h1>
	<jsp:include page="include.jsp" flush="false" />
	<h1>메인 페이지</h1>
<hr>
	<h2>param 테스트</h2>
	id :
	<%=id%>
	pw :
	<%=passWd%>

</body>
</html>