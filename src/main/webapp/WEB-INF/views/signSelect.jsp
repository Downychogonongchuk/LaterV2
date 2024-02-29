<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>가입유형선택</title>
<link rel="stylesheet" href="resources/css/signSelect.css">
<script src="https://code.jquery.com/jquery-3.7.1.min.js"
	integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo="
	crossorigin="anonymous"></script>

</head>
<body>

	<div class="wrap">
		<jsp:include page="header.jsp" />
		<div class="content">
			<h2 class="form-header">가입유형 선택</h2>
			<div class="button-container">
				<button class="large-button" id="mSign">체험단회원</button>
				<button class="large-button" id="cSign">사업자회원</button>
				<br>
				<button class="small-button" id="backbtn">홈으로 돌아가기</button>
			</div>


		</div>
		<jsp:include page="footer.jsp" />
	</div>
</body>
<script>
	$("#mSign").click(function() {
		location.href = `./mSignIn`;
	});
	$("#cSign").click(function() {
		location.href = `./cSignIn`;
	});
	$("#backbtn").click(function() {
		location.href = `./`;
	});
</script>
</html>