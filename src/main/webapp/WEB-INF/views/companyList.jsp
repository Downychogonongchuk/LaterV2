<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내가 모집한 글 목록</title>
<link rel="stylesheet" type="text/css" href="resources/css/applyCompany.css">

<script src="https://code.jquery.com/jquery-3.7.1.min.js"
	integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo="
	crossorigin="anonymous"></script>
</head>
<body>
	<jsp:include page="header.jsp" />
	 <div id="content">
        <section id="applyCompany">
            <div class="data-area">
                <!-- 신청 목록 출력 -->
                    <c:if test="${empty bList}">
                        <div class="shop-item">
                            <span class="none-content">모집글이 없습니다.</span>
                        </div>
                    </c:if><!--if boardList is Empty-->

                    <c:if test="${!empty bList}">
                        <c:forEach var="board" items="${bList}">
                            <div class="shop-item">
                                <a href="companyDetail?boardId=${board.boardId}">
                                    <c:if test="${empty board.boardFile}">
                                        <img src="resources/images/no_image.jpg"
                                            class="poster-pre">
                                    </c:if> <!--!empty boardList End-->

                                    <c:if test="${!empty board.boardFile}">
                                        <img src="resources/upload/${board.boardFile}"
                                            class="poster-pre">
                                    </c:if>
                                </a>
                                <div class="info-pre">
                                    <div class="title-pre">
                                        <a href="companyDetail?boardId=${board.boardId}">
                                            ${board.companyName}
                                        </a>  
                                    </div> <!--title-pre-End-->
                                    
                                    
                                    <div class="content-provide"><strong>제공타입</strong><br><strong>${board.provideType}</strong></div>
                                    <div class="content-price"><strong>가격</strong><br><strong>${board.price}</strong></div>
                                    <div class="content-personnel"><strong>모집인원</strong><br>${board.personnel}</div>
                                    <div class="content-period1"><strong>신청 시작:</strong>${board.periodStart}</div>
                                    <div class="content-period2"><strong>신청 마감:</strong>${board.periodEnd}</div>
                                    

                                </div>
                            </div>
                        </c:forEach>
                    </c:if>
                </div> <!-- data-area End -->
                <div class="paging-area">
			<div class="paging">${paging}</div>
		</div>
        </section> <!--applyCompany End-->
    </div> <!--content End-->






	<jsp:include page="footer.jsp" />
</body>
</html>