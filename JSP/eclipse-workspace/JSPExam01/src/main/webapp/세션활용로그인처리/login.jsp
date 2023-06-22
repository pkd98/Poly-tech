<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>로그인 폼</title>
</head>
<body>
    <h2>로그인</h2>
    <form action="loginOk.jsp" method="POST">
        <div>
            <label for="id">아이디:</label>
            <input type="text" id="id" name="id" required>
        </div>
        <div>
            <label for="pw">비밀번호:</label>
            <input type="password" id="pw" name="pw" required>
        </div>
        <div>
            <input type="submit" value="로그인">
        </div>
    </form>
</body>
</html>
