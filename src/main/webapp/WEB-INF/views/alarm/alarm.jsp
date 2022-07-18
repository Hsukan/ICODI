<%@page import="java.util.List"%>
<%@page import="com.kh.icodi.cscenter.model.dto.Alarm"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file = "/WEB-INF/views/common/header.jsp" %>
<%
	List<Alarm> list = (List<Alarm>)request.getAttribute("alarmList");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/csCenter.css" />
</head>
<body>
<h1>알람</h1>
<table id="tbl-alarm">
	<%for(Alarm a : list) {%>
	<tr>
		<td><a href="<%=request.getContextPath()%>/csCenter/inquireList?memberId=<%=a.getMemberId()%>"><%=a.getAlarmMessage() %></a></td>
		<td><%=a.getAlarmDate()%></td>
	</tr>
	<%} %>
</table>
</body>
</html>