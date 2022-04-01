<%@page import="vo.Board"%>
<%@page import="dao.BoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8"); // 한글이 안깨지게 인코딩 설정
	
	BoardDao boardDao = new BoardDao(); // 메서드를 사용하기 위한 객체 생성
	
	// 사용자가 입력한 정보 받아오기
	String categoryName = request.getParameter("categoryName");
	String boardTitle = request.getParameter("boardTitle");
	String boardContent = request.getParameter("boardContent");
	String boardPw = request.getParameter("boardPw");
	
	// 디버깅
	System.out.println(categoryName);
	System.out.println(boardTitle);
	System.out.println(boardContent);
	System.out.println(boardPw);
	
	// 객체 생성 후 멤버변수에 정보 저장
	Board board = new Board(); // 객체 생성
	board.setCategoryName(categoryName);
	board.setBoardTitle(boardTitle);
	board.setBoardContent(boardContent);
	board.setBoardPw(boardPw);
	
	boardDao.insertBoard(board); // DB에 insert하는 메서드 실행
	
	// 입력 후 다시 리스트로 돌아가기
	response.sendRedirect(request.getContextPath()+"/board/boardList.jsp");
	
%>