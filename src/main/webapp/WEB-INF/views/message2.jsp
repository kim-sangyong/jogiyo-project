<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<jsp:include page="header.jsp"/>
<body>
    <form id="logoutForm" method="post" action="/login/logout.do">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
    </form>

    <script>
        document.addEventListener("DOMContentLoaded", function() {
            alert("${msg}"); // 페이지 로드 후 메시지 출력
			console.log("${_csrf.token}")
            document.getElementById("logoutForm").submit();
        });
    </script>
</body>
