<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<script src="<%= request.getContextPath()%>/js/jquery-3.6.0.js"></script>
<body>
	<h2>비밀번호 찾기</h2>
	<form name="pwFindFrm">
		<table id="tbl-pwFind">
			<thead>
				<tr>
					<th>아이디</th>
					<td><input type="text" name="memberId" id="memberId" required/></td>
				</tr>
				<tr>
					<th>전화번호</th>
					<td><input type="text" name="memberPhone" required /></td>
				</tr>
				<tr id="tbl-pwFindTr"></tr>
			</thead>
		</table>
		<button id="findPwBtn">임시번호 발급</button>
		<div id="newPw"></div>
	</form>
<script>	
		
	
	
	document.pwFindFrm.addEventListener('submit', (e) => {
		e.preventDefault();
		let ranValue1 = ['1','2','3','4','5','6','7','8','9','0'];
		let ranValue2 = ['A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'];
		let ranValue3 = ['a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z'];
		let ranValue4 = ['!','@','#','$','%','^','&','*','(',')'];
		let newPwd = "";
		
		for(i=0 ; i<2; i++) {
			let ranPick1 = Math.floor(Math.random() * ranValue1.length);
			let ranPick2 = Math.floor(Math.random() * ranValue2.length);
			let ranPick3 = Math.floor(Math.random() * ranValue3.length);
			let ranPick4 = Math.floor(Math.random() * ranValue4.length);
			newPwd = newPwd + ranValue1[ranPick1] + ranValue2[ranPick2] + ranValue3[ranPick3] + ranValue4[ranPick4];
		}
			
	
		$.ajax({
			url : '<%= request.getContextPath()%>/member/memberPwFind',
			method : "POST",
			dataType : 'json',
			data : {
				memberId : e.target.memberId.value,
				memberPhone : e.target.memberPhone.value,
				newPwd : newPwd
			},
			success(memberPw) {
				console.log("memberPw", memberPw);
				if(memberPw !== null){
					
					
					$("#newPw").text(newPwd);
				}
				else{
					alert("잘못입력하셨습니다");
				}
			
			}, 
			error : console.log
				
		});
	}, {once:true});
	
</script>
</body>
</html>