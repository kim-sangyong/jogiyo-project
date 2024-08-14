<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="../header.jsp" />
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/listDelivery.css">
<div class="contain">
    <table class="table">
        <tr>
            <th>가게이름</th>
            <th>메뉴이름</th>
            <th>주문상태</th>
        </tr>
        <c:forEach items="${dlist}" var="de">
        <tr>
            <td><a class="link" href="${pageContext.request.contextPath}/customer/viewDelivery.do?deliveryid=${de.deliveryid}">${de.storename}</a></td>
            <td>${de.menuname}</td>
            <td>
                <c:choose>
                    <c:when test="${de.run eq 0}">
                        음식조리중
                    </c:when>
                    <c:when test="${de.run eq 1}">
                        음식배달중
                    </c:when>
                    <c:when test="${de.run eq 2}">
                        배달완료
                    </c:when>
                </c:choose>
            </td>
        </tr>
        </c:forEach>
    </table>
</div>

<jsp:include page="../footer.jsp" />
