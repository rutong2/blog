<%@page import="dao.GuestbookDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%	
	// 사용자가 삭제할 게시물의 번호와 비밀번호를 받아서 사용자가 입력한 비밀번호가 맞으면 삭제
	int guestbookNo = Integer.parseInt(request.getParameter("guestbookNo")); // 게시물의 번호
	String guestbookPw = request.getParameter("guestbookPw"); // 게시물의 비밀번호
	
	// 디버깅
	System.out.println("삭제 할 guestbookNo : " + guestbookNo);
	System.out.println("삭제 할 guestbookPw : " + guestbookPw);
	
	// 삭제할 메서드 가져오기
	GuestbookDao guestbookDao = new GuestbookDao(); // 삭제할 메서드가 있는 GuestbookDao 객체 생성
	int row = guestbookDao.deleteGuestbook(guestbookNo, guestbookPw); // 객체를 이용해 메서드 사용 후 메서드 반환값 row에 저장

	// row를 이용해 삭제가 성공했는지 실패했는지 판별
	if(row == 1) { // 반환값이 1일때
		System.out.println("삭제 성공");
		response.sendRedirect(request.getContextPath()+"/guestbook/guestbookList.jsp"); // 리스트로 보내기
	} else if(row == 0) { // 반환값이 0일때
		System.out.println("삭제 실패");
		response.sendRedirect(request.getContextPath()+"/guestbook/deleteGuestbookForm.jsp?guestbookNo=" + guestbookNo); // 삭제페이지로 보내기
	} else { // 에러
		System.out.println("에러");
	}
%>
