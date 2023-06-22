<%@page import="java.util.List"%>
<%@page import="member.Member"%>
<%@page import="member.JdbcMemberRepository"%>
<%@page import="member.MemberRepository"%>
<%@ page import="oracle.jdbc.OracleDriver" %>
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
	MemberRepository memberRepository = new JdbcMemberRepository();
	Member member = new Member();
	
	member.setId(request.getParameter("id"));
	member.setPw(request.getParameter("pw"));
	member.setName(request.getParameter("name"));
	member.setEmail(request.getParameter("email"));
	
	memberRepository.save(member);
	response.sendRedirect("memberView.jsp");
	%>



</body>
</html>