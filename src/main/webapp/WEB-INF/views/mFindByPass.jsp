<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>비밀번호 찾기</title>
	<link rel="stylesheet" href="resources/css/mFindByPass.css">
	<script src="https://code.jquery.com/jquery-3.7.1.min.js" 
			integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" 
			crossorigin="anonymous"></script>
</head>
<body>

<div class="wrap">
<jsp:include page="header.jsp" />
	<div class="content">
		<form action="mFindByPassProc" method="post" enctype="multipart/form-data">
            <h2 class="form-header">비밀번호 찾기</h2>          
            <!-- 개인정보 입력 영역 -->
            <h5>이메일</h5>
            <input type="text" class="write-input" name="memberEmail" autofocus required="required">
            <h5>이름</h5>
            <input type="text" class="write-input" name="memberName" autofocus required="required">
            <h5>연락처</h5>
            <input type="text" class="write-input" name="memberPhone" autofocus required="required">
            <div class="btn-area">
				<input type="submit" class="btn-write" value="확인"> 
			</div>
        </form>

			<div class="btn-area">
			<input type="button" class="btn-write" value="로그인" id="backbtn">
			<input type="button" class="btn-write" value="회원가입" id="mSingInbtn">
			</div>

		</div>
</div>
<jsp:include page="footer.jsp" />
</body>
<script>
    $("#backbtn").click(function () {
    	location.href = `./mLogin`;
    });
    
    $("#mSingInbtn").click(function () {
    	location.href = `./mSignIn`;
    });
         
</script>
<script type="text/javascript">

let m = "${msg}";
if(m != ""){
    alert(m);
}

</script>
</html>