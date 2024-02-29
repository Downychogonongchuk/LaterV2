<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>비밀번호 변경</title>
	<link rel="stylesheet" href="resources/css/cPassUpdate.css">
	<script src="https://code.jquery.com/jquery-3.7.1.min.js" 
			integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" 
			crossorigin="anonymous"></script>
</head>
<body>
<div class="wrap-home">
<div class="wrap">
<jsp:include page="header.jsp" />
	<div class="content">
		<form action="cUpdatePassProc" method="post" enctype="multipart/form-data">
            <h2 class="form-header">비밀번호 변경</h2>          
            <!-- 개인정보 입력 영역 -->
            <input type="hidden" class="write-input" name="customerId" value="${PassResult.customerId}">
            <h5>비밀번호 변경</h5>
            <br>
        <input type="password" class="write-input" name="customerPass" autofocus required="required"placeholder="비밀번호 입력">
        <br>
        <input type="password" class="write-input" name="customerPassCheck" autofocus required="required" placeholder="비밀번호 재확인">
            <div class="btn-area">
				<input type="submit" class="btn-write" value="확인"> 
			</div>
        </form>
        


			<div class="btn-area">
			<input type="button" class="btn-write" value="돌아가기" id="backbtn">
			</div>

		</div>
</div>
</div>
<jsp:include page="footer.jsp" />
</body>
<script>
    $("#backbtn").click(function () {
    	location.href = `./cLogin`;
    });
    
    $("#mSingInbtn").click(function () {
    	location.href = `./cSignIn`;
    });
         
</script>
<script type="text/javascript">

let m = "${msg}";
if(m != ""){
    alert(m);
}

</script>
</html>