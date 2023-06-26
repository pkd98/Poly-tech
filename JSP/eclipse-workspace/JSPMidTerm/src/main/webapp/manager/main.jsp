<%@page import="com.pkd.repository.MemberDTO"%>
<%@page import="java.util.*"%>
<%@page import="com.pkd.*"%>
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
</head>
<style>
table {
	width: 100%;
	border-collapse: collapse;
}

th, td {
	border: 1px solid #ddd;
	padding: 8px;
}

th {
	background-color: #f2f2f2;
	text-align: center;
}

tr:nth-child(even) {
	background-color: #f2f2f2;
}

td {
	text-align: center;
}

a {
	color: blue;
}
</style>
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
	%>
	<div class="container">
		<h1>관리자 메인 페이지</h1>
		<h2>
			<%=session.getAttribute("name")%>(관리자)님 환영합니다.
		</h2>
		<div class="button-group">
			<button class="button" onclick="goToLogout()">로그아웃</button>
		</div>
		<div class="container">
			<h3>회원 관리</h3>
			<table border="1" align="center">
				<tr>
					<th>아이디</th>
					<th>비밀번호</th>
					<th>이름</th>
					<th>전화번호</th>
					<th>이메일</th>
					<th>상태</th>
					<th>역할</th>
					<th>탈퇴요청</th>
					<th>수정</th>
				</tr>

				<%
				MemberRepository memberRepository = new MemberRepositoryImpl();

				List<MemberDTO> list = memberRepository.findAll();
				for (MemberDTO dto : list) {
				%>
				<tr>
					<td><%=dto.getId()%></td>
					<td><%=dto.getPw()%></td>
					<td><%=dto.getName()%></td>
					<td>010-XXXX-XXXX</td>
					<td><%=dto.getEmail()%></td>
					<td><%=dto.getStatus()%></td>
					<td><%=dto.getRole()%></td>
					<td><%=dto.getWithdraw()%></td>
					<td><a href="update_member.jsp?id=<%=dto.getId()%>">수정</a></td>
				</tr>
				<%
				}
				%>
			</table>

		</div>

		<div class="container">
			<h3>가입 승인</h3>
			<table border="1" align="center">
				<tr>
					<th>아이디</th>
					<th>비밀번호</th>
					<th>이름</th>
					<th>전화번호</th>
					<th>이메일</th>
					<th>상태</th>
					<th>역할</th>
					<th>탈퇴요청</th>
					<th>가입승인</th>
				</tr>

				<%
				List<MemberDTO> list2 = memberRepository.findByWaitingMember();
				for (MemberDTO dto : list2) {
				%>
				<tr>
					<td><%=dto.getId()%></td>
					<td><%=dto.getPw()%></td>
					<td><%=dto.getName()%></td>
					<td>010-XXXX-XXXX</td>
					<td><%=dto.getEmail()%></td>
					<td><%=dto.getStatus()%></td>
					<td><%=dto.getRole()%></td>
					<td><%=dto.getWithdraw()%></td>
					<td><a href="../MemberStatusController?id=<%=dto.getId()%>&state=1">승인</a></td>
				</tr>
				<%
				}
				%>
			</table>
		</div>

		<div class="container">
			<h3>탈퇴 승인</h3>
			<table border="1" align="center">
				<tr>
					<th>아이디</th>
					<th>비밀번호</th>
					<th>이름</th>
					<th>전화번호</th>
					<th>이메일</th>
					<th>상태</th>
					<th>역할</th>
					<th>탈퇴요청</th>
					<th>탈퇴승인</th>
				</tr>

				<%
				List<MemberDTO> list3 = memberRepository.findByWithdrawRequestMember();
				for (MemberDTO dto : list3) {
				%>
				<tr>
					<td><%=dto.getId()%></td>
					<td><%=dto.getPw()%></td>
					<td><%=dto.getName()%></td>
					<td>010-XXXX-XXXX</td>
					<td><%=dto.getEmail()%></td>
					<td><%=dto.getStatus()%></td>
					<td><%=dto.getRole()%></td>
					<td><%=dto.getWithdraw()%></td>
					<td><a href="../MemberDeleteController?id=<%=dto.getId()%>">승인</a></td>
				</tr>
				<%
				}
				%>
			</table>
		</div>

	</div>
	<script>
		function goToLogout() {
			window.location.href = "../logout.jsp";
		}
	</script>
</body>
</html>