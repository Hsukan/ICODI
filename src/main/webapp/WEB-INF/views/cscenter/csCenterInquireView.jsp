<%@page import="com.kh.icodi.cscenter.model.dto.CsCenterInquire"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% CsCenterInquire csCenterInquire = (CsCenterInquire)request.getAttribute("csCenterInquire"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1><%= csCenterInquire.getContent() %></h1>
	<span><%=csCenterInquire.getInquireDate() %></span>
	<span><%=csCenterInquire.getSelectType() %></span>
</body>
</html>