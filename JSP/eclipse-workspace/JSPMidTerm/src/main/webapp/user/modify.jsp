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
	<%
	// 세션 != null, role = user
	if (session != null) {
	    // 세션은 있는데 관리자일 경우 관리자 페이지로 리다이렉트
	    if (!((String) session.getAttribute("role")).equals("user")) {
	        response.sendRedirect("../manager/main.jsp");
	    }
	} else {
	    // 세션 없을 경우 로그인 페이지로
	    response.sendRedirect("../login.jsp");
	}
	%>
    <div class="container">
        <h1>회원 정보 수정</h1>
          <form action="../MemberModifyController" method="POST">
			    <label for="id">아이디:</label>
			    <input type="text" id="id" name="id" value="<%= session.getAttribute("id") %>" readonly><br><br>
			    <label for="name">이름:</label>
			    <input type="text" id="name" name="name" value="<%= session.getAttribute("name") %>" readonly><br><br>
			    <label for="pw">새 비밀번호:</label>
			    <input type="password" id="pw" name="pw" required><br><br>
			
			     <label for="phone">새 휴대전화:</label>
                <input type="text" id="phone" name="phone" pattern="[0-9]{3}-[0-9]{4}-[0-9]{4}" value="<%= session.getAttribute("phone") %>" required><br><br>
			     
			    <label for="email">새 이메일:</label>
			    <input type="email" id="email" name="email" value="<%= session.getAttribute("email") %>" required><br><br>
			
			    <input type="submit" value="정보 수정">
            </form>
    </div>
</body>
</html>