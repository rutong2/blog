<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%
	int currentPage = 1; // 현재 페이지
	
	if(request.getParameter("currentPage") != null) { // 사용자가 페이지를 넘겼을때 current값이 변경 됐을때
		currentPage = Integer.parseInt(request.getParameter("currentPage")); // current값 변경
	}
	System.out.println("currentPage : " + currentPage); // 디버깅
	
	int rowPerPage = 10; // 내가 보고싶은 정보 갯수
	int beginRow = (currentPage-1) * rowPerPage; // (현재페이지-1) * (내가 보고싶은 정보 갯수) -> 처음 시작하는 행이 어디부터 시작인지 알 수 있음 
	
	PhotoDao photoDao = new PhotoDao(); // 정보를 보여줄 메서드 사용하기 위한 객체 생성
	ArrayList<Photo> list = photoDao.selectPhotoListByPage(beginRow, rowPerPage); // 메서드 사용후 반환값이 ArrayList이므로 ArrayList에 저장
	
	int totalRow = photoDao.selectPhotoTotalRow(); // 총 라인 수 구하기
	System.out.println("totalRow : " + totalRow); // 디버깅
	
	// 페이징 작업을 위한 마지막 페이지 구하기
	int lastPage = 0; // 마지막 페이지
	if(totalRow % rowPerPage == 0) {
		lastPage = totalRow / rowPerPage; // ex) 총 10개의 사진을 5개씩 출력했을때는 2페이지로 다 표현이 되므로 lastPage = totalRow / rowPerPage로 가능
	} else {
		lastPage = (totalRow / rowPerPage) + 1; // ex) 총 11개의 사진을 5개씩 출력했을때는 2페이지로 다 표현이 안되므로 +1Page 추가
	}
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>photoList</title>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
</head>
<body>
	<div class="container">
		<jsp:include page="/inc/upMenu.jsp"></jsp:include>
		<br>
		<h1>
			<div class="text-center">사진</div>
		</h1>
		<div class="float-right badge badge-pill badge-warning">
			<%=currentPage%> / <%=lastPage%> Page
		</div>
		<table class="table table-bordered text-center table-striped">
			<tr>
			<%
				// td의 갯수가 5의 배수가 되도록
				// list.size()가 1~5일때는 td는 5개
				// list.size()가 6~10일때는 td는 5개
				
				int endIdx = (((list.size()-1)/5)+1)*5; // 5의 배수가 돼야함(한줄에 5개씩 출력)
				System.out.println("endIdx : " + endIdx); // 디버깅
				
				for(int i=0; i<endIdx; i++) { // 01234, 0123456789
					// tr을 닫고 새로운 tr을 시작해야함
					if(i!=0 && i%5==0) { // i가 5일때(0을 제외한 5의 배수일때)
			%>
						</tr><tr>
			<%
					}
					if(i<list.size()) {
			%>
						<td>
							<a href="<%=request.getContextPath()%>/photo/selectPhotoOne.jsp?photoNo=<%=list.get(i).getPhotoNo()%>">
								<img src="<%=request.getContextPath()%>/upload/<%=list.get(i).getPhotoName()%>" width="100" height="100">
							</a>
						</td>
			<%			
					} else {
			%>
						<td>&nbsp;</td>
			<%
					}
				}
			%>
			</tr>
			<tr class="table-borderless">
				<td colspan="<%=endIdx%>">
					<ul class="pagination float-right">
						<%
							if(currentPage > 1) {
						%>
								<li class="page-item float-right"><a class="page-link float-left badge badge-warning float-right" href="<%=request.getContextPath()%>/photo/photoList.jsp?currentPage=<%=currentPage-1%>">이전</a></li>
						<%
							}
							if(currentPage < lastPage) {
						%>
								<li class="page-item float-right"><a class="page-link float-left badge badge-warning float-right" href="<%=request.getContextPath()%>/photo/photoList.jsp?currentPage=<%=currentPage+1%>">다음</a></li>
						<%
							}
						%>
					</ul>
				</td>
			</tr>
		</table>
		<div>
			<a class= "btn btn-warning float-right" href="<%=request.getContextPath()%>/photo/insertPhotoForm.jsp">글작성</a>
		</div>
	</div>
</body>
</html>