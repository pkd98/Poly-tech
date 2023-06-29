<%@page import="com.pkd.board.domain.Board"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>글 수정하기</title>
<!-- CSS only -->
<link
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
	rel="stylesheet">
</head>
<body>

	<%
	Board board = (Board) request.getAttribute("board");
	%>
	<div class="container mt-5">
		<div class="row">
			<div class="col-md-8 offset-md-2">
				<h2>글 수정하기</h2>
				<form action="edit.do" method="post">
					<input type="hidden" id="id" name="id" value="<%=board.getId()%>">
					<div class="form-group">
						<label for="title">제목</label> <input type="text"
							class="form-control" id="title" name="title"
							value="<%=board.getTitle()%>">
					</div>
					<div class="form-group">
						<label for="content">내용</label>
						<textarea class="form-control" id="content" name="content"
							rows="5"><%=board.getContent()%></textarea>
					</div>
					<div class="mt-3 text-center">
						<input type="submit" class="btn btn-primary" value="수정"> <a
							href="main.do" class="btn btn-secondary">취소</a>
					</div>
				</form>
			</div>
		</div>
	</div>
</body>
</html>