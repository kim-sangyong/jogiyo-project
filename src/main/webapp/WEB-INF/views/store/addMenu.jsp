<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 메뉴추가페이지 -->
<jsp:include page="../header.jsp"/>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/addMenu.css">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script>
	let ck=false;
	function check(){
		const jfrm = document.f;
		let length= jfrm.length -1;
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





	<div class="add-container2">
		
		
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
<div class="content2">
<div class="addMenu">
<h2>메뉴 추가페이지</h2>
 			
 		
 			<form name="f" action ="/store/addMenuPro.do" method="post" enctype="multipart/form-data" onsubmit="return check()">
 			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
 			<input type ="hidden" name="storeid" value="${storeid}">
 			<table>
 			<tr>
 			<th>가게 카테고리:</th>
 			<td>
 			 <select name="jscateid" title="카테고리">
 			 <c:forEach var="dto" items="${cateList}">
 			 <option value="${dto.jscateid}">${dto.jstorename}</option>
 			 </c:forEach>
 			 </select>
 			 </td>
 			 </tr>
			<tr>
				<th>메뉴이름:</th>
					<td> <input type="text" name = "menuname" title="메뉴이름"></td>
			</tr>
			<tr>
				<th>
				메뉴설명:</th>
				<td><textarea name="menucontent" title="메뉴설명" placeholder="메뉴설명을 적어주세요."></textarea></td>
				
			</tr>
			<tr>
				<th>메뉴가격:</th>
				<td><input type="text" name="price" placeholder=",없이 입력해주세요" title="가격"></td>
			</tr>
			<tr>
				<th>메뉴사진:(메뉴사진은 필수입니다)</th>
				<td><input type ="file" name="file" title="메뉴사진"></td>
			</tr>
			<tr>
				<td colspan="2" align="center">
				<input type="submit" value="추가하기">
				<input type="reset" value="취소하기"></td>
			</tr>
			</table>
			</form>
 		</div>
 		</div>
	</div>
<jsp:include page="../footer.jsp"/>