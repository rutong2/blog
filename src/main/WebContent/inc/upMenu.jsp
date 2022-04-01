<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 다른 페이지의 한 부분으로 사용되는 페이지 -->
<div class="text-center container p-3 my-3 bg-dark btn-group">
	<a class="btn btn-secondary" href="<%=request.getContextPath()%>/index.jsp">홈으로</a>
	<a class="btn btn-secondary" href="<%=request.getContextPath()%>/board/boardList.jsp">게시판</a>
	<a class="btn btn-secondary" href="<%=request.getContextPath()%>/photo/photoList.jsp">사진</a>
	<a class="btn btn-secondary" href="<%=request.getContextPath()%>/guestbook/guestbookList.jsp">방명록</a>
	<a class="btn btn-secondary" href="<%=request.getContextPath()%>/pdf/pdfList.jsp">PDF 자료실</a>
</div>