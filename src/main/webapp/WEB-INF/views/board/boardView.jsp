<%@page import="com.kh.icodi.member.model.dto.MemberRole"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.kh.icodi.board.model.dto.CommentLevel"%>
<%@page import="com.kh.icodi.board.model.dto.BoardComment"%>
<%@page import="java.util.List"%>
<%@page import="com.kh.icodi.board.model.dto.Attachment"%>
<%@page import="com.kh.icodi.board.model.dto.BoardExt"%>
<%@page import="com.kh.icodi.board.model.dto.Board"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%
	BoardExt board = (BoardExt) request.getAttribute("board");
	List<Attachment> attachments = board.getAttachments();
	//System.out.println("board = " + board);
	//System.out.println("img = " + board.getAttachments());
	
	List<BoardComment> commentList = (List<BoardComment>) request.getAttribute("commentList");
	
%>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/board.css" />
<section id="board-container">
	<h2>게시판</h2>
	<table id="tbl-board-view">
		<tr>
			<th>글번호</th>
			<td><%= board.getNo() %></td>
		</tr>
		<tr>
			<th>제 목</th>
			<td><%= board.getTitle() %></td>
		</tr>
		<tr>
			<th>작성자</th>
			<td><%= board.getWriter() %></td>
		</tr>
		<tr>
			<th>조회수</th>
			<td><%= board.getReadCount() %></td>
		</tr>
		<% if(attachments != null && !board.getAttachments().isEmpty()) { %>
			<%  for(Attachment a : board.getAttachments()){ %>
			<tr>
				<th>첨부파일</th>
				<td>
					<%-- 첨부파일이 있을경우만, 이미지와 함께 original파일명 표시 --%>
					<% System.out.println("a = " + a); %>
					<img alt="첨부파일" src="<%=request.getContextPath() %>/images/file.png" width=16px><br>
					<a href="<%= request.getContextPath()%>/board/fileDownload?no=<%= a.getNo() %>"><%= a.getOriginalFilename() %></a><br>
				</td>
			</tr>
			<% } %>	
		<% } %>
		<tr>
			<th>내 용</th>
			<td><%= board.getContent() %></td>
		</tr>
		<% if(loginMember != null && 
				(loginMember.getMemberId().equals(board.getWriter()) 
						|| loginMember.getMemberRole() == MemberRole.A)) { %>
		<tr>
			<!-- 작성자와 관리자만 마지막행 수정/삭제버튼이 보일수 있게 할 것 -->
			<th colspan="2">
				<input type="button" value="수정하기" onclick="updateBoard()">
				<input type="button" value="삭제하기" onclick="deleteBoard()">
			</th>
		</tr>
		<% } %>
	</table>
	<hr style="margin-top:30px;" />    
    
    <!-- 댓글 작성 부분 -->
    <div class="comment-container">
        <div class="comment-editor">
            <form
            name="boardCommentFrm"
            action="<%=request.getContextPath()%>/board/boardCommentEnroll" 
            method="post" >
                <input type="hidden" name="boardNo" value="<%= board.getNo() %>" />
                <input type="hidden" name="writer" value="<%= loginMember != null ? loginMember.getMemberId() : "" %>" />
                <input type="hidden" name="commentLevel" value="1" />
                <input type="hidden" name="commentRef" value="0" />    
                <textarea name="content" cols="60" rows="3"></textarea>
                <button type="submit" id="btn-comment-enroll1">등록</button>
            </form>
        </div>
        <!--table#tbl-comment-->
        
        <table id="tbl-comment">
        	<%
        		if(commentList != null && !commentList.isEmpty()) {
        			SimpleDateFormat sdf = new SimpleDateFormat("yy-MM-dd HH:mm");
        			for(BoardComment bc : commentList) {
        				boolean canDelete = loginMember != null &&
        						(loginMember.getMemberId().equals(bc.getWriter())
        								|| loginMember.getMemberRole() == MemberRole.A);
        	%>
        	<tr class="<%= bc.getCommentLevel() == CommentLevel.COMMENT ? "level1" : "level2" %>">
        		<td>
        			<sub class="comment-writer"><%= bc.getWriter() %></sub>
        			<sub class="comment-date"><%= sdf.format(bc.getRegDate()) %></sub>
        			<div>
        				<%= bc.getContent() %>
        			</div>
        		</td>
        		<td>
        			<% if(bc.getCommentLevel() == CommentLevel.COMMENT) { %>
        			<button class="btn-reply" value="<%= bc.getNo() %>">답글</button>
        			<% } %>
        			
        			<% if(canDelete) { %>
        			<button class="btn-delete" value="<%= bc.getNo() %>">삭제</button>
        			<% } %>
        		</td>
        	</tr>
        	<%
        			}
        		}
        	%>
        </table>
    </div>
    
    
</section>
<form 
	action="<%= request.getContextPath() %>/board/boardCommentDelete"
	method="post" 
	name="boardCommentDelFrm">
	<input type="hidden" name="no" /> <!-- 댓글번호 같이 전송 -->	
</form>
<script>
document.querySelectorAll(".btn-delete").forEach((btn) => {
	btn.addEventListener('click', (e) => {
		if(confirm("해당 댓글을 정말 삭제하시겠습니까?")){
			const {value} = e.target;
			const frm = document.boardCommentDelFrm;
			frm.no.value = value;
			
			frm.submit();
		}
	});
});

document.querySelectorAll(".btn-reply").forEach((btn) => {
	btn.addEventListener('click', (e) => {
		<% if(loginMember == null){%>
			loginAlert(); return;
		<% } %>
		
		const {value} = e.target;
		console.log(value);
		
		const tr = `
		<tr>
			<td colspan="2" style="text-align:left;">
				<form
		        	name="boardCommentFrm"
					action="<%=request.getContextPath()%>/board/boardCommentEnroll" 
					method="post">
		            <input type="hidden" name="boardNo" value="<%= board.getNo() %>" />
		            <input type="hidden" name="writer" value="<%= loginMember != null ? loginMember.getMemberId() : "" %>" />
		            <input type="hidden" name="commentLevel" value="2" />
		            <input type="hidden" name="commentRef" value="\${value}" />    
					<textarea name="content" cols="60" rows="1"></textarea>
		            <button type="submit" class="btn-comment-enroll2">등록</button>
		        </form>
			</td>
		</tr>`;
		
        const target = e.target.parentElement.parentElement; // tr
        target.insertAdjacentHTML('afterend', tr);
		
	}, {once: true}); // 1회용 핸들러옵션
});

document.boardCommentFrm.content.addEventListener('focus', (e) => {
	if(<%= loginMember == null %>)
		loginAlert();
});

/**
 * 부모요소에서 자식 submit 이벤트 핸들링
 */
document.addEventListener('submit', (e) => {
	
	// matches(selector) 선택자 일치여부를 반환
	if(e.target.matches("form[name=boardCommentFrm]")){		
		if(<%= loginMember == null %>){
			loginAlert();
			e.preventDefault();
			return;		
		}
		
		if(!/^(.|\n)+$/.test(e.target.content.value)){
			alert("내용을 작성해주세요.");
			e.preventDefault();
			return;			
		}
	}
	
});

const loginAlert = () => {
	alert("로그인후 이용할 수 있습니다.");
	document.querySelector("#memberId").focus();
};

</script>
<% if(loginMember != null && 
				(loginMember.getMemberId().equals(board.getWriter()) 
						|| loginMember.getMemberRole() == MemberRole.A)) { %>
<form action="<%= request.getContextPath() %>/board/boardDelete" 
name="boardDelFrm"
method="POST">
<input type="hidden" name="no" value="<%= board.getNo() %>" />
</form>
<script>
	const updateBoard = () => {
		location.href = "<%= request.getContextPath() %>/board/boardUpdate?no=<%= board.getNo() %>"
	};
	const deleteBoard = () => {
		if(confirm("정말 게시글을 삭제하시겠습니까?")){
			document.boardDelFrm.submit();
		}
	};
</script>
<% } %>
