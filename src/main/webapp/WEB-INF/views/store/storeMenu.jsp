<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/sMenu.css">
<jsp:include page="../header.jsp"/>
<div class="store-container">
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
    <div class="content">
    <div align="center" style="margin-top: 10px;">
    <h1 class="tool-h1" align="center">가게 메뉴관리페이지</h1>
    <div style="text-align: center; ">
        <div class="button2">
            <a href="/store/addMenu.do?storeid=${storeid}">+메뉴 추가</a>
        </div>
        <table align="center">
            <tr>
                <th>메뉴사진</th>
                <th>메뉴이름</th>
                <th>카테고리</th>
                <th>메뉴설명</th>
                <th>메뉴가격</th>
                <th>수정/삭제</th>
                <th>메뉴품절/재개</th>
            </tr>
            <c:forEach var="dto" items="${mlist}">
                <tr>
                    <td><img src="${pageContext.request.contextPath}/resources/img/${dto.img}" width="80" height="80"></td>
                    <td>${dto.menuname}
                        <c:if test="${dto.mqty==1}">[재고있음]</c:if>
                        <c:if test="${dto.mqty==0}">[품절]</c:if>
                    </td>
                    <td>${dto.jstorename}</td>
                    <td>${dto.menucontent}</td>
                    <td><fmt:formatNumber type="number" maxFractionDigits="3" value="${dto.price}"></fmt:formatNumber>￦</td>
                    <td>
                        <form name="f" method="post" action="/store/editMenu.do" onsubmit="return confirm('메뉴 수정페이지로 이동합니다');">
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                            <input type="hidden" value="${dto.menuid}" name="menuid">
                            <input type="hidden" value="${dto.storeid}" name="storeid">
                            <button type="submit">수정</button>
                        </form>
                        <form name="ff" action="/store/deleteMenu.do" onsubmit="return confirm('정말 메뉴를 삭제하시겠습니까?');">
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                            <input type="hidden" value="${dto.menuid}" name="menuid">
                            <input type="hidden" value="${dto.storeid}" name="storeid">
                            <button type="submit">삭제</button>
                        </form>
                    </td>
                    <td>
                        <form name="fff" action="/store/stopMenu.do" onsubmit="return confirm('해당메뉴를 품절처리하시겠습니까?');">
                            <input type="hidden" value="${dto.menuid}" name="menuid">
                            <input type="hidden" value="${dto.storeid}" name="storeid">
                            <button type="submit">품절</button>
                        </form>
                        <form name="ffff" action="/store/startMenu.do" onsubmit="return confirm('해당메뉴를 재개하시겠습니까?');">
                            <input type="hidden" value="${dto.menuid}" name="menuid">
                            <input type="hidden" value="${dto.storeid}" name="storeid">
                            <button type="submit">품절취소</button>
                        </form>
                    </td>
                </tr>
            </c:forEach>
        </table>
    </div>
</div>
</div>
