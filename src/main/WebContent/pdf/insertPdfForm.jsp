<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>insertPdfForm</title>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
</head>
<body>
	<div class="container bg-dark">
		<jsp:include page="/inc/upMenu.jsp"></jsp:include>
		<h1>
			<div class="text-center text-white">PDF 자료 입력</div>
		</h1>
		<form method="post" action="<%=request.getContextPath()%>/pdf/insertPdfAction.jsp" enctype="multipart/form-data">
			<table class="table table-bordered text-center table-striped table-dark">
				<tr>
					<td>PDF 파일</td>
					<td><input type="file" name="pdf"><span style="opacity: 0.5";>(pdf 파일만 가능)</span></td>
				</tr>
				<tr>
					<td>작성자</td>
					<td><input type="text" name="writer"></td>
				</tr>
				<tr>
					<td>비밀번호</td>
					<td><input type="password" name="pdfPw"></td>
				</tr>
				<tr>
					<td colspan="2"><button type="submit" class="btn btn-primary float-right">글쓰기</button></td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>