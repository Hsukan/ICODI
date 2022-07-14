<%@page import="com.kh.icodi.admin.model.dto.CategoryNo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<script src="<%=request.getContextPath()%>/js/jquery-3.6.0.js"></script>
<style>
	.item img {
		width : 110px;
		height : 110px;
	}
</style>
<main>
	<section>
		<article>
			<div class="codiArea-wrap">
				<div class="codiAreaMenu">
					<div id="saveBtn">저장</div>
				</div>
				<div class="canvas-wrap"></div>
			</div>
		</article>
		<article>
			<div class="codiProductArea-wrap">
				<ul id="category">
					<li value="<%= CategoryNo.stringOf("TOP") %>">TOP</li>
					<li value="<%= CategoryNo.stringOf("BOTTOM") %>">BOTTOM</li>
					<li value="<%= CategoryNo.stringOf("SHOES") %>">SHOES</li>
					<li value="<%= CategoryNo.stringOf("ACC") %>">ACC</li>
				</ul>
				<div class="codiProduct">
					<ul>

					</ul>
				</div>
			</div>
		</article>
	</section>
</main>
<script>
	document.querySelector("#category").addEventListener('click', (e) => {
		$.ajax({
			url : '<%= request.getContextPath()%>/codibook/create',
			method : 'POST',
			dataType : 'json',
			data : {categoryNo : e.target.value},
			success(products) {
				const ul = document.querySelector(".codiProduct ul");
				ul.innerHTML = '';
				
				products.forEach((product) => {
					if(product == '') return;
					
					const {productCode, productPrice, attachmentList} = product;
					attachmentList.forEach((attach) => {				
						const {codiRenamedFilename} = attach;
						if(codiRenamedFilename == undefined) {
							return;
						}

						const li =
							`
							<li class="item">
								<img src="<%= request.getContextPath() %>/upload/admin/\${codiRenamedFilename}"
									data-product-code="\${productCode}" data-product-price="\${productPrice}"/>
								<div class="productPrice">\${productPrice}원</div>
							</li>			
							`;
						ul.insertAdjacentHTML('afterbegin', li);
					});
				})
			},
			error : console.log
		});
	});
</script>
</body>
</html>