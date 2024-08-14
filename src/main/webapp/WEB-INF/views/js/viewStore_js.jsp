<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=${key}&libraries=services"></script>
<script type="text/javascript">


	
	
	 function getSelectedCouponContentNumber() {
	        const selectedCoupon = document.querySelector('input[name="coupon"]:checked');
	        if (selectedCoupon) {
	            // 쿠폰의 coucontent에서 숫자만 추출
	            const content = selectedCoupon.getAttribute('data-content');
	            const number = content.match(/\d+/);
	            return number ? number[0] : null;
	        }
	        return null;
	    }


	function insertBasket() {
	    // 선택된 목록 가져오기
	    const query = 'input[name="menu"]:checked';
	    const selectedEls = document.querySelectorAll(query);
	    
	    // 현재 장바구니의 storeid 가져오기
	    var currentStoreId = $("input[name ='storeid']").val();
	    console.log(currentStoreId);
	   
	    
	    // 선택된 목록에서 데이터 추출
	    let result = [];
	    let storeIdCheck = true;
	    selectedEls.forEach((el) => {
	        let menuid = el.value;
	        let price = el.closest('.menu-item').querySelector('.menu-item-price').innerText.trim();
	        let quantity = el.closest('.menu-item').querySelector('select').value;
	        let storeid = ${store.storeid}; // 가게의 storeid
	        // 기존 장바구니의 storeid와 비교
	        if (currentStoreId !== "가게 없음" && currentStoreId !== storeid.toString()) {
	            storeIdCheck = false;
	        }

	        result.push({ menuid: menuid, totprice: price, qty: quantity, storeid: storeid });
	    });
	    
	    // storeid가 다른 경우 경고 메시지 표시
	    if (!storeIdCheck) {
	        alert("같은 가게의 메뉴만 담을 수 있습니다.");
	        return;
	    }
	   
	    
	    // 서버로 데이터 전송
	    var csrfToken = $("meta[name='_csrf']").attr("content");
	    var csrfHeader = $("meta[name='_csrf_header']").attr("content");
	    $.ajax({
	        url: "insertBasket.ajax",
	        type: "POST",
	        contentType: "application/json; charset=UTF-8", 
	        data: JSON.stringify(result), 
	        beforeSend: function(xhr) {
	            xhr.setRequestHeader(csrfHeader, csrfToken);
	        },
	        success: function(res) {
	        	console.log(res);
	        	if(res == '이미 장바구니에 다른 가게 상품이 담겨있습니다.'){
	        		alert(res);
	        	} else {
		        	if(confirm(res)){
		        		location.href="${pageContext.request.contextPath}/customer/basket.do"
		        	}else {
		                cancelSelection();
		            }
	        	}
	        },
	        error: function(err) {
	            console.error("Error:", err);
	        }
	    });
	}

	
	function cancelSelection() {
	    const query = 'input[name="menu"]:checked';
	    const selectedEls = document.querySelectorAll(query);
	    
	    selectedEls.forEach((el) => {
	        el.checked = false;
	        
	        let select = el.closest('.menu-item').querySelector('select');
	        select.value = '1'; 
	    });
	}
	
	function directPay() {
        // 선택된 목록 가져오기
        const query = 'input[name="menu"]:checked';
        const selectedEls = document.querySelectorAll(query);
        
        // 선택된 목록에서 데이터 추출
        let result = [];
        let resultCou = [];
        selectedEls.forEach((el) => {
            let menuid = el.value;
            let price = el.closest('.menu-item').querySelector('.menu-item-price').innerText.trim();
            let quantity = el.closest('.menu-item').querySelector('select').value;
            let storeid = ${store.storeid};
            let menuname = el.closest('.menu-item').querySelector('.menu-item-title').innerText.trim();
            result.push({ menuname: menuname, menuid: menuid, totprice: price, qty: quantity, storeid: storeid });
        });

        // 선택된 쿠폰의 숫자만 가져오기
        let selectedCouponNumber = getSelectedCouponContentNumber();
        if (selectedCouponNumber) {
            resultCou.push({ coupon: selectedCouponNumber });
        }

        // 로컬 스토리지에 데이터 저장
        localStorage.setItem('orderData', JSON.stringify(result));
        localStorage.setItem('couponData', JSON.stringify(resultCou));
        
        // 결제 페이지로 이동
        location.href = "${pageContext.request.contextPath}/customer/directPay.do";
    }
	
	//가게쿠폰받기
	function submitCouponForm(couponId) {
		 // CSRF 토큰 가져오기
	    var csrfToken = $("meta[name='_csrf']").attr("content");

	    // Ajax 요청 보내기
	    $.ajax({
	        type: 'POST',
	        url: '/customer/getCoupon.do',
	        data: {
	            couponid: couponId,
	            _csrf: csrfToken
	        },
	        success: function(response) {
	            // 성공 시 메시지 박스 표시
	            alert(response.message);
	            location.reload();
	        },
	        error: function(xhr, status, error) {
	            // 실패 시 메시지 박스 표시
	            alert('쿠폰 추가 중 오류가 발생했습니다.');
	            location.reload();
	        }
	    });
	}


    var mapContainer = document.getElementById('map'), // 지도를 표시할 div  
     mapOption = {
            center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
            level: 3 // 지도의 확대 레벨
          };

  // 지도를 생성합니다
  var map = new kakao.maps.Map(mapContainer, mapOption);

  // 주소-좌표 변환 객체를 생성합니다
  var geocoder = new kakao.maps.services.Geocoder();

  var positions = [
    {
      title: '${store.storename}',
      address: '${store.address}'
      
    }
  ];

  positions.forEach(function (position) { //추가한 코드
     
    // 주소로 좌표를 검색합니다
    geocoder.addressSearch(position.address, function(result, status) {

      // 정상적으로 검색이 완료됐으면
      if (status === kakao.maps.services.Status.OK) {

        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

        // 결과값으로 받은 위치를 마커로 표시합니다
        var marker = new kakao.maps.Marker({
           
          map: map,
          position: coords
        });

        // 인포윈도우로 장소에 대한 설명을 표시합니다
        //변경한 코드
        var infowindow = new kakao.maps.InfoWindow({
           
         content: '<div style="width:150px;text-align:center;padding:6px 0;">' + position.title + '</div>'
        });
        
       infowindow.open(map, marker);

        window.addEventListener('click', function() {
            map.relayout();
            map.setCenter(coords);
		});
      //  map.setCenter(coords);
      }
    });
  });
	  
</script>