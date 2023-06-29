<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>글쓰기</title>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
</head>
<body>
	<div class="container mt-5">
		<h2 class="mb-4">새 글 작성</h2>

		<form action="write.do" method="POST">
			<div class="form-group">
				<label for="name">이름</label> <input type="text" class="form-control"
					id="name" name="name">
			</div>
			<div class="form-group">
				<label for="title">제목</label> <input type="text"
					class="form-control" id="title" name="title">
			</div>
			<div class="form-group">
				<label for="content">내용</label>
				<textarea class="form-control" id="content" rows="3" name="content"></textarea>
			</div>
			<button type="submit" class="btn btn-primary">등록</button>
		</form>
	</div>
</body>
</html>
