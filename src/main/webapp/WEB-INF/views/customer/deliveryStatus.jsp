<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:include page="../header.jsp" />
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div align="center"><h2>배달상태 확인</h2>
<c:choose>
<c:when test="${delivery.run eq 0}">
	<h3>음식조리중</h3>
</c:when>
<c:when test="${delivery.run eq 1}">
	<h3>음식배달중</h3>
</c:when>
<c:when test="${delivery.run eq 2}">
	<h3>배달완료</h3>
</c:when>
</c:choose>
<div id="map" style="width: 350px; height: 350px;"></div></div>
<jsp:include page="../js/deliveryStatus_js.jsp" />
<jsp:include page="../footer.jsp" />