<%@page import="com.kh.icodi.admin.model.dto.ProductAttachment"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="com.kh.icodi.admin.model.dto.ProductExt"%>
<%@page import="java.util.List"%>
<%@page import="com.kh.icodi.member.model.dto.MemberRole"%>
<%@page import="com.kh.icodi.member.model.dto.MemberCart"%>
<%@page import="com.kh.icodi.admin.model.dto.Product"%>
<%@page import="com.kh.icodi.common.MemberProductManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%
	List<MemberProductManager> orderList = (List<MemberProductManager>)request.getAttribute("order");
	Member member = orderList.get(0).getMember();
	List<ProductAttachment> attachment = orderList.get(0).getProductExt().getAttachmentList();
	DecimalFormat numFormat = new DecimalFormat("#,###");
%>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/order.css" />
<main>
	<section>
		<article>
			<div class="title-wrap">
				<h2>ORDER</h2>
			</div>
			<div class="member-info-wrap">
				<div class="member">
					<span class="strong"><%= member.getMemberName() %>님</span>은, <%= member.getMemberRole() == MemberRole.U ? "[일반]" : "[관리자]" %>회원이십니다.
				</div>
				<div class="mileage">
					적립금 : <span class="strong"><%= numFormat.format(member.getPoint()) %></span>원
				</div>
			</div>
			<div class="help-wrap">상품의 옵션 및 수량 변경은 상품상세 또는 장바구니에서 가능합니다.</div>
			<div class="order-product-header">배송상품 주문내역</div>
			<div class="order-product-view">
				<table class="order-product">
					<thead>
						<tr>
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
					<% if(orderList != null && !orderList.isEmpty()) {
						for(MemberProductManager order : orderList) {	
							Member orderMember = order.getMember();
							ProductExt orderProduct = order.getProductExt();
							MemberCart orderCart = order.getMemberCart();
	
					%>
							<tr>
								<td id="productImg">
									<img src="<%= request.getContextPath() %>/upload/admin/<%=attachment.get(0).getProductRenamedFilename() %>" alt="" />
								</td>
								<td id="productInfo">
									<div class="productName"><%= orderProduct.getProductName() %></div>
									<div class="productOption">[옵션:<%=orderProduct.getProductColor() %>/<%= orderProduct.getProductSize() %>]</div>
								</td>
								<td><span><span id="productPrice"><%= numFormat.format(orderProduct.getProductPrice()) %></span>원</span></td>
								<td><span><%= orderCart.getCartAmount() %></span></td>
								<td><span><%= numFormat.format((int)(orderProduct.getProductPrice() * orderProduct.getProductPluspoint())) %></span></td>
								<td><span>[기본]</span></td>
								<td><span><%= numFormat.format(orderProduct.getProductPrice() * orderCart.getCartAmount()) %>원</span></td>
							</tr>
					<%
						}
					}
					%>
					</tbody>
					<tfoot>
						<tr>
							<td>[기본배송]</td>
							<td colspan="6" id="orderProductPrice">상품구매금액 <span id="productTotalPrice"></span>원 + 배송비 2,500 = 합계 : <span id="totalPrice"></span>원</td>
						</tr>
					</tfoot>
				</table>
			</div>
			<div class="delivery-info-header">배송정보</div>
			<div class="delivery-info-wrap">
				<table class="delivery-product">
					<tbody>
						<tr>
							<th>주문자</th>
							<td><input type="text" class="input" value="<%= member.getMemberName() %>" /></td>
						</tr>
						<tr>
							<th>주소</th>
							<td>
								<input type="text" class="address" value="<%= member.getAddress() %>" readonly /> <span class="size">기본주소</span>
								<br />
								<input type="text" class="address" value="<%= member.getAddressEx() %>" readonly/> <span class="size">나머지주소</span>
							</td>
						</tr>
						<tr>
							<th>휴대전화</th>
							<td>
								<%= member.getPhone() %>
							</td>
						</tr>
						<tr>
							<th>이메일</th>
							<td><%= member.getEmail() %></td>
						</tr>
					</tbody>
				</table>
				<div class="fee-info-header">결제 예정 금액</div>
				<div class="fee-info-wrap">
					<table class="total">
						<thead>
							<tr>
								<th>총 주문 금액</th>
								<th>할인 금액</th>
								<th>총 결제예정 금액</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td><span class="display"><span id="orderPrice"></span>원</span></td>
								<td><span class="display">-<span id="discount">0</span>원</span></td>
								<td><span class="display">= <span id="total"></span>원</span></td>
							</tr>
						</tbody>
					</table>
					<div class="discount-info-wrap">
						<table>
							<tbody>
								<tr>
									<th>적립금</th>
									<td ><input type="text" value="0" id="point" class="input" /> <span class="size">원 (총 사용가능 적립금 : <span><%= member.getPoint() %></span>원)</span></td>
								</tr>
							</tbody>
						</table>
					</div>
					<div class="payment-info-header">결제수단</div>
					<div class="total-wrap">
						<div class="paymentSelect">
							<div class="cash-wrap">
								<input type="radio" name="cash" id="cash" checked />
								<label for="cast">무통장입금</label>
							</div>
							<div class="card-wrap">
								<input type="radio" name="card" id="card" />
								<label for="card">카드결제</label>
							</div>
						</div>
						<div class="payment-info-wrap">
							
						</div>
						<div class="final-wrap">
							<span id="total-payment">무통장입금</span>
							<span>최종결제금액</span>
							<div id="total"></div>원
							<input type="checkbox" name="orderAgree" id="orderAgree" />
							<label for="orderAgree">결제 정보를 확인하였으며, 구매진행에 동의합니다.</label>
							<button id="orderBtn">결제</button>
						</div>
					</div>
				</div>					
			</div>
		</article>
	</section>
</main>
</body>
<script>
	window.addEventListener('load', (e) => {
		const productPrice = document.querySelectorAll("#productPrice");
		const productTotalPrice = document.querySelector("#productTotalPrice");
		const totalPrice= document.querySelector("#totalPrice");
		
		const price = [...productPrice].map((span) => Number(span.innerHTML.replace(",",""))).reduce((total, price) => total + price);
		
		productTotalPrice.innerHTML = price.toLocaleString('ko-KR');
		totalPrice.innerHTML = (price + 2500).toLocaleString('ko-KR');
		
		const orderPrice = document.querySelector("#orderPrice");
		const discount = document.querySelector("#discount");
		const total = document.querySelectorAll("#total");
		orderPrice.innerHTML = totalPrice.innerHTML;
		[...total].forEach((div) => div.innerHTML = totalPrice.innerHTML);
	});
	
	document.querySelector("#point").addEventListener('change', (e) => {
		const point = e.target;
		const memberPoint = <%= member.getPoint()%>;
		const discount = document.querySelector("#discount");
		const total = document.querySelectorAll("#total");
		
		if(memberPoint < point.value) {
			alert('사용가능한 적립금보다 많습니다.');
			point.value = 0;
			point.focus();
			return;
		}
		
		discount.innerHTML = (point.value).toLocaleString('ko-KR');
		total.forEach((div) => div.innerHTML = (Number(div.innerHTML.replace(",","")) - Number(discount.innerHTML.replace(",",""))).toLocaleString('ko-KR'));
	});
</script>
</html>