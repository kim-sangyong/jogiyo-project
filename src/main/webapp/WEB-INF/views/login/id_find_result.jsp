<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 비밀번호 찾기 결과 페이지 -->
<jsp:include page="../header.jsp"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/idFindResult.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

      <div align="center" style="margin-top: 20px; margin-bottom: 20px;">
         <h1><span style="font-weight: bold; color:#fa0050; font-family: 'Gothic A1', sans-serif;">아이디 찾기</span></h1>
         <h4><span style="font-weight: bold; color:#black; font-family: 'Gothic A1', sans-serif;">고객님의 정보와 일치하는 아이디 입니다.</span></h4>
        </div>  
      <div align="center" class="_div">
      <div class="form-container">
      <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
       <form method="post" name="id" action="/login/pw_find_result.do" onsubmit="return validateForm()">
       <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
      <div align="center" style="margin-top: -5px; margin-bottom: 30px; border-radius: 8px;">
      
      <table>
      <c:forEach var="dto" items="${id}">
      <tr>
         <td><input type="checkbox" name="id" value="${dto.id}"></td> <td><label>${dto.id}</label></td>
      </tr>
      </c:forEach>
        </table>
         
         <table>
         <tr>
         <td><button type="button" style="width: 80px;" onclick="alert('로그인 페이지로 이동합니다.');
         window.location.href='login.do';">로그인</button></td>
         <td style="width: 50px;"></td>
         <td><input class="pwupdate" type="submit" value="비밀번호 변경하기"></td>
         <!-- 'pw_find_two.do?id=+${id}'" 찾은 아이디를 비밀번호 찾기 페이지 아이디 입력란이 저장 -->
         </tr>
         </table>
         </div>
         </form>
         </div>
         </div>
         <div align="center" style="margin-bottom: 110px; border-radius: 8px;">
         </div>
         
<script>
    function validateForm() {
        var id = document.querySelectorAll('input[name="id"]:checked');
        
        if (id.length != 1) {
            alert('하나의 아이디만 선택해 주세요.');
            return false; // 체크박스 선택 안하면 안넘어감
        }
        
        // 선택했을시 넘어감
        return true;
    }
</script>
         
<jsp:include page="../footer.jsp"/>