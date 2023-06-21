<%@page import="java.util.Arrays"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
</head>
<body>

	<%
	String name, id, passWd, major, protocol;
	String[] hobby;
	
	request.setCharacterEncoding("utf-8");

	name = request.getParameter("name");
	id = request.getParameter("id");
	passWd = request.getParameter("passWd");
	major = request.getParameter("major");
	protocol = request.getProtocol();
	hobby = request.getParameterValues("hobby");
	%>

	<p>
		이름 : <%= name %>
	</p>
	<p>
		아이디 : <%= id %>
	</p>
	<p>
		비밀번호 : <%= passWd %>
	</p>
	<p>
		취미 : <%= Arrays.toString(hobby) %>
	</p>
	<p>
		전공 : <%= major %>
	</p>
	<p>
		프로토콜 : <%= protocol %>
	</p>
	================================================
	<p>
        이름 : <% out.println(name); %>
    </p>
    <p>
        아이디 : <% out.println(id); %>
    </p>
    <p>
        비밀번호 : <% out.println(passWd); %>
    </p>
    <p>
        취미 : <% out.println(Arrays.toString(hobby)); %>
    </p>
    <p>
        전공 : <% out.println(major); %>
    </p>
    <p>
        프로토콜 : <% out.println(protocol); %>
    </p>
</body>
</html>