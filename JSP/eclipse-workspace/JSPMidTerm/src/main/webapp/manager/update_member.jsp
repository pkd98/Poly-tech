<%@page import="com.pkd.repository.MemberDTO"%>
<%@page import="com.pkd.repository.MemberRepository"%>
<%@page import="com.pkd.repository.MemberRepositoryImpl"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title></title>
<link rel="stylesheet" type="text/css" href="../css/style.css">
<style>
form {
	width: 300px;
	margin: 0 auto;
}

.input-group {
	margin-bottom: 10px;
}

.input-group label {
	display: block;
}

.input-group input[type="text"], .input-group input[type="password"],
	input[type="email"] {
	padding: 5px;
	box-sizing: border-box;
}

.input-group input[type="submit"] {
	padding: 5px 10px;
	background-color: #4CAF50;
	color: white;
	border: none;
	cursor: pointer;
}
</style>
</head>
<body>
	<%
	// 세션 != null, role = user
	if (session != null) {
	    if (session.getAttribute("id") != null) {
	        // 세션은 있는데 유저일 경우 관리자 페이지로 리다이렉트
	        if (!((String) session.getAttribute("role")).equals("manager")) {
	    response.sendRedirect("../index.html");
	        }
	    } else {
	        response.sendRedirect("../index.html");
	    }
	} else {
	    // 세션 없을 경우 로그인 페이지로
	    response.sendRedirect("../login.jsp");
	}



	String id = request.getParameter("id");
	MemberRepository memberRepository = new MemberRepositoryImpl();
	MemberDTO dto = memberRepository.findByMember(id);
	%>
	<div class="container">

		<h1>회원 상세 수정</h1>

		<form action="../ManagerModifyController" method="post">
			<div class="input-group">
				<label>아이디 : <%=dto.getId()%></label> <input type="hidden" name="id"
					value="<%=dto.getId()%>" />
			</div>
			<input type="hidden" name="pw" value="<%=dto.getPw()%>" />
			<div class="input-group">
				<label>이름 : <%=dto.getName()%></label> <input type="hidden"
					name="name" value="<%=dto.getName()%>" />
			</div>
			<div class="input-group">
				<label>휴대전화 : 010-XXXX-XXXX</label> <input type="hidden" name="phone"
					value="<%=dto.getPhone()%>" pattern="[0-9]{3}-[0-9]{4}-[0-9]{4}" />
			</div>
			<div class="input-group">
				<label>이메일</label> <input type="email" name="email"
					value="<%=dto.getEmail()%>" />
			</div>
			<div class="input-group">
				<label>상태</label> <input type="radio" name="status" value="waiting"
					<%=dto.getStatus().equals("waiting") ? "checked" : ""%>> 대기
				<input type="radio" name="status" value="normal"
					<%=dto.getStatus().equals("normal") ? "checked" : ""%>> 정상
				<input type="radio" name="status" value="pause"
					<%=dto.getStatus().equals("pause") ? "checked" : ""%>> 정지
			</div>
			<div class="input-group">
				<label>역할</label> <input type="radio" name="role" value="user"
					<%=dto.getRole().equals("user") ? "checked" : ""%>> 사용자 <input
					type="radio" name="role" value="manager"
					<%=dto.getRole().equals("manager") ? "checked" : ""%>> 관리자
			</div>
			<div class="input-group">
				<label>탈퇴요청</label> <input type="radio" name="withdraw" value="F"
					<%=dto.getWithdraw().equals("F") ? "checked" : ""%>> False
				<input type="radio" name="withdraw" value="T"
					<%=dto.getWithdraw().equals("T") ? "checked" : ""%>> True
			</div>
			<div class="input-group">
				<input type="submit" value="수정" />
			</div>
		</form>
	</div>

</body>
</html>
