<%@page import="java.util.ArrayList"%>
<%@page import="dao.BoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String categoryName = request.getParameter("categoryName"); // 입력하는 게시물의 카테고리 받아오기
	BoardDao boardDao = new BoardDao(); // 메서드 사용을 위한 객체 생성
	ArrayList<String> insertList = boardDao.selectCategory(categoryName); // 카테고리 목록을 보여주는 메서드 실행 후 ArrayList<String>에 저장

%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>insertBoardForm</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
	<div class="container bg-dark">
		<jsp:include page="/inc/upMenu.jsp"></jsp:include>
		<div class="text-center bg-dark text-white">
			<h1>글쓰기</h1>
		</div>
		<form method="post" action="<%=request.getContextPath()%>/board/insertBoardAction.jsp">
			<table class="table table-dark text-white table-borderless table-striped">
				<tr>
					<td class="text-center">카테고리</td>
					<td>
						<select name="categoryName" class="form-select text-center">
							<%
								for(String s : insertList) {
							%>
									<option value="<%=s%>"><%=s%></option>
							<%		
								}
							%>
						</select>
					</td>				
				</tr>
				<tr>
					<td class="text-center">제목</td>
					<td>
						<input type="text" name="boardTitle" class="form-control">
					</td>
				</tr>
				<tr>
					<td class="text-center">내용</td>
					<td style="vertical-align:middle;">
						<textarea row="5" cols="80" name="boardContent" class="form-control"></textarea>
					</td>
				</tr>
				<tr>
					<td class="text-center">비밀번호</td>
					<td>
					<input type="password" name="boardPw" class="form-control">
					</td>
				</tr>
				<tr>
					<td colspan="2" class="text-center">
						<button type="submit" class="btn btn-primary">작성</button>
					</td>
				</tr>
			</table>
		</form>
	</div>	
</body>
</html>