<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 메뉴수정페이지 -->
<jsp:include page="../header.jsp"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/editMenu.css">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <meta charset="UTF-8">
    
    
</head>
<body>
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
        <div align="center" style="margin-top: 80px;">
    <h1>메뉴 수정 페이지</h1>
    <div align="center" style="margin-top: 40px;">
        <form name="f" action="/store/editMenuPro.do" method="post" enctype="multipart/form-data" onsubmit="return check()">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
            <input type="hidden" name="menuid" value="${getMenu[0].menuid}">
            <input type="hidden" name="storeid" value="${getMenu[0].storeid}">
            <table>
                <tr>
                    <th>카테고리:</th>
                    <td>
                        <select name="jscateid" title="카테고리">
                            <c:forEach var="dto" items="${cateList}">
                                <option value="${dto.jscateid}" ${dto.jscateid == getMenu[0].jscateid ? 'selected' : ''}>${dto.jstorename}</option>
                            </c:forEach>
                        </select>
                    </td>
                </tr>
                <tr>
                    <th>메뉴이름:</th>
                    <td><input type="text" name="menuname" value="${getMenu[0].menuname}" title="메뉴이름"></td>
                </tr>
                <tr>
                    <th>가게설명:</th>
                    <td><textarea name="menucontent" title="메뉴설명">${getMenu[0].menucontent}</textarea></td>
                </tr>
                <tr>
                    <th>가격:</th>
                    <td><input type="text" name="price" title="메뉴가격" value="${getMenu[0].price}" pattern="\d*" title=",없이 숫자만 입력해주세요"></td>
                </tr>
                <tr>
                    <th>기존 가게이미지:</th>
                    <td><img src="${pageContext.request.contextPath}/resources/img/${getMenu[0].img}" width="80" height="80"></td>
                </tr>
                <tr>
                    <th>가게이미지 수정하기:</th>
                    <td><input type="file" name="file"></td>
                </tr>
                <tr>
                    <td colspan="2" align="center">
                        <input type="submit" value="수정하기" class="edit_in">
                        <input type="reset" value="취소" class="edit_in">
                    </td>
                </tr>
            </table>
        </form>
    </div>
</div>
</div>
</div>
<script>
    function check() {
        const jfrm = document.f;
        let length = jfrm.length - 3;
        for (let i = 0; i < length; i++) {
            if (jfrm[i].value === "" || jfrm[i].value === null) {
                alert(jfrm[i].title + "를 입력해주세요.");
                jfrm[i].focus();
                return false;
            }
        }
        return true;
    }
</script>

