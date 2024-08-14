<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
   let ck = false;
   function idCheck() {
      let id = $("#jid").val();
      if (id == "") {
         alert("아이디를 입력해주세요");
         $("#jid").focus();
         return;
      }
      var csrfToken = $("meta[name='_csrf']").attr("content");
       var csrfHeader = $("meta[name='_csrf_header']").attr("content");  
      $.ajax({
         url : "idCheck.do",
         type : "post",
         data : {
            "jid" : id,
            "_csrf": csrfToken
         },
         beforeSend: function(xhr) {
                // AJAX 요청 헤더에 CSRF 토큰 추가
                xhr.setRequestHeader(csrfHeader, csrfToken);
            },
         success : function(res) {
            if (res == "OK") {
               alert("사용가능한 아이디 입니다.")
               ck = true;
            } else {
               alert("이미 사용중인 아이디 입니다.")
               $("#jid").val("");
               $("#jid").focus();
               ck = false;
            }
         },
         error : function(err) {
            console.log(err);
            ck = false;
         }

      })
   }
   function check() {
         if (ck == false) {
            alert("아이디 중복확인을 먼저 해주세요.")
            return false;
         }
         /* text 입력 안할 시 title에 대한 알림창이 나옴 */
        const jfrm = document.f1;
         let length = jfrm.length - 4; // length에 버튼 값까지 포함  인증번호전송, 중복확인, 취소, 확인 까지 포함이라서 -4를 함
         for (let i = 0; i < length; i++) {
            if (jfrm[i].value == "" || jfrm[i].value == null) {
               alert(jfrm[i].title + "을 입력해 주세요");
               jfrm[i].focus();
               return false;
            }
         }
         if (!checkTel()) {
             return false; /* chechTel()함수가 false라면 다시 돌아감 */
         }

         return true;
      }
         function checkTel(){
            var phone1 = document.getElementById('p1').value;
            var phone2 = document.getElementById('p2').value;
            var phone3 = document.getElementById('p3').value;
            if (phone1.length !== 3 || phone2.length !== 4 || phone3.length !== 4 ||
                     isNaN(phone1) || isNaN(phone2) || isNaN(phone3)) {
                     /* isNaN()은 문자열 입력, 문자열이 숫자인지 체크  */
                     /* Number.isNaN() 문자열이면서 숫자이면 된다 */
                     alert("전화번호를 올바르게 입력해주세요");
                     document.getElementById('p1').value = "";
                     document.getElementById('p2').value = "";
                     document.getElementById('p3').value = "";
                        /* alert창 띄워지고 전화번호 text 리셋(공백) */
                     /* document.getElementById('p1').focus(); */
                     /* 전화번호 입력 안되어있을때 p1번째 칸으로 이동 */
                     return false;
                 }
          return true;
      }
   </script>
   <script src="https://t1.kakaocdn.net/kakao_js_sdk/2.7.2/kakao.min.js"
  integrity="sha384-TiCUE00h649CAMonG018J2ujOgDKW/kVWlChEuu4jK2vxfAAD0eZxzCKakxg55G4" crossorigin="anonymous"></script>
   <script>
   Kakao.init('${kakao_login}');
   Kakao.isInitialized();
   
   function sendToMe() {
      var url = new URL(window.location.href);
      // AJAX 요청 예시
      $.ajax({
          url: 'https://kauth.kakao.com/oauth/token',
          type: 'POST',
          data: {
              grant_type: 'authorization_code',
              client_id: '${kakao_login}',
              redirect_url: '${redirect_url}/login/owner_membership.do',
              code : url.searchParams.get('code')
          },
          success: function(response) {
              console.log(response)
                accessToken = response.access_token;
              console.log('추출된 access_token:', accessToken);
              Kakao.Auth.setAccessToken(accessToken);
            Kakao.API.request({
                 url: '/v2/api/talk/memo/default/send',
                 data: {
                   template_object: {
                     object_type: 'feed',
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
            // 사용자가 입력한 인증번호
             var code = document.getElementById("code").value;
            // 서버에서 받은 랜덤 값
            var random = <%= request.getAttribute("random") %>;
            // 유효성 검사
            if (code == random) {
                // 인증 성공 메시지 표시
                /* document.getElementById("message").innerHTML = "인증이 완료되었습니다."; */
                var messageElement = document.getElementById("message");
            messageElement.innerHTML = "인증이 완료되었습니다.";
            messageElement.style.color = "black"; // 알림에 대한 색상
                // 확인 버튼 활성화
                // 카카오톡 인증 코드가 맞으면 모든 text 값 활성화
                document.getElementById("ok").disabled = false;
                document.getElementById("name").disabled = false;
                document.getElementById("jid").disabled = false;
                document.getElementById("pw").disabled = false;
                document.getElementById("mail").disabled = false;
                document.getElementById("p1").disabled = false;
                document.getElementById("p2").disabled = false;
                document.getElementById("p3").disabled = false;
               
            } else {
                // 인증 실패 메시지 표시
                /* document.getElementById("message").innerHTML = "인증번호가 일치하지 않습니다. 다시 시도해 주세요."; */
                var messageElement = document.getElementById("message");
            messageElement.innerHTML = "인증번호가 일치하지 않습니다. 다시 시도해 주세요.";
            messageElement.style.color = "black"; // 알림에 대한 색상
                // 확인 버튼 비활성화
                // 카카오 인증 코드가 틀렸을시 모든 text 값 비활성화
                document.getElementById("ok").disabled = true;
                document.getElementById("name").disabled = true;
                document.getElementById("jid").disabled = true;
                document.getElementById("pw").disabled = true;
                document.getElementById("mail").disabled = true;
                document.getElementById("p1").disabled = true;
                document.getElementById("p2").disabled = true;
                document.getElementById("p3").disabled = true;
               
     
            }
       }
   /* 인증번호 전송 버튼을 눌렀을때 click_div에 대한 값 사라짐, 나타남 */
    /* function btnclick(){
       const click_div = document.getElementById('click_div');
       if(click_div.style.display === 'none'){ /* click_div에 대한 요소 사라지게함 */
          //click_div.style.display = 'block';  /* 함수가 호출 되었을때 click_div에 대한 값 나타내지게하고 block */
      // }
  //  }  */
   
   
   /* 카카오 로그인 버튼 클릭시 인증번호 전송 활성화(그 전에 비활성화) */
   /* function kakao_btn(){
       const send = document.getElementById('send');
        document.getElementById("send").disabled = false;
    } */
   

</script> 
    