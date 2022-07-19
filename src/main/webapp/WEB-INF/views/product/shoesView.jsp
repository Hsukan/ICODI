<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%
	int categoryNo = (int)request.getAttribute("categoryNo");
	int totalPage = (int)request.getAttribute("totalPage");
%>
<main>
	<section>
		<article>
			<h2>SHOES</h2>
			<ul class="productList">
			
			</ul>
			<div id='btn-more-container'>
				<button id="btn-more" value="">더보기(<span id="cPage"></span>/<span id="totalPage"><%= totalPage%></span>)</button>
			</div>
		</article>
	</section>
</main>
<script>
	document.querySelector("#btn-more").addEventListener('click', (e) => {
		const cPage = Number(document.querySelector("#cPage").textContent) + 1;
		getPage(cPage);
	});
	
	const getPage = (cPage) => {
		const categoryNo = <%= categoryNo%>;
		$.ajax({
			url : '<%= request.getContextPath() %>/product/morePage',
			dataType : 'json',
			data : {cPage, categoryNo},
			success(response){
				const ul = document.querySelector(".productList");
				
				response.forEach((product) => {
					const {productRenamedFilename} = product.attachmentList[0];
					console.log(productRenamedFilename);
					const {productCode, productName, productPrice} = product;
					
					const li = `
					<a href="<%= request.getContextPath()%>/product/detail?product_code=\${productCode}">					
						<li class="product">
							<img src="<%= request.getContextPath()%>/upload/admin/\${productRenamedFilename}" alt="" />
							<div class="product-info">
								<div id="productName">\${productName}</div>
								<div id="productPrice">\${productPrice}</div>
							</div>
						</li>
					</a>
					`;
					ul.insertAdjacentHTML('beforeend', li);
				})
			},
			error : console.log,
			complete() {
				document.querySelector('#cPage').innerHTML = cPage;	

				if(cPage == <%= totalPage %>){
					document.querySelector("#btn-more").disabled = true;
				}
			}
		})
	};
	getPage(1);
</script>
</body>
</html>