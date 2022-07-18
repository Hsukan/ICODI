<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
	<main>
		<div id="content-wrap">
			<button id="btn-product-enroll">상품등록</button>
			<button id="btn-product-delete">상품삭제</button>
		</div>
	</main>
	
	<script>
	document.querySelector("#btn-product-enroll").addEventListener('click', (e) => {
		location.href = "<%= request.getContextPath()%>/admin/productEnroll";
	});
	
	document.querySelector("#btn-product-delete").addEventListener('click', (e) => {
		location.href = "<%= request.getContextPath()%>/admin/productDelete";
	});
	</script>
</body>
</html>