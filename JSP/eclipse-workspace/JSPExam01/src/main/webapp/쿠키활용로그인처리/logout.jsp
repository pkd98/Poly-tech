<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
    <%
    Cookie[] cookies = request.getCookies();

    if (cookies != null) {
        for (Cookie cookie : cookies) {
            if (cookie.getName().equals("test")) {
        cookie.setMaxAge(0); // 쿠키 수명을 0으로 설정하여 삭제
        response.addCookie(cookie);
        response.sendRedirect("login.jsp");
        break;
            }
        }
        out.println("잘못된 접근입니다.");
    } else {
        out.println("잘못된 접근입니다.");
    }
    %>
</body>
</html>
