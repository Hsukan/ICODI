<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.kh.icodi.board.model.dto.BoardExt"%>
<%@page import="com.kh.icodi.board.model.dto.Board"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/member/memberMyPage.jsp" %>
<%
	List<Board> list = (List<Board>) request.getAttribute("list");
	System.out.println("list@boardList = " + list);
%>

<!-- 내 게시글 확인 -->
<section id="my-board-container">
	<h2> 내가 작성한 게시글 </h2>
	<table id="tbl-my-board">
		<tr>
			<th>번호</th>
			<th>제목</th>
			<th>작성자</th>
			<th>작성일</th>
			<th>첨부파일</th>
			<th>조회수</th>
		</tr>
		<%
			if(list != null && !list.isEmpty()){
				for(Board _board : list){
					BoardExt board = (BoardExt) _board;
		%>
		<tr>
			<td><%= board.getNo() %></td>
			<td>
				<a href="<%= request.getContextPath()%>/board/boardView?no=<%= board.getNo() %>">
						<%= board.getTitle() %>
				</a>
				<% if(board.getCommentCount() > 0){ %>
				✉<%= board.getCommentCount() %>
				<% } %>
			</td>
			<td><%= board.getWriter() %></td>
			<td><%= new SimpleDateFormat("yyyy-MM-dd HH:mm").format(board.getRegDate()) %></td>
			<td>
				<% if(board.getAttachCount() > 0){ %>
				<img src="<%= request.getContextPath() %>/images/file.png" alt="" style="width: 16px;" />
				<% } %>
			</td>
			<td><%= board.getReadCount() %></td>
		</tr>
		<%
				}
			} else {
				
		%>
		
		<tr>
			<td colspan="6">조회된 게시글이 없습니다.</td>
		</tr>
		<% } %>
	</table>
	
	<div id='my-codi-bagebar'>
		<%= request.getAttribute("pagebar") %>
	</div>
</section>
</body>
</html>