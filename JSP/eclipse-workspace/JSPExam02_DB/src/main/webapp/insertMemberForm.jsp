<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
  <title>User Registration Form</title>
</head>
<body>
  <h2>User Registration</h2>
  <form action="memberService.jsp" method="POST">
    <label for="id">ID:</label>
    <input type="text" id="id" name="id" required><br><br>

    <label for="pw">Password:</label>
    <input type="password" id="pw" name="pw" required><br><br>

    <label for="name">Name:</label>
    <input type="text" id="name" name="name" required><br><br>

    <label for="email">Email:</label>
    <input type="email" id="email" name="email" required><br><br>

    <input type="submit" value="Submit">
  </form>
</body>
</html>
