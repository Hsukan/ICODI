<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/idfind.css" />    
<script src="<%= request.getContextPath()%>/js/jquery-3.6.0.js"></script>
<main>
	<div class="idFind">
        <h1>아이디 찾기</h1>
            <form name="idFindFrm">
                <div class="inputInfo">
                    <input type="text" name="memberName" id="memberName" placeholder="이름" required />
                    <input type="text" oninput="autoHyphen(this)" id="memberPhone" placeholder="전화번호" required maxlength="13"/>
                </div>
                <button class="findIdBtn">아이디찾기</button>
                <div class="resultId">
                </div>
            </form>
    </div>
</main>
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
				const div = document.querySelector(".resultId");
				div.innerHTML = '';
				if(memberId !== null) {		
					div.append(memberId);					
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