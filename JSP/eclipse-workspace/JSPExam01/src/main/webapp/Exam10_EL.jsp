<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>

${12}
${'name'}
${(10+1-1)/5}
${((1+2) >= 3)?"ŭ":"����"}<br/><hr><br/>

<jsp:useBean id="member" class="bean.Member" scope="page"></jsp:useBean>
<jsp:setProperty property="id" name="member" value="id01"/>
<jsp:setProperty property="pw" name="member" value="1234"/>
<jsp:setProperty property="name" name="member" value="hong-gildong"/>
<jsp:setProperty property="email" name="member" value="test@123.com"/>

���̵� : ${ pageScope.member.id } <br/>
��й�ȣ : ${ pageScope.member.pw } <br/>
�̸� : ${ pageScope.member.name } <br/>
�̸��� : ${ pageScope.member.email } <br/>
<br/><hr><br/>

<% String id = request.getParameter("id");
   String pw = request.getParameter("pw"); %>
id : <%= id %> <br>
pw : <%= pw %> <br>
<br>
${param.id}
${param["pw"]}


</body>
</html>