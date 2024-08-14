<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!-- 회원가입 페이지 -->
<jsp:include page="../header.jsp" />
<jsp:include page="../js/join_membership_js.jsp"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/joinMemberShip.css">

<div align="center" style="margin-top: 60px;">
<div align="center" style="margin-top: 20px; margin-bottom: 20px;">
<h1><span style="font-weight: bold; color:#fa0050; font-family: 'Gothic A1', sans-serif;">회원가입</span></h1>
</div>
   <form name="f1" method="post" onsubmit="return check()"
   action="/login/join_membership_ok.do" class="form-container">
   <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
     
         
        <div class="form-row" >
           <div class="label-lo">이름</div>
           <div class="input"><input type="text" title="이름" name="name" id="name" disabled ></div>
       </div>
         
         
         <div class="form-row" >
            <div class="label-lo" >아이디</div>
             <div class="input"><input type="text" name="id" id="jid" title="아이디" disabled ></div>
          <input type="button" value="중복확인" id="dupli"  onclick="idCheck()">
        </div>
        
      <div class="form-row" >
            <div class="label-lo" >비밀번호</div>
            <div class="input"><input type="password" name="passwd" id="pw" title="비밀번호" disabled ></div>
      </div>
      
     <div class="form-row" >
         <div class="label-lo" >이메일</div>
         <div class="input"><input type="text" name="mail" id="mail" title="이메일" disabled></div>
     </div>
      
       <div class="form-row" >
         <div class="label-lo" >전화번호</div>
          <div class="input-lo">
         <input type="text" title="전화번호" name="phone1" id="p1" size="3" maxlength="3" disabled> 
         -
         <input type="text" title="전화번호" name="phone2" id="p2" size="3" maxlength="4" disabled>
        -
        <input type="text" title="전화번호" name="phone3" id="p3" size="3" maxlength="4" disabled>
           </div>
     </div>
                        <!-- div값 나타나지 않게 하기 -->
      <div>
      <table style="position:relative; left:35px;">
      <div class="form-row">
         <div class="label-lo" >인증번호</div>
         <div class="input"><input type="text" name="code" id="code" placeholder="(필수)인증번호 입력"></div>
        <button class="join_button" type="button" onclick="out()" id="dupli">인증번호확인</button>
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
      </div>
      
   <table style="position:relative; top:25px;">
      <tr>
        <td><a href="https://kauth.kakao.com/oauth/authorize?client_id=${kakao_login}&redirect_uri=${redirect_url}/login/join_membership.do&response_type=code&scope=talk_message"> <!--  onclick="kakao_btn()" -->
         <img src="${pageContext.request.contextPath}/resources/img/kakao_login_medium_narrow.png"
                  alt="카카오 로그인"></a></td>
                 
     </tr>
     </table>
     
        </form>
      </div>
      <div align="center" style="margin-bottom: 110px; border-radius: 8px;">
      </div>

<jsp:include page="../footer.jsp" />