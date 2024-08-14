<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/test.css"> 
<div class="footer"
   ng-show="is_yogiyo &amp;&amp; !session_storage.oauth_next">
   <div class="footer-menu">
      <ul>
         <li class="mb" ng-show="!is_mobile_device"><a href="#/policy/">이용약관</a></li>
         <li class="mb privacy-txt" ng-show="!is_mobile_device"><a
            href="#/privacy/">개인정보처리방침</a></li>
         <li class="mb cscenter" ng-show="!is_mobile_device"><a
            href="#/point_policy/">포인트정책</a></li>
         <li class="mb ng-hide" ng-show="is_mobile_device"><a
            ng-bind="check_login() ? '로그아웃' : '로그인'" ng-click="login()"
            class="ng-binding">로그인</a></li>
         <li class="mb cscenter ng-hide" ng-show="is_mobile_device"><a
            href="#/contact/">고객만족센터</a></li>
         <li class="mb"><a href="https://www.wesang.com/"
            rel="noopener noreferrer" target="_blank">회사소개</a></li>
         <li><a href="https://www.yogiyo.co.kr/owner/login/"
            target="_blank">조기요사장님</a></li>
         <li class="mb lst"><a
            href="https://owner.yogiyo.co.kr/owner/join/request/">입점문의</a></li>
         <li class="mb down_app ng-hide" ng-show="is_mobile_device"><a
            href="" ng-click="download_app('footer')" class="app">APP설치</a></li>
         <li class="mb notice"><a href="#/notice/">공지사항</a></li>
         <li class="sns-link"><a
            href="https://www.facebook.com/Yogiyokorea/" class="facebook"
            rel="noopener noreferrer" target="_blank"><span></span>페이스북</a><a
            href="https://blog.naver.com/rgpkorea" class="blog"
            rel="noopener noreferrer" target="_blank"><span></span>블로그</a></li>
      </ul>
   </div>
   <div class="company-wrap">
      <div class="company-logo">
         <a href="" ng-click="click_home()">죠기요1</a>
      </div>
      <div class="company-info">
         <p>
            <strong>주식회사 위대한점심</strong><br>서울시 서초구 서초대로38길 12 마제스타시티 타워2
            17층<span class="bar">|</span>대표이사 : 장예진<span class="bar">|</span>사업자등록번호:211-88-68802
            <a href="http://www.ftc.go.kr/bizCommPop.do?wrkr_no=2118868802"
               rel="noopener noreferrer" target="_blank" class="biz-info"
               ng-show="!is_mobile_device">사업자정보확인</a>통신판매업신고:제 2018-서울서초-2635호<span
               class="bar">|</span>개인정보담당자 : <a href="mailto:privacy@yogiyo.co.kr">privacy@jogiyo.co.kr</a><span
               class="bar">|</span>제휴문의 : <a
               href="mailto:partnership@yogiyo.co.kr">partnership@jogiyo.co.kr</a><span
               class="bar">|</span>고객만족센터 : <span ng-show="is_mobile_width"
               class="pnum ng-hide">1661-5270(유료) 24시간, 연중무휴</span> <a
               href="mailto:support@yogiyo.co.kr">support@jogiyo.co.kr</a><span
               class="bar">|</span>호스팅 제공자: 깜보24 주식회사
         </p>
         <div class="footer-terms ng-hide" ng-show="is_mobile_device">
            <a href="#/policy/">이용약관</a><span class="bar">|</span><a
               href="#/privacy/"><strong>개인정보처리방침</strong></a><span class="bar">|</span><a
               href="#/point_policy/">포인트정책</a><span class="bar">|</span><a
               href="http://www.ftc.go.kr/bizCommPop.do?wrkr_no=2118868802"
               rel="noopener noreferrer" target="_blank">사업자정보확인</a>
         </div>
      </div>
   </div>
   <div class="service-info">
      <div class="bpg">
         <a href="#/trust/"><span class="img"></span><span class="text">죠기요<br>안심센터
         </span></a>
      </div>
      <div class="cleanreview">
         <a href="#/cleanreview/"><span class="img"></span><span
            class="text">죠기요 100%<br>클린리뷰
         </span></a>
      </div>
      <div class="csc">
         <em>고객만족센터</em> <strong>1661-5270</strong><em>(유료)</em> <span>24시간,
            연중무휴</span>
      </div>
   </div>
   <div class="guide">
      <p>주식회사 위대한점심은 통신판매중개자이며 통신판매의 당사자가 아닙니다. 따라서 상품/ 거래정보 및 거래와 관련하여
         요기요에 등록된 판매자의 고의 또는 과실로 소비자에게 발생하는 손해에 대해 주식회사 위대한상상은 책임을 지지 않습니다. 상품
         및 거래에 관하여 보다 정확한 정보는 해당 판매자에게 직접 확인하여 주시기 바랍니다. Copyright JOGIYO. All
         Rights Reserved.</p>
   </div>
</div>

</body>
</html>