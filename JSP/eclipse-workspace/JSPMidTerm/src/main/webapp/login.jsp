<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title></title>
<link rel="stylesheet" type="text/css" href="./css/style.css">

<style>
body {
	font-family: Arial, sans-serif;
}

form {
	width: 300px;
	margin: 0 auto;
	padding: 30px;
	border: 1px solid #f1f1f1;
	border-radius: 5px;
	box-shadow: 0px 0px 10px 2px #f1f1f1;
}

label {
	display: block;
	margin-bottom: 5px;
}

input[type="text"], input[type="password"] {
	width: 100%;
	padding: 10px;
	margin-bottom: 20px;
	box-sizing: border-box;
	border: 1px solid #ccc;
	border-radius: 4px;
}

button {
	padding: 10px;
	width: 100%;
	color: white;
	background-color: #4CAF50;
	border: none;
	cursor: pointer;
	border-radius: 4px;
}
</style>

</head>
<body>
	<%
	// 세션 아이디가 있고, role에 따라 리다이렉트 처리
	if (session != null) {
	    if (session.getAttribute("id") != null) {
	        // out.println(session.getAttribute("id"));
	        if (((String) session.getAttribute("role")).equals("user")) {
	    response.sendRedirect("./user/main.jsp");
	        } else if (((String) session.getAttribute("role")).equals("manager")) {
	    response.sendRedirect("./manager/main.jsp");
	        }
	    }
	}
	%>
	<div class="container">
		<h2>로그인</h2>


		<form action="LoginController" method="POST">
			<label for="username"> 아이디: </label> <input type="text" id="id"
				name="id" required><br /> <label for="password">비밀번호:</label>
			<input type="password" id="pw" name="pw" required><br /> <br />

			<button class="admin-button" type="submit">로그인</button>
		</form>
	</div>
</body>
</html>