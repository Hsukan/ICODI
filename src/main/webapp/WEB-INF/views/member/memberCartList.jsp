<%@page import="com.kh.icodi.admin.model.dto.Product"%>
<%@page import="com.kh.icodi.member.model.dto.MemberCart"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="com.kh.icodi.common.MemberCartProductManager"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link rel="stylesheet"
	href="<%=request.getContextPath() %>/css/cart.css" />

<% 
	List<MemberCartProductManager> cartList = (List<MemberCartProductManager>)request.getAttribute("cartList");
	Member member = cartList.get(0).getMember();
	DecimalFormat numFormat = new DecimalFormat("#,###");
%>

<main>
	<section>
		<article>
			<div class="content-wrap">
				<form action="<%= request.getContextPath()%>/member/cartToOrder">
					<div class="title-wrap">
						<h2>SHOPPING CART</h2>
					</div>
					<div class="member-info-wrap">
						<div class="member">
							<span class="strong"><%= member.getMemberName() %>님</span>은, <%= member.getMemberRole() == MemberRole.U ? "[일반]" : "[관리자]" %>회원이십니다.
						</div>
						<div class="mileage">
							적립금 : <span class="strong"><%= numFormat.format(member.getPoint()) %></span>원
						</div>
					</div>
					<div class="cart-product-header">장바구니 내역</div>
					<table class="cart-product">
						<thead>
							<tr>
								<th class="checkbox">
									<input type="checkbox" name="checkbox" id="allOrder" />
								</th>
								<th>이미지</th>
								<th>상품정보</th>
								<th>판매가</th>
								<th>수량</th>
								<th>적립금</th>
								<th>배송비</th>
								<th>합계</th>
							</tr>
						</thead>
						<tbody>
							<% if(cartList != null && !cartList.isEmpty()) { 
								for(MemberCartProductManager list : cartList) {
									MemberCart cart = list.getCart();
									Product product = list.getProduct();
							%>
							<tr>
								<td class="checkbox">
									<span>
										<input type="checkbox" name="checkbox" id="selectOrder" value="<%= cart.getCartNo() %>"/>
									</span>						
								</td>
								<td id="productImg">
									<div>이미지</div>
								</td>
								<td id="productInfo">
									<div class="productName"><%= product.getProductName() %></div>
									<div class="productOption">[옵션:<%=product.getProductColor() %>/<%= product.getProductSize() %>]</div>
									<input type="hidden" name="productCode" value="<%= product.getProductCode() %>" />
									<input type="hidden" name="cartNo" value="<%= cart.getCartNo() %>" />
								</td>
								<td><span><span><%= numFormat.format(product.getProductPrice()) %></span>원</span></td>
								<td>
									<span><%= cart.getCartAmount() %></span>
									<input type="hidden" name="cartAmount" value="<%= cart.getCartAmount() %>" />
								</td>
								<td><span id="addPoint"><%= numFormat.format((int)(product.getProductPrice() * product.getProductPluspoint()) * cart.getCartAmount()) %></span></td>
								<td><span>[기본]</span></td>
								<td><span><span id="productPrice"><%= numFormat.format(product.getProductPrice() * cart.getCartAmount()) %></span>원</span></td>
							</tr>
							<%
								}
							}
							%>
						</tbody>
						<tfoot>
							<tr>
								<td colspan="2">[기본배송]</td>
								<td colspan="6" id="orderProductPrice">상품구매금액 <span id="productTotalPrice"></span>원 + 배송비 2,500 = 합계 : <span id="totalPrice"></span>원</td>
							</tr>
						</tfoot>
					</table>
					<div class="delete-wrap">
						<span>선택상품</span>
						<button id="delBtn">삭제하기</button>
					</div>
					<div class="total-info-wrap">
						<table class="total">
							<thead>
								<tr>
									<th>총 주문 금액</th>
									<th>총 배송비</th>
									<th>총 결제예정 금액</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td><span class="display"><span id="orderPrice"></span>원</span></td>
									<td><span class="display"><span>2,500원</span></span></td>
									<td><span class="display">= <span id="total"></span>원</span></td>
								</tr>
							</tbody>
						</table>
					</div>
					<div class="order-wrap">
						<button id="order-btn">상품주문</button>
					</div>
				</form>
			</div>
			
		</article>
	</section>
</main>

<script>
const select = document.querySelectorAll("#selectOrder");

document.querySelector("#allOrder").addEventListener('click', (e) => {
	[...select].forEach((check) => {
		if(check.checked == false) {
			check.checked = true;
		} else {
			check.checked = false;
		}
	});
});

document.querySelector("#delBtn").addEventListener('click', (e) => {
	let delCartNo = [];
	
	if(!confirm('해당 상품을 삭제하시겠습니까?')) return;
	
	for(let i = 0; i < select.length; i++) {
		if(select[i].checked == true) {
			delCartNo.push(select[i].value);
		}
	}

	// 비동기로 삭제
	$.ajax({
		url : '<%= request.getContextPath()%>/member/cartDelete',
		type : 'POST',
		data : {delCartNo},
		traditional:true,
		success(response) {
			location.reload();
		},
		error : console.log
	});
});
</script>
</body>
</html>