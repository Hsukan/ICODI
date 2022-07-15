<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
	<main>
		<div id="content-wrap">
			<button id="btn-product-enroll">상품등록</button>
			<button onclick="location.href='<%=request.getContextPath()%>/inquireAnswer'">문의 답변</button>
		</div>
	</main>
	
	<script>
	document.querySelector("#btn-product-enroll").addEventListener('click', (e) => {
		location.href = "<%= request.getContextPath()%>/admin/productEnroll";
	});
	</script>
</body>
</html>