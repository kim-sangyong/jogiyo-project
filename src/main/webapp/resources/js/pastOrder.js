function reorder() {
	alert('재주문 기능을 구현하세요.');
}

function writeReview(storeid) {
	var form = document.createElement('form');
	form.method = 'POST';
	form.action = '/customer/viewStore.do';

	var idInput = document.createElement('input');
	idInput.type = 'hidden';
	idInput.name = 'storeid';
	idInput.value = storeid;
	form.appendChild(idInput);

	var csrfToken = $("meta[name='_csrf']").attr("content");

	var idInput2 = document.createElement('input');
	idInput2.type = 'hidden';
	idInput2.name = '_csrf';
	idInput2.value = csrfToken;
	form.appendChild(idInput2);

	var idInput3 = document.createElement('input');
	idInput3.type = 'hidden';
	idInput3.name = 'isReview';
	idInput3.value = 'ok';
	form.appendChild(idInput3);

	document.body.appendChild(form);
	form.submit();
}
function deleteorder(orderid) {
    var form = document.createElement('form');
     form.method = 'POST';
     form.action = '/customer/orderDelete.do';

     var idInput = document.createElement('input');
     idInput.type = 'hidden';
     idInput.name = 'orderid';
     idInput.value = orderid;
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

