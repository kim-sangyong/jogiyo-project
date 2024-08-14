<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="mainHeader.jsp"/>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript">
window.onload = function() {
	if(${result}){
    	var features = "menubar=no, toolbar=no, width=500, height=700";
    	window.open('${pageContext.request.contextPath}/indexNotice.do', '_blank', features);
	}
};
</script>
<div class="container">
    <div class="categories">
        <a href="${pageContext.request.contextPath}/customer/storeList.do" class="category">
                <div class="category-content">
                    <img src="${pageContext.request.contextPath}/resources/img/category-01.png" alt="1">
                    <p>전체보기</p>
                </div>
            </a>
        <c:forEach items="${cateList}" var="dto">
            <a href="${pageContext.request.contextPath}/customer/storeList.do?cateId=${dto.cateid}" class="category">
                <div class="category-content">
                    <img src="${pageContext.request.contextPath}/resources/img/${dto.img}" alt="${dto.catename}">
                    <p>${dto.catename}</p>
                </div>
            </a>
        </c:forEach>
    </div>
</div>
   <jsp:include page="mainFooter.jsp"/>