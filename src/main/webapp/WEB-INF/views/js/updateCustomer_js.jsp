<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
function checkPass() {
	let id = $("#id").val();
	let passwd = $("#passwd").val();
	let passwd1 = $("#passwd1").val();
	let passwd2 = $("#passwd2").val();
	var csrfToken = $("meta[name='_csrf']").attr("content");
    var csrfHeader = $("meta[name='_csrf_header']").attr("content");
    $.ajax({
		url : "checkPasswd.ajax",
		type : "post",
		data : {
			"id" : id,
			"passwd" : passwd1,
			"_csrf": csrfToken
		},
		beforeSend: function(xhr) {
            xhr.setRequestHeader(csrfHeader, csrfToken);
        },
        success : function(res) {
        	if(res == 'ok'){
	            if(passwd != passwd2 || passwd ==''){
	            	alert('변경할 비밀번호가 일치하지 않습니다!');
	            	return;
	            }
	            alert('비밀번호 확인 완료!');
	            document.getElementById('btn').disabled = false;
        	}else{
        		alert('입력하신 비밀번호와 현재 비밀번호가 일치 하지 않습니다!');
        		return;
        	}
        },
        error : function(err) {
			console.log(err);
		}
	})
}
</script>