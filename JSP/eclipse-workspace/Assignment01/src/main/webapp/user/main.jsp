<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="ko">
        <head>
            <meta charset="UTF-8">
            <title></title>
            <link rel="stylesheet" type="text/css" href="../css/style.css">
        </head>
        <body>
            <div class="container">
                <h1>사용자 메인 페이지</h1>
                <div class="button-group">
                    <button class="button" onclick="goToModify()">회원정보수정</button>
                    <button class="button" onclick="withdraw()">회원 탈퇴</button>
                    <button class="button" onclick="goToLogout()">로그아웃</button>
                </div>
            </div>
            <script>
                function goToModify() {
                    window.location.href = "./modify.jsp";
                }

                function withdraw() {
                    window.location.href = "../login.jsp";
                }

                function goToLogout() {
                    window.location.href = "../logout.jsp";
                }
            </script>
        </body>
    </html>