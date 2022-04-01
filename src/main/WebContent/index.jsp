<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>photoIndex</title>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
</head>
<body>
	<div class="container bg-dark">
		<jsp:include page="/inc/upMenu.jsp"></jsp:include>
		<h1>
			<div class="text-center text-white">HOME</div>
		</h1>
		<table class="table table-bordered text-center table-striped table-dark">
				<tr>
					<td><a class="text-white" href="<%=request.getContextPath()%>/board/boardList.jsp">게시판</a></td>
				</tr>
				<tr>
					<td><a class="text-white" href="<%=request.getContextPath()%>/guestbook/guestbookList.jsp">방명록</a></td>
				</tr>
				<tr>
					<td><a class="text-white" href="<%=request.getContextPath()%>/photo/photoList.jsp">사진</a></td>
				</tr>
				<tr>
					<td><a class="text-white" href="<%=request.getContextPath()%>/pdf/pdfList.jsp">PDF자료실</a></td>
				</tr>
		</table>
	</div>
</body>
</html>