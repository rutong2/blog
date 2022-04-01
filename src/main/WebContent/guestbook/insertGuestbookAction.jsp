<%@page import="vo.Guestbook"%>
<%@page import="dao.GuestbookDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%

	request.setCharacterEncoding("utf-8"); // 한글이 깨지지 않게 설정

	// insertGuestbook() 함수의 매개변수인 Guestbook 객체 생성하기
	Guestbook guestbook = new Guestbook(); // 객체 생성
	
	// 변수에 사용자가 입력한 값 저장
	String writer = request.getParameter("writer");
	String guestbookPw = request.getParameter("guestbookPw");
	String guestbookContent = request.getParameter("guestbookContent");
	
	// 디버깅
	System.out.println("글쓴이 : " + writer);
	System.out.println("비밀번호 : " + guestbookPw);
	System.out.println("내용 : " + guestbookContent);
	
	// Guestbook에 있는 멤버변수에 사용자가 입력한 값 저장
	guestbook.setWriter(writer);
	guestbook.setGuestbookPw(guestbookPw);
	guestbook.setGuestbookContent(guestbookContent);
	
	// 방명록 작성 구현 -> GuestbookDao에 있는 insertGuetbook()함수를 호출
	GuestbookDao guestbookDao = new GuestbookDao(); // 객체 생성
	guestbookDao.insertGuestbook(guestbook); // 함수 매개변수에 Guestbook객체 넣어주기
	
	// 입력 후 다시 리스트로 돌아가기
	response.sendRedirect(request.getContextPath()+"/guestbook/guestbookList.jsp");
	
%>
