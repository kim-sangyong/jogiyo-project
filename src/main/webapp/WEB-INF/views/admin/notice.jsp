<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="../header.jsp"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/table.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/notice.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/notice.js" ></script> 
<div align="center" style="margin-top: 80px;">
    <h1><span style="font-weight: bold; color:#fa0050; font-family: 'Gothic A1', sans-serif;">공지사항 등록</span></h1>
    <div align="center" style="margin-top: 40px;">
        <div class="container">
            <form action="/admin/insertNotice.do" method="post" name="mynotice" onsubmit="return check();">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                <table class="form-table">
                    <tr>
                        <td><input type="text" name="subject" placeholder="제목을 입력하세요"></td>
                    </tr>
                    <tr>
                        <td><textarea name="content" rows="10" cols="50" placeholder="내용을 입력하세요"></textarea></td>
                    </tr>
                    <tr>
                        <td><div style="text-align: center; color=red;">
                <button type="submit" align="center">등록
                </button>
                <button type="button" onclick="location.href='/admin/listNotice.do'">공지사항 목록 보기</button></div>
                        </td>
                    </tr>
                </table>
            </form>
            
        </div>
    </div>
</div>
<jsp:include page="../footer.jsp"/>
