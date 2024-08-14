<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="../header.jsp"/>

<!-- 회원정보 고객센터 페이지 -->

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/serviceCenter.css">


<div align="center" style="margin-top: 20px; margin-bottom: 20px;">
   <h1><span style="font-weight: bold; color:#fa0050; font-family: 'Gothic A1', sans-serif;">회원정보 고객센터</span></h1>
	
	
	<div align="center" style="margin-top: -5px; margin-bottom: 30px; border-radius: 8px;">
	
	<div class="form-container">
	<h3>도용자 확인 및 신고 방법</h3>
	<h4>
   	<span>계정 도용 및 피해에 대한 수사 의뢰는 고객님께서 직접 해야 합니다.</span><br>
   	<br>
    <span>아이디 도용자에 대한 신고 및 처벌을 원한다면 사이버범죄 신고시스템 (ECRM)로 신고하세요.</span><br>
    <br>
    <span>수사에 필요한 자료를 요청한다면 최대한 협조해 도움드리겠습니다.</span><br>
    <br>
    <span>또한 신고와 관련해 경찰의 요청이 있을 경우 고객님을 위해 필요한 정보를 제공해 수사에 적극 협조할 것을 약속드립니다.</span><br>
    </h4>
    
    <h3>
    <span>[사이버범죄 신고시스템 (ECRM)]</span><br>
    <span>- 연락처: 국번없이 182</span><br>
    - 홈페이지: <a href="https://ecrm.police.go.kr/" target="_blank">https://ecrm.police.go.kr/</a><br>
    												<!-- target="_blank" 는 링크 클릭시 새창 생성 -->
    <br>
    <br>
    <span style="font-size: 0.8em;">[사이버범죄 신고시스템 (ECRM)]에서
    	로그인 기록을 통해 확인한 IP는 한국인터넷진흥원(KISA) WHOIS 사이트에서 사용 기관명, 주소, 할당 일자 등의 정보를 조회할 수 있습니다.</span><br><br>
    	<a href="https://xn--c79as89aj0e29b77z.xn--3e0b707e/main.do"
    		target="_blank"><b>한국인터넷진흥원(KISA) WHOIS 바로가기</b></a><br><br>
    		<!-- target="_blank" 는 링크 클릭시 새창 생성 -->
    <span style="font-size: 0.8em;">※ WHOIS 조회로 IP 정보 확인이 불가한 경우</span><br>
    <span style="font-size: 0.8em;">- 해외 국가(기관)에 할당된 IP</span><br>
    <span style="font-size: 0.8em;">- 특수한 목적을 위해 사용되는 가상 또는 기업내부망용 IP</span>
    
    </h3>
    
    <h3>회원 탈퇴 방법</h3>
    <h4>
    <span>회원 탈퇴시 고객님의 모든 정보가 사라집니다.</span><br>
    <br>
    <span>사이트를 이용하려면 다시 회원가입해 주세요.</span><br>
    <br>
    <span><a href="/login/login.do">로그인</a> -> <a href="/customer/mypage.do">마이페이지</a> -> 회원탈퇴</span>
    </h4>
	</div>
	</div>
	<div align="center" style="margin-bottom: 110px; border-radius: 8px;">
	</div>
	</div>

<jsp:include page="../footer.jsp"/>