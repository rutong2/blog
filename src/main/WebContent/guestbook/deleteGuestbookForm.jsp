<%@page import="vo.Guestbook"%>
<%@page import="dao.GuestbookDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 사용자가 삭제할 게시물의 번호와 비밀번호 받아오기
	int guestbookNo = Integer.parseInt(request.getParameter("guestbookNo")); // 사용자가 삭제할 게시물 번호
	GuestbookDao guestbookDao = new GuestbookDao(); // 삭제할 게시물의 번호와 비밀번호를 가져올 메서드를 사용하기 위해 객체 생성
	Guestbook guestbook = new Guestbook(); // 메서드의 반환값을 저장할 객체 생성
	guestbook = guestbookDao.selectGuestbookOne(guestbookNo); // 객체에 메서드 반환값 저장
	
    // 디버깅
    System.out.println("삭제할 게시물 guestbookNo : " + guestbook.getGuestbookNo());
    System.out.println("삭제할 게시물 guestbookPw : " + guestbook.getGuestbookPw());
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>deleteGuestbookForm</title>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
</head>
<body>
	<div class="container">
		<jsp:include page="/inc/upMenu.jsp"></jsp:include>
		<br>
		<h1>
			<div class="text-center">방명록 삭제</div>
		</h1>
		<form method="post" action="<%=request.getContextPath()%>/guestbook/deleteGuestbookAction.jsp">
			<table class="table table-bordered text-center table-striped">
				<tr>
					<td>번호</td>
					<td><input class="text-center" type="text" name="guestbookNo" value="<%=guestbook.getGuestbookNo()%>" readonly="readonly"></td>
					<td>비밀번호</td>
					<td><input type="password" name="guestbookPw" value=""></td>
				</tr>
				<tr>
					<td colspan="4"><button type="submit" class="btn btn-warning float-right">삭제</button></td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>