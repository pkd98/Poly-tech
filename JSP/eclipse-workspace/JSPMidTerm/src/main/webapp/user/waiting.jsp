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
        <h1>가입 대기 페이지</h1>
        <h2>
            가입 대기 중 입니다. 관리자 승인 처리 후 정상 로그인 됩니다.
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