<%@page import="com.kh.icodi.member.model.dto.MemberRole"%>
<%@page import="com.kh.icodi.member.model.dto.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	Member loginMember = (Member) session.getAttribute("loginMember");
	String msg = (String) session.getAttribute("msg");
	if(msg != null) session.removeAttribute("msg");
	
	String saveId = null;
	Cookie[] cookies = request.getCookies();
	if(cookies != null)
		for(Cookie c : cookies){
			String name = c.getName();
			String value = c.getValue();
			System.out.println("[cookie] " + name + " = " + value);
			if("saveId".equals(name)){
				saveId = value;
			}
		}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ICODI</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet"
	href="<%=request.getContextPath() %>/css/style.css" />
<script src="<%= request.getContextPath() %>/js/jquery-3.6.0.js"></script>
<script src="https://code.jquery.com/ui/1.13.1/jquery-ui.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.1/themes/base/jquery-ui.css">
<style>
	.ui-menu-item{width:308px; background-color : #fff;}
	#ui-id-1{height: 0px;  border:1px solid black;}
	.search-btn{width:30px; height: 30px;}
</style>
<script>
window.onload = () => {
	<% if(msg != null) { %>	
		alert("<%= msg %>");
	<% } %>
}
</script>

<% if(loginMember != null) {%>
<script src="<%= request.getContextPath()%>/js/ws.js"></script>
<%} %>
</head>
<body>
	<div id="header">
        <div id="header_of_header_wrapper">
            <div id="header_of_header">
                <div class="btn_wrapper_right">
                    <a class="create btn" href="<%= request.getContextPath() %>/codibook/create">· 코디 만들기</a>
                   <a class="cscenter btn" href="<%=request.getContextPath() %>/cs_center">· 고객센터</a>
                </div>
            </div>
        </div>
        <div id="header_wrapper">
            <a href="<%= request.getContextPath()%>/"><img src="<%=request.getContextPath() %>/images/logo.png" alt="" id="logo" style="width: 200px; height: 100px; position: absolute; left:100px; bottom: -15px;"></a>
            <div class="userMenu">
                <a href="<%= request.getContextPath()%>/member/memberMyCodiList">마이페이지</a>
                <a href="#">마이쇼핑</a>
                <a href="#">카트</a>
                <%if (loginMember == null){ %>
                <a href="<%= request.getContextPath()%>/member/memberLogin">LOGIN</a>
                <% } else {%>
				<a href="#"><%= loginMember.getMemberId() %>님, 환영합니다.</a> 
				<a href="<%= request.getContextPath()%>/member/memberLogout">LOGOUT</a>
				<form action="<%=request.getContextPath()%>/alarm" id="header_alert">
					<input type="hidden" name="alarmMemberId" value="<%=loginMember.getMemberId() %>" />
					<button id="btn-alarm"><i id="notification" class="fa-solid fa-bell"></i></button>
				</form>         
                <% } %>
            </div>
            
            <form class="search_wrapper hide_for_mobile" action="<%=request.getContextPath()%>/product/productFind">
                <input id="productAuto" class="search" type="text" placeholder="검색어를 입력하세요" value=""
                name="searchFrm">
                <button class="search-btn" type="submit">
 			 	<i class="fas fa-search"></i>
				</button>
            </form>
            <script>
            $("#productAuto").autocomplete({
                source(request, response){
              	  console.log(request);
              	  const {term} = request;
              	  if(!/.+/.test(term)) return;
              	  
              	  $.ajax({
              		  url : "<%= request.getContextPath()%>/productNameList",
              		  method: "GET",
              		  data : {term},
              		  success(csv){
              			  console.log(csv);
              			  const arr = csv.split(",").map((classmate) => ({
              				 label : classmate,
              				 value : classmate
              			  }));
              			  console.log(arr);
              			  response(arr);
              			  
              		  },
              		  error(jqxhr, statusText, err){
              			  console.log(jqxhr, statusText, err);
              		  }
              		  
              	  });
                },
                focus(e, select){
              	  return false;
                }
              });
            </script>
        </div>
        <div id="main_menu_container">
            <div id="main_menu">
                <div class="main_menu"><a href="<%= request.getContextPath()%>/codi/newCodiList">ootd</a></div>
                <div class="main_menu"><a href="<%= request.getContextPath() %>/board/boardList">Community</a></div>
                <div class="main_menu"><a href="<%= request.getContextPath() %>/product/tops?categoryNo=1" data-alter="tops">Tops</a></div>
                <div class="main_menu"><a href="<%= request.getContextPath() %>/product/bottoms?categoryNo=2" data-alter="bottoms">Bottoms</a></div>
                <div class="main_menu"><a href="<%= request.getContextPath() %>/product/shoes?categoryNo=3" data-alter="shoes">Shoes</a></div>
                <div class="main_menu"><a href="<%= request.getContextPath() %>/product/acc?categoryNo=4" data-alter="accessories">Accessories</a></div>
                <% if(loginMember != null && loginMember.getMemberRole() == MemberRole.A){ %>
                <div class="main_menu"><a href="<%= request.getContextPath() %>/admin/adminPage" data-alter="admin">Admin</a></div>
                <% } %>
            </div>
        </div>
    </div>