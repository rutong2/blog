<%@page import="vo.Pdf"%>
<%@page import="dao.PdfDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	int pdfNo = Integer.parseInt(request.getParameter("pdfNo")); // 정보를 보고싶은 게시물 번호 저장
	System.out.println("pdfNo : " + pdfNo); // 디버깅
	
	PdfDao pdfDao = new PdfDao(); // 메서드 사용을 위한 객체 생성
	Pdf pdf = pdfDao.selectPdfOne(pdfNo); // 메서드를 사용해 정보를 가져온 후 Pdf 객체에 저장
	
	// 디버깅
	System.out.println("상세보기 한 pdf 번호 : " + pdf.getPdfNo());
	System.out.println("상세보기 한 pdf 작성자 : " + pdf.getWriter());
	System.out.println("상세보기 한 pdf 이름 : " + pdf.getPdfName());
	System.out.println("상세보기 한 pdf 작성날짜 : " + pdf.getCreateDate());
	System.out.println("상세보기 한 pdf 업데이트 날짜 : " + pdf.getUpdateDate());
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>selectPdfOne</title>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
</head>
<body>
	<div class="container">
		<jsp:include page="/inc/upMenu.jsp"></jsp:include>
		<br>
		<h1>
			<div class="text-center">PDF 상세보기</div>
		</h1>
		<table class="table table-bordered text-center table-striped">
			<tr>
				<td>번호</td>
				<td><%=pdf.getPdfNo()%></td>
				<td>작성자</td>
				<td><%=pdf.getWriter()%></td>
			</tr>
			<tr>
				<td colspan="4">
					자세히보기 : <a href="<%=request.getContextPath()%>/uploadPdf/<%=pdf.getPdfName()%>"><%=pdf.getPdfName()%></a>
				</td>
			</tr>
			<tr>
				<td>생성날짜</td>
				<td><%=pdf.getCreateDate()%></td>				
				<td>수정날짜</td>
				<td><%=pdf.getUpdateDate()%></td>				
			</tr>
		</table>
		<div>
			<a class = "btn btn-warning float-right" href="<%=request.getContextPath()%>/pdf/deletePdfForm.jsp?pdfNo=<%=pdf.getPdfNo()%>">삭제</a>
		</div>
	</div>
</body>
</html>