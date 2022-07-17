<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<script src="<%=request.getContextPath()%>/js/jquery-3.6.0.js"></script>
<%
	List<String> imgSrc = (List<String>) request.getAttribute("imgSrc");
	System.out.println("imgSrc@mycoid.jsp = " + imgSrc);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<% for(String img : imgSrc) { %>
	<div id="here">
		<img src="data:image/jpeg;base64,<%= img %>" alt="" />
	</div>
	<% } %>

</body>
</html>