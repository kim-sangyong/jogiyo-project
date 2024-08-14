<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">

function execDaumPostcode() {
    new daum.Postcode({
        oncomplete : function(data) {
            var addr = ''; // 주소 변수
            var extraAddr = ''; // 참고항목 변수

            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                addr = data.roadAddress;
            } else { // 사용자가 지번 주소를 선택했을 경우(J)
                addr = data.jibunAddress;
            }

            if (data.userSelectedType === 'R') {
                if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
                    extraAddr += data.bname;
                }
                if (data.buildingName !== '' && data.apartment === 'Y') {
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                if (extraAddr !== '') {
                    extraAddr = ' (' + extraAddr + ')';
                }
                document.getElementById("extraAddress").value = extraAddr;
            } else {
                document.getElementById("extraAddress").value = '';
            }

            document.getElementById("postcode").value = data.zonecode;
            document.getElementById("address").value = addr;
            document.getElementById("detailAddress").focus();
        }
    }).open();
}


//로컬 스토리지에서 데이터 불러오기
const orderData = JSON.parse(localStorage.getItem('orderData'));
const couponData = JSON.parse(localStorage.getItem('couponData'));

// 쿠폰 금액을 저장할 변수 선언
let couponAmount = 0;

if (couponData && Array.isArray(couponData) && couponData.length > 0 && typeof couponData[0] === 'object' && couponData[0].coupon && !isNaN(Number(couponData[0].coupon))) {
    couponAmount = Number(couponData[0].coupon);
    console.log("Coupon amount from array object:", couponAmount); // 배열 객체일 경우 처리 확인
} else if (couponData && !isNaN(Number(couponData))) { // 단순 숫자 문자열인 경우 처리
    couponAmount = Number(couponData);
    console.log("Coupon amount from string:", couponAmount); // 단순 숫자일 경우 처리 확인
} else {
    console.error("Invalid couponData format:", couponData);
}

// 데이터가 존재하는지 확인
console.log("Loaded order data:", orderData);
console.log("Loaded coupon data:", couponData);
console.log("Loaded coupon:", couponAmount);

$(function() {
    if (orderData && orderData.length > 0) {
        const orderListDiv = document.getElementById('orderList');
        orderListDiv.innerHTML = ''; // 기존 내용을 비웁니다.

        let totalAmount = 0;
        
        console.log("Coupon Amount:", couponAmount); // 쿠폰 금액 확인

     // 전체 주문 데이터를 감싸는 wrap div를 생성
        let menuWrapDiv = document.querySelector('.menu-wrap');
        if (!menuWrapDiv) {
            menuWrapDiv = document.createElement('div');
            menuWrapDiv.className = 'menu-wrap';
            orderListDiv.appendChild(menuWrapDiv);
        }

        // 전체 주문 데이터를 처리
        orderData.forEach(item => {
            console.log("Processing item:", item);

            // 각 메뉴 항목을 담는 div 생성
            const menuItemDiv = document.createElement('div');
            menuItemDiv.className = 'menu-item';
            menuItemDiv.innerHTML = `
                <p>`+ item.menuname + ` `+ item.qty + `개 `+ item.totprice +`원</p>
            `;

            // menu-wrap div에 menu-item div 추가
            menuWrapDiv.appendChild(menuItemDiv);

            // 총 금액 계산
            totalAmount += parseInt(item.totprice) * parseInt(item.qty);
        });


     // 쿠폰 적용 금액 계산
        totalAmount -= couponAmount;
        console.log("Total Amount after coupon:", totalAmount);

        // 총 주문 금액 표시 
        const totalDiv = document.createElement('div');
        totalDiv.className = 'total-wrap';
        totalDiv.innerHTML = ` <div class="coupon-info"> 쿠폰 적용 : `+couponAmount+`원 </div>
        <div class="total-amount">총 주문 금액: <strong>`+totalAmount+`</strong>원</div>`;
        orderListDiv.appendChild(totalDiv);
    } else {
        document.getElementById('orderList').innerHTML = '<p>주문 데이터가 없습니다.</p>';
    }
});

    function Pay() {
    	if(document.getElementById("postcode").value == "" || document.getElementById("address").value == ""){
			alert('주소를 먼저 입력해주세요!')
		}else{
        let itemsObject = {};
        let totalAmount = 0;

        // orderData 배열을 사용하여 총 금액 계산
        if (orderData) {
            orderData.forEach(item => {
            	const menuname = item.menuname;
                const menuid = item.menuid;
                const price = parseInt(item.totprice);
                const quantity = parseInt(item.qty);
                const storeid = item.storeid;

                if (!itemsObject[menuname]) {
                    itemsObject[menuname] = {
                        menuID: menuid,
                        menuName: menuname,
                        quantity: quantity,
                        price: price,
                        total: price * quantity,
                        storeid : storeid
                    };
                } else {
                    itemsObject[menuname].quantity += quantity;
                    itemsObject[menuname].total += price * quantity;
                }

                totalAmount += price * quantity;
            });
            
            totalAmount -= couponAmount;
        }

        console.log("총 금액:", totalAmount);
        console.log("아이템 객체:", itemsObject);

        // 각 메뉴 ID를 배열에 담기
        const menuIds = Object.keys(itemsObject);
        // 배열을 문자열로 변환
        const menuIdsString = menuIds.join(', ');

        IMP.init('imp46547018');
        IMP.request_pay({
            pg: 'kakaopay.TC0ONETIME',
            pay_method: 'card',
            merchant_uid: 'id' + new Date().getTime(),
            name: menuIdsString,   //상품 이름으로 메뉴 ID를 사용
            amount: totalAmount,
            buyer_name: '하하' ,     //구매자 이름(id)

        }, function (rsp) {
            if (rsp.success) {
                alert('결제 성공');
                //window.location.href = "/customer/pastOrder.do";
                addOrder(itemsObject);
             // couponData에서 usercid 가져오기
                if (couponData && couponData.length > 0 && couponData[0].usercid) {
                    let usercid = couponData[0].usercid;
                    useCouponDel(usercid);  // 쿠폰 사용 함수 호출 시 usercid 전달
                }
            } else {
                alert('결제에 실패하였습니다: ' + rsp.error_msg);
            }
        });
    }
    
    }
    
    function addOrder(itemsObject) {
    	 let orderData = [];
    	    
    	  for (let key in itemsObject) {
    	        if (itemsObject.hasOwnProperty(key)) {
    	            let item = itemsObject[key];
    	            orderData.push({
    	                menuid: item.menuID,
    	                qty: item.quantity,
    	                totprice: item.total,
    	                address : $('#address').val(),
    	                storeid: item.storeid,
    	                menuname: item.menuName
    	                /* cateid: category ID ,*/
    	                /*id: '하하' // 주문자 ID*/
    	            });
    	        }
    	  }

    	  console.log('Order data to send:', orderData);

    	    var csrfToken = $("meta[name='_csrf']").attr("content");
    	    var csrfHeader = $("meta[name='_csrf_header']").attr("content");

    	    // 서버로 데이터 전송
    	    $.ajax({
    	        url: "directOrder.ajax",
    	        type: "POST",
    	        contentType: "application/json",
    	        data: JSON.stringify(orderData),
    	        beforeSend: function(xhr) {
    	            // AJAX 요청 헤더에 CSRF 토큰 추가
    	            xhr.setRequestHeader(csrfHeader, csrfToken);
    	        },
    	        success: function(response) {
    	            console.log('주문 데이터 전송 성공:', response);
    	            window.location.href = "/customer/viewDelivery.do?deliveryid="+response;
    	        },
    	        error: function(xhr, status, error) {
    	            console.error('주문 데이터 전송 실패:', error);
    	            console.error('상태 코드:', xhr.status);
    	            console.error('응답 텍스트:', xhr.responseText);
    	        }
    	    });
    	}
    
    function useCouponDel(usercid) {
    	console.log(usercid);
        var csrfToken = $("meta[name='_csrf']").attr("content");
        var csrfHeader = $("meta[name='_csrf_header']").attr("content");

        $.ajax({
            url: "useCoupon.ajax",
            type: "POST",
            contentType: "application/json",
            data: JSON.stringify({ usercid: usercid }),
            beforeSend: function(xhr) {
                xhr.setRequestHeader(csrfHeader, csrfToken);
            },
            success: function(response) {
                console.log('쿠폰 사용 데이터 전송 성공:', response);
            },
            error: function(xhr, status, error) {
                console.error('쿠폰 사용 데이터 전송 실패:', error);
                console.error('상태 코드:', xhr.status);
                console.error('응답 텍스트:', xhr.responseText);
            }
        });
    }
    
    
</script>