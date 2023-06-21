<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
  <title>User Registration Form</title>
</head>
<body>
  <h2>User Registration</h2>
  <form action="Exam04_request02_실습.jsp" method="POST">
    <label for="name">Name:</label>
    <input type="text" id="name" name="name" required><br><br>

    <label for="username">id:</label>
    <input type="text" id="username" name="id" required><br><br>

    <label for="password">Password:</label>
    <input type="password" id="password" name="passWd" required><br><br>

    <label for="hobby">Hobby:</label><br>
    <input type="checkbox" id="hobby1" name="hobby" value="Reading">
    <label for="hobby1">Reading</label><br>
    <input type="checkbox" id="hobby2" name="hobby" value="Sports">
    <label for="hobby2">Sports</label><br>
    <input type="checkbox" id="hobby3" name="hobby" value="Music">
    <label for="hobby3">Music</label><br><br>

    <label for="major">Major:</label><br>
    <input type="radio" id="major1" name="major" value="이과">
    <label for="major1">이과</label><br>
    <input type="radio" id="major2" name="major" value="문과">
    <label for="major2">문과</label><br><br>

    <input type="submit" value="Submit">
  </form>
</body>
</html>
