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
					<td><input type="text" oninput="autoHyphen(this)" id="memberPhone" required maxlength="13"/></td>
				</tr>
				<tr id="tbl-idFindTr"></tr>
			</thead>
 		</table>
 		<button id="findIdBtn">아이디찾기</button>
	</form>
<script>
	const autoHyphen = (target) => {
		target.value = target.value.replace(/[^0-9]/g, '')
		   .replace(/^(\d{2,3})(\d{3,4})(\d{4})$/, `$1-$2-$3`);
	}

	document.idFindFrm.addEventListener('submit', (e) => {
		e.preventDefault();
		
		const memberName = document.querySelector("#memberName");
		if(!/^[가-힣]{2,}$/.test(memberName.value)){
			alert("한글 2글자이상 입력해주세요");
			memberName.select();
			return false;
		}
	
		const phone = document.querySelector("#memberPhone");
		if(!/^010-[0-9]{4}-[0-9]{4}$/.test(phone.value)){
			alert("유효한 전화번호를 입력해주세요");
			phone.select();
			return false;
		}
		
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