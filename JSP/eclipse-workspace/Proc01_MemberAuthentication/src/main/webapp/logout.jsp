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
	if (session != null) {
	    // 세션 종료
	    session.invalidate();
	}

	out.println("로그아웃 되었습니다.");
	%>

</body>
</html>