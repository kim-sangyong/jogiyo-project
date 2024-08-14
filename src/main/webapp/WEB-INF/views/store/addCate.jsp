<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 가게카테고리추가 페이지 -->
<jsp:include page="../header.jsp"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/addCate.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
let ck = false;

function check() {
    const jfrm = document.f;
    let length = jfrm.length - 4;
    for (let i = 0; i < length; i++) {
        if (jfrm[i].value == "" || jfrm[i].value == null) {
            alert(jfrm[i].title + "를 입력해주세요.");
            jfrm[i].focus();
            return false;
        }
    }
    return true;
}
</script>

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

    <div class="content">
        <h1>카테고리 추가</h1>
        <table>
        <form name="f" method="post" action="addCateOk.do" onsubmit="return check()">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
            <input type="hidden" name="storeid" value="${storeid}">
            <input type="text" name="jstorename" placeholder="메뉴카테고리 이름" title="카테고리이름">
            <button type="submit">확인</button>
            <button type="reset">취소</button>
        </form>
    </div>
</div>
</table>
<jsp:include page="../footer.jsp"/>

