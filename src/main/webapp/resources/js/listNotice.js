/**
 * 
 */
function viewNotice(id) {
    var form = document.createElement('form');
    form.method = 'POST';
    form.action = '/admin/viewNotice.do';

    var idInput = document.createElement('input');
    idInput.type = 'hidden';
    idInput.name = 'notiid';
    idInput.value = id;
    form.appendChild(idInput);

    var csrfToken = $("meta[name='_csrf']").attr("content");
    
    var csrfInput = document.createElement('input');
    csrfInput.type = 'hidden';
    csrfInput.name = '_csrf';
    csrfInput.value = csrfToken;
    form.appendChild(csrfInput);
    
    document.body.appendChild(form);
    form.submit();
}