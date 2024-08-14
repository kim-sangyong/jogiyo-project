<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="../header2.jsp"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/table.css">
<div align="center" style="margin-top: 90px;">
<h4><span style="font-weight: bold; font-family: 'Gothic A1', sans-serif;">카테고리 추가</span></h4>
<div align="center" style="margin-top: 20px;">
    <form action="/admin/insertCateOk.do" method="post" enctype="multipart/form-data" style="border: 1px solid #ddd; padding: 20px; width: 50%; border-radius: 10px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);"> 
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
        <div style="margin-bottom: 20px; width:70%;">
            <label for="catename" style="font-weight: bold; margin-top: 30px; margin-right: 10px;">카테고리 이름</label>
            <input type="text" name="catename" id="catename" style= "padding: 5px; border-radius: 5px; border: 1px solid #ccc; flex: 1;">
        </div>
        <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 15px;width: 50%;">
            <label for="file" style="font-weight: bold; margin-bottom: 8px; margin-right: 10px;">카테고리 이미지</label>
            <input type="file" name="file" id="file" style="padding: 5px; border-radius: 5px; border: 1px solid #ccc; width: 30%; flex: 1;">
        </div>
        <div style= "text-align: center;">
            <button type="submit" style="padding: 10px 20px; background-color: #fa0050; color: #fff; border: none; border-radius: 5px; cursor: pointer;margin-right: 10px;margin-bottom: 30px;">등록</button>
            <button type="submit" style="padding: 10px 20px; background-color: #fa0050; color: #fff; border: none; border-radius: 5px; cursor: pointer;margin-bottom: 30px;">임시등록</button>
        </div>
    </form>
</div>
<div align ="center" style="margin-bottom: 200px;">
</div>
<jsp:include page="../footer.jsp"/>
