<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<jsp:include page="../header.jsp"/>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/storeInfo.css">
<script>
function editStore(storeid){
   var confirmed= confirm('해당 가게로 이동하시겠습니까?');
   if(confirmed){
   //var storeid = document.getElementById('storeid').value;
   location.href="/store/editStore.do?storeid="+storeid;
   return true;
   }else{
      return false;
   }
   
}
</script>
<div class="container">
<div class="listings">
    <c:forEach var="dto" items="${getStore}">
        <div class="listing">
            <img src="${pageContext.request.contextPath}/resources/img/${dto.img}" alt="가게이미지">
            <div class="details">
                <h2>${dto.storename}</h2>
                <div class="min_order">가게카테고리: ${dto.catename}</div>
                <div class="min_order">가게위치: ${dto.address} | ${dto.detailaddress} | ${dto.extraaddress}</div>
                <div class="min_order">가게 주인id: ${dto.id}</div>
                <form class="modify-form" name="f" method="post" action="/store/selectStore.do" onsubmit="return confirm('해당 가게로 이동하시겠습니까?');">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                     <input type="hidden" name="storeid" value="${dto.storeid}" id="storeid">
                     <input type="hidden" name ="storename" value="${dto.storename}">
                     <input type="button" value="수정하기" onclick="editStore(${dto.storeid})">
                    <input type="submit" value="이동하기">
                </form>
            </div>
        </div>
    </c:forEach>
</div>
</div>
<jsp:include page="../footer.jsp"/>
 
 <!--  
	<div align="center">
	<table>
	<tr>
	<th>가게이미지</th>
	<th>가게이름</th>
	<th>가게카테고리</th>
	<th>가게위치</th>
	<th>가게 주인id</th>
	</tr>
	
	<c:forEach var="dto" items="${getStore}">
	<tr>
	
	<td><img src="${pageContext.request.contextPath}/resources/img/${dto.img}" width="80" height="80"></td>
	<td>${dto.storename}</td>
	<td>${dto.catename}</td>
	<td>${dto.address}<br>
	${dto.detailaddress}
	${dto.extraaddress}</td>
	<td>${dto.id}</td>
	
	<form name ="f"  method="post"  action="/store/selectStore.do" onsubmit="return confirm('해당가게로 이동하시겠습니까?');">
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	<input type="hidden" name ="storename" value="${dto.storename}">
	<input type="hidden" name = "storeid" value="${dto.storeid}">
	<td><input type="submit" value="이동하기"></td>
	</form>
	</tr>
	</c:forEach>
	
	</table>
	</div>

</html>
-->