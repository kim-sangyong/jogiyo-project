<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
     <script type="text/javascript">
     var contextPath = "${pageContext.request.contextPath}";
  // 선택한 역할에 따라 계정 목록을 가져와서 표시하는 함수
     function cateList(){
        let sel = $("select").val();  // 드롭다운에서 선택한 역할 값을 가져옴
        var csrfToken = $("meta[name='_csrf']").attr("content");  // CSRF 토큰 값을 가져옴
         var csrfHeader = $("meta[name='_csrf_header']").attr("content");  // CSRF 헤더 이름을 가져옴

         // 계정 목록을 가져오기 위해 AJAX POST 요청을 보냄
        $.ajax({
           url : "listCate.ajax",  // 요청을 보낼 URL
           type : "post",  // HTTP 메서드
           data: {
                    "sel": sel,  // 서버로 전송할 데이터 (선택한 역할)
                    "_csrf": csrfToken  // CSRF 토큰을 데이터에 포함
                },
                beforeSend: function(xhr) {
                     // AJAX 요청 헤더에 CSRF 토큰을 추가
                     xhr.setRequestHeader(csrfHeader, csrfToken);
                 },
           success : function(res) {
              // 요청이 성공하면 JSON 응답을 파싱
                 var data = JSON.parse(res);
                 // 기존 테이블 내용을 초기화
                 $("#storeList").empty();
                 
                 // 데이터 각 항목을 테이블에 추가
                 $.each(data, function(index, item) {
                    var div =
                       "<div class='listing'>" +
                        "<img src='" + contextPath + "/resources/img/" + item.img + "' width='80' height='80'>" +
                        "<div class='details'>" +
                            "<h2><a onclick='viewStore(" + item.storeid + ")' href='#'>" + item.storename + "</a></h2>" +
                            //7073 윤장호수정
                            "<div class='rating'>"+ item.rev_avg +" ★</div>" +
                            "<div class='reviews'>리뷰"+ item.row_count +" | 사장님댓글 " + item.reply_count + "</div>" +
                            "<div class='min_order'>가게설명 | " + item.storecontent + "</div>" +
                            "<div class='discount'>쿠폰 | " + item.couponid + "</div>" +
                            
                        "</div>" +
                      "</div>";
   
                     $("#storeList").append(div);
                 
                 });
           },
           error : function(err) {
              // 오류가 발생하면 콘솔에 오류를 출력
              console.log(err);
           }
        })
     }
function viewStore(id) {
    var form = document.createElement('form');
    form.method = 'POST';
    form.action = '/customer/viewStore.do';

    var idInput = document.createElement('input');
    idInput.type = 'hidden';
    idInput.name = 'storeid';
    idInput.value = id;
    form.appendChild(idInput);
    
    var csrfToken = $("meta[name='_csrf']").attr("content");
    
    var idInput2 = document.createElement('input');
    idInput2.type = 'hidden';
    idInput2.name = '_csrf';
    idInput2.value = csrfToken;
    form.appendChild(idInput2);

    document.body.appendChild(form);
    form.submit();
}

</script>