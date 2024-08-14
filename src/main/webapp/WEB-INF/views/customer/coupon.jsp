<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="../header.jsp"/>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/pastOrder.css">
    <div class="order-table-container">
        <div class="order-header">
            <h2>My Coupon</h2>
        </div>
        <table class="order-table">
            <thead>
                <tr>
                    <th>coupon name</th>
                    <th>coupon content</th>
                    <th>store</th>
                </tr>
            </thead>
            <tbody>
                
                <c:forEach items="${cCoupon}" var="coupon">
                	<tr>
	                    <td>${coupon.couname}</td>
	                    <td>${coupon.coucontent}</td>
	                    <td>${coupon.storename}</td>
                     </tr>
                </c:forEach>
                    
            </tbody>
        </table>
    </div>
    <script>
        function reorder() {
            alert('재주문 기능을 구현하세요.');
        }

        function writeReview() {
            alert('리뷰 쓰기 기능을 구현하세요.');
        }
    </script>

<jsp:include page="../footer.jsp"/>

