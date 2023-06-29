<%@page import="com.pkd.board.domain.Board"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>글 상세 보기</title>
<!-- CSS only -->
<link
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
	rel="stylesheet">
<style>
.content {
	min-height: 500px;
}
</style>
</head>
<body>
	<%
	Board board = (Board) request.getAttribute("board");
	%>
	<div class="container mt-5">
		<div class="row">
			<div class="col-md-8 offset-md-2">
				<div class="card content">
					<div class="card-header">
						<h3><%=board.getTitle()%></h3>
					</div>
					<div class="card-body">
						<h6>
							아이디:
							<%=board.getId()%></h6>
						<h6>
							작성자:
							<%=board.getName()%></h6>
						<h6>
							작성일:
							<%=board.getCreatedAt()%></h6>
						<h6>
							조회수:
							<%=board.getViews()%></h6>
						<hr>
						<p><%=board.getContent()%></p>
					</div>
				</div>
				<div class="mt-3 text-center">
					<a href="goToEdit.do?id=<%=board.getId()%>&title=<%=board.getTitle()%>&content=<%=board.getContent()%>" class="btn btn-warning">수정</a>
					<a href="delete.do?id=<%=board.getId()%>" class="btn btn-danger">삭제</a>
					<a href="reply.jsp?id=<%=board.getId()%>&depth=<%=board.getDepth() %>" class="btn btn-info">답글</a>
					<a href="main.do" class="btn btn-secondary">뒤로가기</a>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
