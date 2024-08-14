/**
 * 
 */
document.addEventListener("DOMContentLoaded", function() {
    document.querySelector("form").addEventListener("submit", function(event) {
        // 등록 전 확인 메시지 표시
        var confirmMessage = "등록하시겠습니까?";
        if (!confirm(confirmMessage)) {
            event.preventDefault(); // 제출을 중지
        }  
    });
});
