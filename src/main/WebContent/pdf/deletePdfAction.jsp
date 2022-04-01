<%@page import="java.io.File"%>
<%@page import="vo.Pdf"%>
<%@page import="dao.PdfDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	PdfDao pdfDao = new PdfDao(); // 메서드를 사용하기 위한 객체 생성
	Pdf pdf = new Pdf(); // 객체 생성
	
	int pdfNo = Integer.parseInt(request.getParameter("pdfNo")); // 삭제하고 싶은 게시물 번호 가져오기
	String pdfPw = request.getParameter("pdfPw"); // 삭제하고 싶은 게시물의 비밀번호 가져오기
	String pdfName = pdfDao.selectPdfName(pdfNo); // pdf의 이름을 가져오는 메서드 실행 후 pdfName에 저장
	
	// 디버깅
	System.out.println("pdfNo : " + pdfNo);
	System.out.println("pdfPw : " + pdfPw);
	System.out.println("pdfName : " + pdfName); // 디버깅
	
	// 객체 저장
	pdf.setPdfNo(pdfNo);
	pdf.setPdfPw(pdfPw);
	
	int row = pdfDao.deletePdf(pdf); // 삭제 메서드 사용 후 몇행을 삭제 했는지 저장
	System.out.println("row : " + row);
	
	if(row == 1) { // 삭제한 행이 있을때 삭제 후 리스트로 돌아가기
		System.out.println("삭제 성공!");
		String path = application.getRealPath("uploadPdf"); // 폴더 위치
		File file = new File(path + "\\" + pdfName); // 파일 위치
		file.delete(); // 파일 삭제
		response.sendRedirect(request.getContextPath() + "/pdf/pdfList.jsp");
	} else if(row == 0) { // 삭제한 행이 없을때 다시 삭제 페이지로 돌아가기
		System.out.println("삭제 실패!");
		response.sendRedirect(request.getContextPath() + "/pdf/selectPdfOne.jsp?pdfNo=" + pdf.getPdfNo());
	} else { // 에러
		System.out.println("에러");
	}
%>
