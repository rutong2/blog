<%@page import="java.util.ArrayList"%>
<%@page import="dao.PdfDao"%>
<%@page import="vo.Pdf"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	int currentPage = 1; // 현재 페이지
	
	if(request.getParameter("currentPage") != null) { // 페이지를 넘겨서 currentPage의 값을 받아왔을때 null이 아니면 currentPage 값 변경 
		currentPage = Integer.parseInt(request.getParameter("currentPage")); // 값 저장
	}
	System.out.println("currentPage : " + currentPage); // 디버깅
	
	int rowPerPage = 5; // 내가 보고싶은 정보의 갯수
	int beginRow = (currentPage-1) * rowPerPage;

	Pdf pdf = new Pdf(); // 객체 생성
	PdfDao pdfDao = new PdfDao(); // 메서드 사용을 위한 객체 생성
	ArrayList<Pdf> list = pdfDao.selectPdfListByPage(beginRow, rowPerPage); // 리스트 출력
	
	int lastPage = 0; // 마지막 페이지
	int totalRow = pdfDao.selectPdfTotalRow(); // 총 행의 갯수 저장
	System.out.println("totalRow : " + totalRow); // 디버깅
	
	if(totalRow % rowPerPage == 0) {
		lastPage = totalRow / rowPerPage; // totalRow / rowPerPage의 몫 페이지까지만 출력해도 됨
	} else {
		lastPage = (totalRow / rowPerPage) + 1; // totalRow / rowPerPage의 몫 페이지까지만 출력하면 안나오는 정보들이 있으므로 1Page 더 추가
	}
	
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>pdfList</title>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
</head>
<body>
	<div class="container bg-dark">
		<jsp:include page="/inc/upMenu.jsp"></jsp:include>
		<h1>
			<div class="text-center text-white">PDF 자료실</div>
		</h1>
		<div class="float-right">
			<span class="text-white"><%=currentPage%> / <%=lastPage%> Page</span>
		</div>
		<table class="table table-bordered text-center table-striped table-dark">
				<tr>
					<td>자료명</td>
					<td>작성날짜</td>
				</tr>
			<%
				for(Pdf p : list) {
			%>
					<tr>
						<td>
							<a class="text-white" href="<%=request.getContextPath()%>/pdf/selectPdfOne.jsp?pdfNo=<%=p.getPdfNo()%>"><%=p.getPdfName()%></a>
						</td>
						<td><%=p.getCreateDate()%></td>
					</tr>
			<%		
				}
			%>
			<tr class="bg-dark table-borderless">
				<td colspan="2">
					<div class="row">
						<div class="col-sm-6">
							<ul class="pagination float-right">
								<%
									if(currentPage > 1) {
								%>
										<li class="page-item float-right"><a class="page-link float-left badge badge-secondary float-right" href="<%=request.getContextPath()%>/pdf/pdfList.jsp?currentPage=<%=currentPage-1%>">이전</a></li>
								<%
									}
									if(currentPage < lastPage) {
								%>
										<li class="page-item float-right"><a class="page-link float-left badge badge-secondary float-right" href="<%=request.getContextPath()%>/pdf/pdfList.jsp?currentPage=<%=currentPage+1%>">다음</a></li>
								<%
									}
								%>
							</ul>
						</div>
						<div class="col-sm-6">
							<a class= "btn btn-primary float-right" href="<%=request.getContextPath()%>/pdf/insertPdfForm.jsp">글작성</a>
						</div>
					</div>
				</td>
			</tr>
		</table>
	</div>
</body>
</html>