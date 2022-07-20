<%@page import="com.kh.icodi.codiBoard.model.dto.LikeThat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/member/memberMyPage.jsp" %>
<%
	int totalPage = (int) request.getAttribute("totalPage");
	String loginMemberId = (String)request.getAttribute("loginMemberId");
	List<LikeThat> likeList = (List<LikeThat>) request.getAttribute("likeThat");
%>
<script src="<%= request.getContextPath()%>/js/jquery-3.6.0.js"></script>
<section id="my-codi-wrapper">
	<h2> 내가 만든 코디 </h2>
	<div id="my-codi-container"></div>
	<hr />
	<div id='btn-more-container'>
		<button id="btn-more" value="" >더보기(<span id="cPage"></span> / <span id="totalPage"><%= totalPage %></span>)</button>
	</div>
</section>
<script>
document.querySelector("#btn-more").addEventListener('click', (e) => {
	const cPage = Number(document.querySelector("#cPage").textContent) + 1
	getPage(cPage);
});

const getPage = (cPage) => {
	$.ajax({
		url : '<%= request.getContextPath() %>/member/memberMyCodiMore',
		data : {cPage},
		success(response) {
			console.log(response);
			const container = document.querySelector("#my-codi-container");
			
			response.forEach((codiList) => {
				console.log(codiList);
				const {codiBoardContent, codiBoardNo, filename, isOpen, likeCount, memberId, regDate, useProduct} = codiList;
				const html = `
					<div class="codi-info-container">
						<img src="data:image/jpeg;base64,\${filename}" id="myCodiImg"/>
						<div clss="liked-wrap">
							받은 좋아요 <span id="likeCount">\${likeCount}</span>
							<span id="Checkheart">
							\${likeCount === 0 ? '♡' : '♥'}
							</span>
						</div>
					</div>
					`;
					container.insertAdjacentHTML('beforeend', html);
				
			});
			
		},
		error : console.log,
		complete() {
			document.querySelector('#cPage').innerHTML = cPage;
			
			if(cPage == <%= totalPage %>){
				document.querySelector("#btn-more").disabled = true;
			}
		}
	})
};
getPage(1);
</script>
</body>
</html>