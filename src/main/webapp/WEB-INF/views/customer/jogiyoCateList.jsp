<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="../header.jsp"/>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/jogiyoCateList.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jogiyoCateList.js" ></script> 
     <div class="container">
        <div class="order-header">
            <h2>카테고리별 가게</h2>
        </div>
		<div class="sorting">
        <label for="cateid">Choose a category:</label>
        <select name="cateid" id="sortOptions" onchange="CateList(this.value)">
            <c:forEach items="${cateList}" var="cate">
                <option value="${cate.cateid}" >${cate.catename}</option>
            </c:forEach>
        </select>
        <input type="submit" value="선택">
    	 </div>
        <div class="listings">
        <c:forEach items="${cateStoreList}" var="cateS"> 
                <div class="listing">
                <img src="${pageContext.request.contextPath}/resources/img/${dto.img}" width="80" height="80"> 
                 <div class="details">  
                   <h2><a onclick="viewStore(${cateS.storeid})" href="#"> ${cateS.storename} </a></h2>
						<div class="rating">4.8 ★</div>
						<div class="reviews">리뷰 3537 | 사장님댓글 2694</div>
						<div class="min_order">가게설명 | ${cateS.storecontent}</div>
                        <div class="discount">쿠폰 | ${cateS.couponid}</div>
                        <div class="time">22-37분</div>
                    </div>
                </div>
      </c:forEach>
    </div>
    <a onclick="viewStore(${cateS.storeid})" href="#"></a>
    </div>     

<jsp:include page="../footer.jsp"/>

