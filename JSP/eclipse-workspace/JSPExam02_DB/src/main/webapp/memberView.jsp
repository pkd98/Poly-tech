<%@page import="java.util.List"%>
<%@page import="member.Member"%>
<%@page import="member.JdbcMemberRepository"%>
<%@page import="member.MemberRepository"%>
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
	List<Member> memberList = memberRepository.selectAll();

	memberList = memberRepository.selectAll();
	for (Member m : memberList) {
	    out.println(m.toString() + "<br/>");
	}
	%>

</body>
</html>