<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="vo.Photo" %>
<%@ page import="dao.PhotoDao" %>
<%
	/*
		form태그에 enctype="multipart/form-data"로 넘겨져서 request.getParameter() API를 사용할 수 없다.
		String writer = request.getParameter("writer");
		System.out.println(writer);
		request.getParameter() API 대신 다른 API를 사용해야 하는데 너무 복잡
		--> request를 단순하게 사용하게 해주는 cos.jar같은 API(외부 라이브러리)를 사용하자.
	*/
	
	request.setCharacterEncoding("utf-8"); // 한글이 안깨지게 설정
	DefaultFileRenamePolicy rp = new DefaultFileRenamePolicy(); // 파일 이름이 중복된 이름인지 검사하는 클래스
	
	String path = application.getRealPath("upload"); // application변수 -> 톰캣을 가르키는 변수
	// 기존 request는 정보들이 2진수로 넘어와서 사용 못하므로 MultipartRequest 객체를 생성 후 사용
	MultipartRequest multiReq = new MultipartRequest(request, path, 1024*1024*100 , "utf-8", rp);
	// 2^10 byte -> 1kbyte 1024byte -> 1kbyte
	// 2^10 kbyte - > 1mbyte
	// 100 mbyte -> 1024*1024*100 byte -> 104857600 byte
	
	// 사용자가 입력한 정보 받아오기
	String photoPw = multiReq.getParameter("photoPw");
	String writer = multiReq.getParameter("writer");
	
	// <input type="file" name="photo"> 처리
	String photoOriginalName = multiReq.getOriginalFileName("photo"); // 파일 업로드시 원본의 이름
	String photoName = multiReq.getFilesystemName("photo"); // DefaultFileRenamePolicy() 객체를 통해 변경된 이름
	String photoType = multiReq.getContentType("photo");
	
	// 디버깅
	System.out.println("photoPw : " + photoPw);
	System.out.println("writer : " + writer);
	System.out.println("photoOriginalName : " + photoOriginalName);
	System.out.println("photoName : " + photoName);
	System.out.println("photoType : " + photoType);
	
	// 파일 업로드의 경우 100mbyte 이하의 image/gif, image/png, image/jpeg 3가지 이미지 확장자만 허용
	if(photoType.equals("image/gif") || photoType.equals("image/png") || photoType.equals("image/jpeg")) {
		// DB에 저장
		PhotoDao photoDao = new PhotoDao();
		Photo photo = new Photo();
		photo.setPhotoName(photoName);
		photo.setPhotoOriginalName(photoOriginalName);
		photo.setPhotoType(photoType);
		photo.setPhotoPw(photoPw);
		photo.setWriter(writer);
		photoDao.insertPhoto(photo);
		response.sendRedirect(request.getContextPath() + "/photo/photoList.jsp");
		System.out.println("DB 저장 완료");
		
	} else {
		// 업로드 취소
		System.out.println("이미지 파일만 업로드");
		// 잘못들어온 파일이므로 업로드된 파일 지우기
		File file = new File(path + "\\" + photoName); // java.io.File 잘못된 파일을 불러온다.
		file.delete(); // 불러온 후 삭제
		response.sendRedirect(request.getContextPath() + "/photo/insertPhotoForm.jsp");
	}
%>