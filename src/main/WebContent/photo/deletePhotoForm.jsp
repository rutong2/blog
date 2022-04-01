<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 삭제할 사진의 번호와 비밀번호 받아오기
	int photoNo = Integer.parseInt(request.getParameter("photoNo"));
	String photoPw = request.getParameter("photoPw");

	// 디버깅
	System.out.println("삭제할 photoNo : " + photoNo);
	System.out.println("삭제할 photoPw : " + photoPw);
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>deletePhotoForm</title>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
</head>
<body>
	<div class="container bg-dark">
		<jsp:include page="/inc/upMenu.jsp"></jsp:include>
		<h1>
			<div class="text-center text-white">이미지 삭제</div>
		</h1>
		<form method="post" action="<%=request.getContextPath()%>/photo/deletePhotoAction.jsp">
			<table class="table table-bordered text-center table-striped table-dark">
				<tr>
					<td>번호</td>
					<td><input class="text-center" type="text" name="photoNo" value="<%=photoNo%>" readonly="readonly"></td>
					<td>비밀번호</td>
					<td><input type="password" name="photoPw" value=""></td>
				</tr>
				<tr>
					<td colspan="4">
						<button type="submit" class="btn btn-danger float-right">삭제</button>
					</td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>