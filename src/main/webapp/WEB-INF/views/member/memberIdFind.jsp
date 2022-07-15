<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<script src="<%= request.getContextPath()%>/js/jquery-3.6.0.js"></script>
<body>
	<h2>아이디 찾기</h2>
	<form name="idFindFrm">
		<table id="tbl-idFind">
			<thead>
				<tr>
					<th>이름</th>
					<td><input type="text" name="memberName" id="memberName" required /></td>
				</tr>
				<tr>
					<th>전화번호</th>
					<td><input type="text" name="memberPhone" required/></td>
				</tr>
				<tr id="tbl-idFindTr"></tr>
			</thead>
 		</table>
 		<button id="findIdBtn">아이디찾기</button>
	</form>
<script>
	document.idFindFrm.addEventListener('submit', (e) => {
		e.preventDefault();
		$.ajax({
			url : '<%= request.getContextPath()%>/member/memberIdFind',
			method : "POST",
			dataType : 'json',
			data : {
				memberName : e.target.memberName.value,
				memberPhone : e.target.memberPhone.value
			},
			success(memberId) {
				const tr = document.querySelector("#tbl-idFindTr");
				tr.innerHTML = '';
				if(memberId !== null) {		
					tr.append(memberId);					
				} else {
					alert("존재하지 않는 회원입니다.");
				}
				
			}, 
			error : console.log
					
		});
	});
</script>
</body>
</html>