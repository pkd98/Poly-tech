<%@page import="com.pkd.board.domain.Board"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>하나 게시판</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<style>
h1 {
	font-family: 'Roboto', sans-serif;
	text-align: center;
}

table {
	text-align: center;
}
</style>
</head>
<body>
<h1 class="mt-5">하나 게시판</h1>
<%
List<Board> boardList = (List<Board>) request.getAttribute("allArticleList");
int perPage = 10;
int currentPage =
        request.getParameter("page") == null ? 1 : Integer.parseInt(request.getParameter("page"));
int start = (currentPage - 1) * perPage;
int end = Math.min(boardList.size(), start + perPage);
int totalPages = (int) Math.ceil((double) boardList.size() / perPage);
%>
<div class="container mt-5">
    <form id="deleteForm" action="delete.do" method="POST">
        <table class="table table-striped">
            <thead>
                <tr>
                    <th scope="col"><input type="checkbox" id="selectAll"></th>
                    <th scope="col">번호</th>
                    <th scope="col">작성자</th>
                    <th scope="col">제목</th>
                    <th scope="col">작성일</th>
                    <th scope="col">조회수</th>
                </tr>
            </thead>
            <tbody>
                <%
                for (int i = start; i < end; i++) {
                    Board board = boardList.get(i);
                %>
                <tr>
                    <th scope="row"><input type="checkbox" name="selectedIds" value="<%=board.getId()%>"></th>
                    <td><%=board.getId()%></td>
                    <td><%=board.getName()%></td>
					<td>
					    <a href="detail.do?id=<%=board.getId()%>">
					        <% if (board.getTitle().startsWith("RE:")) { %> 
					               <span style="color: red;"><%=board.getTitle()%></span>
					           <% } else { %>
					               <%=board.getTitle()%>
					           <% } %>
					    </a>
					</td>
                    <td><%=board.getCreatedAt()%></td>
                    <td><%=board.getViews()%></td>
                </tr>
                <%
                }
                %>
            </tbody>
        </table>
        <div class="mb-3 text-center">
            <button type="submit" class="btn btn-danger">선택된 글 삭제</button>
            <a href="write.jsp" class="btn btn-primary">글쓰기</a>
        </div>
		<nav aria-label="Page navigation example" class="mt-5">
			<ul class="pagination justify-content-center">
				<li class="page-item <%if (currentPage == 1) {%>disabled<%}%>">
					<a class="page-link" href="?page=<%=currentPage - 1%>">Previous</a>
				</li>
				<%
				for (int i = 1; i <= totalPages; i++) {
				%>
				<li class="page-item <%if (i == currentPage) {%>active<%}%>"><a
					class="page-link" href="?page=<%=i%>"><%=i%></a></li>
				<%
				}
				%>
				<li
					class="page-item <%if (currentPage == totalPages) {%>disabled<%}%>">
					<a class="page-link" href="?page=<%=currentPage + 1%>">Next</a>
				</li>
			</ul>
		</nav>
	</div>
	
<script>
    document.getElementById('selectAll').addEventListener('change', function(event) {
        let checkboxes = document.querySelectorAll('input[type="checkbox"][name="selectedIds"]');
        for(let checkbox of checkboxes) {
            checkbox.checked = event.target.checked;
        }
    });
</script>

</body>
</html>