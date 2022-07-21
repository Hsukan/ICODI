<%@page import="java.util.List"%>
<%@page import="com.kh.icodi.stats.model.dto.Stats"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>   
<%
	List<Stats> list = (List<Stats>)request.getAttribute("list"); 
	Object cnt = request.getAttribute("cnt");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/stats.css" />
<title>Insert title here</title>
</head>
<body>


	<h1>통계</h1>
	<hr />
	<div id="space">
	<div id="stats-container">
	<div id="search-container">
	<h2>방문자 조회</h2>
	<span>언제?</span>
	<div id="search-day">
		<form action="<%=request.getContextPath()%>/stats/finder">
		  <input type='date' id='currentDate' name="when"/>
			<button type="submit">검색</button>
		</form>
	</div>
	
	<%if(list.isEmpty() || list == null){%>
		<span>아무 결과가 없습니다.</span>
	<%}else{ %>
		<table>
		<%for(Stats s : list) {%>
		<tr>
			<td><%=s.getVisitMemberId() %></td>
		</tr>
		<%} %>
	</table>	
	<%} %>
	</div>
	
	<div id="search-codi-cnt">
	<h2>코디 통계</h2>
		<form action="<%=request.getContextPath()%>/stats/finder">
			<input type="date" name="codiWhen"/>
			<button type="submit">검색</button>
		</form>
	
		<%if(cnt == null) {%>
			<span>아무 결과가 없습니다.</span>
		<%} else{%>
		<span><%=cnt %></span>
		<%} %>
	</div>
	</div>
</div>
</body>
</html>