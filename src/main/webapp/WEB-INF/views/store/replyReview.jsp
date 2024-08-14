<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  
   
    
    
<div align="center">
<h3>답글추가</h3>
<form name="f" action ="addReviewOk.do" method="post">
<input type="hidden" name ="reviewid" value="${reviewid}">
<input type="hidden" name ="storeid" value ="${storeid}">
 <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
댓글내용: <br>
<textarea name="reply" rows="10" cols="50"></textarea>
<br>
<input type="submit" value="답글달기" >
<input type="reset" value="취소">
</form>
</div>
