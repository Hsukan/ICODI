<%@page import="com.kh.icodi.cscenter.model.dto.CsCenter"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file = "/WEB-INF/views/common/header.jsp" %>
<%
	List<CsCenter> list = (List<CsCenter>)request.getAttribute("list");
%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/csCenter.css" />
<meta charset="UTF-8">
<title>Insert title here</title>
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
	<input type="button" value="문의내역 확인" onclick="location.href='<%= request.getContextPath() %>/csCenter/inquireList';">	
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
	<h2>공지사항</h2>
<ul>
	<% if(list == null || list.isEmpty()){ %>
		<li>공지사항이 없습니다.</li>
	<%}else{
		for(CsCenter c : list){%>
		<li><a href="<%=request.getContextPath()%>/csCenter/csCenterView?no=<%=c.getNoticeNo()%>"><%= c.getNoticeTitle() %></a></li>
		<%
		}
	} %>
	
</ul>
	
	<div id="faq">
	<hr />
		<h2>자주 묻는 FAQ</h2>
		<ul>
			<span>배송관련</span>
			<li>배송은 얼마나 걸리나요?</li>
			<li>현재 배송상태를 알고 싶어요</li>
		</ul>
		<ul>
			<span>주문관련</span>
			<li>교환/반품/AS안내</li>
			<li>주문 방법을 알려주세요</li>
	
		</ul>
		<ul>
			<span>계정관련</span>
			<li>아이디/비밀번호를 잊어버렸어요.</li>
			<li>회원 탈퇴하는 방법</li>
		</ul>
		
		<ul>
			<span>적립금 관련</span>
			<li>구매 적립금은 언제 지급되나요?</li>
		</ul>
	</div>	
	</div>
</div>
	
</body>
</html>