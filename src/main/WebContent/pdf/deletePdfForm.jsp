<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	int pdfNo = Integer.parseInt(request.getParameter("pdfNo")); // 삭제할 게시물 번호
	String pdfPw = request.getParameter("pdfPw"); // 삭제할 게시물 비밀번호

	// 디버깅
	System.out.println("삭제할 pdfNo : " + pdfNo);
	System.out.println("삭제할 pdfPw : " + pdfPw);
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>deletePdfForm</title>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
</head>
<body>
	<div class="container bg-dark">
		<jsp:include page="/inc/upMenu.jsp"></jsp:include>
		<h1>
			<div class="text-center text-white">삭제 페이지</div>
		</h1>
		<form method="post" action="<%=request.getContextPath()%>/pdf/deletePdfAction.jsp">
			<table class="table table-borderless text-center table-striped table-dark">
				<tr>
					<td>번호</td>
					<td><input class="text-center" type="text" name="pdfNo" value = "<%=pdfNo%>" readonly="readonly"></td>
					<td>비밀번호</td>
					<td><input type="password" name="pdfPw" value=""></td>
				</tr>
				<tr>
					<td colspan = "4"><button href="<%=request.getContextPath()%>/pdf/deletePdfAction.jsp?pdfNo=<%=pdfNo%>" class="btn btn-danger float-right">삭제</button></td>
				</tr>
			</table>
		</form>
	</div>	
</body>
</html>