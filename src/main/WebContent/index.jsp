<%@page import="vo.Guestbook"%>
<%@page import="dao.GuestbookDao"%>
<%@page import="vo.Board"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.BoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String categoryName = null;
	BoardDao boardDao = new BoardDao();
	ArrayList<Board> boardList = boardDao.selectBoardListByPage(0, 10, categoryName);
	
	GuestbookDao guestbookDao = new GuestbookDao(); // 메서드 사용을 위한 객체 생성
	ArrayList<Guestbook> guestList = guestbookDao.selectGuestbookListByPage(0, 10); // 페이지별로 정보를 보여주는 리스트 메서드 실행 후 ArrayList<Guestbook>에 저장
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>photoIndex</title>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
</head>
<body>
	<div class="container">
		<jsp:include page="/inc/upMenu.jsp"></jsp:include>
		<br>
		<div class="row">
			<div class="col-sm-6 text-left">
			<h5 class="text-warning"><b>최근 게시글</b><a href="<%=request.getContextPath()%>/board/boardList.jsp" class="btn btn-link text-warning bg-light btn-sm float-right">더보기</a></h5>
			 
				<table class="table table-hover">	
					<%for(Board b : boardList) { %>
						<tr>
							<td>
								<a href="<%=request.getContextPath()%>/board/boardOne.jsp?boardNo=<%=b.getBoardNo()%>" class="text-secondary">
									<b><%=b.getBoardTitle()%></b>
								</a>
							</td>
							<td class="text-right">
								<%=b.getCreateDate()%>
							</td>
						</tr>
					<%}%>
				</table>
			</div>
			<div class="col-sm-6 text-left">
			<h5 class="text-warning"><b>최근 방명록</b><a href="<%=request.getContextPath()%>/guestbook/guestbookList.jsp" class="btn btn-link text-warning bg-light btn-sm float-right">더보기</a></h5>
				<table class="table">	
				<tr>
					<%for(Guestbook g : guestList) {%>
						<td>
							<b><%=g.getWriter()%></b>
						</td>
						<td>
							<b><%=g.getGuestbookContent()%></b>
						</td>
						<td class="text-right">
							<%=g.getCreateDate()%>
						</td>
					<%}%>
				<tr>
				</table>
			</div>
		</div>
	</div>
</div>
</body>
</html>