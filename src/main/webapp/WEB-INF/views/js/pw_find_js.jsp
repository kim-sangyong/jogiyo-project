<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!-- 카카오 인증번호 코드를 받기위한 jquery  -->
<script src="https://t1.kakaocdn.net/kakao_js_sdk/2.7.2/kakao.min.js"
  integrity="sha384-TiCUE00h649CAMonG018J2ujOgDKW/kVWlChEuu4jK2vxfAAD0eZxzCKakxg55G4" crossorigin="anonymous"></script>
   <script>
   Kakao.init('${kakao_login}'); // 카카오 rest api 코드
   Kakao.isInitialized();
   
   function sendToMe() {
      var url = new URL(window.location.href);
      // AJAX 요청 예시
      $.ajax({
          url: 'https://kauth.kakao.com/oauth/token',
          type: 'POST',
          data: {
              grant_type: 'authorization_code', // 이 코드는 고정 값
              client_id: '${kakao_login}', // 카카오 rest api 코드
              redirect_url: '${redirect_url}/login/pw_find.do', // 카카오에 등록한 redirect_url
              code : url.searchParams.get('code') // jquery를 통해 받아오는 코드
          },
          success: function(response) {
              console.log(response)
                accessToken = response.access_token;
              console.log('추출된 access_token:', accessToken);
              Kakao.Auth.setAccessToken(accessToken);
            Kakao.API.request({
                 url: '/v2/api/talk/memo/default/send',// 나에게 메세지를 보내기위한 카카오 url 
                 data: {                        // requst post 방식
                   template_object: {
                     object_type: 'feed', // feed 방식 post 등 방식도 있음
                     content: {
                       title: '${random}',
                       description: '회원가입을 위한 인증 코드를 확인해주세요.',
                             image_url:
                                'https://developers.kakao.com',
                             link: {
                               web_url: 'https://developers.kakao.com',
                               mobile_web_url: 'https://developers.kakao.com',
                       },
                     },
                    
                     buttons: [
                       {
                         title: '웹으로 보기',
                         link: {
                           mobile_web_url: 'https://developers.kakao.com',
                           web_url: 'https://developers.kakao.com',
                         },
                       },
                       {
                         title: '앱으로 보기',
                         link: {
                           mobile_web_url: 'https://developers.kakao.com',
                           web_url: 'https://developers.kakao.com',
                         },
                       },
                     ],
                   },
                 },
               })
                 .then(function(response) {
                   console.log(response);
                   // 인증 코드를 서버에 전송하여 검증
                         $.ajax({
                             url: 'verifyCode.do',
                             type: 'POST',
                             data: {
                                 access_token: accessToken,
                                 auth_code: response.auth_code // 인증 코드 전송
                             },
                             success: function(verificationResult) {
                                 if (verificationResult === 'success') {
                                     alert('인증이 성공적으로 완료되었습니다.');
                                 } else {
                                     alert('인증에 실패했습니다.');
                                 }
                             },
                             error: function(err) {
                                 console.error('서버 오류:', err);
                             }
                         });
                 })
                 .catch(function(error) {
                   console.log(error);
                 });
          },
          error: function(xhr, status, error) {
              console.error('에러 발생:', error);
              alert('인증번호 전송 실패! 카카오 로그인 먼저 해주세요!');
             /* 카카오 로그인을 하지 않고 인증번호 전송시 알림창이 뜸 */
          }
      });
   } 
</script>

<script type="text/javascript">

    function out() {
            // // 사용자가 입력한 랜덤으로 온 인증번호
             var code = document.getElementById("code").value;
            // 서버(controller)에서 받은 랜덤 값
            var random = <%= request.getAttribute("random") %>;
            // 랜덤 값으로 온 인증번호 유효성 검사
            if (code == random) {
                // 인증 성공 메시지 표시
                /* document.getElementById("message").innerHTML = "인증이 완료되었습니다."; */
                var messageElement = document.getElementById("message");
            messageElement.innerHTML = "인증이 완료되었습니다.";
            messageElement.style.color = "black"; // 알림에 대한 색상
                // 확인 버튼 활성화
                // 카카오톡 인증 코드가 맞으면 모든 text 값 활성화
                document.getElementById("ok").disabled = false;
                document.getElementById("id").disabled = false;
                document.getElementById("name").disabled = false;
                document.getElementById("p1").disabled = false;
                document.getElementById("p2").disabled = false;
                document.getElementById("p3").disabled = false;
                
                
            } else {
                // 인증 실패 메시지 표시
               /*  document.getElementById("message").innerHTML = "인증번호가 일치하지 않습니다. 다시 시도해 주세요."; */
                  var messageElement = document.getElementById("message");
            messageElement.innerHTML = "인증번호가 일치하지 않습니다. 다시 시도해 주세요.";
            messageElement.style.color = "black"; // 알림에 대한 색상
                // 확인 버튼 비활성화
                // 카카오 인증 코드가 틀렸을시 모든 text 값 비활성화
                document.getElementById("ok").disabled = true;
                document.getElementById("id").disabled = true;
                document.getElementById("name").disabled = true;
                document.getElementById("p1").disabled = true;
                document.getElementById("p2").disabled = true;
                document.getElementById("p3").disabled = true;
     
            }
       }
    
    /* 인증번호 전송 버튼을 눌렀을때 click_div에 대한 값 사라짐, 나타남 */
   /*  function btnclick(){
       const click_div = document.getElementById('click_div');
       if(click_div.style.display === 'none'){ /* click_div에 대한 요소 사라지게함 */
          //click_div.style.display = 'block';  /* 함수가 호출 되었을때 click_div에 대한 값 나타내지게하고 block */
       //}
   // } */
   
    function show(){
       const con = document.getElementById('con');
       if(con.style.display ==='none' || con.style.display === ''){       
            con.style.display = 'block';
            document.getElementById('under').innerText = '상세내용 닫기';
        }else{       
            con.style.display = 'none';
            document.getElementById('under').innerText = '상세내용 펼치기';
        } 
       } 
   
    function check() {
        /* text 입력 안할 시 title에 대한 알림창이 나옴 */
       const jfrm = document.f;
        let length = jfrm.length - 5; // length에 버튼 값까지 포함  인증번호전송, 중복확인, 취소, 확인 까지 포함이라서 -4를 함
        for (let i = 0; i < length; i++) {
           if (jfrm[i].value == "" || jfrm[i].value == null) {
              alert(jfrm[i].title + "을 입력해 주세요");
              jfrm[i].focus();
              return false;
           }
        }
        return true;
     }
    
</script>  