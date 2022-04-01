<%@page import="java.io.File"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="vo.Pdf"%>
<%@page import="dao.PdfDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8"); // 한글이 안깨지게 설정
	DefaultFileRenamePolicy rp = new DefaultFileRenamePolicy(); // 파일 이름이 중복됐을때 임의로 (1), (2)를 붙여서 중복을 피함
	String path = application.getRealPath("uploadPdf"); // 톰캣에 있는 uploadPdf파일을 찾아서 경로 저장
	// 정보들이 2진수로 넘어와서 기존request는 사용하지 못해서 MultipartRequest사용 (request, 경로, 파일 최대 용량, 인코딩, 파일이름 중복 방지 객체)
	MultipartRequest multiReq = new MultipartRequest(request, path, 1024*1024*100, "utf-8", rp); 
	
	// 사용자가 입력한 정보 받아오기
	String pdfPw = multiReq.getParameter("pdfPw");
	String writer = multiReq.getParameter("writer");
	
	// <input type="file" name="pdf"> 처리
	String pdfOriginalName = multiReq.getOriginalFileName("pdf");
	String pdfName = multiReq.getFilesystemName("pdf");
	String pdfType = multiReq.getContentType("pdf");
	
	// 디버깅
	System.out.println("pdfPw : " + pdfPw);
	System.out.println("writer : " + writer);
	System.out.println("pdfOriginalName : " + pdfOriginalName);
	System.out.println("pdfName : " + pdfName);
	System.out.println("pdfType : " + pdfType);
	
	if(pdfType.equals("application/pdf")) {
		PdfDao pdfDao = new PdfDao(); // 메서드 사용을 위한 객체 생성
		Pdf pdf = new Pdf(); // 객체 생성
		// 사용자에게서 받아온 정보들 객체를 이용해서 각 멤버변수에 저장
		pdf.setPdfPw(pdfPw);
		pdf.setWriter(writer);
		pdf.setPdfOriginalName(pdfOriginalName);
		pdf.setPdfName(pdfName);
		pdf.setPdfType(pdfType);
		pdfDao.insertPdf(pdf);
		response.sendRedirect(request.getContextPath() + "/pdf/pdfList.jsp"); // 저장 후 리스트로 돌려보내기
		System.out.println("DB 저장 완료"); // 디버깅
	} else {
		// 업로드 취소
		System.out.println("pdf 파일만 업로드");
		// 잘못들어온 파일이므로 업로드된 파일 지우기
		File file = new File(path + "\\" + pdfName); // java.io.File 잘못된 파일을 불러온다.
		file.delete(); // 불러온 후 삭제
		response.sendRedirect(request.getContextPath() + "/pdf/insertPdfForm.jsp");
	}

%>
