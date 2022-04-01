<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	int boardNo = Integer.parseInt(request.getParameter("boardNo")); // 삭제할 게시물의 번호 받아오기
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>deleteBoardForm</title>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
</head>
<body>
	<div class="container bg-dark">
		<jsp:include page="/inc/upMenu.jsp"></jsp:include>
		<h1>
			<div class="text-center bg-dark text-white">삭제 페이지</div>
		</h1>
		<br>
		<form method="post" action="<%=request.getContextPath()%>/board/deleteBoardAction.jsp">
			<table class="table table-dark text-white table-borderless table-striped">
				<tr class="table-sm">
					<td class="float-right">게시물 번호 : </td>
					<td><input class="text-center" type="text" name="boardNo" value=<%=boardNo%> readonly="readonly"></td>
					<td class="float-right">비밀번호 : </td>
					<td><input type="password" name="boardPw"></td>
				</tr>
				<tr>
					<td colspan="4"><button type="submit" class="btn btn-danger float-right">삭제</button></td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>