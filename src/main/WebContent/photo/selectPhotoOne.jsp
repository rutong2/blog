<%@page import="vo.Photo"%>
<%@page import="dao.PhotoDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	int photoNo = Integer.parseInt(request.getParameter("photoNo")); // 사용자가 볼 이미지의 번호 받아오기

	PhotoDao photoDao = new PhotoDao();
	Photo photo = photoDao.selectPhotoOne(photoNo);
	
	// 디버깅
	System.out.println("상세보기 한 이미지 번호 : " + photo.getPhotoNo());
	System.out.println("상세보기 한 이미지 작성자 : " + photo.getWriter());
	System.out.println("상세보기 한 pdf 이름 : " + photo.getPhotoName());
	System.out.println("상세보기 한 이미지 작성날짜 : " + photo.getCreateDate());
	System.out.println("상세보기 한 이미지 업데이트 날짜 : " + photo.getUpdateDate());
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>selectPhotoOne</title>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
</head>
<body>
	<div class="container bg-dark">
		<jsp:include page="/inc/upMenu.jsp"></jsp:include>
		<h1>
			<div class="text-center text-white">상세 페이지</div>
		</h1>
		<table class="table table-bordered text-center table-striped table-dark">
			<tr>
				<td>번호</td>
				<td><%=photo.getPhotoNo()%></td>
				<td>작성자</td>
				<td><%=photo.getWriter()%></td>
			</tr>
			<tr>
				<td colspan="4">
					<img src="<%=request.getContextPath()%>/upload/<%=photo.getPhotoName()%>">
				</td>
			</tr>
			<tr>
				<td>작성날짜</td>
				<td><%=photo.getCreateDate()%></td>
				<td>수정날짜</td>
				<td><%=photo.getUpdateDate()%></td>
			</tr>
			<tr>
				<td colspan="4"><a class = "btn btn-danger float-right" href="<%=request.getContextPath()%>/photo/deletePhotoForm.jsp?photoNo=<%=photo.getPhotoNo()%>">삭제</a></td>
			</tr>
		</table>
	</div>
	
</body>
</html>