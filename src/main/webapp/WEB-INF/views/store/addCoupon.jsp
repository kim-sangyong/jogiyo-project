<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- addCoupon -->
<jsp:include page="../header.jsp"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/addCoupon.css">

<script>
   let ck=false;
   function check(){
      const jfrm = document.f;
      let length= jfrm.length -2;
      for(let i=0; i<length; i++){
         if(jfrm[i].value == "" || jfrm[i].value ==null){
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


<div class="coupon-container">
<h1 align="center" style="color: #fa0050; font-weight: bold;"> 쿠폰 추가 페이지</h1>
   <form name="f" action="addCouponOk.do" method="post" onsubmit="return check()" >
   <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
      <table>
         <tr>
            <th>쿠폰이름</th>
            <th>쿠폰내용</th>
            <th>가게고유번호</th>
            <th>확인/취소</th>
         </tr>
         <tr>
         <td><input type="text" name="couname" title="쿠폰이름" ></td>
         <td><textarea name="coucontent" title="쿠폰내용" placeholder="할인가격을 포함해주세요(,제외)"></textarea></td>
         <td><input type="text" name="storeid" value="${storeid}" title="가게번호" readonly="readonly"></td>
         <td><input type="submit" value="쿠폰추가">
               <input type="reset" value="취소"></td>
          </tr>
      </table>   
   </form>
</div>
</div>
</body>
</html>
<jsp:include page="../footer.jsp"/>