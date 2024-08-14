<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="../header.jsp"/>
<jsp:include page="../js/id_find_js.jsp"/>
<!-- 아이디 찾기 페이지 -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/idFind.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!-- 카카오 인증번호 코드를 받기위한 jquery  -->

<div align="center" style="margin-top: 40px; margin-bottom: 20px;">
   <h1><span style="font-weight: bold; color:#fa0050; font-family: 'Gothic A1', sans-serif;">아이디 찾기</span></h1>
   <h4><span style="font-weight: bold; color:#black; font-family: 'Gothic A1', sans-serif;">이름과 전화번호를 입력해주세요.</span></h4>
   </div>
   
<div align="center" style="margin-top: 40px;">
            <!-- return check()를 하면  위 유효성 검사가 false, true를 받기위해 -->
   <form name="f" onsubmit="return check()" method="post" action="/login/id_find_result.do" class="form-container">
   <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
     <div align="center" style="margin-top: -5px; margin-bottom: 30px; border-radius: 8px;">

      <div class="form-row">
      <div class="label-lo">이름</div>
      <div class="input"><input type="text" title="이름" name="name" id="name" disabled></div>
      </div>
      
      <div class="form-row" >
         <div class="label-lo" >전화번호</div>
            <div class="input-lo">
         <input type="text" name="phone1" id="p1" title="전화번호" size="3" maxlength="3" disabled>
         -
         <input type="text" name="phone2" id="p2" title="전화번호" size="3" maxlength="4" disabled>
         -
         <input type="text" name="phone3" id="p3" title="전화번호" size="3" maxlength="4" disabled>
         </div>
      </div>
                     <!-- div값 나타나지 않게 하기 style="display: none; -->
      
      <table style="position:relative; left:30px;">
       <div class="form-row">
         <div class="label-lo" >인증번호</div>
         <div class="input"><input type="text" name="code"  placeholder="(필수)인증번호 입력" id="code"></div>
         <button type="button" onclick="out()" id="dupli">인증번호확인</button>
      </div>
        </table>
        <div id="message"></div> <!-- 인증이 완료됨, 인증실패 문구 출력 -->
        </div>
     
      
     <div class="buttons">
   
         <input type="submit" value="확인" id="ok" disabled>
         <button type="button" id="button-lo2" onclick="alert('로그인 페이지로 이동합니다.');
            window.location.href='login.do';">취소</button>
           <button type="button" id="button-lo2" onclick="sendToMe()" id="send">인증번호 전송</button>
                                                               <!-- btnclick(); -->
            <!-- 버튼을 눌러 sendToMe()가 활성화가되면 나에게 랜덤값 코드 번호 전송  -->
      
      </div>
      
      <div class="form-img">
      <a href="https://kauth.kakao.com/oauth/authorize?client_id=${kakao_login}&redirect_uri=${redirect_url}/login/id_find.do&response_type=code&scope=talk_message" class="center-img">
         <img src="${pageContext.request.contextPath}/resources/img/kakao_login_medium_narrow.png" alt="카카오 로그인"></a>
         <!-- rest api와  redirect url을 request GET으로 보냄 -->
      </div>
      
      <div>
      <div class="delete">직접 가입하지 않은 아이디를 탈퇴(삭제)하고 싶으신가요?</div>
      <div class="open"><a onclick="show()" id="under">상세내용 펼치기</a></div>
      <div style="display: none;" id="con">
      <div class="help">신고를 하고 싶으시다면 도움말을 참고해 주세요
      <a href="/login/service_center.do" id="under_two">도움말</a></div>
      </div>
      </div>
      </form>
      </div>
       <div align="center" style="margin-bottom: 110px; border-radius: 8px;">
       </div>
<jsp:include page="../footer.jsp"/>