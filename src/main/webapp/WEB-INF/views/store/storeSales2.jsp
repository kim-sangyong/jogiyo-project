<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 가게 매출관리 페이지 -->
<jsp:include page="../header.jsp"/>
<jsp:include page="../js/storeSales2_js.jsp"/>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/storeSales.css">

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

<div class="sales-container2">
<div align="center" style="background-color: #fa0050; padding: 10px;">
    <span style="color: white;">시작날짜 : </span><input type="text" name="date1" id="date1" style="margin-right: 10px;"> 
    <span style="color: white;">종료날짜 : </span><input type="text" name="date2" id="date2" style="margin-right: 10px;"><br> 
    <input type="hidden" name="storeid" id="storeid" value="${storeid}">
    <input type="button" name="searchBtn" id="searchBtn" value="검색" onclick="indateSales()" style="background-color: white; color: #fa0050; border: none; padding: 5px 10px; margin-top: 10px; margin-right: 10px;"> 
    <input type="button" name="canBtn" id="canBtn" value="취소" style="background-color: white; color: #fa0050; border: none; padding: 5px 10px; margin-top: 10px;" onclick="cancelChart()">
</div>
<div class="content2">

<div id="canvasDiv" style="display: flex; justify-content: center;" align="center">
    <canvas id="logNameChart" style="width: 600px; height: 500px;"></canvas>
    <canvas id="logNameChart2" style="width: 600px; height: 500px;"></canvas>
</div>
</div>
</div>
</body>
</html>
<jsp:include page="../footer.jsp"/>