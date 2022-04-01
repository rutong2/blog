<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
	<!-- 상단 메뉴 / 좌측 메뉴 / 메인 / 아래내용... -->
	
	<div class="container">
		<!-- 상단 메뉴 -->
		<div class="bg-secondary">
			상단메뉴
		</div>
		<!-- 좌측 메뉴 / 메인 -->
		<div class="row">
			<!-- 좌측 메뉴 -->
			<div class="col-sm-2 bg-warning">
				<ul class="list-group">
					<li class="list-group-item"><a href="">컴퓨터</a><span class="badge bg-danger">(25)</span></li>
					<li class="list-group-item"><a href="">여행</a><span class="badge bg-danger">(30)</span></li>
					<li class="list-group-item"><a href="">독서</a><span class="badge bg-danger">(35)</span></li>
				</ul>
			</div>
			<!-- 메인 -->
			<div class="col-sm-10">
				<div class="mt-4 p-5 bg-primary text-white rounded">
  					<h1>Jumbotron Example</h1>
  					<p>Lorem ipsum...</p>
				</div>
				<div>
					<img src="./onepiece.jpg">
				</div>
				<div>
					<img src="./onepiece.jpg" class="rounded">
				</div>
				<div>
					<img src="./onepiece.jpg" class="rounded-circle">
				</div>
				<div>
					<img src="./onepiece.jpg" class="img-thumbnail">
				</div>
				<div>
					<button type="button" class="btn btn-success">BUTTON 회원가입</button>
				</div>
				<div>
					<input type="button" value="input회원가입" class="btn btn-primary">
				</div>
				<div>
					<a href="" class="btn btn-danger">A 회원가입</a>
				</div>
			</div>
		</div>
		<!-- 아래 내용 -->
		<div class="bg-secondary">
			<ul class="pagination">
				<li class="page-item"><a class="page-link" href="#">이전</a></li>
				<li class="page-item"><a class="page-link" href="#">다음</a></li>
			</ul>
		</div>
	</div>
</body>
</html>