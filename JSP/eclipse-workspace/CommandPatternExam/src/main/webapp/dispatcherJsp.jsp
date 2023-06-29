<%@page import="com.pkd.member.domain.Member"%>
<%@page import="java.util.List"%>
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
List<Member> memberList = (List<Member>) request.getAttribute("memberList");

for(Member member : memberList) {
    out.println(member);
}
memberList.clear();
%>

</body>
</html>