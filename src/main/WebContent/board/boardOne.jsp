<%@page import="java.util.ArrayList"%>
<%@page import="java.util.HashMap"%>
<%@page import="vo.Board"%>
<%@page import="dao.BoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	int boardNo = Integer.parseInt(request.getParameter("boardNo")); // 상세보기 할 게시물의 번호 받아오기
	BoardDao boardDao = new BoardDao(); // 메서드 사용을 위한 객체 생성
	Board board = boardDao.selectBoardOne(boardNo); // 정보를 상세보기 해주는 메서드 사용 후 객체에 저장
	ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>(); // 카테고리 목록을 보여주기 위한 ArrayList<HashMap<String, Object>> 객체 생성
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>boardOne</title>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
</head>
<body>
	<div class="container bg-dark">
		<jsp:include page="/inc/upMenu.jsp"></jsp:include>
		<h1>
			<div class="text-center text-white">
				자세히보기
			</div>
		</h1>
		<br>
		<div class="row">
	  		<div class="col-sm-2">
	  			<div>
					<ul>
						<%
							for(HashMap<String, Object> m : list) {
						%>
								<li>
									<h5><a href="<%=request.getContextPath()%>/board/boardList.jsp?categoryName=<%=m.get("categoryName")%>" class="badge badge-pill badge-secondary"><%=m.get("categoryName")%>(<%=m.get("cnt")%>)</a></h5>
								</li>
						<%		
							}
						%>
					</ul>
				</div>
	  		</div>
	  		<div class="col-sm-10">
		  		<table class="table table-bordered table-dark text-center table-bordered table-striped">
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
					<tr>
						<td colspan="2"><a href="<%=request.getContextPath()%>/board/deleteBoardForm.jsp?boardNo=<%=board.getBoardNo()%>" class="btn btn-danger float-right">삭제</a><a href="<%=request.getContextPath()%>/board/updateBoardForm.jsp?boardNo=<%=board.getBoardNo()%>" class="btn btn-primary float-right">수정</a></td>
					</tr>
				</table>
	  		</div>
	  	</div>
	</div>
</body>
</html>