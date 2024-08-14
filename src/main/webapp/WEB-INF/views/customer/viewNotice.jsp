<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="../header.jsp"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/table.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/viewNotice.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<jsp:include page="../js/viewNotice_js.jsp"/>
<div align="center" style="margin-top: 80px; margin-bottom: 50px;">
    <h1><span style="font-weight: bold; color:#fa0050; font-family: 'Gothic A1', sans-serif;">공지사항 상세</span></h1>
    <table class="form-table">
        <tr>
            <td><input type="text" name="subject" value="${dto.subject}" disabled></td>
        </tr>
        <tr>
            <td><textarea name="content" rows="10" cols="50" disabled>${dto.content}</textarea></td>
        </tr>
        <tr>
            <td class="button-container">
                <button style="color: white"; onclick="location.href='/customer/notice.do'">목록</button>
            </td>
        </tr>
    </table>
</div>
<jsp:include page="../footer.jsp"/>
