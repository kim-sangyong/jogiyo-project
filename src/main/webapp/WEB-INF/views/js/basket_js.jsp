<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">
	

	function deleteBasket(basketid) {
        var form = document.createElement('form');
         form.method = 'POST';
         form.action = '/customer/BasketDelete.do';

         var idInput = document.createElement('input');
         idInput.type = 'hidden';
         idInput.name = 'basketid';
         idInput.value = basketid;
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

	function Pay() {
		if(document.getElementById("postcode").value == "" || document.getElementById("address").value == ""){
			alert('주소를 먼저 입력해주세요!')
		}else{
		var itemsObject = {};
		var totalAmount = 0;

		$('.basketTable').each(
				function() {
					var csrfToken = $("meta[name='_csrf']").attr("content");
					var csrfHeader = $("meta[name='_csrf_header']").attr(
							"content");

					var menuID = $(this).find('.td_width_1').text().trim();
					var menuname = $(this).find('.td_width_3').text().trim();
					var quantity = parseInt($(this).find('.quantity_input')
							.val());
					var storeid = $(this).find('.storeid_input').val();
					var cateid = $(this).find('.cateid_input').val();
					var price = parseInt($(this).find('.price_td .red_color')
							.text().replace(/[^0-9]/g, ''));
					console.log(price);

					if (menuID && menuname && quantity && price) {
						if (!itemsObject[menuname]) {
							itemsObject[menuname] = {
								menuID : menuID,
								quantity : quantity,
								price : price,
								total : price * quantity,
								address : $('#address').val(),
								storeid : storeid,
								cateid : cateid
							};
						} else {
							itemsObject[menuname].quantity += quantity;
							itemsObject[menuname].total += price * quantity;
						}

						totalAmount += price * quantity;
					}
				});

		console.log(totalAmount);
		console.log(itemsObject);
		 var couponNumber = getSelectedCouponContentNumber();
		    var discountAmount = 0;
		    var selectedCoupon = document.querySelector('input[name="coupon"]:checked');
	        var usercid = selectedCoupon ? selectedCoupon.value : null;
	        
		    if (couponNumber) {
		        discountAmount = parseInt(couponNumber); // 쿠폰의 숫자를 할인 금액으로 사용
		        totalAmount -= discountAmount; // 총 결제 금액에서 할인 금액을 뺌
		    }
		// 각 메뉴 이름을 배열에 담기
		var menuNames = Object.keys(itemsObject);
		// 배열을 문자열로 변환
		var menuNamesString = menuNames.join(', ');

		IMP.init('imp46547018');
		IMP.request_pay({
			pg : 'kakaopay.TC0ONETIME',
			pay_method : 'card',
			merchant_uid : 'id' + new Date().getTime(),
			name : menuNamesString, //상품이름
			amount : totalAmount,
			buyer_name : '하하', //구매자 이름(id)

		}, function(rsp) {
			if (rsp.success) {
				alert('결제 성공');
				addOrder(itemsObject);
				useCouponDel(usercid);
			} else {
				alert('결제에 실패하였습니다: ' + rsp.error_msg);
			}
		});
	}
	}
	function addOrder(itemsObject) {
		console.log(itemsObject);
		var csrfToken = $("meta[name='_csrf']").attr("content");
		var csrfHeader = $("meta[name='_csrf_header']").attr("content");
		// itemsObject 구조를 확인하기 위한 콘솔 로그
		console.log('전송할 데이터:', JSON.stringify(itemsObject));
		$.ajax({
			url : 'addOrder.ajax', // 서버의 컨트롤러 URL
			type : 'POST',
			contentType : 'application/json',
			data : JSON.stringify(itemsObject),
			beforeSend : function(xhr) {
				// AJAX 요청 헤더에 CSRF 토큰 추가
				xhr.setRequestHeader(csrfHeader, csrfToken);
			},
			success : function(response) {
				console.log('주문 데이터 전송 성공:', response);
				window.location.href = "/customer/viewDelivery.do?deliveryid="+response;
			},
			error : function(xhr, status, error) {
				console.error('주문 데이터 전송 실패:', error);
				console.error('상태 코드:', xhr.status);
				console.error('응답 텍스트:', xhr.responseText);
				// 오류 시 추가 작업 (예: 사용자에게 오류 메시지 표시 등)
			}
		}); 
	}
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


		<%-- 버튼 + - 추가함수 --%>
		function plusQty(index) {
		    let ogQty = document.getElementById('bqty' + index).value;
		    let chQty = parseInt(ogQty) + 1;
		    document.getElementById('bqty' + index).value = chQty;
		}

		function minusQty(index) {
		    let ogQty = document.getElementById('bqty' + index).value;
		    let chQty = parseInt(ogQty);

		    if (chQty > 1) {
		        chQty--;
		        document.getElementById('bqty' + index).value = chQty;
		    }
		}

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

		//수량 변경 함수 (서버에 업데이트 요청)
		function updateQuantity(index, menuid) {
		    let qty = document.getElementById('bqty' + index).value;
		    var csrfToken = $("meta[name='_csrf']").attr("content");
			var csrfHeader = $("meta[name='_csrf_header']").attr("content");
		    $.ajax({
		        url: '/customer/updateBasketQty.ajax',
		        type: 'POST',
		        beforeSend : function(xhr) {
					// AJAX 요청 헤더에 CSRF 토큰 추가
					xhr.setRequestHeader(csrfHeader, csrfToken);
				},
		        data: {
		            menuid: menuid,
		            qty: qty
		        },
		         
		        success: function(response) {
		            if (response === 'success') {
		                alert('수량이 업데이트되었습니다.');
		                location.reload();
		            } else {
		                alert('수량 업데이트에 실패했습니다.');
		            }
		        },
		        error: function(xhr, status, error) {
		            alert('수량 업데이트에 실패했습니다.');
		        
		    }})
		    };

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
