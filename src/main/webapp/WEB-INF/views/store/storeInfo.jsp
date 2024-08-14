<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 가게정보페이지 -->
<jsp:include page="../header.jsp"/>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/storeInfo.css">



<div class="listings">
    <c:forEach var="dto" items="${getStore}">
        <div class="listing">
            <img src="${pageContext.request.contextPath}/resources/img/${dto.img}" alt="가게이미지">
            <div class="details">
                <h2>${dto.storename}</h2>
               
                <div class="min_order">가게카테고리: ${dto.catename}</div>
                <div class="min_order">가게위치: ${dto.address} | ${dto.detailaddress} | ${dto.extraaddress}</div>
                <div class="min_order">가게 주인id: ${dto.id}</div>
                <form class="modify-form" name="f" method="post" action="/store/editStore.do" onsubmit="return confirm('해당 가게를 수정하시겠습니까?');">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                     <input type="hidden" name="storeid" value="${dto.storeid}">
                    <input type="submit" value="수정하기">
                </form>
            </div>
        </div>
    </c:forEach>
</div>

<jsp:include page="../footer.jsp"/>