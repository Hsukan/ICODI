<%@page import="com.kh.icodi.admin.model.dto.ProductAttachment"%>
<%@page import="java.util.List"%>
<%@page import="com.kh.icodi.admin.model.dto.ProductExt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%
	List<ProductExt> productList = (List<ProductExt>)request.getAttribute("productList");
	int productPrice = productList.get(0).getProductPrice();
	String productName = productList.get(0).getProductName(); 
	String productInfo = productList.get(0).getProductInfo();
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
					<h2><%= productName %></h2>
					<table>
						<tbody>
							<tr>
								<th>price</th>
								<td><%= productPrice %></td>
							</tr>
							<tr>
								<th>color</th>
								<td>
									<ul class="color-list">
										<% for(ProductExt product : productList) { %>
											<li class="color"><%= product.getProductColor() %></li>
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
											<li class="size size-disabled"><%= product.getProductSize() %></li>
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
					<div class="total-price">
						TOTAL : 
						<span id="totalPrice">0</span>원
						(<span id="totalCount">0</span>개)
					</div>
					<button id="buy">BUY IT NOW</button>
					<button id="cart">ADD TO CART</button>
					
					<div class="product-detail-wrap">
						<div id="detail-header">DETAIL</div>
						<div id="detail-content"><%= productInfo %></div>
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
		const size = document.querySelectorAll(".size-list li"); 
			
		if(color.classList.value.indexOf('product-select') == -1) {
			color.classList.add('product-select');
			size.forEach((li) => li.classList.remove('size-disabled'));
		} else {
			color.classList.remove('product-select');		
			size.forEach((li) => li.classList.add('size-disabled'));
			size.forEach((li) => li.classList.remove('product-select'));
		}
	});
});

document.querySelectorAll(".size").forEach((target) => {
	target.onclick = (e) => {
		const size = e.target;
		const color = document.querySelector(".color-list li");
		
		if(size.classList.value.indexOf('size-disabled') != -1 || size.classList.value.indexOf('product-select') != -1) {
			size.disabled = true;
			size.classList.remove('product-select');	
		} else {
			const sizeList = document.querySelectorAll(".size-list li");
			const colorList = document.querySelectorAll(".color-list li");
			
			size.classList.add('product-select');
			sizeList.forEach((li) => li.classList.add('size-disabled'));
			
			const selected = document.querySelectorAll(".product-select");
			
			let totalColor = '';
			let totalSize = '';
			
			[...selected].forEach((select) => {
				console.dir()
				if(select.className.indexOf('color') != -1) {
					totalColor = select.innerHTML;
				} else if(select.className.indexOf('size') != -1) {
					totalSize = select.innerHTML;					
				}
			});
			
			sizeList.forEach((li) => li.classList.remove('product-select'));
			colorList.forEach((li) => li.classList.remove('product-select'));
			
			const tbody = document.querySelector(".totalProductList tbody");
			const tr = `
			<tr>
				<td class='totalSelect'>
					<p class="product">
						<%= productName %>
						<br />
						- \${totalColor}/\${totalSize}
					</p>
					<span class="count"><input type="number" name="count" min="1" max="100" value="1" onchange="countChange(event)"/></span>
					<span class="delete">X</span>
					<span class="price"><%= productPrice %></span>
				</td>
			</tr>
			`
			tbody.insertAdjacentHTML('beforeend', tr);
			
			// totalPrice
			const totalPrice = [...document.querySelectorAll('.price')].map((price) => {
					return Number(price.innerHTML);
				}).reduce((total, price) => {
					return total + price;
				}, 0);
			document.querySelector("#totalPrice").innerHTML = totalPrice;
			totalCount();
		}
	}
});

const countChange = (e) => {
	let total = totalCount();

	const countVal = e.target.value;
	const price = e.target.parentElement.nextElementSibling.nextElementSibling;
	price.innerHTML = countVal * <%= productPrice %>;
	
	const totalPrice = document.querySelector("#totalPrice");
	totalPrice.innerHTML = total * <%= productPrice %>;
};

const totalCount = (e) => {
	const totalCount = [...document.querySelectorAll('[name=count]')].map((count) => {
		return Number(count.value);
	}).reduce((total, count) => {
		return total + count;
	}, 0);
	document.querySelector("#totalCount").innerHTML = totalCount;
	return totalCount;
};
</script>
</body>
</html>