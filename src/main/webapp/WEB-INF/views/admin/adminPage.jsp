<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<style>
	.nav-wrap {
		border : 1px solid black;
		width : 300px;
		height : 400px;
	}
</style>
	<main>
		<section>
			<article>
				<nav>
					<div class="nav-wrap">
						<h2>관리자 페이지</h2>
						<ul>
							<li><a href="#">회원 정보 관리</a></li>
							<li><a href="#">상품 관리</a></li>
							<li><a href="#">주문/배송 관리</a></li>
							<li><a href="#">통계</a></li>
							<li><a href="#">고객센터</a></li>
						</ul>
					</div>
				</nav>
			</article>
		<div id="content-wrap">
			<button id="btn-product-enroll">상품등록</button>
			<button id="btn-product-delete">상품삭제</button>
		</div>
		</section>
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