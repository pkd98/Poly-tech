<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
	
<!DOCTYPE html>
<html>
<head>
<title>Birth Year Form</title>
</head>
<body>
	<form action="Exam04_request03_실습.jsp" method="post">
		<label for="birthYear">Birth Year:</label> <input type="number"
			id="birthYear" name="birthYear" min="1900" max="2023" required><br>
		<br> <input type="submit" value="Submit">
	</form>
</body>
</html>
