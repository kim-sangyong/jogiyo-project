function check() {
    if (mynotice.subject.value == "") {
        alert("제목을 입력하셔야합니다.");
        mynotice.subject.focus();
        return false;
    }
         
    if (mynotice.content.value.length == 0) {
        alert("내용을 입력하셔야합니다.");
        mynotice.content.focus();
        return false;
    }
    
    var str = "지금까지 작성한 것들은 : \n";
    str += mynotice.subject.value + "\n";
    str += mynotice.content.value + "\n";
    mynotice.submit();
}
function convertTextArea() {
    var content = document.getElementById('content').value;
    content = content.replace(/\n/g, '<br>');
    document.getElementById('content').value = content;
    return true;
}

document.forms['mynotice'].onsubmit = convertTextArea;