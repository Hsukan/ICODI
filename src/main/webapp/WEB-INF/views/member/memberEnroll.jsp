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
					<input type="text" placeholder="아이디를 입력해주세요" name="memberId" id="memberId" required />
					<span id="msg1" class="msg">아이디는 영문자/숫자 포함 6자리 이상이여야 합니다.</span>
				</td>
			</tr>
			<tr>
				<th>비밀번호<sup>*</sup></th>
				<td>
					<input type="password" name="password" id="password" placeholder="비밀번호를 입력해주세요" required />
					<span id="msg2" class="msg">비밀번호는 영문/숫자/특수문자 포함 10자리 이상이여야 합니다.</span><br />
				</td>
			</tr>
			<tr>
				<th>비밀번호 확인<sup>*</sup></th>
				<td>
					<input type="password" id="passwordCheck" placeholder="비밀번호를 한 번 더 입력해주세요" required />
					<span id="msg3" class="msg"></span>
				</td>
			</tr>
			<tr>
				<th>이름<sup>*</sup></th>
				<td>
					<input type="text" name="memberName" id="memberName" placeholder="이름을 입력해주세요" required /><br />
					<span id="msg4" class="msg"></span>
				</td>
			</tr>
			<tr>
				<th>이메일<sup>*</sup></th>
				<td>
					<input type="email" name="email" id="email" placeholder="이메일을 입력해주세요" required /><br />
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
					<input type="text" name="phone" maxlength="4" required/>-
					<input type="text" name="phone" maxlength="4" required/>
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
document.memberEnrollFrm.onsubmit = (e) => {
	const memberId = document.querySelector("#memberId");
	if(!/^[a-zA-Z0-9]{6,}$/.test(memberId.value)){
		memberId.select();
		return false;
	}
	
	const password = document.querySelector("#password");
	if(!/^[a-zA-Z0-9!@#$%^&*]{4,}$/.test(password.value)){
		alert("유효한 비밀번호를 입력해 주세요.");
		password.select();
		return false;
	}
	
	const passwordCheck = document.querySelector("#passwordCheck");
	if(password.value != passwordCheck.value) {
		document.querySelector("#msg3").innerHTML = "비밀번호가 일치하지 않습니다.";
		password.select();
		return false;
	}
	
	const memberName = document.querySelector("#memberName");
	if(!/^[가-힣]{2,}$/.test(memberName.value)){
		alert("한글 2글자이상 입력해주세요.");
		memberName.select();
		return false;
	}
	
	//const phone =  = document.querySelectorAll(".phone");
	//if(!/^010[0-9]{8}$/.test(phone.value)){
	//	alert("유효한 전화번호를 입력해주세요.");
	//	phone.select();
	//	return false;
	//}
	
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