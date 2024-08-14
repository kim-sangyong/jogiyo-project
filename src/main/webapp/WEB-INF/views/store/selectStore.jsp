<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 리스트에서 가게눌렀을때page -->
<jsp:include page="../header.jsp"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/storeToolbar.css">
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<div class="store-container2">
    <div class="toolbar" style="font-family: Arial, sans-serif;">
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
        <h1 class="tool-h1">주문목록 ${run}</h1>

        <table class="table" style="width: 80%;" align="center">
            <tr>
                <th style="text-align: center;" class="th">고객id(콜)</th>
                <th style="text-align: center;"  class="th">주문일자</th>
                <th style="text-align: center;"  class="th">주문메뉴</th>
                <th style="text-align: center;"  class="th">수량</th>
                <th style="text-align: center;"  class="th">총 가격</th>
             <%--  <th style="text-align: center;"  class="th">주문받기/주문취소</th>--%>  
            </tr>
            <c:if test="${empty orderList}">
                <tr>
                    <th colspan="6" class="empty-message" ><br><br><br>최근 주문내역이 없습니다.<br><br><br><br></th>
                </tr>
            </c:if>
            <c:forEach var="dto" items="${orderList}">
                <tr align="center">
                    <td class="td">${dto.id}<br>${dto.phone}</td>
                    <td class="td">${dto.indate}</td>
                    <td class="td">${dto.menuname}</td>
                    <td class="td">${dto.qty}개</td>
                    <td class="td"><fmt:formatNumber type="number" maxFractionDigits="3" value="${dto.totprice}"></fmt:formatNumber>￦</td>
                    <%-- <td class="td">
                        <input type="button" value="주문받기" class="custom-button"/>
                        <input type="button" value="주문취소" class="custom-button" />
                    </td>--%>
                </tr>
            </c:forEach>
        </table>
  </div>
</div>

<jsp:include page="../footer.jsp"/>
