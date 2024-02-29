<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>업체정보 수정</title>
	<link rel="stylesheet" href="resources/css/writeFrm.css">
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
  <style>
  	.content {
	padding: 15px 30px;
	margin: 0 auto;
	width: 800px;
	flex: 1;
}
.form-header {
	margin-top: 30px;
	margin-bottom: 30px;
	font-size: 2em;
	text-align: center;
	font-size: 1.8em;
}
  </style>
</head>
<body>

<div class="wrap">
<jsp:include page="cheader.jsp" />
	<div class="content">
		<form action="bUpdateProc" method="post" enctype="multipart/form-data">
            <h2 class="form-header">업체 정보 수정</h2>          
                <!-- 파일 입력 처리 영역 -->
                 <div class="filebox">
                <label for="file">업체 사진</label>
                <input type="file" name="files" id="file">
                <input type="text" class="upload-name" value="파일명" readonly>
            </div>
            <!-- 변경할 업체 정보 입력 -->
            <input type="hidden" class="write-input" name="customerId"
            autofocus value="${board.customerId}">
            <input type="hidden" class="write-input" name="boardId"
            autofocus value="${board.boardId}">
            <input type="text" class="write-input" name="periodStart"
            autofocus value="${board.periodStart}" placeholder="모집시작일ex)2024-02-00">
            <input type="text" class="write-input" name="periodEnd"
                   autofocus value="${board.periodEnd}" placeholder="모집종료일ex)2024-02-00">
            <input type="text" class="write-input" name="personnel"
                   value="${board.personnel}" placeholder="모집인원">
            <input type="hidden" class="write-input" name="companyName"
                   autofocus value="${board.companyName}" placeholder="companyName">
            <input type="hidden" class="write-input" name="category"
                   autofocus value="${board.category}" placeholder="category" >
            <textarea rows="10" class="write-input ta" name="detail" placeholder="상세설명"
                   >${board.detail}</textarea> 
            <textarea rows="10" class="write-input ta" name="checkInfo" placeholder="체크사항 및 요청사항"
                   >${board.checkInfo}</textarea>
             
             <input type="text" class="write-input" name="price"
                    autofocus value="${board.price}" placeholder="원가">
             <!-- <h6 id="write1">**규정상 무료제공을 원칙으로 하고있습니다, 동의하지 않으시는 회원께서는 리뷰엔 이용에 제한됩니다
            제공하는 금액에서 추가적인 비용 발생시 체험신청자와 협의하에 추가비용 청구는 가능합니다.**</h6>
             <h4>제공 가격</h4>  -->
             <input type="hidden" class="write-input" name="provideType"
                   autofocus value="무료" placeholder="제공가격">
            
			
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
</html>s