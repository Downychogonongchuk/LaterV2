<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<html>
<head>
<title>Home</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />
<link rel="stylesheet" href="resources/css/myPage.css" />

<script src="https://code.jquery.com/jquery-3.7.1.min.js"
	integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo="
	crossorigin="anonymous"></script>
<script
	src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.slim.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

<script>
	let m = "${msg}";
	if (m != "") {
		alert(m);
	}
</script>
</head>
<body>
	<div class="wrap">
		<div>
			<c:if test="${empty mLogInInfo && empty cLogInInfo}">
				<jsp:include page="header.jsp" />
			</c:if>
			<c:if test="${!empty mLogInInfo}">
				<jsp:include page="mheader.jsp" />
			</c:if>
			<c:if test="${!empty cLogInInfo}">
				<jsp:include page="cheader.jsp" />
			</c:if>
		</div>

		
				<c:if test="${!empty mLogInInfo}">
				<div class="sidebar">
			<div class="box-line">
				<div class="img-box">
					<c:if test="${!empty mLogInInfo.memberProfile}">
						<img src="resources/upload/${mLogInInfo.memberProfile}"
							class="poster-pre">
					</c:if>
					<c:if test="${empty mLogInInfo.memberProfile}">
						<img src="resources/images/no_image.jpg" class="poster-pre">
					</c:if>
				</div>
					<h4 id="h4">
						<strong>${mLogInInfo.memberName}</strong>
					</h4>
				</div>
					<div class="div-box">
					<div>
						<a href="mUpdate">회원정보수정</a>
					</div>
					<div>
						<a href="applyCompany">내가 신청한 모집글</a>
					</div>
					<div>
						<a href="reviewWrite">리뷰 작성</a>
					</div>
					<div>
						<a href="mDelete">회원탈퇴</a>
					</div>
			</div>
			
			
			</div>
				</c:if>
				<c:if test="${!empty cLogInInfo}">
				<div class="sidebar">
					<div class="box-line">
					<div class="img-box">
					<c:if test="${!empty cLogInInfo.customerProfile}">
						<img src="resources/upload/${cLogInInfo.customerFile}"
							class="poster-pre">
					</c:if>
					<c:if test="${empty cLogInInfo.customerProfile}">
						<img src="resources/images/no_image.jpg" class="poster-pre">
					</c:if>
					</div>
					<h4 id="h4">
					<strong>${cLogInInfo.customerName}</strong>
					</h4>
					</div>
					<div class="div-box">
					<div>
						<a href="mUpdate">회원정보수정</a>
					</div>
					<div>
						<a href="companyList?customerId=${cLogInInfo.customerId}">내가 모집한글</a>
					</div>
					<div>
						<a href="writeFrm">업체 등록</a>
					</div>
					<div>
						<a href="bUpdate">업체 수정</a>
					</div>
					<div>
						<a href="mDelete">회원탈퇴</a>
					</div>
					</div>
				
			
		</div>
				</c:if>
				<div>
		<jsp:include page="footer.jsp" />
	</div>
				</div>

		<span class="mypage-icon-user"><i class="fa fa-user-circle-o"></i></span><br>
		<span class="mypage-icon">
		<strong>My Page</strong>
		</span>
			


</body>
</html>