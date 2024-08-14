<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- MyInfo.jsp -->
<jsp:include page="../header.jsp"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/myInfo.css">

<div align ="center">
<h1> MY INFO</h1>

 <div class="button-container">
    <button onclick="location.href='/store/ownerInfo.do'" class="my-info-button">내 정보</button>
    <button onclick="location.href='/store/storeInfo.do'" class="my-info-button">가게정보페이지</button>
</div>
<br>
<br>
<br>

</body>
</div>
<jsp:include page="../footer.jsp"/>