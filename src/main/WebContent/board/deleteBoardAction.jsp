<%@page import="dao.BoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 삭제할 게시물의 번호와 패스워드 받아오기
	int boardNo = Integer.parseInt(request.getParameter("boardNo"));
	String boardPw = request.getParameter("boardPw");
	
	// 디버깅
	System.out.println("boardNo : " + boardNo);
	System.out.println("boardPw : " + boardPw);
	
	BoardDao boardDao = new BoardDao(); // 메서드를 사용하기 위한 객체 생성
	int row = boardDao.deleteBoard(boardNo, boardPw); // 메서드 사용 후 몇행을 삭제했는지 저장
	
	if(row == 0) { // 삭제 실패
		System.out.println("삭제 실패"); // 디버깅코드
		// 삭제를 실패했을때 삭제하려던 글로 다시 보내기
		response.sendRedirect(request.getContextPath() + "/board/boardOne.jsp?boardNo=" + boardNo);
	} else if(row == 1) { // 삭제 성공
		System.out.println("삭제 성공"); // 디버깅코드
		// 삭제 성공 시 처음 페이지로 보내기
		response.sendRedirect(request.getContextPath() + "/board/boardList.jsp");
	} else {
		System.out.println("에러"); // 에러
	}
%>
