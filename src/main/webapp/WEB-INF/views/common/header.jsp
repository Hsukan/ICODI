<%@page import="com.kh.icodi.member.model.dto.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	Member loginMember = (Member) session.getAttribute("loginMember");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ICODI</title>
<link rel="stylesheet"
	href="<%=request.getContextPath() %>/css/style.css" />
<script src="<%= request.getContextPath() %>/js/jquery-3.6.0.js"></script>
</head>
<body>
	<div id="header">
        <div id="header_of_header_wrapper">
            <div id="header_of_header">
                <div class="btn_wrapper_right">
                    <a class="create btn" href="<%= request.getContextPath() %>/codibook/create">· 코디 만들기</a>
                    <a class="cscenter btn" href="/cs_center">· 고객센터</a>
                </div>
            </div>
        </div>
        <div id="header_wrapper">
            <img src="<%=request.getContextPath() %>/images/logo.png" alt="" id="logo" style="width: 200px; height: 100px; position: absolute; left:100px; bottom: -15px;">
            <div class="userMenu">
                <a href="#">마이페이지</a>
                <a href="#">마이쇼핑</a>
                <a href="#">카트</a>
                <%if (loginMember == null){ %>
                <a href="<%= request.getContextPath()%>/member/memberLogin">LOGIN</a>
                <% } else {%>
				<a href="#"><%= loginMember.getMemberId() %>님, 환영합니다.</a> 
				<a href="<%= request.getContextPath()%>/member/memberLogout">LOGOUT</a>         
                <% } %>
            </div>
            <form class="search_wrapper hide_for_mobile" action="/search/">
                <input class="search" type="text" placeholder="검색어를 입력하세요" value="">
            </form>
        </div>
        <div id="main_menu_container">
            <div id="main_menu">
                <div class="main_menu"><a href="#">ootd</a></div>
                <div class="main_menu"><a href="<%= request.getContextPath() %>/board/boardList">Community</a></div>
                <div class="main_menu"><a href="#" data-alter="tops">Tops</a></div>
                <div class="main_menu"><a href="#" data-alter="bottoms">Bottoms</a></div>
                <div class="main_menu"><a href="#" data-alter="shoes">Shoes</a></div>
                <div class="main_menu"><a href="#" data-alter="accessories">Accessories</a></div>
                <div class="main_menu"><a href="<%= request.getContextPath() %>/admin/adminPage" data-alter="admin">Admin</a></div>
            </div>
        </div>
    </div>
</body>
</html>

