<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 다른 페이지의 한 부분으로 사용되는 페이지 -->
<style>
	.upMenu{
		 position: relative;
		 }
</style>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
<div class="upMenu">
	<div>
		<a href="<%=request.getContextPath()%>/index.jsp">
			<img style="width: 100%; height: 200px;" src="<%=request.getContextPath()%>/img/blogBanner.png">
		</a>
	</div>
	<div style="width: 100%;" class="btn-group">
		<a class="btn btn-warning" href="<%=request.getContextPath()%>/board/boardList.jsp">게시판</a>
		<a class="btn btn-warning" href="<%=request.getContextPath()%>/guestbook/guestbookList.jsp">방명록</a>
		<a class="btn btn-warning" href="<%=request.getContextPath()%>/photo/photoList.jsp">사진</a>
		<a class="btn btn-warning" href="<%=request.getContextPath()%>/pdf/pdfList.jsp">PDF 자료실</a>
	</div>
</div>