<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="../header.jsp" />
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/listAcc.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/listAcc.js"></script> 
<div align="center">
    <select id="select" class="styled-select">
        <option value="ROLE_2">점주</option>
        <option value="ROLE_3">이용객</option>
    </select>
    <input type="button" name="searchBtn" id="searchBtn" value="검색" onclick="accList()" class="btn btn-search">
    <table id="accountTable" class="styled-table">
    </table>
</div>
<jsp:include page="../footer.jsp" />
