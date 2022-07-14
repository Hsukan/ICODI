<%@page import="java.util.List"%>
<%@page import="com.kh.icodi.cscenter.model.dto.CsCenterInquire"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file = "/WEB-INF/views/common/header.jsp" %>
<% 
	List <CsCenterInquire> list = (List<CsCenterInquire>)request.getAttribute("list");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>문의내역확인</h1>
	<table id="tbl-inquire-list">
	<thead>
	<tr>
	<th>문의내용</th>
	<th>답변여부</th>
	<th>등록일</th>
	</tr>
	</thead>
	<tbody>
	<%for(CsCenterInquire c : list) {%>
		<tr>
		<a href="<%=request.getContextPath()%>/csCenter/inquireView?no=<%= c.getNo()%>">
		<%=c.getTitle() %>				
		</a>
		
		</tr>
	<%} %>
	</tbody>
	</table>
</body>
</html>