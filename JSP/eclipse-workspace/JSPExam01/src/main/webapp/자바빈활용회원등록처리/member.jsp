<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>User Registration Form</title>
</head>
<body>
	<h2>회원 등록</h2>
	<form action="memberProcess.jsp" method="POST">
		<label for="id">id:</label> <input type="text" id="id" name="id"
			required><br> <br> <label for="pw">pw:</label> <input
			type="pw" id="pw" name="pw" required><br> <br> <label
			for="name">Name:</label> <input type="text" id="name" name="name"
			required><br> <br> <label for="email">Email:</label>
		<input type="email" id="email" name="email" required><br>
		<br> <input type="submit" value="Submit">
	</form>
</body>
</html>
