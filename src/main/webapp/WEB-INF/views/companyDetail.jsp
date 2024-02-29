 <%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>companyDetail</title>
<link rel="stylesheet" href="resources/css/companyDetail.css">
<script src="https://code.jquery.com/jquery-3.7.1.min.js"
	integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo="
	crossorigin="anonymous"></script>
</head>
<body>
	<jsp:include page="header.jsp" />
	<!--view-->
	
		
		
			<!-- 인포 -->
			<form id="detailForm" method="post" action="rev"
				enctype="multipart/form-data">
                <div id="content">
                <div class="left">
                    <section>
                        <p>
                            <img src="resources/upload/${board.boardFile}" class="boardfile"></p>
                            <input type="hidden" name="boardFile" value="${board.boardFile}">   
                        <p>
                    </section>
                    <section class="checkInfo">
                        <p>
                            <strong><b>체크사항</b>체크사항</strong> <span class="checkContent">"${checkInfo}"</span>
                        </p>
                    </section> <!--checkInfoEnd-->	
                </div>	<!--leftEnd-->
                    
                    <div class="right">
				    <section class="info">
					
					
					<input type="hidden" name="boardId" value="${board.boardId}">

					<p class="name">
						<strong>업체이름</strong><br>${board.companyName}</p>
					<!-- Hidden input fields to hold the data -->
					<input type="hidden" name="companyName"
						value="${board.companyName}">

					<p>
						<strong>모집인원</strong><br>${board.personnel}</p>
					<input type="hidden" name="personnel" value="${board.personnel}">

					<p>
						<strong>모집신청일자</strong><br>${board.periodStart}</p>
					<input type="hidden" name="periodStart"
						value="${board.periodStart}">

					<p>
						<strong>모집마감일자</strong><br>${board.periodEnd}</p>
					<input type="hidden" name="periodEnd" value="${board.periodEnd}">

					<p>
						<strong>제공타입</strong><br>${board.provideType}</p>
					<input type="hidden" name="provideType"
						value="${board.provideType}">

					<p>
						<strong>가격</strong><br>${board.price}</p>
					<input type="hidden" name="price" value="${board.price}">

				</section>

				<section class="detail">
					<p>
						<strong><b>상세정보</b></strong> <span class="detailContent">
							"${detail}"</span>
					</p>
					<ul>
						<li></li>
						
					</ul>
				</section> <!--detailEnd-->
			
                
                <div class="buttons">
                <c:if test="${!empty mLogInInfo}">
                <!-- 결제버튼-->
				<button type="submit" id="btn-apply" class="btn-apply">신청하기</button>
				</c:if><!--!empty mLogInInfo -->
				
				<c:if test="${!empty cLogInInfo}">
                <a href="modifyDetail.jsp" class="btn-modifyDetail">수정</a>
				</c:if><!--!empty cLogInInfo -->
				
				
                </div> <!--buttonsEnd-->
			    </div><!--rightEnd-->
				
            </div><!--content-->
			</form>
		
				
	<jsp:include page="footer.jsp" />
	
	<script>
	$("#btn-apply").click(function() {
		location.href = `./`;
	});
	
</script>

</body>
</html>