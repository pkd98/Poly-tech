<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
  <title>Member Information Update</title>
</head>
<body>
  <h2>Member Information Update</h2>
  <form action="ModifyOk" method="POST">
    <label for="id">ID:</label>
    <input type="text" id="id" name="id" value="<%= session.getAttribute("id") %>" readonly><br><br>

    <label for="pw">New Password:</label>
    <input type="password" id="pw" name="pw" required><br><br>

    <label for="name">Name:</label>
    <input type="text" id="name" name="name" value="<%= session.getAttribute("name") %>" required><br><br>

    <label for="email">Email:</label>
    <input type="email" id="email" name="email" value="<%= session.getAttribute("email") %>" required><br><br>

    <input type="submit" value="Update">
  </form>
</body>
</html>
