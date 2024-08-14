<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<jsp:include page="../header.jsp"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/login.css">

<div align="center" style="margin-top: 80px;">
    <h1><span style="font-weight: bold; color:#fa0050; font-family: 'Gothic A1', sans-serif;">죠기요</span></h1>
    <div align="center" style="margin-top: 40px;">
        <form action="/login/loginOk.do" method="post" class="form-container">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
            <table>
                <tr>
                    <td style="text-align: center;"margin-top: 40px;">
                        <label for="id" style="display:none;">아이디</label>
                        <input type="text" name="id" placeholder="아이디 입력(필수)" required style="margin-top: 30px; margin-bottom: 3px;">
                    </td>
                </tr>
                <tr>
                    <td style="text-align: center;">
                        <label for="passwd" style="display:none;">비밀번호</label>
                        <input type="password" name="passwd" placeholder="비밀번호 입력(필수)" required style="margin-bottom: 3px;">
                    </td>
                </tr>
                <tr>
                    <td style="text-align: center;">
                        <button type="submit" >로그인</button>
                    </td>
                </tr>
                <tr>
                    <td style="text-align: center;">
                        <a href="/login/join_membership.do"
                        onclick="alert('카카오 로그인을 먼저 해주세요')">회원가입</a> |
                        
                        <a href="/login/id_find.do"
                        onclick="alert('카카오 로그인을 먼저 해주세요')">아이디 찾기</a> |
                        
                        <a href="/login/pw_find.do"
                        onclick="alert('카카오 로그인을 먼저 해주세요')">비밀번호 변경하기</a> |
                        
                        <a href="/login/owner_membership.do"
                        onclick="alert('카카오 로그인을 먼저 해주세요')">점주 회원가입</a>
                    </td>
                </tr>
            </table>
        </form>
    </div>
    <div align="center" style="margin-bottom: 200px; border-radius: 8px;">
    </div>
    </div>
    <jsp:include page="../footer.jsp"/>


