<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 비밀번호 찾기 결과 페이지 -->
<jsp:include page="../header.jsp"/>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/myPageUpdate.css">
<div class="my-page-container">
    <h1 class="my-page-title">비밀번호 변경</h1>

    <form action="/login/updatePassword.do" method="post" class="my-page-form" name="f">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
      <input type="hidden" name="id" value="${id}">
        <label for="passwd1" class="my-page-label">변경할 비밀번호:</label>
        <input type="password" id="passwd1" name="passwd1" value="" class="my-page-input"><br>

        <label for="passwd" class="my-page-label">변경할 비밀번호 확인:</label>
        <input type="password" id="passwd" name="passwd" value="" class="my-page-input"><br>
        <div align="center">
      <input type="button" onclick="checkPass()" name="checkPasswd" id="checkPasswd" value="비밀번호 확인">
        <button type="submit" id="btn" class="my-page-button" disabled="disabled">Update</button>
       </div>
    </form>
    <div class="my-page-message" id="message"></div>
</div>
<script type="text/javascript">
function checkPass() {
   let passwd = $("#passwd").val();
   let passwd1 = $("#passwd1").val();
   if (passwd != "" && passwd == passwd1){
      alert("비밀번호가 일치합니다!");
      document.getElementById('btn').disabled = false;
   } else{
      alert("비밀번호가 일치하지 않습니다!");
   }
}
</script>
<jsp:include page="../footer.jsp"/>