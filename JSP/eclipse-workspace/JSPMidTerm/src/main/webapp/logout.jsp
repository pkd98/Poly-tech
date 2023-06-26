<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title></title>
<link rel="stylesheet" type="text/css" href="./css/style.css">
</head>
<body>
	<div class="container">
		<%
		if (session != null) {
			// 세션 종료
			session.invalidate();
		}

		out.println("로그아웃 되었습니다.");
		%>

		<div class="button-group">
			<button class="user-button" onclick="goToIndex()">처음으로</button>
		</div>
	</div>
	<script>
		function goToIndex() {
			window.location.href = "index.html";
		}
	</script>
</body>
</html>
</body>
</html>