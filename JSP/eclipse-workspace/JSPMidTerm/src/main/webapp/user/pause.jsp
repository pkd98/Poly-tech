<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title></title>
<link rel="stylesheet" type="text/css" href="../css/style.css">
</head>
<body>
    <div class="container">
        <h1>정지 회원 페이지</h1>
        <h2>
            정지된 회원입니다. 관리자에게 문의하세요!
        </h2>
        <div class="button-group">
            <button class="button" onclick="goToFirst()">처음으로</button>
        </div>
    </div>
    <script>
        function goToFirst() {
            window.location.href = "../index.html";
        }
    </script>
</body>
</html>