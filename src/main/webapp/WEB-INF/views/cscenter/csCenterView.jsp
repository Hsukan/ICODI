<%@page import="com.kh.icodi.cscenter.model.dto.CsCenter"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file = "/WEB-INF/views/common/header.jsp" %>
<%
	CsCenter csCenter =  (CsCenter)request.getAttribute("csCenter");
%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/csCenter.css" />

<meta charset="UTF-8">
<title></title>
</head>
<body>
<div id="titleContainer">
		<h1>SUPPORT CENTER</h1>
	</div>
<hr />
<div id="csCenter">
	<div id="csCenterLeft">
	<div id="buttonContainer">
	<input type="button" value="1:1 문의하기" onclick="location.href='<%= request.getContextPath() %>/csCenter/inquireEnroll';">
	<form name="inquireListFrm" action="<%= request.getContextPath() %>/csCenter/inquireList">
		<input type="hidden" name="memberId" value="<%= loginMember != null ? loginMember.getMemberId() : ""%>" />
		<button type="submit" id="btn-inquireList" onclick="location.href='<%=request.getContextPath()%>/csCenter/inquireList'">문의내역확인</button>
	</form>
	</div>
	<div id="csInfo">
	<span>고객센터 전화번호</span>
	<h3>1111-2222</h3>
	<span>MON-FRI 11AM ~ 6PM</span>
	<span>LUNCH 12:30PM ~ 1:30PM</span>
	<span>DAY OFF 토/일/공휴일</span>
	</div>
	</div>
	<div id="csCenterRight">
	<div id="alert"><span>고객센터 안내 : 구매하신 상품 및 I COD I 이용에 편의를 돕기 위해 전용 고객센터를 운영하고 있으니, 아래 내용 확인 부탁드립니다.</span></div>
	<h1>[<%=csCenter.getNoticeTitle() %>]</h1>
	<span><%=csCenter.getNoticeContent()%></span>
	</div>
	
</body>
</html>