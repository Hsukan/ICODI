<%@page import="com.kh.icodi.admin.model.dto.ProductAttachment"%>
<%@page import="java.util.List"%>
<%@page import="com.kh.icodi.admin.model.dto.ProductExt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%
	List<ProductExt> productList = (List<ProductExt>)request.getAttribute("productList");
%>
<style>
main {
	max-width: 1024px;
}
</style>
	<main>
		<section>
			<article>
				<div class="img-wrap">
					<div id="product-img">
						<%
							if(productList != null && !productList.isEmpty()) {
								for(ProductExt product : productList) {
									List<ProductAttachment> attachments = product.getAttachmentList();
									if(attachments != null && !attachments.isEmpty()) {
										for(ProductAttachment attach : attachments) {
											if(attach.getProductRenamedFilename() == null) break;
						%>
							<img src="<%= request.getContextPath() %>/upload/admin/<%= attach.getProductRenamedFilename()%>" alt="" />
						<%
										}
									}
 								}
							}
						%>
					</div>				
				</div>
				<div class="product-info-wrap">
					<h2><%= productList.get(0).getProductName() %></h2>
					<table>
						<tbody>
							<tr>
								<th>price</th>
								<td><%= productList.get(0).getProductPrice() %></td>
							</tr>
							<tr>
								<th>color</th>
								<td>
									<ul class="color-list">
										<% for(ProductExt product : productList) { %>
											<li class="color">
												<span><%= product.getProductColor() %></span>
											</li>
										<% } %>
									</ul>
									<span>[필수] 옵션을 선택해주세요</span>
								</td>
							</tr>
							<tr>
								<th>size</th>
								<td>
									<ul class="size-list">
										<% for(ProductExt product : productList) { %>
											<li class="size size-disabled">
												<span><%= product.getProductSize() %></span>
											</li>
										<% } %>
									</ul>
									<span>[필수] 옵션을 선택해주세요</span>
								</td>
							</tr>
						</tbody>
					</table>
					<div class="total-product-wrap">
						<table class="totalProductList">
							<tbody>
							
							</tbody>
						</table>
					</div>
				</div>
			</article>
		</section>
	</main>
<style>
.size {
	border : 1px solid black;
}
.size-disabled {
	background-color: gray;
}
</style>
<script>
document.querySelectorAll(".color").forEach((target) => {
	target.addEventListener('click', (e) => {
		const color = e.target;
		const sizeList = document.querySelectorAll(".size-list li"); 
			
		if(color.classList.value.indexOf('product-select') == -1) {
			color.classList.add('product-select');
			sizeList.forEach((li) => li.classList.remove('size-disabled'));
		} else {
			color.classList.remove('product-select');		
			sizeList.forEach((li) => li.classList.add('size-disabled'));
			sizeList.forEach((li) => li.classList.remove('product-select'));
		}
	});
});

document.querySelectorAll(".size").forEach((target) => {
	target.addEventListener('click', (e) => {
		const size = e.target;

		if(size.classList.value.indexOf('size-disabled') != -1 || size.classList.value.indexOf('product-select') != -1) {
			size.disabled = true;
			size.classList.remove('product-select');	
		} else {
			size.classList.add('product-select');	
			
			const selected = document.querySelectorAll(".product-select");
			console.log('selected', selected);
			[...selected].forEach((select) => {
				console.dir(select);
			})
			const tbody = document.querySelector(".totalProductList tbody");
			
			/* const tr = `
			<tr>
				<td class='totalSelect'></td>
			</tr>
				
			` */
		}
	
	})
})
</script>
</body>
</html>