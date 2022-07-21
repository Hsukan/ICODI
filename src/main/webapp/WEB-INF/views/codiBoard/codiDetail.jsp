<%@page import="com.kh.icodi.admin.model.dto.ProductExt"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/productList.css" />
<style>
	img{width:150px; height:150px;}
</style>
<%
	List<ArrayList<ProductExt>> list =(List<ArrayList<ProductExt>>) request.getAttribute("list");
	System.out.println("list@detail.jsp = "+ list);
%>
<h2>사용된 코디</h2>
<% for(List<ProductExt> product : list){ 
	for(ProductExt product2 : product){
%>

<span>
	<a href="<%= request.getContextPath()%>/product/detail?product_name=<%= product2.getProductName() %>">
	<img src="<%= request.getContextPath()%>/upload/admin/<%=product2.getAttachmentList().get(0).getProductRenamedFilename() %>" alt="" />
	<%= product2.getProductName() %>
	</a>
</span>
<% 		} 
	}
%>