<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<jsp:include page="../header.jsp"/>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/stopStore.css">
<div class="store-container2">
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
    
<div class="stop-container">
<h1 class="tool-h1">가게일시중지</h1>
<h3>-일시중지 유의사항-</h3>
<label class="stop-label">▶일시중지기능은 <font style="color:red; font-weight: bold;"> 3일이내</font>만가능합니다.</label>
   <label class="stop-label">▶당일 중지는 즉시중지를 사용해주세요.</label>
   <label class="stop-label">※즉시중지: 중지를 누른시점에서  <font style="color:red; font-weight: bold;">24시간후 (분,초 올림) 정각</font>에 자동해제됩니다. 
   <br>ex)2024-06-24 09:09 -> 2024-06-25 10:00</label>

<br>




    <form name="f" action="/store/stopStorePro.do" method="post">
        <input type="hidden" name="storeid" value="${storeid}">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
        <input type="date" id='currentDatetime' readonly="readonly"/>~
        <input type="date" id='selectDatetime' name="selectDatetime" required pattern="\d{4}-\d{2}-\d{2}T"/>
        <input type="submit" value="가게일시중지" class="custom-button">    
    </form>
    <form name="ff" action="/store/instacestopStore.do" method="post">
    <input type="hidden" name="storeid" value="${storeid}">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
        <input type="submit" value="즉시중지" class="custom-button2"> 
    </form>
    <form name="fff" action="/store/runStore.do" method="post">
    <input type="hidden" name="storeid" value="${storeid}">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
        <input type="submit" value="영업시작" class="custom-button2"> 
    </form>
</div>
</div>
<script type="text/javascript">
    window.onload = function(){
        let offset = 1000 * 60 * 60 * 9;   // 한국 시간대로 맞춰주기 위해서 9시간을 더함
        let today = new Date(Date.now() + offset);
        let maxDate = new Date(today);
        maxDate.setDate(today.getDate() + 3); // 현재 시간에서 3일 후의 시간 설정

        document.getElementById('currentDatetime').value = today.toISOString().slice(0, 10);
        document.getElementById('selectDatetime').setAttribute("min", today.toISOString().slice(0, 10));
        document.getElementById('selectDatetime').setAttribute("max", maxDate.toISOString().slice(0, 10));

        // 최소 날짜 제한 및 경고 처리
        document.getElementById('selectDatetime').addEventListener('change', function(event) {
            let selectedDate = new Date(this.value);
            let selectedTimestamp = selectedDate.getTime();
            let currentTimestamp = today.getTime();
            let maxTimestamp = maxDate.getTime();

            if (selectedTimestamp < currentTimestamp) {
                alert('현재 날짜 이후의 날짜만 선택할 수 있습니다.');
                this.value = today.toISOString().slice(0, 10); // 현재 날짜로 설정
            } else if (selectedTimestamp > maxTimestamp) {
                alert('최대 선택 기간은 현재 날짜부터 3일 후까지입니다.');
                this.value = maxDate.toISOString().slice(0, 10); // 최대 날짜로 설정
            }
        });
    }
</script>
<jsp:include page="../footer.jsp"/>