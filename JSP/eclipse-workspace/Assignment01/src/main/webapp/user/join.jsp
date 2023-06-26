<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="ko">
        <head>
            <meta charset="UTF-8">
            <title></title>
            <link rel="stylesheet" type="text/css" href="../css/style.css">
        </head>
        <body>
            <h2>회원가입</h2>
            <form action="../JoinController" method="POST">
                <label for="id">아이디:</label>
                <input type="text" id="id" name="id" required><br><br>

                <label for="pw">비밀번호:</label>
                <input type="password" id="pw" name="pw" required><br><br>

                <label for="name">이름:</label>
                <input type="text" id="name" name="name" required><br><br>

                <label for="phone">휴대전화:</label>
                <input type="tel" id="phone" name="phone" pattern="[0-9]{3}-[0-9]{4}-[0-9]{4}" required><br><br>

                <label for="email">이메일:</label>
                <input type="email" id="email" name="email" required><br><br>

                <input type="submit" value="Submit">
            </form>
        </body>
    </html>