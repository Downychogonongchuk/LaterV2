<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내가 신청한 업체 목록</title>
<link rel="stylesheet" type="text/css" href="resources/css/applyCompany.css?after">

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
                            <span class="none-content">신청한 체험단 모집글이 없습니다.</span>
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
                                <section class="info-pre">
                              
                                    <div class="title-pre">
                                        <a class="title" href="companyDetail?boardId=${board.boardId}">
                                            ${board.companyName}
                                        </a>  
                                    </div> <!--title-pre-End-->
                                    
                                    
                                    <div class="content-provide">${board.provideType}</div>
                                    <div class="content-price">${board.price}</div>
                                     <div class="priceline"></div>
                                     <div class="div3">모집인원</div>
                                    <div class="content-personnel">${board.personnel}</div>
                                    <div class="content-period1">신청 시작:${board.periodStart}</div>
                                    <div class="content-period2">신청 마감:${board.periodEnd}</div>
                                   
                               
                                </section>
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