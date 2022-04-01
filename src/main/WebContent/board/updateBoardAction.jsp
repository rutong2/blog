<%@page import="vo.Board"%>
<%@page import="dao.BoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8"); // 한글이 안깨지게 설정

	BoardDao boardDao = new BoardDao(); // 메서드를 사용하기 위한 객체 생성
	Board board = new Board(); // 객체 생성
	
	// 사용자가 입력한 정보 받아오기
	int boardNo = Integer.parseInt(request.getParameter("boardNo"));
	String categoryName = request.getParameter("categoryName");
	String boardTitle = request.getParameter("boardTitle");
	String boardContent = request.getParameter("boardContent");
	String boardPw = request.getParameter("boardPw");
	
	// 디버깅
	System.out.println(boardNo);
	System.out.println(categoryName);
	System.out.println(boardTitle);
	System.out.println(boardContent);
	System.out.println(boardPw);
	
	// 객체 생성 후 멤버변수에 정보 저장
	board.setBoardNo(boardNo);
	board.setCategoryName(categoryName);
	board.setBoardTitle(boardTitle);
	board.setBoardContent(boardContent);
	board.setBoardPw(boardPw);
	
	int row =  boardDao.updateBoard(board); // 메서드로 실행된 행의 갯수 저장
	
	if(row == 0) { // 실행이 실패했을때
		System.out.println("수정 실패");
		response.sendRedirect(request.getContextPath() + "/board/boardList.jsp");
	} else if(row == 1) { // 실행이 성공했을때
		System.out.println("수정 성공");
		response.sendRedirect(request.getContextPath() + "/board/boardOne.jsp?boardNo=" + boardNo);
	} else {
		System.out.println("에러");
	}
%>
