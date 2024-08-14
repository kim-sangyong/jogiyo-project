<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:include page="../header.jsp" />

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/star.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/viewStore.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
function openTab(evt, tabName) {
	var i, tabcontent, tablinks;
	tabcontent = document.getElementsByClassName("tabcontent");
	for (i = 0; i < tabcontent.length; i++) {
		tabcontent[i].style.display = "none";
	}
	
	tablinks = document.getElementsByClassName("tablinks");
	for (i = 0; i < tablinks.length; i++) {
		tablinks[i].className = tablinks[i].className
				.replace(" active", "");
	}
	
	document.getElementById(tabName).style.display = "block";
	evt.currentTarget.className += " active";
}

function toggleDropdown(button) {
	button.classList.toggle("active");
}
</script>
<div align="center">
    <span>${store.storename}</span>
    <input type="hidden" name ="storeid" value="${store.storeid}"/>
    <hr>
    <img src="${pageContext.request.contextPath}/resources/img/${store.img}">
    <div class="tab">
        <button class="tablinks" onclick="openTab(event, 'Menu')" id="defaultOpen">메뉴</button>
        <button class="tablinks" onclick="openTab(event, 'Review')" id="reviewOpen">리뷰</button>
        <button class="tablinks" onclick="openTab(event, 'Info')">정보</button>
        <button class="tablinks" onclick="openTab(event, 'coupon')">쿠폰</button>
    </div>

    <div id="Menu" class="tabcontent">
        <h3>메뉴 탭</h3>
        <c:forEach items="${menuMap}" var="map" varStatus="sta">
            <div class="dropdown">
                <button class="dropbtn active" onclick="toggleDropdown(this)">${map.key}</button>
                <div class="dropdown-content">
                    <c:forEach items="${map.value}" var="menu" varStatus="status">
                        <div class="menu-item" id="menuItemsContainer">
                            <c:if test="${menu.mqty==1}">
                                <div class="menu-item-content">
                                <img src="${pageContext.request.contextPath}/resources/img/${menu.img}"><br><br>
                                    <span class='label'>
                                        <input type='checkbox' id='dataInput${sta.index}${status.index}' name='menu' class="check_btn" value='${menu.menuid}' />
                                        <label for="dataInput${sta.index}${status.index}" class="menu-item-title" style="color: black;">${menu.menuname}</label><br>
                                   		<span class="menu-item-description">${menu.menucontent}</span>
                                    </span>
                                </div>
                                <div class="menu-item-price">${menu.price}</div>원
                                <div class="menu-item-qty">
                                    <select>
                                        <option value="1">1</option>
                                        <option value="2">2</option>
                                        <option value="3">3</option>
                                        <option value="4">4</option>
                                        <option value="5">5</option>
                                    </select>
                                </div>
                            </c:if>
                            <c:if test="${menu.mqty==0}">
                                <div class="menu-item-content">
                                <img src="${pageContext.request.contextPath}/resources/img/${menu.img}"><br><br>
                                    <span class='label'>
                                        <input type='checkbox' disabled id='dataInput${sta.index}${status.index}' name='menu' class="check_btn" value='${menu.menuid}' />
                                        <label for="dataInput${sta.index}${status.index}" class="menu-item-title" style="color: black;">${menu.menuname}[품절]</label><br>
                                        <span class="menu-item-description">${menu.menucontent}</span>
                                    </span>
                                </div>
                                <div class="menu-item-price">${menu.price}</div>원
                                <div class="menu-item-qty">
                                    <select disabled>
                                        <option value="1">품절</option>
                                    </select>
                                </div>
                            </c:if>
                        </div>
                    </c:forEach>
                	
                </div>
            </div>
        </c:forEach>
       	 <!-- 쿠폰 -->
         	<h4>사용가능한 쿠폰</h4>
				<table class="order-table">
				    <c:forEach items="${cCoupon}" var="co">
				        <tr>
				            <td>
				                <input type='radio' name='coupon' data-content='${co.coucontent}' value='${co.usercid}' />
				            </td>
				            <td>
				                ${co.couname} : ${co.coucontent}
				            </td>
				        </tr>
				    </c:forEach>
				</table>
    	<!-- 쿠폰 -->
        <button class="button_btn" onclick='insertBasket()'>장바구니 담기</button>
        <button type="button" class="button_btn" onclick="directPay()">주문서 전송</button>
        <div id="result"></div>

        <form id="orderForm" action="/customer/directPay.ajax" method="POST"  enctype="multipart/form-data">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
            <!--<input type="hidden" id="sub" name="sub">
             <input type="hidden" id="sub2" name="sub2" value="${store.storename}"> -->
            </form>
    		
       
    </div>
    <div id="Review" class="tabcontent">
        <form method="post" action="/customer/insertReview.do" enctype="multipart/form-data">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
            <input type="hidden" name="storeid" value="${store.storeid}">
            <ul id="main">
                <li>
                    <ul class="row">
                        <li>별점</li>
                        <li>
                            <fieldset>
                                <input type="radio" name="grade" value="5" id="rate5"><label for="rate5">⭐</label>
                                <input type="radio" name="grade" value="4" id="rate4"><label for="rate4">⭐</label>
                                <input type="radio" name="grade" value="3" id="rate3"><label for="rate3">⭐</label>
                                <input type="radio" name="grade" value="2" id="rate2"><label for="rate2">⭐</label>
                                <input type="radio" name="grade" value="1" id="rate1"><label for="rate1">⭐</label>
                            </fieldset>
                        </li>
                    </ul>
                </li>
                <li>
                    <h3>리뷰 탭</h3>
                    리뷰내용 : <textarea placeholder="리뷰내용을 써주세요" name="revcotent"></textarea>
                    <input type="file" name="file"><br>
                    <input type="submit" value="작성">
                </li>
            </ul>
        </form>
        <c:forEach items="${review}" var="re">
            <li class="review-item">
                <div class="review-content">
                <img src="${pageContext.request.contextPath}/resources/img/${re.img}" style="width: 20%; height: 20%;">
                    <h2>${re.revcotent}</h2>
                    <c:if test="${not empty re.reply}">
                        <p class="reply">↳${re.reply}</p>
                    </c:if>
                </div>
                <div class="star-rating">
                    <fieldset>
                        <input type="radio" id="star${re.grade}-5" disabled ${re.grade ge 5 ? 'checked' : ''}><label for="star${re.grade}-5"></label>
                        <input type="radio" id="star${re.grade}-4" disabled ${re.grade ge 4 ? 'checked' : ''}><label for="star${re.grade}-4"></label>
                        <input type="radio" id="star${re.grade}-3" disabled ${re.grade ge 3 ? 'checked' : ''}><label for="star${re.grade}-3"></label>
                        <input type="radio" id="star${re.grade}-2" disabled ${re.grade ge 2 ? 'checked' : ''}><label for="star${re.grade}-2"></label>
                        <input type="radio" id="star${re.grade}-1" disabled ${re.grade ge 1 ? 'checked' : ''}><label for="star${re.grade}-1"></label>
                    </fieldset>
                    <p>${re.grade}</p>
                </div>
            </li>
        </c:forEach>
    </div>

    <div id="Info" class="tabcontent">
        <h3>${store.storecontent}</h3>
        <p>가게이름: ${store.storename}</p>
        <p>가게위치: ${store.address}</p>
        <div id="map" style="width:350px;height:350px;"></div>
    </div>
    
     <div id="coupon" class="tabcontent">
        <h3>${store.storename}쿠폰</h3>
        
        <ul class="cp_list">
	        <c:forEach items="${storecou}" var="scou">
	        <li class="cp_items">
	             <a class="cpn" href="javascript:void(0);" onclick="submitCouponForm(${scou.couponid});">
	                <div class="cpn_txt">
	                    <p class="cpn_tit">${scou.couname}</p>
	                    <p class="cpn_desc">${scou.coucontent}</p>
	                </div>
	            </a>
	        
	        </li>
	        </c:forEach>
    	</ul>
    </div>

    
</div>
<script type="text/javascript">
if ("${isReview}" === "ok") {
    document.getElementById("reviewOpen").click();
} else{
	document.getElementById("defaultOpen").click();
}
</script>
<jsp:include page="../js/viewStore_js.jsp"/>
<jsp:include page="../footer.jsp" />