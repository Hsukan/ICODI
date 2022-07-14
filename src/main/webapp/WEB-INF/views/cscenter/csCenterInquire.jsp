<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file = "/WEB-INF/views/common/header.jsp" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>

	
</style>
</head>
<body>
<form action="<%= request.getContextPath() %>/csCenter/inquireEnroll" method ="POST" name ="inquireFrm">
	<table>
		<tr>
		<th>아이디</th>
		<td><input type="text" name="memberId"/></td>
		</tr>
		<tr>
		<th>제목</th>
		<td><input type="text" required name="title"/></td>
		</tr>
		<tr>
		<th>카테고리</th>
		<td>
		<select name="selectType" id="">
		<option value="A">선택</option>
		<option value="B">상품</option>
		<option value="C">배송</option>
		<option value="D">교환</option>
		<option value="E">환불</option>
		<option value="F">기타</option>
		</select>
		</td>
		</tr>
		<td colspan="2"><textarea class="content" name="content" placeholder="문의내용을 입력해주세요" required></textarea></td>
	</table>
		<div>
		<p>주말 및 공휴일에는 고객센터 답변이 지연 될 수 있습니다.</p>
		<p>고객센터 운영시간 : 월-금: 11AM~6PM.</p>
		</div>
		<div>
		<input type="submit" value="문의하기"/>
		</div>
</form>
</body>
</html>