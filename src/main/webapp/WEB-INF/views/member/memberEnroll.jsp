<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<section id="enroll-container">
	<h2>JOIN US</h2>
	<form name="memberEnrollFrm" method="POST">
		<table>
			<tr>
				<th>아이디<sup>*</sup></th>
				<td>
					<input type="text" placeholder="아이디를 입력해주세요" name="memberId" id="memberId" maxlength="10" required />
					<span id="msgMemberId" class="msg">아이디는 영소문자/숫자 포함 6자리 이상이여야 합니다.</span>
				</td>
			</tr>
			<tr>
				<th>비밀번호<sup>*</sup></th>
				<td>
					<input type="password" name="password" id="password" placeholder="비밀번호를 입력해주세요" maxlength="12" required />
					<span id="msgPassword" class="msg">비밀번호는 영문/숫자/특수문자 하나를 반드시 포함해 8자리 이상이여야 합니다.</span>
				</td>
			</tr>
			<tr>
				<th>비밀번호 확인<sup>*</sup></th>
				<td>
					<input type="password" id="passwordCheck" placeholder="비밀번호를 한 번 더 입력해주세요" maxlength="12" required />
					<span id="msgPasswordCheck" class="msg"></span>
				</td>
			</tr>
			<tr>
				<th>이름<sup>*</sup></th>
				<td>
					<input type="text" name="memberName" id="memberName" placeholder="이름을 입력해주세요" maxlength="20" required />
					<span id="msgMemberName" class="msg"></span>
				</td>
			</tr>
			<tr>
				<th>이메일<sup>*</sup></th>
				<td>
					<input type="email" name="email" id="email" placeholder="이메일을 입력해주세요" required />
					<span id="msgEmail" class="msg"></span>
				</td>
			</tr>
			<tr>
				<th>휴대폰<sup>*</sup></th>
				<td>
					<select name="phone">
						<option value="010">010</option>
						<option value="011">011</option>
						<option value="016">016</option>
						<option value="017">017</option>
						<option value="018">018</option>
						<option value="019">019</option>
					</select>-
					<input type="text" name="phone" id="phone1" maxlength="4" required/>-
					<input type="text" name="phone" id="phone2" maxlength="4" required/>
					<span id="msgPhone" class="msg"></span>
				</td>
			</tr>
			<tr>
				<th>주소<sup>*</sup></th>
				<td>
					<input type="text" id="address" name="address" required/>
					<input type="button" id="researchButton" value="주소 찾기🔎"/>
				</td>
			</tr>
			<tr>
				<th></th>
				<td>
					<input type="text" id="addressEx" name="addressEx" required/>
					<span id="msgAddress" class="msg"></span>
				</td>
			</tr>
		</table>
		<input type="submit" value="JOIN" />
	</form>
</section>
<script>
/**
 * 폼 유효성 검사
 */
const memberId = document.querySelector("#memberId");
memberId.addEventListener('blur', (e) => {
	if(!/^[a-z\d]{6,10}$/.test(memberId.value)){
		msgMemberId.innerHTML = '아이디는 영소문자/숫자 포함 6자리 이상이여야 합니다.';
		msgMemberId.style.color = 'red';
		memberId.select();
		return false;
	}
	else {
		msgMemberId.innerHTML = '';
		msgMemberId.style.color = '';
	}
	
});
const password = document.querySelector("#password");
password.addEventListener('blur', (e) => {
	if(!/^(?=.*\d{1,})(?=.*[!@#$%^&*]{1,})(?=.*[a-zA-Z]{1,}).{8,12}$/.test(password.value)){
		msgPassword.innerHTML = '비밀번호는 영문+숫자+특수문자(!@#$%^&*) 포함 8자리 이상이여야 합니다.';
		msgPassword.style.color = 'red';
		password.select();
		return false;
	}
	else {
		msgPassword.innerHTML = '';
		msgPassword.style.color = '';
	}
	
});
const passwordCheck = document.querySelector("#passwordCheck");
passwordCheck.addEventListener('blur', (e) => {
	if(password.value !== passwordCheck.value) {
		msgPassword.innerHTML = '비밀번호가 일치하지 않습니다.';
		msgPassword.style.color = 'red';
		passwordCheck.value = "";
		password.select();
		return false;
	}
	else {
		msgPassword.innerHTML = '';
		msgPassword.style.color = '';
	}
});

const memberName = document.querySelector("#memberName");
memberName.addEventListener('blur', (e) => {
	if(!/^[가-힣]{2,}$/.test(memberName.value)){
		msgMemberName.innerHTML = '한글 2글자 이상 입력해 주세요.';
		msgMemberName.style.color = 'red';
		memberName.select();
		return false;
	}
	else {
		msgMemberName.innerHTML = '';
		msgMemberName.style.color = '';
	}
});

const email = document.querySelector("#email");
email.addEventListener('blur', (e) => {
	if(!/^([\w\.-]+)@([\w-]+)(\.[\w-]+){1,2}$/.test(email.value)) {
		msgEmail.innerHTML = '이메일 형식이 유효하지 않습니다.';
		msgEmail.style.color = 'red';
		email.select();
		return false;
	}
	else {
		msgEmail.innerHTML = '';
		msgEmail.style.color = '';
	}
});

const phone1 = document.querySelector("#phone1");
phone1.addEventListener('blur', (e) => {
	if(!/[0-9]{3,4}/.test(phone1.value)) {
		msgPhone.innerHTML = '휴대폰 번호를 다시 확인해 주세요.';
		msgPhone.style.color = 'red';
		phone1.select();
		return false;
	}
	else {
		msgPhone.innerHTML = '';
		msgPhone.style.color = '';
	}
});

const phone2 = document.querySelector("#phone2");
phone2.addEventListener('blur', (e) => {
	if(!/[0-9]{4,}/.test(phone2.value)) {
		msgPhone.innerHTML = '휴대폰 번호를 다시 확인해 주세요.';
		msgPhone.style.color = 'red';
		phone2.select();
		return false;
	}
	else {
		msgPhone.innerHTML = '';
		msgPhone.style.color = '';
	}

});

document.memberEnrollFrm.onsubmit = (e) => {
	if(!memberId.value || !password.value || !passwordCheck.value || !memberName.value || 
			!email.value || !phone1.value || !phone2.value || !address.value || !addressEx.value) {
		return false;
	}
};


</script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
document.querySelector("#address").addEventListener('click', function(){
    new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분입니다.
            document.querySelector("#address").value = data.address;
			document.querySelector("#addressEx").focus();
        }
    }).open();
});	
document.querySelector("#researchButton").addEventListener('click', function(){
    new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분입니다.
            document.querySelector("#address").value = data.address;
			document.querySelector("#addressEx").focus();
        }
    }).open();
});
</script>