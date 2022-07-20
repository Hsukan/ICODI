<%@page import="java.text.DecimalFormat"%>
<%@page import="com.kh.icodi.admin.model.dto.Product"%>
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
	DecimalFormat priceFormat = new DecimalFormat("#,###");
%>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/product.css" />
	<main>
		<section>
			<article>
				<div class="content-wrap">
					<div class="product-wrap">
						<div class="img-wrap">
							<div id="product-img">
								<%-- <%
									if(productList != null && !productList.isEmpty()) {
										for(ProductExt product : productList) {
											List<ProductAttachment> attachments = product.getAttachmentList();
											if(attachments != null && !attachments.isEmpty()) {
												for(ProductAttachment attach : attachments) {
													if(attach.getProductRenamedFilename() == null) break;
								%> --%>
									<img src="<%= request.getContextPath() %>/upload/admin/<%= productList.get(0).getAttachmentList().get(1)%>" />
								<%-- <%
												}
											}
		 								}
									}
								%> --%>
							</div>				
						</div>
						<div class="product-info-wrap">
							<h2 class="productName"><%= productName %></h2>
							<table>
								<tbody>
									<tr>
										<th colspan="">price</th>
										<td><%= priceFormat.format(productPrice) %>원</td>
									</tr>
									<tr>
										<th>color</th>
										<td>
											<ul class="color-list">
												<% for(ProductExt product : productList) { %>
													<li class="color"><%= product.getProductColor() %></li>
												<% } %>
											</ul>
											<span class="essential">[필수] 옵션을 선택해주세요</span>
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
											<span class="essential">[필수] 옵션을 선택해주세요</span>
										</td>
									</tr>
									<tr>
										<th></th>
										<td id="soldOut"></td>
									</tr>
								</tbody>
							</table>
		
							<div class="total-product-wrap">
								<form action="" method="POST" name="totalProductFrm">
									<table class="totalProductList">
										<tbody>
										
										</tbody>
									</table>
								</form>
							</div>
							<div class="total-price">
								TOTAL : 
								<span id="totalPrice" class="totalPriceVal">0</span>원
								(<span id="totalCount" class="totalCountVal">0</span>개)
							</div>
							<button id="buy">BUY IT NOW</button>
							<br />
							<button id="cart">ADD TO CART</button>
						</div>
					</div>
					<div class="product-detail-wrap">
						<div id="detail-header"><span>DETAIL</span></div>
						<div id="detail-content"><%= productInfo %></div>
					</div>
				</div>
			</article>
		</section>
	</main>
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
			const productCode = `<%= productName%>_\${totalSize}_\${totalColor}`;
			
			for(let i = 0; i < tbody.children.length; i++) {
				if(productCode == tbody.children[i].id) {
					alert("이미 추가한 상품입니다.");
					return;
				}
			}
			
			document.querySelector("#soldOut").innerHTML = '';
			// 품절 확인
			<%-- <% if(productList != null && !productList.isEmpty()) {
				for(Product product : productList) {
			%>
				if("<%= product.getProductCode()%>" == productCode && <%= product.getProductStock()%> == 0) {
						document.querySelector("#soldOut").innerHTML = '해당 상품은 품절입니다.';
						return;
					}
		 	<% }
			} %> --%>
			
			const tr = `
			<tr id="\${productCode}" class="productList">
				<td class='totalSelect'>
					<p class="product">
						<span id="totalProductName"><%= productName %></span>
						<br />
						- \${totalColor}/\${totalSize}
					</p>
					<span class="count"><input type="number" name="count" min="1" max="100" value="1" onchange="countChange(event)"/></span>
					<span class="delete" onclick="productDelete(event)">X</span>
					<span class="price"><%= priceFormat.format(productPrice) %></span>원
					<input type="hidden" name="productCode" value="\${productCode}" />
					<input type="hidden" name="productCount" value="1"/>
				</td>
			</tr>
			`;
			tbody.insertAdjacentHTML('beforeend', tr);
			
			// totalPrice
			const totalPrice = [...document.querySelectorAll('.price')].map((price) => {
					return Number(price.innerHTML.replace(",", ""));
				}).reduce((total, price) => {
					return total + price;
				}, 0);
			document.querySelector("#totalPrice").innerHTML = totalPrice.toLocaleString('ko-KR');
			totalCount();
		}
	}
});

const countChange = (e) => {
	let totalCnt = totalCount();

	const countVal = e.target.value;
	const price = e.target.parentElement.nextElementSibling.nextElementSibling;
	const inputCount = e.target.parentElement.nextElementSibling.nextElementSibling.nextElementSibling.nextElementSibling;
	price.innerHTML = (countVal * <%= productPrice %>).toLocaleString('ko-KR');
	inputCount.value = countVal;
	
	totalPrice(totalCnt);
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

const totalPrice = (totalCnt) => {
	const totalPrice = document.querySelector("#totalPrice");
	totalPrice.innerHTML = (totalCnt * <%= productPrice %>).toLocaleString('ko-KR');
}

const productDelete = (e) => {
	e.target.parentElement.parentElement.remove();
	let totalCnt = totalCount();
	totalPrice(totalCnt);
};

document.querySelectorAll("button").forEach((button) => {
	button.addEventListener('click', (e) => {
		const frm = document.totalProductFrm;
		if(e.target.id === 'buy') {
			frm.action = "<%= request.getContextPath()%>/product/order";
			frm.submit();
			return;
		} else if(e.target.id === 'cart') {
			frm.action = "<%= request.getContextPath()%>/product/addCart";
			frm.submit();
			return;
		}
	});
})

</script>
</body>
</html>