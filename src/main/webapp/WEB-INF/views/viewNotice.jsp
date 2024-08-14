<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/indexNotice.css">
<link rel="shortcut icon" href="${pageContext.request.contextPath}/resources/img/favicon.ico" type="image/x-icon">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<div class="notice-container">
    <div class="notice-header">
    <h1 class="notice-title">${dto.subject}</h1>
    </div>
    <div class="notice-content">
        <div class="notice-item">
            <div class="notice-description"><p style="white-space: pre-line;">${dto.content}</p></div>
        </div>
    </div>
</div>