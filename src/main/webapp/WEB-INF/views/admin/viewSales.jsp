<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="../header.jsp" />
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="../js/viewSales_js.jsp"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/viewSales.css">
<div class="salesContainer">
    <div class="message">
        검색하려면 날짜를 입력하세요.
    </div>
    <div class="input-group">
        <span>시작 날짜 : </span><input type="text" name="cal1" id="cal1" class="date-input"> 
        <span>종료 날짜 : </span><input type="text" name="cal2" id="cal2" class="date-input"> 
        <input type="button" name="searchBtn" id="searchBtn" value="검색" onclick="dateList()"> 
        <input type="button" name="canBtn" id="canBtn" value="취소">
    </div>
</div>
<div id="canvasDiv" align="center">
        <!-- Chart canvases will be dynamically added here -->
    </div>
<jsp:include page="../footer.jsp" />
