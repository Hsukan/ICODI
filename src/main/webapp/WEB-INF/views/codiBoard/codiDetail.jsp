<%@page import="com.kh.icodi.admin.model.dto.ProductExt"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/productList.css" />
 <style>
        #codiImg {text-align: center;;}
        #codiImg img{width: 400px; height: 550px;}
        .product img{width: 150px; height: 150px;}
        #line{margin: 0 auto; width: 1000px; border: 1px solid gray;}
        #productContainer{width: 1000px; text-align: center; margin: 0 auto; display: flex; flex-wrap: wrap; justify-content: center;}
        .product-wrapper{width: 200px; height: 260px; border: 1px solid lightgray; padding: 15px 5px 0 5px ; margin: 0 20px 15px 20px;}
        #productName{text-align: left; padding: 0 0 0 20px; font-size: 20px;}
        #productPrice{text-align: left; padding: 0 0 0 20px; font-size: 15px;}
    </style>
<%
	List<ArrayList<ProductExt>> list =(List<ArrayList<ProductExt>>) request.getAttribute("list");
	String codiImg = (String) request.getAttribute("codiImg");
	int likeCount = (int) request.getAttribute("likeCount");
	//System.out.println("list@detail.jsp = "+ list);
%>
<br>
<br>
    <div id="codiImg">
        <img src="data:image/jpeg;base64,<%=codiImg %>" alt="">
        <br><br>
        <div id="line"></div>
    </div><br>
    <div style="margin: 0 auto; width: 1000px;">
        <span>♡ <%=likeCount %>명이 좋아합니다.</span>
    </div>
    <br><br>
    <div style="margin: 0 auto; width: 1000px;">
        <span style="font-size: 1.5em; color:gray">코디에 사용된 상품</span>
    </div><br><br>
    <div id="productContainer">
	<% for(List<ProductExt> _product : list){ 
	for(ProductExt product : _product){
%>
	<div class="product-wrapper">
		<div class="product">
			<a href="<%= request.getContextPath()%>/product/detail?product_name=<%= product.getProductName() %>">
				<img src="<%= request.getContextPath()%>/upload/admin/<%=product.getAttachmentList().get(0).getProductRenamedFilename() %>" alt="" />
			</a>
			<div id="productName">
				<p><%= product.getProductName() %></p>
			</div>
			<div id="productPrice">
				<p><%= product.getProductPrice() %>원</p>
			</div>
		</div>
	</div>
	<% 		} 
	}
%>
</div>
<%@include file="/WEB-INF/views/common/footer.jsp"%>