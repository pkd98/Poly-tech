<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<jsp:useBean id="member" class="bean.Member" scope="application" />
	<jsp:setProperty name="member" property="*" />

	<%
	/*
	member.setId(request.getParameter("id"));
	member.setPw(request.getParameter("pw"));
	member.setName(request.getParameter("name"));
	member.setEmail(request.getParameter("email"));
	 */
	response.sendRedirect("memberConfirm.jsp");
	%>

</body>
</html>