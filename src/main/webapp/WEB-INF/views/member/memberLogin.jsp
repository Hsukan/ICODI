<%@page import="com.kh.icodi.member.model.dto.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>    

<script>

// 로그인 유효성
window.onload = () => {
	
<% if(loginMember == null){ %>
	document.loginFrm.onsubmit = (e) => {
		
		const memberIdVal = document.querySelectcor("#memberId").value;
		const passwordVal = document.querySelectcor("#password").value;
		
		if(!/^.{4.}$/.test(memberId.value)){
			alert("유효한 아이디를 입력해주세요.");
			memberId.select();
			return false;
		}
		if(!/^.{4.}$/.test(password.value)){
			alert("유효한 비밀번호를 입력해주세요.");
			password.select();
			return false;
		}
		
	};
	
};
<% } %>
</script>

<main>
	<div class="login-container">
		<h2>LOGIN</h2>
		<form id="loginFrm" name="loginFrm"
			action="<%= request.getContextPath()%>/member/memberLogin" method="POST">
			<table>
				<tr>
					<td colspan="2"><a href="#">기존회원이신가요?</a></td>
					<td colspan="2"><a href="<%= request.getContextPath()%>/member/memberEnroll">회원가입</a></td>
				</tr>
				<tr>
					<td colspan="4"><input type="text" name="memberId" id="memberId"
						placeholder="아이디" value="<%= saveId != null ? saveId : "" %>"></td>
				</tr>
				<tr>
					<td colspan="4"><input type="password" name="password" id="password"
						placeholder="비밀번호"></td>
					<td></td>
				</tr>
				<tr>
					<td colspan="4"><input type="submit" value="로그인"></td>
				</tr>
				<tr>
					<td colspan="2"><input type="checkbox" name="saveId" id="saveId"
					<%= saveId != null ? "checked" : "" %>/>
						<label for="saveId">아이디저장</label></td>
					<td><a href="<%= request.getContextPath()%>/member/memberIdFind">아이디찾기</a></td>
					<td><a href="<%= request.getContextPath()%>/member/memberPwFind">비밀번호찾기</a></td>
				</tr>
			</table>
		</form>
	</div>
</main>
</body>
</html>