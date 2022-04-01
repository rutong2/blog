<%@page import="java.util.ArrayList"%>
<%@page import="dao.GuestbookDao" %>
<%@page import="vo.Guestbook" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	int currentPage = 1; // 현재 페이지
	
	if(request.getParameter("currentPage") != null) { // 사용자가 다음이나 이전을 눌렀을때 넘어온 currentPage 값이 null이 아니면
		currentPage = Integer.parseInt(request.getParameter("currentPage")); // currentPage 받아온 값으로 저장
	}

	int rowPerPage = 3; // 내가 보고싶은 정보 갯수
	int beginRow = (currentPage-1)*rowPerPage; // 시작하는 행의 번호
	
	GuestbookDao guestbookDao = new GuestbookDao(); // 메서드 사용을 위한 객체 생성
	ArrayList<Guestbook> list = guestbookDao.selectGuestbookListByPage(beginRow, rowPerPage); // 페이지별로 정보를 보여주는 리스트 메서드 실행 후 ArrayList<Guestbook>에 저장
	
	int lastPage = 0; // 마지막 페이지
	int totalCount = guestbookDao.selectGuestbookTotalRow(); // 총 행의 갯수를 구하는 메서드 실행 후 총 행의 갯수를 저장하는 변수에 저장
	lastPage = (int)(Math.ceil((double)totalCount / (double)rowPerPage)); // Mathi.ceil()메서드는 올림을 해주는 메서드
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>guestbookList</title>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
</head>
<body>
	<div class="container bg-dark">
		<!-- 메인 메뉴 시작 -->
		<!-- include시 컨텍스명(프로젝트명)을 명시하지 않는다 -->
		<jsp:include page="/inc/upMenu.jsp"></jsp:include>
		<!-- 메인 메뉴 끝 -->
		<h1>
			<div class="text-center text-white">방명록</div>
		</h1>
		<div class="float-right">
			<span class="text-white"><%=currentPage%> / <%=lastPage%> Page</span>
		</div>
		<%
			for(Guestbook g : list) {
		%>
			<table class="table table-bordered text-center table-striped table-dark">
				<tr>
					<td><%=g.getWriter()%></td>
					<td><%=g.getCreateDate()%></td>
				</tr>
				<tr>
					<td colspan="2"><%=g.getGuestbookContent()%></td>
				</tr>
			</table>	
			<div>
				<a class = "btn btn-danger float-right" href="<%=request.getContextPath()%>/guestbook/deleteGuestbookForm.jsp?guestbookNo=<%=g.getGuestbookNo()%>">삭제</a>
				<a class = "btn btn-primary float-right" href="<%=request.getContextPath()%>/guestbook/updateGuestbookForm.jsp?guestbookNo=<%=g.getGuestbookNo()%>">수정</a>
			</div>
		<%
			}
		%>
		<ul class="pagination">
		<%
			if(currentPage > 1) {
		%>
				<li class="page-item"><a class="page-link float-left badge badge-pill badge-secondary" href="<%=request.getContextPath()%>/guestbook/guestbookList.jsp?currentPage=<%=currentPage-1%>">이전</a></li>						
		<%	
			}
			
			if(currentPage < lastPage) {
		%>
				<li class="page-item"><a class="page-link float-left badge badge-pill badge-secondary" href="<%=request.getContextPath()%>/guestbook/guestbookList.jsp?currentPage=<%=currentPage+1%>">다음</a></li>					
		<%		
			}
		%>
		</ul>
		<!-- 방명록 입력 -->
		<form method="post" action="<%=request.getContextPath()%>/guestbook/insertGuestbookAction.jsp">
			<table class="table table-bordered text-center table-striped table-dark">
				<tr>
					<td>글쓴이</td>
					<td><input type="text" name="writer"></td>
					<td>비밀번호</td>
					<td><input type="password" name="guestbookPw"></td>
				</tr>
				<tr>
					<td colspan="4"><textarea name="guestbookContent" rows="2" cols="120"></textarea></td>
				</tr>
				<tr>
					<td colspan="4"><button type="submit" class="btn btn-primary float-right">입력</button></td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>