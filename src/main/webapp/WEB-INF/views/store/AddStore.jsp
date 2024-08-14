<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="../header.jsp" />
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/addStore.css">
<script>

function check() {
    const jfrm = document.f;
    let length = jfrm.length - 1;
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
<div align="center" style="margin-top: 80px;">
    <h1><span style="font-weight: bold; color:#fa0050; font-family: 'Gothic A1', sans-serif;">가게 추가</span></h1>
    <div align="center" style="margin-top: 40px;">
<div class="my-page-container" >
    <form name="f" action="/store/AddStore.do" method="POST" enctype="multipart/form-data" onsubmit="return check()">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
        
            
                <label for="storename" class="my-page-label">가게이름</label>
               <input type="text" name="storename" title="가게이름" class="my-page-input" placeholder="가게 이름 입력(필수)" >
           
           
                <label for="cateid" class="my-page-label" >카테고리</label>
               
                    <select name="cateid" title="카테고리" class="select">
                    <c:forEach items="${clist}" var="cate">
                        <option value="${cate.cateid}">${cate.catename}</option>
                    </c:forEach>
                    </select>
<br></br>
              <label for="cateid" class="my-page-label"> 가게설명 </label>
                <textarea rows="5" cols="30" name="storecontent" title="가게설명" placeholder="가게 설명을 입력하시오."></textarea>
           
            <br></br>
              <label for="id" class="my-page-label"> ID </label>
                <input type="text" name="id" value="${jId}" readonly class="my-page-input">
            
                 <label for="address" class="my-page-label"> 가게위치 </label>
               
                    <input type="text" name="postcode" id="postcode" placeholder="우편번호" title="우편번호" class="my-page-input">
                    <input type="button" onclick="execDaumPostcode()" value="우편번호 찾기" class="my-page-button">
                    <input type="text" name="address" id="address" placeholder="주소" title="주소" class="my-page-input"><br>
                    <input type="text" name="detailaddress" id="detailAddress" placeholder="상세주소" title="상세주소" class="my-page-input">
                    <input type="text" name="extraaddress" id="extraAddress" placeholder="참고항목" title="참고항목" class="my-page-input">
         
             <label for="file" class="my-page-label"> 가게사진 </label>
                <input type="file" name="file" title="가게사진" class="my-page-input">
          
                <!--   <label for="couponid" class="my-page-label"> 쿠폰 (없으면0을 입력해주세요):</label>
                <input type="text" name="couponid" title="쿠폰" class="my-page-input">-->
            
               
                    <input type="submit" value="확인" class="my-page-button">
                    <input type="reset" value="취소" class="my-page-button">
                
        
    </form>
</div>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
function execDaumPostcode() {
    new daum.Postcode({
        oncomplete : function(data) {
            var addr = ''; // 주소 변수
            var extraAddr = ''; // 참고항목 변수

            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                addr = data.roadAddress;
            } else { // 사용자가 지번 주소를 선택했을 경우(J)
                addr = data.jibunAddress;
            }

            if (data.userSelectedType === 'R') {
                if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
                    extraAddr += data.bname;
                }
                if (data.buildingName !== '' && data.apartment === 'Y') {
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                if (extraAddr !== '') {
                    extraAddr = ' (' + extraAddr + ')';
                }
                document.getElementById("extraAddress").value = extraAddr;
            } else {
                document.getElementById("extraAddress").value = '';
            }

            document.getElementById("postcode").value = data.zonecode;
            document.getElementById("address").value = addr;
            document.getElementById("detailAddress").focus();
        }
    }).open();
}





</script>
<jsp:include page="../footer.jsp" />
