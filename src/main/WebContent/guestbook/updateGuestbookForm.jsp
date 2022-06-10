<%@page import="vo.Guestbook"%>
<%@page import="dao.GuestbookDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	//사용자가 수정하기 전 게시물의 정보 받아오기
	int guestbookNo = Integer.parseInt(request.getParameter("guestbookNo")); // 사용자가 수정할 게시물 번호
	GuestbookDao guestbookDao = new GuestbookDao(); // 수정하기 전 정보를 가져오는 메서드를 사용하기 위한 객체 생성
	Guestbook guestbook = guestbookDao.selectGuestbookOne(guestbookNo); // selectGuestbookOne메서드는 객체를 반환하므로 Guest객체에 저장
	
	// 디버깅
	System.out.println("guestbookNo : " + guestbook.getGuestbookNo());
	System.out.println("수정 전 guestbookContent : " + guestbook.getGuestbookContent());
	System.out.println("guestbookPw : " + guestbook.getGuestbookPw());
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>updateGuestbookForm</title>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
</head>
<body>
	<div class="container">
		<jsp:include page="/inc/upMenu.jsp"></jsp:include>
		<br>
		<h1>
			<div class="text-center">방명록 수정</div>
		</h1>
		<form method="post" action="<%=request.getContextPath()%>/guestbook/updateGuestbookAction.jsp">
			<table class="table text-center table-striped">
				<tr>
					<td>번호</td>
					<td><input class="text-center" type="text" name="guestbookNo" value="<%=guestbook.getGuestbookNo()%>" readonly="readonly"></td>
					<td>비밀번호</td>
					<td><input type="password" name="guestbookPw" value=""></td>
				<tr>
				<tr>
					<td colspan="4"><textarea name="guestbookContent" rows="2" cols="120"><%=guestbook.getGuestbookContent()%></textarea></td>
				</tr>
			</table>
			<div>
				<button type="submit" class="btn btn-warning float-right">수정</button>
			</div>
		</form>
	</div>
</body>
</html>