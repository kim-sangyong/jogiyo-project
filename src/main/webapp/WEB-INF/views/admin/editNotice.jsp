<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="../header.jsp"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/table.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/editNotice.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/editNotice.js" ></script> 

<form method="post" action="/admin/updateNotice.do">
<input type="hidden" name="notiid" value="${dto.notiid}">
<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
<div align="center" style="margin-top: 80px;" "margin-bottom: 50px;>
    <h1><span style="font-weight: bold; color:#fa0050; font-family: 'Gothic A1', sans-serif;">공지사항 수정</span></h1>
    <table class="form-table">
        <tr>
            <td><input type="text" name="subject" placeholder="제목을 입력해 주세요." value="${dto.subject}"></td>
        </tr>
        <tr>
            <td><textarea name="content" placeholder="내용을 입력하세요." rows="10" cols="50">${dto.content}</textarea></td>
        </tr>
        <tr>
            <td class="button-container">
                <button style="color: white"; type="submit">등록</button>
            </td>
       </tr>
            
    </table>
    </form>
</div>
<jsp:include page="../footer.jsp"/>
