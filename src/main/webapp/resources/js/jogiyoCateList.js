function viewStore(id) {
    var form = document.createElement('form');
    form.method = 'POST';
    form.action = '/customer/viewStore.do';

    var idInput = document.createElement('input');
    idInput.type = 'hidden';
    idInput.name = 'storeid';
    idInput.value = id;
    form.appendChild(idInput);

    document.body.appendChild(form);
    form.submit();
}

function CateList(id) {
    var form = document.createElement('form');
    form.method = 'POST';
    form.action = '/customer/cateList.do';

    var idInput = document.createElement('input');
    idInput.type = 'hidden';
    idInput.name = 'cateid';
    idInput.value = id;
    form.appendChild(idInput);

    document.body.appendChild(form);
    form.submit();
}