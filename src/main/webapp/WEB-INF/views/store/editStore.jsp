<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 가게선택해서 수정하는페이지 -->
<jsp:include page="../header.jsp"/>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/addStore.css">

<script>
    
    function check() {
        const jfrm = document.forms['f'];
        let length = jfrm.length -3;
        for (let i = 0; i < length; i++) {
            if (jfrm[i].value == "" || jfrm[i].value == null) {
               alert(jfrm[i].getAttribute('title') + "를 입력해주세요.");
                jfrm[i].focus();
                return false;
            }
        }
        return true;
    }
      
</script>
<div align="center" style="margin-top: 80px;">
    <h1><span style="font-weight: bold; color:#fa0050; font-family: 'Gothic A1', sans-serif;">가게 정보</span></h1>
    <div align="center" style="margin-top: 40px;">
<div class="my-page-container">
    <c:forEach var="dto" items="${findStore}">
        <form name="f" action="/store/editStorePro.do" method="post" enctype="multipart/form-data" onsubmit="return check()">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
            <input type="hidden" name="storeid" value="${dto.storeid}">
            <input type="hidden" name="img" value="${dto.img}">
            
            <label for="storename" class="my-page-label">가게이름</label>
            <input type="text" id="storename" value="${dto.storename}" title="가게이름" name="storename" class="my-page-input">
            <br>
            <label for="cateid" class="my-page-label">카테고리</label>
            <select name="cateid" id="cateid" class="my-page-input" title="카테고리">
                <option value="90001" <c:if test="${dto.cateid eq '90001'}">selected</c:if>>한식</option>
                <option value="90002" <c:if test="${dto.cateid eq '90002'}">selected</c:if>>피자/양식</option>
                <option value="90003" <c:if test="${dto.cateid eq '90003'}">selected</c:if>>중식</option>
                <option value="90004" <c:if test="${dto.cateid eq '90004'}">selected</c:if>>족발/보쌈</option>
                <option value="90005" <c:if test="${dto.cateid eq '90005'}">selected</c:if>>일식/돈가스</option>
                <option value="90006" <c:if test="${dto.cateid eq '90006'}">selected</c:if>>야식</option>
                <option value="90007" <c:if test="${dto.cateid eq '90007'}">selected</c:if>>분식</option>
            </select>
            <br>
            <label for="storecontent" class="my-page-label" >가게설명</label>
            <textarea id="storecontent" rows="5" cols="20" name="storecontent" class="my-page-input" title="가게설명">${dto.storecontent}</textarea>
            <br>
            <label for="id" class="my-page-label">점주ID</label>
            <input type="text" id="id" value="${dto.id}" readonly="readonly" class="my-page-input" title="점주ID">
            <br>
            <label for="postcode" class="my-page-label">우편번호</label>
            <input type="text" name="postcode" id="postcode" placeholder="우편번호" value="${dto.postcode}" class="my-page-input" title="우편번호">
            <input type="button" onclick="execDaumPostcode()" value="우편번호 찾기"><br>
            <br>
            <label for="address" class="my-page-label">주소</label>
            <input type="text" name="address" id="address" placeholder="주소" value="${dto.address}" class="my-page-input" title="주소"><br>
            <br>
            <label for="detailAddress" class="my-page-label">상세주소</label>
            <input type="text" name="detailaddress" id="detailAddress" placeholder="상세주소" value="${dto.detailaddress}" class="my-page-input" title="상세주소">
            <br>
            <label for="extraAddress" class="my-page-label">참고항목</label>
            <input type="text" name="extraaddress" id="extraAddress" placeholder="참고항목" value="${dto.extraaddress}" class="my-page-input" title="참고항목"> 
            <br>
            <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
            <script>
                function execDaumPostcode() {
                    new daum.Postcode({
                        oncomplete: function(data) {
                            var addr = ''; // 주소 변수
                            var extraAddr = ''; // 참고항목 변수
                            if (data.userSelectedType === 'R') {
                                addr = data.roadAddress;
                            } else {
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
                            document.getElementById('postcode').value = data.zonecode;
                            document.getElementById("address").value = addr;
                            document.getElementById("detailAddress").focus();
                        }
                    }).open();
                }
            </script>
            
            <label class="my-page-label">가게 사진</label>
            <img src="${pageContext.request.contextPath}/resources/img/${dto.img}" width="100" height="100"><br>
            
            <label for="file" class="my-page-label">가게 이미지 수정하기</label>
            <input type="file" name="file" id="file" class="my-page-input">
            
            <div align="center">
                <input type="submit" value="수정" class="my-page-button">
                <input type="reset" value="취소" class="my-page-button">
            </div>
            
        </form>
        <form name="ff" action="/store/deleteStore.do">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
            <input type="hidden" value="${dto.storename}" name="storename">
            <div align="center">
                <input type="submit" value="가게 탈퇴" class="my-page-button">
            </div>
        </form>
    </c:forEach>
</div>
<jsp:include page="../footer.jsp"/>
