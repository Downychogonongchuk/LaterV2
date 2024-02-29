<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>header</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.css" />

<script
	src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.slim.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="resources/css/header.css">

</head>


<body>

<div class="top-bar"> 
	<div class="review">
		<a href="/later"><img alt="로고" src="resources/images/logo.png" class="logo"></a>
	</div >
	<!-- 사이트 이름 (2024-02-23)-->
	<div class="site">
		<a href="/later">리뷰엔</a>
	</div>
	<div class="login-signin">
		<i class="fa fa-user-circle-o" aria-hidden="true"></i>
		<a class="link" href="loginSelect">로그인</a> 
		<a class="link" href="signSelect">회원가입</a>
		<a class="link" href="logout">로그아웃</a>
	</div>
</div>

</body>
</html>