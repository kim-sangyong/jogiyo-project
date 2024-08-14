<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>  
<jsp:include page="../header.jsp"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/myPage.css">

<div align="center" style="margin-top: 80px;">
    <h1><span style="font-weight: bold; color:#fa0050; font-family: 'Gothic A1', sans-serif;">마이페이지</span></h1>
    <div align="center" style="margin-top: 40px;">

<div class="my-page-container">
    <form action="/customer/update.do" method="post" class="my-page-form">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
        

        <label for="id" class="my-page-label">ID</label>
        <input type="text" id="id" name="id" value="${customer.id}" readonly="readonly" class="my-page-input"><br>
<br>
        <label for="name" class="my-page-label">Name</label>
        <input type="text" id="name" name="name" value="${customer.name}" class="my-page-input"><br>
<br>
        <label for="mail" class="my-page-label">Email</label>
        <input type="text" id="mail" name="mail" value="${customer.mail}" class="my-page-input"><br>
<br>
        <label for="phone" class="my-page-label">Phone</label>
        <input type="text" id="phone" name="phone" value="${customer.phone}" class="my-page-input"><br>
<br>
        <button type="submit" class="my-page-button">회원정보수정</button>

    </form>
<br>   
    <form action="/customer/secession.do" method="post">
    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
        <button type="submit" class="my-page-button">회원탈퇴</button>
    </form>
</div>
</div>
<jsp:include page="../footer.jsp"/>

