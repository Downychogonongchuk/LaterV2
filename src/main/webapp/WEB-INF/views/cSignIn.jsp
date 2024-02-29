<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>회원가입</title>
	<link rel="stylesheet" href="resources/css/cSignIn.css">
	<script src="https://code.jquery.com/jquery-3.7.1.min.js" 
			integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" 
			crossorigin="anonymous"></script>

</head>
<body>

<div class="wrap">
<jsp:include page="header.jsp" />
	<div class="content">
		<form action="cSignInProc" method="post" enctype="multipart/form-data">
            <h2 class="form-header">회원가입</h2>          
                <!-- 파일 입력 처리 영역 -->
                
            <!-- 개인정보 입력 영역 -->
            <h5>이메일</h5>
            <input type="email" class="write-input" name="customerEmail" autofocus required="required" id="customerEmailCheck" onblur="validateCustomerId()">
            <input type="button" class="btn-emailCheck" value="중복확인" id="checkIdBtn">
            <span id="id-confirm-message"></span>
				 <span id="id-error-message">${error}</span>
            <h5>비밀번호</h5>
            <input type="password" class="write-input" name="customerPass" autofocus required="required" id="customerPassword">
            <h5>비밀번호 재확인</h5>
            <input type="password" class="write-input" name="customerPassCheck" autofocus required="required" id="customerPasswordCheck">
            <span id="pw-confirm-error-message"></span>
            <h5>이름</h5>
            <input type="text" class="write-input" name="customerName" autofocus required="required">
            <h5>사업자번호</h5>
            <input type="text" class="write-input" name="customerNum" autofocus required="required">
            <h5>업체명</h5>
            <input type="text" class="write-input" name="companyName" autofocus required="required">
            <h5>사업장 주소</h5>
            <input type="text" class="write-input" name="companyAddress" autofocus required="required">
            <h5>업종</h5>            
			<select name="sectors" class="write-input" required="required" autofocus>
			<option value="없음">==카테고리 선택==</option>
			<option value="요식업">요식업</option>
			<option value="숙박업">숙박업</option>
			<option value="가전제품 도소매업">가전제품 도소매업</option>
			<option value="미용업">미용업</option>
			<option value="기타">기타</option>
			 </select>  
			  <div class="filebox">
                <label for="file">프로필사진</label>
                <input type="file" name="files" id="file">
                <input type="text" class="upload-name" value="파일선택" readonly>
            </div>
            <div class="btn-area">
                <input type="submit" class="btn-write" value="가입">
                <input type="button" class="btn-write" value="돌아가기" id="backbtn">
            </div>
        </form>
	</div>
	<jsp:include page="footer.jsp" />
</div>
</body>
<script>

	//파일 업로드 시 선택한 파일명 출력
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

	//뒤로가기 버튼
	$("#backbtn").click(function() {
		location.href = `./`;
	});
	//메세지 출력
	let m = "${msg}";
	if (m != "") {
		alert(m);
	}
	
	// 정규식 및 중복체크
	$("#checkIdBtn").on("click", function() {
	    const c_id = $("#customerEmailCheck").val();
	    if (c_id === "") {
	        alert("아이디를 입력해주세요 !");
	        return;
	    }

	    if (validateCustomerId()) { // 이메일 형식이 올바르면 중복 확인을 진행
	        $.ajax({
	            url: "cEmailCheck",
	            method: "POST",
	            data: {
	                "CustomerEmailCheck": c_id
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

	function validateCustomerId() {
	    const c_id = document.getElementById("customerEmailCheck").value;
	    const regExp = /^[a-zA-Z0-9]+@[a-zA-Z0-9]+\.[A-Za-z]+$/;
	    const c_idError = document.getElementById("id-confirm-message");
	    
	    if (!regExp.test(c_id)) {
	        c_idError.innerText = "아이디 형식이 올바르지 않습니다.";
	        return false;
	    } else {
	        c_idError.innerText = "";
	        return true;
	    }
		
	}

	// 아이디 입력란 변경 시 에러 메시지 초기화
	$("#customerEmailCheck").on("input", function() {
	    const c_idError = document.getElementById("id-confirm-message");
	    c_idError.innerText = ""; // 에러 메시지 초기화
	});

	// 비밀번호 일치 여부 확인
$("#customerPassword, #customerPasswordCheck").on("keyup", function() {
    let password = $("#customerPassword").val();
    let confirmPassword = $("#customerPasswordCheck").val();

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