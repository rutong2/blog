<%@page import="java.util.ArrayList"%>
<%@page import="java.util.HashMap"%>
<%@page import="vo.Board"%>
<%@page import="dao.BoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	int boardNo = Integer.parseInt(request.getParameter("boardNo")); // 상세보기 할 게시물의 번호 받아오기
	BoardDao boardDao = new BoardDao(); // 메서드 사용을 위한 객체 생성
	Board board = boardDao.selectBoardOne(boardNo); // 정보를 상세보기 해주는 메서드 사용 후 객체에 저장
	String categoryName = request.getParameter("categoryName");
	ArrayList<HashMap<String, Object>> categoryList = boardDao.boardListByCategoryPage(categoryName);
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>boardOne</title>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
</head>
<body>
	<div class="container">
		<jsp:include page="/inc/upMenu.jsp"></jsp:include>
		<br>
		<h1>
			<div class="text-center">
				상세보기
			</div>
		</h1>
		<br>
		<div class="row">
	  		<div class="col-sm-2">
	  			<table class="table table-bordered text-center table-striped">
	  				<tr class="bg-warning">
	  					<td>카테고리</td>
	  				</tr>
	  				<tr>
	  					<td>
								<%
									for(HashMap<String, Object> m : categoryList) {
								%>
										<h5><a href="<%=request.getContextPath()%>/board/boardList.jsp?categoryName=<%=m.get("categoryName")%>"><%=m.get("categoryName")%> <span class="badge badge-pill badge-warning"><%=m.get("cnt")%></span></a></h5>
								<%		
									}
								%>
						</td>
					</tr>
				</table>
	  		</div>
	  		<div class="col-sm-10">
		  		<table class="table table-bordered text-center table-bordered table-striped">
					<tr>
						<td width=150>번호</td>
						<td><%=board.getBoardNo()%></td>
					</tr>
					<tr>
						<td>카테고리</td>
						<td><%=board.getCategoryName()%></td>
					</tr>
					<tr>
						<td>제목</td>
						<td><%=board.getBoardTitle()%></td>
					</tr>
					<tr>
						<td>내용</td>
						<td><%=board.getBoardContent()%></td>
					</tr>
					<tr>
						<td>생성 날짜</td>
						<td><%=board.getCreateDate()%></td>
					</tr>
					<tr>
						<td>업데이트 날짜</td>
						<td><%=board.getUpdateDate()%></td>
					</tr>
				</table>
				<div>
					<a href="<%=request.getContextPath()%>/board/deleteBoardForm.jsp?boardNo=<%=board.getBoardNo()%>" class="btn btn-warning float-right">삭제</a>
					<a href="<%=request.getContextPath()%>/board/updateBoardForm.jsp?boardNo=<%=board.getBoardNo()%>" class="btn btn-warning float-right">수정</a>
				</div>
	  		</div>
	  	</div>
	</div>
</body>
</html>