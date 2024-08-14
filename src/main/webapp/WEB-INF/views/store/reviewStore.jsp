<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="../header.jsp"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/star.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/reviewStore.css">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="store-container2">
<div class="toolbar">
        <ul>
            <li><a href="/store/selectStore.do?storeid=${storeid}&storename=${storename}">주문목록</a></li>
            <li><a href="/store/reviewStore.do?storeid=${storeid}&storename=${storename}">리뷰관리</a></li>
            <li><a href="/store/storeMenu.do?storeid=${storeid}&storename=${storename}">메뉴관리</a></li>
            <li><a href="/store/storeSales2.do?storeid=${storeid}&storename=${storename}">매출관리(기간별)</a></li>
            <li><a href="/store/storeSales.do?storeid=${storeid}&storename=${storename}">매출관리(메뉴별)</a></li>
            <li><a href="/store/addCate.do?storeid=${storeid}&storename=${storename}">카테고리추가</a></li>
            <li><a href="/store/stopStore.do?storeid=${storeid}&storename=${storename}">가게일시정지</a></li>
            <li><a href="/store/addCoupon.do?storeid=${storeid}&storename=${storename}">쿠폰추가하기</a></li>
        </ul>
    </div>
 
    <div class="container" >
    <div style="margin-top: 10px; width:100%;">
    <h1>리뷰관리 페이지</h1>
    <div style="margin-top: 40px;">
    <c:if test="${empty rList}">
        <p>등록된 리뷰가 없습니다.</p>
    </c:if>
    <c:if test="${not empty rList}">
        <div id="Review">
            <c:forEach var="dto" items="${rList}" varStatus="loop">
                <c:if test="${loop.index % 5 == 0}">
                    <c:if test="${loop.index != 0}">
                        </div>
                    </c:if>
                    <div class="review-group">
                </c:if>
                <div class="review-item">
                    <div class="review-content">
                        <c:choose>
                            <c:when test="${not empty dto.img}">
                                <div>
                                    <img src="${pageContext.request.contextPath}/resources/img/${dto.img}" alt="Review Image">
                                </div>
                            </c:when>
                            <c:when test="${empty dto.img}">
                                <p>등록된 사진이 없습니다.</p>
                            </c:when>
                        </c:choose>
                        <div>
                            <h3>아이디:  ${dto.id}</h3>
                            <h3>주문일자: ${dto.reviewdate}</h3>
                            <h2>리뷰내용: ${dto.revcotent}</h2>
                            <c:if test="${not empty dto.reply}">
                                <p class="reply">⤷ 사장님댓글: ${dto.reply}</p>
                            </c:if>
                            <div class="star-rating">
                                <fieldset>
                            <input type="radio" id="star${dto.grade}-5" disabled ${dto.grade ge 5 ? 'checked' : ''}><label for="star${re.grade}-5"></label>
                            <input type="radio" id="star${dto.grade}-4" disabled ${dto.grade ge 4 ? 'checked' : ''}><label for="star${re.grade}-4"></label>
                            <input type="radio" id="star${dto.grade}-3" disabled ${dto.grade ge 3 ? 'checked' : ''}><label for="star${re.grade}-3"></label>
                            <input type="radio" id="star${dto.grade}-2" disabled ${dto.grade ge 2 ? 'checked' : ''}><label for="star${re.grade}-2"></label>
                            <input type="radio" id="star${dto.grade}-1" disabled ${dto.grade ge 1 ? 'checked' : ''}><label for="star${re.grade}-1"></label>
                        </fieldset>
                                <p>평점: ${dto.grade}</p>
                            </div>
                            <c:if test="${empty dto.reply}">
                        <button onclick="showForm(${dto.reviewid})">댓글등록</button>
                    </c:if>
                    <c:if test="${not empty dto.reply}">
                        <button onclick="showForm2(${dto.reviewid})">댓글수정</button>
                        <button onclick="location.href='/store/deleteReview.do?reviewid=${dto.reviewid}&storeid=${dto.storeid}'">답글삭제</button><br>
                    </c:if>
                        </div>
                    </div>
                    
                    <br>
                    <div id="myForm${dto.reviewid}" class="form-container" style="display: none;">
                        <h4>${empty dto.reply ? '댓글추가' : '댓글수정'}</h4>
                        <form id="form${dto.reviewid}" action="${empty dto.reply ? 'addReviewOk.do' : 'editReviewOk.do'}" method="post">
                            <input type="hidden" name="reviewid" value="${dto.reviewid}">
                            <input type="hidden" name="storeid" value="${dto.storeid}">
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                            <label for="reply${dto.reviewid}"></label>
                            <textarea id="reply${dto.reviewid}" name="reply" rows="4">${dto.reply}</textarea>
                            <br>
                            <button type="submit" value="${empty dto.reply ? '등록' : '수정'}">등록</button>
                            <button type="button" onclick="cancelForm(${dto.reviewid})">취소</button>
                        </form>
                    </div>
                </div>
                <c:if test="${loop.last}">
                    </div>
                </c:if>
            </c:forEach>
        </div>
        <div class="pagination">
            <c:if test="${pageCount > 1}">
                <c:set var="startPage" value="${currentPage - 2}"/>
                <c:if test="${startPage lt 1}">
                    <c:set var="startPage" value="1"/>
                </c:if>
                <c:set var="endPage" value="${currentPage + 2}"/>
                <c:if test="${endPage gt pageCount}">
                    <c:set var="endPage" value="${pageCount}"/>
                </c:if>
                <c:url value="/store/reviewStore.do" var="firstPageUrl">
                    <c:param name="page" value="1"/>
                    <c:param name="storeid" value="${param.storeid}"/>
                </c:url>
                <c:url value="/store/reviewStore.do" var="prevPageUrl">
                    <c:param name="page" value="${currentPage - 1}"/>
                    <c:param name="storeid" value="${param.storeid}"/>
                </c:url>
                <a href="${firstPageUrl}">First</a>
                <c:if test="${currentPage > 1}">
                    <a href="${prevPageUrl}">Previous</a>
                </c:if>
                <c:forEach begin="${startPage}" end="${endPage}" var="pageNumber">
                    <c:url value="/store/reviewStore.do" var="pageUrl">
                        <c:param name="page" value="${pageNumber}"/>
                        <c:param name="storeid" value="${param.storeid}"/>
                    </c:url>
                    <a href="${pageUrl}" class="${pageNumber == currentPage ? 'active' : ''}">${pageNumber}</a>
                </c:forEach>
                <c:url value="/store/reviewStore.do" var="nextPageUrl">
                    <c:param name="page" value="${currentPage + 1}"/>
                    <c:param name="storeid" value="${param.storeid}"/>
                </c:url>
                <c:if test="${currentPage lt pageCount}">
                    <a href="${nextPageUrl}">Next</a>
                </c:if>
                <c:url value="/store/reviewStore.do" var="lastPageUrl">
                    <c:param name="page" value="${pageCount}"/>
                    <c:param name="storeid" value="${param.storeid}"/>
                </c:url>
                <a href="${lastPageUrl}">End</a>
            </c:if>
        </div>
    </c:if>
</div>
</div>
</div>
<script type="text/javascript">
    function showForm(reviewId) {
        var form = document.getElementById("myForm" + reviewId);
        if (form !== null) {
            form.style.display = "block";
            var textarea = form.querySelector('textarea');
            if (textarea) {
                textarea.focus();
            }
        } else {
            console.error("showform에러");
        }
    }

    function showForm2(reviewId) {
        var form = document.getElementById("myForm" + reviewId);
        if (form !== null) {
            form.style.display = "block";
            var textarea = form.querySelector('textarea');
            if (textarea) {
                textarea.focus();
            }
        } else {
            console.error("showform2에러");
        }
    }

    function cancelForm(reviewId) {
        var form = document.getElementById("form" + reviewId);
        if (form !== null) {
            form.reset(); 
            var formDiv = document.getElementById("myForm" + reviewId);
            if (formDiv !== null) {
                formDiv.style.display = "none"; 
            }
        } else {
            console.error("cancelError");
        }
    }
</script>