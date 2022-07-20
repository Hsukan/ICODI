<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <!-- src/main/webapp 부터 시작! -->
<%@include file = "/WEB-INF/views/common/header.jsp" %> <br /><br />
<style>
	#newProduct{width:800px; height:200px; margin: 0 auto; border:1px solid black;}
	#newProduct img{width: 150px; height: 200px;}
	
</style>
	<section>
		<span>신상품</span>
		<div id="newProduct">
		</div>
	</section>
	<script>
		const newProduct = () => {
			$.ajax({
				url : '<%=request.getContextPath()%>/product/newProdcut',
				dataType: 'json',
				success(response){
					console.log("response@index = " + response);
					const div = document.querySelector("#newProduct");
					
					response.forEach((product) => {
						const {productRenamedFilename} = product.attachmentList[0];
						const {productCode, productName, productPrice} = product;
						
						const img = `
							<a href="<%= request.getContextPath()%>/product/detail?product_name=\${productName}">					
							<img src="<%= request.getContextPath()%>/upload/admin/\${productRenamedFilename}" alt="" />
						</a>
						`;
						div.insertAdjacentHTML('beforeend', img);
					})
				},
				error: console.log
			});
		};
		newProduct();
	</script>