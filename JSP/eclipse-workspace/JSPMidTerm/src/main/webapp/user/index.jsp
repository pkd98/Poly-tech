<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.HttpSession"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title></title>
<link rel="stylesheet" type="text/css" href="../css/style.css">
<style>
.button-group {
	margin-top: 20px;
}

button {
	padding: 10px 20px;
	font-size: 16px;
	border-radius: 5px;
	border: none;
	color: #fff;
	cursor: pointer;
}

.signup-button {
	background-color: #4caf50;
}

.login-button {
	background-color: #f44336;
	margin-left: 10px;
}

.signup-button:hover, .login-button:hover {
	opacity: 0.8;
}
사용자
</style>
</head>
<body>
	<%
	// 세션 아이디가 있고, role에 따라 리다이렉트 처리
	if (session != null) {
		if (session.getAttribute("id") != null) {
			// out.println(session.getAttribute("id"));
			if (((String) session.getAttribute("role")).equals("user")) {
				response.sendRedirect("main.jsp");
			} else if (((String) session.getAttribute("role")).equals("manager")) {
				response.sendRedirect("../manager/main.jsp");
			}
		}
	}
	%>

	<div class="container">
		<h1>사용자 페이지</h1>
		<div class="button-group">
			<button class="signup-button" onclick="goToJoin()">회원가입</button>
			<button class="login-button" onclick="goToLogin()">로그인</button>
		</div>
	</div>
	<script>
		function goToJoin() {
			window.location.href = "./join.jsp";
		}

		function goToLogin() {
			window.location.href = "../login.jsp";
		}
	</script>

</body>
</html>