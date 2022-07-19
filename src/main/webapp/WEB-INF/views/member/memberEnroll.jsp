<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link rel="stylesheet"
	href="<%=request.getContextPath() %>/css/member.css" />
<section id="enroll-container">
	<h2>JOIN US</h2>
	<div id="form-container">
		<form name="memberEnrollFrm" method="POST">
			<table>
				<tr>
					<th>아이디<sup>*</sup></th>
					<td>
						<input type="text" placeholder="아이디를 입력해주세요" name="memberId" id="memberId" maxlength="10" oninput="checkId()" required />
						<span id="msgMemberId" class="msg">아이디는 영소문자/숫자 포함 6자리 이상이여야 합니다.</span>
					</td>
				</tr>
				<tr>
					<th>비밀번호<sup>*</sup></th>
					<td>
						<input type="password" name="password" id="password" placeholder="비밀번호를 입력해주세요" maxlength="12" required />
						<span id="msgPassword" class="msg">비밀번호는 영문+숫자+특수문자(!@#$%^&*) 포함 8자리 이상이여야 합니다.</span>
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
						<select name="phone" id="phone1">
							<option value="010">010</option>
							<option value="011">011</option>
							<option value="016">016</option>
							<option value="017">017</option>
							<option value="018">018</option>
							<option value="019">019</option>
						</select>-
						<input type="text" name="phone" id="phone2" maxlength="4" required/>-
						<input type="text" name="phone" id="phone3" maxlength="4" required/>
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
			<div id="submit-container">
				<input type="submit" value="JOIN" />
			</div>
		</form>
	</div>
</section>
<script>
/**
 * 폼 유효성 검사
 */
const availableCheck = (input, result, msg) => {
	if (result === "fail") {
	  input.style.color = 'red';
	} else {
		input.style.color = 'blue';
	}
	input.innerHTML = msg;
};



const password = document.querySelector("#password");
const msgPassword = document.querySelector("#msgPassword");
password.addEventListener('input', (e) => {
	if (!/^(?=.*\d{1,})(?=.*[!@#$%^&*]{1,})(?=.*[a-zA-Z]{1,}).{8,12}$/.test(password.value)) {
		availableCheck(msgPassword, "fail", "비밀번호는 영문+숫자+특수문자(!@#$%^&*) 포함 8자리 이상이여야 합니다.");
	} else {
		availableCheck(msgPassword, "clear", "");
	}
});

password.addEventListener('blur', (e) => {
	if (!/^(?=.*\d{1,})(?=.*[!@#$%^&*]{1,})(?=.*[a-zA-Z]{1,}).{8,12}$/.test(password.value)) {
		password.select();
	} else {
		msgPassword.innerHTML = "";
	}
});

const passwordCheck = document.querySelector("#passwordCheck");
passwordCheck.addEventListener('blur', (e) => {
	if (password.value !== passwordCheck.value) {
		availableCheck(msgPassword, "fail", "비밀번호가 일치하지 않습니다.");
		password.select();
		passwordCheck.value ="";
	}
});
 
const memberName = document.querySelector("#memberName");
const msgMemberName = document.querySelector("#msgMemberName");
memberName.addEventListener('input', (e) => {
	if (!/^[가-힣]{2,}$/.test(memberName.value)) {
		availableCheck(msgMemberName, "fail", "한글 2글자 이상 입력해 주세요.");
	} else {
		availableCheck(msgMemberName, "clear", "");
	}
});

memberName.addEventListener('blur', (e) => {
	if (!/^[가-힣]{2,}$/.test(memberName.value)) {
		memberName.select();
	} else {
		msgMemberName.innerHTML = "";
	}
});

const email = document.querySelector("#email");
const msgEmail = document.querySelector("#msgEmail");
email.addEventListener('input', (e) => {
	if (!/^([\w\.-]+)@([\w-]+)(\.[\w-]+){1,2}$/.test(email.value)) {
		availableCheck(msgEmail, "fail", "이메일 형식이 유효하지 않습니다.");
	} else {
		availableCheck(msgEmail, "clear", "");
	}
});

email.addEventListener('blur', (e) => {
	if (!/^([\w\.-]+)@([\w-]+)(\.[\w-]+){1,2}$/.test(email.value)) {
		email.select();
	} else {
		msgEmail.innerHTML = "";
	}
});

const phone2 = document.querySelector("#phone2");
const msgPhone = document.querySelector("#msgPhone");
phone2.addEventListener('input', (e) => {
	if (!/[0-9]{3,4}$/.test(phone2.value)) {
		availableCheck(msgPhone, "fail", "휴대폰 번호를 다시 확인해 주세요.");
	} else {
		availableCheck(msgPhone, "clear", "");
	}
});

phone2.addEventListener('blur', (e) => {
	if (!/[0-9]{3,4}$/.test(phone2.value)) {
		phone2.select();
	} else {
		msgPhone.innerHTML = "";
	}
});

const phone3 = document.querySelector("#phone3");
phone3.addEventListener('input', (e) => {
	if (!/[0-9]{4,}$/.test(phone3.value)) {
		availableCheck(msgPhone, "fail", "휴대폰 번호를 다시 확인해 주세요.");
	} else {
		availableCheck(msgPhone, "clear", "");
	}
});

phone3.addEventListener('blur', (e) => {
	if (!/[0-9]{4,}$/.test(phone3.value)) {
		phone3.select();
	} else {
		msgPhone.innerHTML = "";
	}
});



function checkId(){
	let memberId = $('#memberId').val();
	
	$.ajax({
		url : '<%= request.getContextPath()%>/member/memberCheckId',
		type : "post",
		data : {memberId : memberId},
		dataType : 'json',
		success : function(result){
			if(/^[a-z\d]{6,10}$/.test(memberId) && result != 0) {
				$("#msgMemberId").html('사용가능한 아이디입니다.');
				$("#msgMemberId").css("color", 'blue');
			}
			else if(/^[a-z\d]{6,10}$/.test(memberId) && result == 0){
				$("#msgMemberId").html('사용할 수 없는 아이디입니다.');
				$("#msgMemberId").css("color", 'red');
				document.querySelector("#memberId").addEventListener('blur', (e) => {
					e.target.select();
					return false;
				});
			}
			else if(/!^[a-z\d]{6,10}$/.test(memberId)) {
				$("#msgMemberId").html('아이디는 영소문자/숫자 포함 6자리 이상이여야 합니다.');
				$("#msgMemberId").css("color", 'red');
			}

		},
		error : console.log
		
	})
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