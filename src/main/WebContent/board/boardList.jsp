<%@page import="dao.BoardDao"%>
<%@page import="vo.Board"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>

<%
	BoardDao boardDao = new BoardDao(); // 메서드 사용을 위한 객체 생성
	Board board = new Board(); // 객체 생성
	
	// boardList페이지 실행 시 최근 10개의 게시물을 보여줌 (1페이지로 설정)
	int currentPage = 1; // 현재 페이지의 기본값 -> 1페이지
	
	if(request.getParameter("currentPage") != null) { // 이전 또는 다음 버튼을 눌러서 들어왔을때
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	System.out.println("currentPage : " + currentPage);
	
	String categoryName = request.getParameter("categoryName"); // 카테고리 받아오기
	// 페이지가 바뀔때 데이터도 변해야 함
	/*
		알고리즘
		SELECT .... LIMIT 0, 10
		
		currentPage	beginRow
		1			0
		2			10
		3			20
		4			30
		? <-- (currentPage-1)*10
	*/
	int rowPerPage = 10; // 내가 보고싶은 페이지의 갯수
	int beginRow = (currentPage-1) * rowPerPage; // 페이지 알고리즘 -> 1page : LIMIT 0, 10 2page : LIMIT 10, 10 ...

	
	ArrayList<HashMap<String, Object>> categoryList = boardDao.boardListByCategoryPage(categoryName); // 카테고리별 목록을 보여주는 메서드를 이용해 ArrayList<HashMap<String, Object>>에 저장
	ArrayList<Board> list = boardDao.selectBoardListByPage(beginRow, rowPerPage, categoryName); // 카테고리별로 정보를 보여주는 메서드

 	int lastPage = 0; // 마지막 페이지
 	int totalRow = 0; // 총 행의 갯수
 	
 	if(categoryName == null) { // 사용자가 카테고리를 선택하지 않았을때
 		totalRow = boardDao.selectBoardTotalRow(); // 카테고리와 상관없이 모든 행의 갯수 저장
 	} else { // 사용자가 카테고리를 선택했을때
 		totalRow = boardDao.selectCategoryTotalRow(categoryName); // 카테고리별 행의 갯수 저장
 	}
 	
 	System.out.println("totalRow : " + totalRow); // 디버깅
 	if(totalRow % rowPerPage == 0) {
 		lastPage = totalRow / rowPerPage; // ex) 총 10개의 게시물을 5개씩 출력했을때는 2페이지로 다 표현이 되므로 lastPage = totalRow / rowPerPage로 가능
 	} else {
 		lastPage = (totalRow / rowPerPage) + 1; // ex) 총 11개의 게시물을 5개씩 출력했을때는 2페이지로 다 표현이 안되므로 +1Page 추가
 	}
 	
 	System.out.println("lastPage : " + lastPage); // 디버깅
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>boardList</title>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
</head>
<body>
	<div class="container">
		<jsp:include page="/inc/upMenu.jsp"></jsp:include>
			<br>
			<div class="text-center">
				<%
					if(request.getParameter("categoryName") == null) { // 사용자가 아직 카테고리를 선택하지 않았을때
				%>
						<h1>게시판 <span class="badge badge-pill badge-warning"><%=totalRow%></span></h1> 
				<%
					} else { // 사용자가 카테고리를 선택했을때
				%>
						<h1><%=categoryName%></h1> 
				<%
					}
				%>
			</div>
		<div class="float-right badge badge-pill badge-warning">
			<%=currentPage%> / <%=lastPage%> Page
		</div>
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
	 			<table class="table table-bordered text-center table-striped">
					<thead class="bg-warning">
						<tr>
							<th>카테고리</th>
							<th>제목</th>
							<th>생성 날짜</th>
						</tr>
					</thead>
					<tbody>
						<%
							for(Board b : list) {
						%>
								<tr>
									<td><%=b.getCategoryName()%></td>
									<!-- request.getContextPath() -> /blog -->
									<td><a href="<%=request.getContextPath()%>/board/boardOne.jsp?boardNo=<%=b.getBoardNo()%>"><%=b.getBoardTitle()%></a></td>
									<td><%=b.getCreateDate()%></td>
								</tr>
						<%
							}
						%>
					</tbody>
				</table>
	 		</div>
		</div>
		<div class="row">
			<div class="col-sm-7">
				<div>
					<ul class="pagination float-right">
						<%
							if(currentPage > 1) { // 현재 페이지가 1이면 이전페이지가 나오면 안됨
								if(categoryName == null) {
						%>
									<li class="page-item"><a class="page-link float-left badge badge-pill badge-warning" href="<%=request.getContextPath()%>/board/boardList.jsp?currentPage=<%=currentPage-1%>">이전</a>
						<%
								} else {
						%>
									<li class="page-item"><a class="page-link float-left badge badge-pill badge-warning" href="<%=request.getContextPath()%>/board/boardList.jsp?currentPage=<%=currentPage-1%>&categoryName=<%=categoryName%>">이전</a>
						<%
								}			
							}
						%>
						
						<!-- 
							전체 행	마지막 페이지 
							1~10	1
							11~20	2
							21~30	3
							31~40	4
							
							마지막 페이지 = (전체행 / rowPerPage) + 1
							
						 -->
						 <%
						 	if(currentPage < lastPage) {
						 		if(categoryName == null) {
						 %>		
						 			<li class="page-item"><a class="page-link float-left badge badge-pill badge-warning" href="<%=request.getContextPath()%>/board/boardList.jsp?currentPage=<%=currentPage+1%>">다음</a></li>
						 <%
						 		} else {
						 %>			
						 			<li class="page-item"><a class="page-link float-left badge badge-pill badge-warning" href="<%=request.getContextPath()%>/board/boardList.jsp?currentPage=<%=currentPage+1%>&categoryName=<%=categoryName%>">다음</a></li>
						 				
						 <%			
						 		}	
						 	}
						 %>
					</ul>
				</div>
			</div>
			<div class="col-sm-5">
				<a href="<%=request.getContextPath()%>/board/insertBoardForm.jsp?boardNo=<%=board.getBoardNo()%>" class="btn btn-warning float-right">글쓰기</a>
			</div>
		</div>
	</div>	
</body>
</html>