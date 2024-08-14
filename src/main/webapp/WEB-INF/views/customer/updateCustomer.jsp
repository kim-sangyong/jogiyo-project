<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="../header.jsp"/>
<jsp:include page="../js/updateCustomer_js.jsp"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/myPageUpdate.css">
<div class="my-page-container">
    <h1 class="my-page-title">회원 정보 수정</h1>

    <form action="/customer/updateOk.do" method="post" class="my-page-form">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

        <label for="id" class="my-page-label">ID:</label>
        <input type="text" id="id" name="id" value="${customer.id}" readonly="readonly" class="my-page-input"><br>

        <label for="name" class="my-page-label">Name:</label>
        <input type="text" id="name" name="name" value="${customer.name}" class="my-page-input"><br>

        <label for="mail" class="my-page-label">Email:</label>
        <input type="text" id="mail" name="mail" value="${customer.mail}" class="my-page-input"><br>

        <label for="phone" class="my-page-label">Phone:</label>
        <input type="text" id="phone" name="phone" value="${customer.phone}" class="my-page-input"><br>

        <label for="passwd1" class="my-page-label">현재 비밀번호:</label>
        <input type="password" id="passwd1" name="passwd1" value="" class="my-page-input">
        

        <label for="passwd2" class="my-page-label">변경할 비밀번호:</label>
        <input type="password" id="passwd2" name="passwd2" value="" class="my-page-input"><br>

        <label for="passwd" class="my-page-label">변경할 비밀번호 확인:</label>
        <input type="password" id="passwd" name="passwd" value="" class="my-page-input"><br>
        <div align="center">
		<input type="button" onclick="checkPass()" name="checkPasswd" id="checkPasswd" value="비밀번호 확인">
        <button type="submit" id="btn" class="my-page-button" disabled="disabled">Update</button>
    	</div>
    </form>
    <div class="my-page-message" id="message"></div>
</div>

<jsp:include page="../footer.jsp"/>

