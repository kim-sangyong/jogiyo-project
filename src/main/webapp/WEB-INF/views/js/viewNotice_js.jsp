<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
function deleteNotice() {
    if (confirm("정말로 삭제하시겠습니까?")) {
        var form = document.createElement('form');
        form.method = 'POST';
        form.action = '/admin/deleteNotice.do';

        var idInput = document.createElement('input');
        idInput.type = 'hidden';
        idInput.name = 'notiid';
        idInput.value = ${dto.notiid};
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
}
function editNotice() {
   var form = document.createElement('form');
    form.method = 'POST';
    form.action = '/admin/editNotice.do';

    var idInput = document.createElement('input');
    idInput.type = 'hidden';
    idInput.name = 'notiid';
    idInput.value = ${dto.notiid};
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