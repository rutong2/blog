<%@page import="vo.Board"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.BoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%	
	// 사용자가 수정할 게시물의 번호 받아오기
	int boardNo = Integer.parseInt(request.getParameter("boardNo"));

	BoardDao boardDao = new BoardDao(); // 메서드를 사용할 객체 생성
	Board board = boardDao.selectBoardOne(boardNo); // 메서드 사용 후 Board객체에 저장
	
	System.out.println("board.getCategoryName() : " + board.getCategoryName()); // 디버깅
	
	ArrayList<String> categoryList = boardDao.selectCategory(board.getCategoryName()); // 카테고리 이름들을 select하는 메서드 실행 후 ArrayList에 저장
	
	for(String s : categoryList) {
		System.out.println(s);
	}
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>updateBoardForm</title>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
</head>
<body>
	<div class="container">
		<jsp:include page="/inc/upMenu.jsp"></jsp:include>
		<br>
		<h1>
			<div class="text-center">게시판 수정</div>
		</h1>
		<br>
		<form method="post" action="<%=request.getContextPath()%>/board/updateBoardAction.jsp">
			<table class="table table-striped">
				<tr>
					<td class="text-center">번호</td>
					<td><input type="text" name="boardNo" value="<%=board.getBoardNo()%>" readonly="readonly"></td>
				</tr>
				<tr>
					<td class="text-center">카테고리</td>
					<td>
						<select name="categoryName">
							<%
								for(String s : categoryList) {
									if(s.equals(board.getCategoryName())) {
							%>
										<!-- 사용자가 게시물을 수정할때 최초에 작성했던 글의 카테고리 이름과 같아야 함 -->
										<option selected="selected" value="<%=board.getCategoryName()%>"><%=board.getCategoryName()%></option>
							<%			
									} else {
							%>
										<option value="<%=s%>"><%=s%></option>
							<%			
									}		
								}
							%>
						</select>
					</td>
				</tr>
				<tr>
					<td class="text-center">제목</td>
					<td><input type="text" name="boardTitle" value="<%=board.getBoardTitle()%>"></td>
				</tr>
				<tr>
					<td class="text-center">내용</td>
					<td>
						<textarea rows="5" cols="50" name="boardContent"><%=board.getBoardContent()%></textarea>
					</td>
				</tr>
				<tr>
					<td class="text-center">비밀번호</td>
					<td><input type="password" name="boardPw" value=""></td>
				</tr>
				<tr>
					<td colspan="2"><button type="submit" class="btn btn-warning float-right">수정</button></td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>