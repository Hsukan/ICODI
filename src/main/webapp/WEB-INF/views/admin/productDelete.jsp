<%@page import="com.kh.icodi.admin.model.dto.CategoryNo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<main>
	<div class="content-wrap">
		<div class="header-wrap">
			<h2>상품 삭제</h2>
		</div>
		<section>
			<article>
				<form name="productDelFrm" action="<%= request.getContextPath()%>/admin/productDel" method="POST">
					<div class="categoryArea-wrap">
						<select name="categoryName">
							<option>선택하세요</option>
							<option value="<%=CategoryNo.stringOf("TOP")%>">상의</option>
							<option value="<%=CategoryNo.stringOf("BOTTOM")%>">하의</option>
							<option value="<%=CategoryNo.stringOf("SHOES")%>">신발</option>
							<option value="<%=CategoryNo.stringOf("ACC")%>">악세사리</option>
						</select>
						<input type="submit" value="삭제"/>
					</div>
					<div class="codiProduct">
						<ul>
								
						</ul>
					</div>	
				</form>			
			</article>
		</section>
	</div>
</main>
<script>
	document.querySelector("[name=categoryName]").addEventListener('change', (e) => {
		const categoryNo = e.target.value;
		$.ajax({
			url : '<%= request.getContextPath()%>/admin/productView',
			method : 'POST',
			dataType : 'json',
			data : {categoryNo},
			success(products){
				const ul = document.querySelector(".codiProduct ul");
				ul.innerHTML = '';
				
				products.forEach((product) => {
					if(product == '') return;
					
					const {productCode, productName, productPrice, productSize, productColor, attachmentList} = product;
					attachmentList.forEach((attach) => {
						const {productRenamedFilename}	= attach;
						if(productRenamedFilename == undefined){
							return;
						} 
						const li =
							`
							<li>
								<img src="<%= request.getContextPath()%>/upload/admin/\${productRenamedFilename}"
									id="\${productCode}" class="img"/>
								<input type="checkbox" id="pdCode" value="\${productCode}" name="pdCode" />
								<label for="pdCode">\${productCode}</label>
								<div id="productName">\${productName}</div>
								<div id="productPrice">\${productPrice}</div>
								<div id="productSize">\${productSize}</div>
								<div id="productColor">\${productColor}</div>
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