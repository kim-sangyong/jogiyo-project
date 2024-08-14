<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="../header.jsp"/>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/listNoticeC.js" ></script> 
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/table.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/listNotice.css">
<div align="center" style="margin-top: 80px; margin-bottom: 80px">
    <h1><span style="font-weight: bold; color:#fa0050; font-family: 'Gothic A1', sans-serif;">공지사항 목록  </span></h1>
    <div align="center" >
    <h4>
        <span style="font-weight: bold; color: black; font-family: 'Gothic A1', sans-serif;">
            <img src="${pageContext.request.contextPath}/resources/img/빨간 확성기.png" alt="1" style="vertical-align: middle; width: 24px; height: 24px; margin-right: 8px;">
            공지사항 페이지입니다.
        </span>
    </h4>
    <div class="notice-container" style="margin-top: 60px">
        <div class="notice-list" style="width: 70%; height: 385px;">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
            <table class="notice-table">
                <thead>
                    <tr>
                        <th style="background-color: #DDD; width: 30%;font-size: 20px; text-align: center; border-right: none;">Total</th>
     <th style="background-color: #DDD; width: 5%;font-size: 20px; text-align: center; border-right: none;">Date</th>
                    
     </thead>
                <tbody>
                    <c:forEach items="${rList}" var="dto">
                        <tr class="notice-row">
                            <td class="notice-cell"><a href="javascript:void(0);" onclick="viewNotice(${dto.notiid})">${dto.subject}</a></td>
                            <td class="notice-cell">${dto.indate}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>
</div>
<div class="pagination" style="display: inherit;">
            <c:if test="${pageCount > 1}">
                <c:set var="startPage" value="${currentPage - 2}"/>
                <c:if test="${startPage lt 1}">
                    <c:set var="startPage" value="1"/>
                </c:if>
                <c:set var="endPage" value="${currentPage + 2}"/>
                <c:if test="${endPage gt pageCount}">
                    <c:set var="endPage" value="${pageCount}"/>
                </c:if>
                <c:url value="/customer/notice.do" var="firstPageUrl">
                    <c:param name="page" value="1"/>
                    <c:param name="listNotice" value="${param.listNotice}"/>
                </c:url>
                <c:url value="/customer/notice.do" var="prevPageUrl">
                    <c:param name="page" value="${currentPage - 1}"/>
                    <c:param name="listNotice" value="${param.listNotice}"/>
                </c:url>
                <a href="${firstPageUrl}">First</a>
                <c:if test="${currentPage > 1}">
                    <a href="${prevPageUrl}">Previous</a>
                </c:if>
                <c:forEach begin="${startPage}" end="${endPage}" var="pageNumber">
                    <c:url value="/customer/notice.do" var="pageUrl">
                        <c:param name="page" value="${pageNumber}"/>
                        <c:param name="listNotice" value="${param.listNotice}"/>
                    </c:url>
                    <a href="${pageUrl}" class="${pageNumber == currentPage ? 'active' : ''}">${pageNumber}</a>
                </c:forEach>
                <c:url value="/customer/notice.do" var="nextPageUrl">
                    <c:param name="page" value="${currentPage + 1}"/>
                    <c:param name="listNotice" value="${param.listNotice}"/>
                </c:url>
                <c:if test="${currentPage lt pageCount}">
                    <a href="${nextPageUrl}">Next</a>
                </c:if>
                <c:url value="/customer/notice.do" var="lastPageUrl">
                    <c:param name="page" value="${pageCount}"/>
                    <c:param name="listNotice" value="${param.listNotice}"/>
                </c:url>
                <a href="${lastPageUrl}">End</a>
            </c:if>
        </div>
    
</div>
</div>
</div>

<jsp:include page="../footer.jsp"/>
