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
		if (session.getAttribute("id") != null) {
			// 세션은 있는데 관리자일 경우 관리자 페이지로 리다이렉트
			if (!((String) session.getAttribute("role")).equals("user")) {
				response.sendRedirect("../manager/main.jsp");
			}
		} else {
			response.sendRedirect("../login.jsp");
		}
	} else {
		// 세션 없을 경우 로그인 페이지로
		response.sendRedirect("../login.jsp");
	}
	%>
	<div class="container">
		<h1>사용자 메인 페이지</h1>
		<h2>
			<%=session.getAttribute("name")%>님 환영합니다.
		</h2>
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
			var confirmation = confirm("정말로 탈퇴하시겠습니까?");

			if (confirmation) {
				// 페이지 이동
				window.location.href = "../MemberWithdrawController?id=<%= session.getAttribute("id")%>";
			}
		}

		function goToLogout() {
			window.location.href = "../logout.jsp";
		}
	</script>
</body>
</html>