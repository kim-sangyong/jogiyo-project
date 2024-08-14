<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="../header.jsp"/>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/pastOrder.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/pastOrder.js" ></script> 
    <div class="order-table-container">
        <div class="order-header">
            <h2>Past Orders</h2>
        </div>
        <table class="order-table">
            <thead>
                <tr>
                    <th>Restaurant</th>
                    <th>Date</th>
                    <th>Menu</th>
                    <th>Total</th>
                    <th>Review</th>
                    <th>Delete</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${porder}" var="order">
                <tr>
                    <td> ${order.storename}</td>
                    <td> ${order.indate}</td>
                    <td>
                         ${order.menuname}
                    </td>
                    <td>${order.totprice}</td>
                    <td class="actions">
                    	<button onclick="writeReview(${order.storeid})">리뷰 쓰기</button>
                    </td>
                	    <td class="actions">
                       <button onclick="deleteorder(${order.orderid})">주문내역 삭제</button>
                    </td>
                	
                 </tr>
                     </c:forEach>
            </tbody>
        </table>
    </div>
</body>
</html>

<jsp:include page="../footer.jsp"/>

