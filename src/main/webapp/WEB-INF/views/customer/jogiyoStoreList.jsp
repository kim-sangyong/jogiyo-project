<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="../header.jsp"/>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/jogiyoStoreList.css">
<jsp:include page="../js/jogiyoStoreList_js.jsp"/>   
    <div class="container">
        <div class="order-header">
            <h2>Store List</h2>
        </div>
        <c:if test="${not empty cateList}">
       <div class="sorting">
        <label for="cateid">Choose a category:</label>
        <select name="cateid" id="select" >
            <c:forEach items="${cateList}" var="cate">
                <option value="${cate.cateid}" >${cate.catename}</option>
            </c:forEach>
        </select>
        <input type="button" name="searchBtn" id="searchBtn" value="선택" onclick="cateList()" class="s_btn">
        </div>
        </c:if>
        <div class="listings" id="storeList" >
            <c:if test="${not empty storeList}" >
            <c:forEach items="${storeList}" var="store">
            <c:if test="${store.run==1}">
                  <div class="listing">
                  <!-- 윤장호 0703수정 -->
                        <img src="${pageContext.request.contextPath}/resources/img/${store.img}" width="80" height="80">
                        <div class="details">
                            <h2><a onclick="viewStore(${store.storeid})" href="#"> ${store.storename} </a></h2>
                            <div class="rating">${store.rev_avg} ★</div>
                            <div class="reviews">리뷰  ${store.row_count} | 사장님댓글  ${store.reply_count}</div>
                            <div class="min_order">가게설명 | ${store.storecontent}</div>
                            <div class="discount">쿠폰 | ${store.couponid}</div>
                        </div>
                    </div>
      		</c:if>
      		<c:if test="${store.run==0}">
                  <div class="listing active">
                        <img src="${pageContext.request.contextPath}/resources/img/${store.img}" width="80" height="80" >
                        <div class="details">
                            <h2> ${store.storename}  </h2>
                            	<br>
                            <div class="rating">${store.rev_avg} ★</div>
                            <div class="reviews">리뷰 ${store.row_count} | 사장님댓글  ${store.reply_count}</div>
                            <div class="min_order">가게설명 | ${store.storecontent}</div>
                            <div class="discount">쿠폰 | ${store.couponid}</div>
                        </div>
                    </div>
      		</c:if>
            </c:forEach>
            </c:if>
       </div>
          <a onclick="viewStore(${store.storeid})" href="#"></a>
    </div>
<jsp:include page="../footer.jsp"/>

