<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인선택</title>
<link rel="stylesheet" href="resources/css/loginSelect.css">
<script src="https://code.jquery.com/jquery-3.7.1.min.js"
	integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo="
	crossorigin="anonymous"></script>

</head>
<body>

	<div class="wrap">
		<jsp:include page="header.jsp" />
		<div class="content">
			<h2 class="form-header">로그인</h2>
			<div class="button-container">
				<button class="large-button" id="mLogin">일반회원</button>
				<button class="large-button" id="cLogin">사업회원</button>
				<button class="small-button" id="backbtn">홈으로 돌아가기</button>
			</div>


		</div>
		<jsp:include page="footer.jsp" />
	</div>
</body>
<script>
	$("#mLogin").click(function() {
		location.href = `./mLogin`;
	});
	$("#cLogin").click(function() {
		location.href = `./cLogin`;
	});
	$("#backbtn").click(function() {
		location.href = `./`;
	});
</script>
</html>