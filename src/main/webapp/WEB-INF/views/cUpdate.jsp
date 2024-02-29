<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>사업자 회원정보수정</title>
	<link rel="stylesheet" href="resources/css/cUpdate.css">
	<script src="https://code.jquery.com/jquery-3.7.1.min.js" 
			integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" 
			crossorigin="anonymous"></script>
	<script>
            
          	//파일 업로드 시 선택한 파일명 출력
            $("#file").on("change", function () {
                //파일 입력창(input type=file)에서 파일 목록 가져오기
                let files = $("#file")[0].files;
                console.log(files);

                let fileName = "";

                if(files.length == 1) {
                    fileName = files[0].name;
                }
                else {//파일 선택 창에서 '취소' 버튼을 클릭
                    fileName = "파일선택";
                }

                $(".upload-name").val(fileName);
            });
    </script>
    <!-- 기존의 업종 가져와서 선택 상태 설정하는 스크립트 -->
    <script>
        $(document).ready(function() {
            let sectorsValue = "${logInInfo.sectors}";

            $("select[name='sectors'] option").each(function() {
                let optionValue = $(this).val();

                if (optionValue === sectorsValue) {
                    $(this).prop("selected", true);
                }
            });
        });
    </script>
  
</head>
<body>

<div class="wrap">
<jsp:include page="header.jsp" />
	<div class="content">
		<form action="cUpdateProc" method="post" enctype="multipart/form-data">
            <h2 class="form-header">회원정보 수정</h2>          
                <!-- 파일 입력 처리 영역 -->
                 <div class="filebox">
                <label for="file">프로필사진</label>
                <input type="file" name="files" id="file">
                <input type="text" class="upload-name" value="파일선택" readonly>
            </div>
            <!-- 개인정보 입력 영역 -->
            <input type="hidden" class="write-input" name="customerId"
            autofocus value="${logInInfo.customerId}">
            <input type="hidden" class="write-input" name="customerName"
            autofocus value="${logInInfo.customerName}">
            <input type="hidden" class="write-input" name="customerEmail"
                   autofocus value="${logInInfo.customerEmail}">
            <h5>비밀번호</h5>
            <input type="password" class="write-input" name="customerPass"
                   autofocus value="${logInInfo.customerPass}">
            <h5>비밀번호 재확인</h5>
            <input type="password" class="write-input" name=""
                   autofocus placeholder="변동사항 없을시 미입력">
            <h5>사업자번호</h5>
            <input type="text" class="write-input" name="customerNum"
                   autofocus value="${logInInfo.customerNum}">
            <h5>업체명</h5>
            <input type="text" class="write-input" name="companyName"
                   autofocus value="${logInInfo.companyName}">
            <h5>사업장 주소</h5>       
            <input type="text" class="write-input" name="companyAddress"
                   autofocus value="${logInInfo.companyAddress}">
            <h5>업종</h5>       
            <select name="sectors" class="write-input" required="required" autofocus>
			<option value="없음">==카테고리 선택==</option>
			<option value="요식업">요식업</option>
			<option value="숙박업">숙박업</option>
			<option value="가전제품 도소매업">가전제품 도소매업</option>
			<option value="미용업">미용업</option>
			<option value="기타">기타</option>
			 </select>  
     

            <div class="btn-area">
                <input type="submit" class="btn-write" value="수정완료">
                <input type="button" class="btn-write" value="뒤로가기" id="backbtn">
            </div>
        </form>
	</div>
	<jsp:include page="footer.jsp" />
</div>
</body>
<script>
    $("#backbtn").click(function () {
    	location.href = `./`;
    });
         
</script>
<script type="text/javascript">

let m = "${msg}";
if(m != ""){
    alert(m);
}

</script>
</html>