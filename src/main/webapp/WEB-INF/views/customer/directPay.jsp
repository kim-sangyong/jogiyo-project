<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="../header.jsp" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/directPay.css">
<jsp:include page="../js/directPay_js.jsp" />

<div align="center" class="order-table-container">
     <div class="order-header">
            <h2>주문서</h2>
        </div>
          
    <div id="orderList"></div>
    <div class="form-group-wrap">
        <div class="form-group">
            <input type="text" name="postcode" id="postcode" placeholder="우편번호" title="우편번호" class="input-field">
            <input type="button" onclick="execDaumPostcode()" value="우편번호 찾기" class="button-field">
        </div>
        <div class="form-group">
            <input type="text" name="address" id="address" placeholder="주소" title="주소" class="input-field">
        </div>
        <div class="form-group">
            <input type="text" name="detailaddress" id="detailAddress" placeholder="상세주소" title="상세주소" class="input-field">
        </div>
        <div class="form-group">
            <input type="text" name="extraaddress" id="extraAddress" placeholder="참고항목" title="참고항목" class="input-field">
        </div>
        <button type="button" onclick="Pay()" class="button-field button-pay">결제하기</button>
    </div>
   
</div>


<jsp:include page="../footer.jsp" />
