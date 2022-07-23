<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link rel="stylesheet"
	href="<%=request.getContextPath() %>/css/admin.css" />

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
							<li><a href="<%=request.getContextPath()%>/stats">통계</a></li>
							
						</ul>
					</div>
				</nav>
			</article>
		<div id="content-center">
			<span>주문배송관리</span>
				<div class="waiting-wrap">
					<a href="<%= request.getContextPath()%>/admin/waitDeposit">
						<div>입금대기</div>
					</a>
				</div>
				<div class="finish-wrap">
					<a href="<%= request.getContextPath()%>/admin/paymentCompleted">
						<div>결제완료</div>
					</a>
				</div>
				<div class="refund-wrap">
					<a href="<%= request.getContextPath()%>/admin/orderList">
						<div>교환/환불처리</div>
					</a>
				</div>
			</div>
		<div id="content-wrap">
				<h2>상품관리</h2>
			<div class="product-content">
			<div class="product-content-icon">
			<i class="fa-solid fa-circle-arrow-up" id="btn-product-enroll"></i>
			<span>상품등록</span>
			</div>
			<div class="product-content-icon">
			<i class="fa-solid fa-circle-arrow-down" id="btn-product-delete"></i>
			<span>상품삭제</span>
			</div>
			</div>
			<h2>고객 서비스</h2>
			<div  class="product-content">
			<div class="product-content-icon">
			<i class="fa-solid fa-user" id="btn-csCenter"></i>			
			<span>고객센터</span>
			</div>
			<div class="product-content-icon">
			<i class="fa-solid fa-walkie-talkie" id="btn-answer"></i>
			<span>문의답변</span>
			</div>
			</div>
			
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
	
	document.querySelector("#btn-csCenter").addEventListener('click',(e)=>{
		location.href = "<%=request.getContextPath()%>/cs_center";
	});
	
	document.querySelector("#btn-answer").addEventListener('click',(e)=>{
		location.href = "<%=request.getContextPath()%>/inquireAnswer";
	});
	
	
	</script>
</body>
</html>