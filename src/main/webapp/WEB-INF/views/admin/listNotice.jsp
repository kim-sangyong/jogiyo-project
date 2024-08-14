<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="../header.jsp"/>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/listNotice.js" ></script> 
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/table.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/listNotice.css">
<div align="center" style="margin-top: 80px; margin-bottom: 80px">
    <h1><span style="font-weight: bold; color:#fa0050; font-family: 'Gothic A1', sans-serif;">공지사항 목록  </span></h1>
    <div align="center" >
    <h4><span style="font-weight: bold; color:black; font-family: 'Gothic A1', sans-serif;">관리자의 공지사항 페이지입니다.  </span></h4>
    <div class="notice-container" style="margin-top: 60px">
        <div class="notice-list" style="width: 70%; height: 400px; overflow-y: scroll;">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
            <table class="notice-table">
                <thead>
                    <tr>
                        <th style="background-color: #DDD; width: 30%;font-size: 20px; text-align: center; border-right: none;">Total</th>
     <th style="background-color: #DDD; width: 5%;font-size: 20px; text-align: center; border-right: none;">Date</th>
                    
     </thead>
                <tbody>
                    <c:forEach items="${list}" var="dto">
                        <tr class="notice-row">
                            <td class="notice-cell"><a href="javascript:void(0);" onclick="viewNotice(${dto.notiid})">${dto.subject}</a></td>
                            <td class="notice-cell">${dto.indate}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>
</div>

<jsp:include page="../footer.jsp"/>
