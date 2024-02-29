<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<link rel="stylesheet" href="resources/css/mSignIn.css">

</head>
<body>
	<div class="wrap">
		<jsp:include page="header.jsp" />
		<div class="content">
			<form action="mSignInProc" method="post" enctype="multipart/form-data">
				<h2 class="form-header">회원가입</h2>
				<!-- 개인정보 입력 영역 -->
				<h5>이메일</h5>
				<input type="email" class="write-input" name="memberEmail" id="memberEmailCheck" autofocus
					required="required" onblur="validateMemberId()">
					<input
						type="button" class="btn-emailCheck" value="중복확인" id="checkIdBtn">
						<span id="id-confirm-message"></span>
				 <span id="id-error-message">${error}</span>
				<h5>비밀번호</h5>
				<input type="password" class="write-input" name="memberPass" autofocus required="required" id="memberPassword">
				<h5>비밀번호 재확인</h5>
				<input type="password" class="write-input" name="memberPassCheck" autofocus required="required" id="memberPasswordCheck">
				<span id="pw-confirm-error-message"></span>
				<h5>이름</h5>
				<input type="text" class="write-input" name="memberName" autofocus
					required="required">
				<h5>전화번호</h5>
				<input type="text" class="write-input" name="memberPhone" autofocus
					required="required">
				<h5>사용하는 SNS</h5>
				<select name="snsKind" class="write-input" required autofocus>
					<option value="없음">==선택해주세요==</option>
					<option value="facebook">페이스북</option>
					<option value="instagram">인스타그램</option>
					<option value="blog">블로그</option>
					<option value="youtube">유튜브</option>
				</select>
				<h5>SNS 링크</h5>
				<input type="text" class="write-input" name="snsLink" autofocus
					required="required">
				<h5>팔로워 수</h5>
				<select name="snsFollower" class="write-input" required autofocus>
					<option value="없음">==선택해주세요==</option>
					<option value="1000">1~1,000</option>
					<option value="5000">1,000~5,000</option>
					<option value="10000">5,000~10,000</option>
					<option value="30000">10,000~30,000</option>
					<option value="50000">30,000~50,000</option>
					<option value="50001">50,000 이상</option>
				</select>
				<!-- 파일 입력 처리 영역 -->
				<div class="filebox">
					<label for="file">프로필사진</label> <input type="file" name="files"
						id="file"> <input type="text" class="upload-name"
						value="파일선택" readonly>
				</div>
				<div class="btn-area">
					<input type="submit" class="btn-write" value="가입"> <input
						type="button" class="btn-write" value="돌아가기" id="backbtn">
				</div>
			</form>
			
		</div>
		<jsp:include page="footer.jsp" />
		</div>
</body>
<script src="https://code.jquery.com/jquery-3.7.1.min.js" 
	integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" 
	crossorigin="anonymous"></script>
<script>

	$("#file").on("change", function() {
		//파일 입력창(input type=file)에서 파일 목록 가져오기
		let files = $("#file")[0].files;
		console.log(files);

		let fileName = "";

		if (files.length == 1) {
			fileName = files[0].name;
		} else {//파일 선택 창에서 '취소' 버튼을 클릭
			fileName = "파일선택";
		}

		$(".upload-name").val(fileName);
	});

	let m = "${msg}";
	if (m != "") {
		alert(m);
	}

	$("#backbtn").click(function() {
		location.href = `./`;
	});

	$("#checkIdBtn").on("click", function() {
	    const m_id = $("#memberEmailCheck").val();
	    if (m_id === "") {
	        alert("아이디를 입력해주세요 !");
	        return;
	    }

	    if (validateMemberId()) { // 이메일 형식이 올바르면 중복 확인을 진행
	        $.ajax({
	            url: "mEmailCheck",
	            method: "POST",
	            data: {
	                "memberEmailCheck": m_id
	            },
	            success: function(data) {
	                console.log(data);
	                const idErrorMessage = $("#id-error-message");
	                if (data == "fail") {
	                    idErrorMessage.text("이미 사용 중인 아이디입니다.");
	                    $("#joinSubmitBtn").prop("disabled", true);
	                } else {
	                    idErrorMessage.text("사용가능한 아이디입니다.");
	                    $("#joinSubmitBtn").prop("disabled", false);
	                }
	            },
	            error: function(error) {
	                console.log(error);
	            }
	        });
	    }
	});

	function validateMemberId() {
	    const m_id = document.getElementById("memberEmailCheck").value;
	    const regExp = /^[a-zA-Z0-9]+@[a-zA-Z0-9]+\.[A-Za-z]+$/;
	    const m_idError = document.getElementById("id-confirm-message");
	    
	    if (!regExp.test(m_id)) {
	        m_idError.innerText = "아이디 형식이 올바르지 않습니다.";
	        return false;
	    } else {
	        m_idError.innerText = "";
	        return true;
	    }
		
	}

	// 아이디 입력란 변경 시 에러 메시지 초기화
	$("#memberEmailCheck").on("input", function() {
	    const m_idError = document.getElementById("id-confirm-message");
	    m_idError.innerText = ""; // 에러 메시지 초기화
	});

	// 비밀번호 일치 여부 확인
$("#memberPassword, #memberPasswordCheck").on("keyup", function() {
    let password = $("#memberPassword").val();
    let confirmPassword = $("#memberPasswordCheck").val();

    if (password !== confirmPassword) {
        $("#pw-confirm-error-message").text("비밀번호가 일치하지 않습니다.");
        $("#joinSubmitBtn").prop("disabled", true);
    } else {
        $("#pw-confirm-error-message").text("비밀번호가 일치합니다!");
        $("#joinSubmitBtn").prop("disabled", false);
    }
});

</script>

</html>