<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>회원정보수정 - WRITE</title>
	<link rel="stylesheet" href="resources/css/mUpdate.css">
	<script src="https://code.jquery.com/jquery-3.7.1.min.js" 
			integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" 
			crossorigin="anonymous"></script>
	<!-- 파일 업로드 시 선택한 파일명 출력을 위한 스크립트 -->
    <script>
        $(document).ready(function() {
            $("#file").on("change", function () {
                let files = $("#file")[0].files;
                let fileName = "";

                if(files.length == 1) {  
                    fileName = files[0].name;
                }
                else {
                    fileName = "파일선택";
                }

                $(".upload-name").val(fileName);
            });
        });
    </script>

    <!-- 기존의 SNS 종류 값 가져와서 선택 상태 설정하는 스크립트 -->
    <script>
        $(document).ready(function() {
            let snsKindValue = "${logInInfo.snsKind}";

            $("select[name='snsKind'] option").each(function() {
                let optionValue = $(this).val();

                if (optionValue === snsKindValue) {
                    $(this).prop("selected", true);
                }
            });
        });
    </script>

    <!-- 기존의 팔로워 수 값 가져와서 선택 상태 설정하는 스크립트 -->
    <script>
        $(document).ready(function() {
            let snsFollowerValue = "${logInInfo.snsFollower}";

            $("select[name='snsFollower'] option").each(function() {
                let optionValue = $(this).val();

                if (optionValue === snsFollowerValue) {
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
		<form action="mUpdateProc" method="post" enctype="multipart/form-data">
            <h2 class="form-header">회원정보 수정</h2>          
                <!-- 파일 입력 처리 영역 -->
                 <div class="filebox">
                <label for="file">프로필사진</label>
                <input type="file" name="files" id="file">
                <input type="text" class="upload-name" value="파일선택" readonly>
            </div>
            <!-- 개인정보 입력 영역 -->
            <input type="hidden" class="write-input" name="memberId"
            autofocus value="${logInInfo.memberId}">
            <input type="hidden" class="write-input" name="memberName"
            autofocus value="${logInInfo.memberName}">
            <input type="hidden" class="write-input" name="memberEmail"
                   autofocus value="${logInInfo.memberEmail}">
            <h5>비밀번호</h5>
            <input type="password" class="write-input" name="memberPass"
                   autofocus value="${logInInfo.memberPass}">
            <h5>비밀번호 재확인</h5>
            <input type="password" class="write-input" name=""
                   autofocus placeholder="변동사항 없을시 미입력">
            <h5>연락처</h5>
            <input type="text" class="write-input" name="memberPhone"
                   autofocus value="${logInInfo.memberPhone}">
            <h5>사용하는 SNS</h5>
            <select name = "snsKind" class="write-input" required="required" autofocus>
			<option value="없음">==선택해주세요==</option>
			<option value="facebook">페이스북</option>
			<option value="instagram">인스타그램</option>
			<option value="blog">블로그</option>
			<option value="youtube">유튜브</option>
            </select>
            <h5>본인의 SNS또는 BLOG 링크</h5>
            <input type="text" class="write-input" name="snsLink"
                   value="${logInInfo.snsLink}">
            <h5>팔로워 수</h5>       
            <select name="snsFollower" class="write-input" required="required" autofocus>
			<option value="없음">==선택해주세요==</option>
			<option value="1000">1~1,000</option>
			<option value="5000">1,000~5,000</option>
			<option value="10000">5,000~10,000</option>
			<option value="30000">10,000~30,000</option>
			<option value="50000">30,000~50,000</option>
			<option value="50001">50,000 이상</option>
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