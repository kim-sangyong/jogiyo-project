<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:include page="../header.jsp" />
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/basket.css">


<div class="order-table-container">
        <div class="order-header">
            <h2>CART</h2>
        </div>
            <table class="order-table">
               <caption>표 제목 부분</caption>		<tbody>
			<tr>
				<th class="td_width_1"></th>
				<th class="td_width_2"></th>
				<th class="td_width_3">상품명</th>
				<th class="td_width_4">가격</th>
				<th class="td_width_4">수량</th>
				<th class="td_width_4">합계</th>
				<th class="td_width_4">삭제</th>
			</tr>
		</tbody>
	</table>
	<table>
		<caption>표 내용 부분</caption>
		<tbody>
			<c:forEach items="${basket}" var="ba" varStatus="loop">

				<tr class="basketTable">
					<td class="td_width_1" style="display: none;">${ba.menuid}</td>
					<td class="td_width_2">${ba.img}</td>
					<td class="td_width_3">${ba.menuname}</td>
					<td class="td_width_4 price_td"><span class="red_color"><fmt:formatNumber
								value="${ba.price}" pattern="##,### 원" /></span><br></td>
					<td class="td_width_4 table_text_align_center">
						<div class="table_text_align_center quantity_div">
							<%--input type에 id="bqty"추가 + button에 onlick으로 함수2개 추가 --%>
							<input type="hidden" value="${ba.storeid}" class="storeid_input">
							<input type="hidden" value="${ba.jscateid}" class="cateid_input">
							<button class="quantity_btn minus_btn" onclick="minusQty(${loop.index})">-</button>
							<input type="text" value="${ba.qty}" class="quantity_input" id="bqty${loop.index}">
							<button class="quantity_btn plus_btn"  onclick="plusQty(${loop.index})">+</button>
							<a class="quantity_modify_btn" onclick="updateQuantity(${loop.index}, ${ba.basketid})">변경</a>
						</div>  
					</td>

					<td class="td_width_4"><span class="red_color"><fmt:formatNumber
								value="${ba.totprice}" pattern="##,### 원" /></span><br></td>
					 <td class="td_width_4 table_text_align_center delete_btn">
                              <button onclick="deleteBasket(${ba.basketid})" class="button-field-del">삭제</button></td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<table class="order-table">
		<td class="actions" >
			<button onclick="viewStore(${storeid})" href="#">메뉴추가</button>
		</td>
	</table>
	
	<!-- 쿠폰 -->
         	
				<table class="order-table"> 
				    <c:forEach items="${cCoupon}" var="co">
				   
				        <tr>
				            <td>
				                <input type='radio' name='coupon'data-content='${co.coucontent}' value='${co.usercid}' />
				            </td>
				            <td>
				                ${co.couname} : ${co.coucontent}
				            </td>
				           
				        </tr>
				    </c:forEach>
				</table>
    	<!-- 쿠폰 -->
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
<table class="order-table">
	<tr>
		
	
	</tr>
</table>
</div>
<jsp:include page="../js/basket_js.jsp" />
<jsp:include page="../footer.jsp" />