<%@page import="dao.GuestbookDao"%>
<%@page import="vo.Guestbook"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 수정했을때 한글이 깨지지 않게 설정
	request.setCharacterEncoding("utf-8");

	// 사용자가 수정할 게시물의 정보를 저장하기 위해 객체 생성
	Guestbook guestbook = new Guestbook();
	
	// 사용자가 수정할 게시물의 정보 받아오기
	int guestbookNo = Integer.parseInt(request.getParameter("guestbookNo"));
	String guestbookContent = request.getParameter("guestbookContent");
	String guestbookPw = request.getParameter("guestbookPw");
	
	// 디버깅
	System.out.println("수정 한 guestbookNo : " + guestbookNo);
	System.out.println("수정 한 guestbookContent : " + guestbookContent);
	System.out.println("guestbookPw : " + guestbookPw);
	
	// guestbook 객체를 이용해 Guestbook에 있는 멤버변수들에 사용자가 수정할 게시물 정보 저장
	guestbook.setGuestbookNo(guestbookNo);
	guestbook.setGuestbookContent(guestbookContent);
	guestbook.setGuestbookPw(guestbookPw);
	
	
	// update메서드를 사용하기 위해 객체 생성
	GuestbookDao guestbookDao = new GuestbookDao();
	int row = guestbookDao.updateGuestbook(guestbook); // update메서드 실행 후 반환값 저장

	if(row == 1) { // 반환값이 1일때
		System.out.println("수정 성공");
		response.sendRedirect(request.getContextPath()+"/guestbook/guestbookList.jsp"); // 리스트로 보내기
	} else if(row == 0) { // 반환값이 0일때
		System.out.println("수정 실패");
		response.sendRedirect(request.getContextPath()+"/guestbook/updateGuestbookForm.jsp?guestbookNo=" + guestbook.getGuestbookNo()); // 수정페이지로 보내기
	} else { // 에러
		System.out.println("에러");
	}
%> 