<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>insertPhotoForm</title>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
</head>
<body>
	<div class="container">
		<jsp:include page="/inc/upMenu.jsp"></jsp:include>
		<br>
		<h1>
			<div class="text-center">이미지 등록</div>
		</h1>
		<!-- 
			1) form태그안의 값을 넘기는 기본값(enctype 속성)은 문자열이다.
			2) 파일을 넘길 수는 없다. 기본값(application/x-www-form-urlencoded)을 변경해야 한다.
			3) 기본값을 "multipart/form-data"로 변경하면 기본값이 문자열에서 2진수로 변경된다.
			4) 같은 form안에 모든 값이 2진수로 넘어간다. request.getParameter(); 사용 불가능
			5) 복잡한 코드를 통해서만 2진수 내용을 넘겨 받을 수 있다.
			6) 외부 라이브러리(cos.jar)를 사용해서 복잡한 코드를 간단하게 구현하자.
		 -->
		<form method="post" action="<%=request.getContextPath()%>/photo/insertPhotoAction.jsp" enctype="multipart/form-data">
			<table class="table table-bordered text-center table-striped">
				<tr>
					<td>이미지파일</td>
					<!-- style="opacity: 0.5"를 사용해 글자 흐리게 표시 -->
					<td><input type="file" name="photo"><span style="opacity: 0.5";>(gif, png, jpeg 파일만 가능)</span></td>
				</tr>
				<tr>
					<td>글쓴이</td>
					<td><input type="text" name="writer"></td>
				</tr>
				<tr>
					<td>비밀번호</td>
					<td><input type="password" name="photoPw"></td>
				</tr>
			</table>
			<div>
				<button type="submit" class="btn btn-warning float-right">이미지등록</button>
			</div>
		</form>
	</div>
</body>
</html>