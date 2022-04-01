<%@page import="java.io.File"%>
<%@page import="dao.PhotoDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 1) 테이블 데이터 삭제 -> photoNo
	// 2) upload 폴더에 이미지 삭제

	PhotoDao photoDao = new PhotoDao(); // 메서드를 사용하기 위해 PhotoDao 객체 생성

	//삭제할 사진의 번호와 비밀번호 받아오기
	int photoNo = Integer.parseInt(request.getParameter("photoNo"));
	String photoPw = request.getParameter("photoPw");
	String photoName = photoDao.selectPhotoName(photoNo); // 사진 이름을 받아오는 메서드 실행 후 photoName에 저장
	
	// 디버깅
	System.out.println("photoNo : " + photoNo);
	System.out.println("photoPw : " + photoPw);
	System.out.println("photoName : " + photoName);
	
	int row = photoDao.deletePhoto(photoNo, photoPw); // 삭제 메서드 사용 후 몇행이 삭제됐는지 저장
	
	if(row == 1) {
		System.out.println("삭제 완료!!");
		String path = application.getRealPath("upload"); // 폴더 위치
		File file = new File(path + "\\" + photoName); // 파일 위치
		file.delete(); // 파일 삭제
		response.sendRedirect(request.getContextPath() + "/photo/photoList.jsp");
	} else if (row == 0) {
		System.out.println("삭제 실패!!");
		response.sendRedirect(request.getContextPath() + "/photo/selectPhotoOne.jsp?photoNo=" + photoNo);
	} else {
		System.out.println("에러");
	}
%>