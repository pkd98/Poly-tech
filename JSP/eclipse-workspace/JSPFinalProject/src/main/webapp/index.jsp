<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>최종 과제</title>
<!-- CSS only -->
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<style>
body {
	display: flex;
	flex-direction: column;
	justify-content: center;
	align-items: center;
	height: 100vh;
	background-color: #f8f9fa;
}

h1, h3 {
	margin-bottom: 30px;
}

.button {
	margin-top: 20px;
}
</style>
</head>
<body>
	<div class="container text-center">
		<h1>[MVC model 2] JSP, Servlet 게시판 만들기</h1>
		<h3>박경덕</h3>
		<button class="btn btn-primary button" onclick="goToMain()">메인으로</button>
	</div>

	<script>
		function goToMain() {
			window.location.href = "main.do";
		}
	</script>
</body>
</html>
