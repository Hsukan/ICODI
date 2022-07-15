<%@page import="com.kh.icodi.cscenter.model.dto.CsCenterInquireAnswer"%>
<%@page import="java.util.List"%>
<%@page import="com.kh.icodi.member.model.dto.MemberRole"%>
<%@page import="com.kh.icodi.cscenter.model.dto.CsCenterInquire"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file = "/WEB-INF/views/common/header.jsp" %>
<% 
	CsCenterInquire csCenterInquire = (CsCenterInquire)request.getAttribute("csCenterInquire");
	List<CsCenterInquireAnswer> answerList = (List<CsCenterInquireAnswer>)request.getAttribute("answerList");
%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/csCenter.css" />
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>SUPPORT CENTER</h1>
	<hr />
	<h2>문의내용확인</h2>
	<table>
		<tr>
			<td>등록일</td>
			<td><%=csCenterInquire.getInquireDate() %></td>
		</tr>
		<tr>
			<td>답변여부</td>
			<td>
			<% if(answerList.isEmpty()){ %>
				X
			<%} else{%>
				O
			<%} %>
			</td>
		</tr>
		<tr>
			<td>문의내용</td>
			<td><%= csCenterInquire.getContent() %></td>
		</tr>
		<tr>
			<td>답변내용</td>
			<td></td>
		</tr>		
	</table>
	
	
	
	<%if(loginMember != null && loginMember.getMemberRole() == MemberRole.A){ %>
		<form name="inquireAnswerFrm" action="<%=request.getContextPath()%>/inquireAnswerEnroll" method="POST">
			<input type="hidden" name="inquireNo" value="<%=csCenterInquire.getNo()%>"/>
			<input type="hidden" name="answerNo" value=""/>
			<input type="hidden" name="answerWriter" value="<%=loginMember != null && loginMember.getMemberRole() == MemberRole.A ? loginMember.getMemberId() : ""%>"/>
			<textarea name="answerContent" id="" cols="60" rows="3"></textarea>
			<button id="btn-answer-enroll">등록</button>
		</form>
	<%} %>
	<table id="tbl-answer">
	<%
		if(answerList == null || answerList.isEmpty()){
	%>
		<span>답변없음</span>
			
	<%} 
		else{
			for(CsCenterInquireAnswer as : answerList){
		%>
	<tr>
		<td><%=as.getAnswerContent() %></td>
		<td><%=as.getAnswerWriter() %></td>
		<td><%=as.getAnswerDate() %></td>
		<td>
		<%if(loginMember != null && loginMember.getMemberRole() == MemberRole.A){ %>
		<form id="inquireDelFrm" action="<%=request.getContextPath()%>/inquireAnswerDelete" method="POST">
			<input type="hidden" name="inquireNo" value="<%=as.getInquireNo() %>" />
			<input type="hidden" name="answerNo" value=<%=as.getAnswerNo() %> />
			<input type="submit" value="삭제" onclick="location.href='<%=request.getContextPath()%>/inquireAnswerDelete'"/>
		</form>
		<%} %>		
		</td>
	</tr>
	<% 	}
	}%>
	</table>
	<ul>
		<li>★주말 및 공휴일에는 고객센터 답변이 지연 될 수 있습니다.</li>
		<li>★고객센터 운영시간: 월~금: 11AM~6PM(토/일/공휴일 휴무)</li>
	</ul>
	
</body>
</html>