<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>    
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/board.css" />
<style>
table#tbl-board-view th, td {border-bottom: 1px solid lightgray;}
table#tbl-board-view {
	width:800px; 
	margin:0 auto; 
}
table#tbl-board-view th {
    padding: 10px 0; 
	text-align:center; 
    width: 100px;
} 
table#tbl-board-view td {
    padding: 5px 0 5px 0; 
	text-align:left;
}
table#tbl-board-view img {width: 16px;}
table#tbl-board-view input[type=file] {margin: 3px 0;}
#button-wrap{
    float: right;
    margin-right: 25px;
} 
</style>
<section id="board-container">
<h2>게시글 작성</h2>
<div style="border: 3px solid gray; margin: 10px auto; width: 800px;"></div>
<form
	name="boardEnrollFrm"
	action="<%=request.getContextPath() %>/board/boardEnroll" 
	method="post" 
	enctype="multipart/form-data"> <!--파일 업로드를 하고싶을때 이거 적혀있는지 확인과 POST방식 확인  -->
	<table id="tbl-board-view">
            <tr>
            <th>작성자</th>
            <td>
                <input type="text" name="writer" value="<%= loginMember.getMemberId() %>"  readonly />
            </td>
        </tr>
        <tr>
            <th>제 목</th>
            <td><input type="text" name="title" required style="width: 600px;"></td>
        </tr>
        <th>첨부파일</th>
        <td>			
            <input type="file" name="upFile1" style="margin-left: 10px;">
            <input type="file" name="upFile2">
        </td>
        <tr>
            <th>내 용</th>
            <td><textarea rows="20" cols="100" name="content" style="resize: none;"></textarea></td>
        </tr>
        <tr>
            <td colspan="2" style="border-bottom: none;">
                <input type="submit" value="등록하기" style="float: right;">
            </td>
        </tr>
    </table>
</form>
</section>
<script>
/**
* boardEnrollFrm 유효성 검사
*/
document.boardEnrollFrm.onsubmit= (e) => {
	const frm = e.target;
	//제목을 작성하지 않은 경우 폼제출할 수 없음.
	if(!/^.+$/.test(frm.title.value)){
		alert("제목을 작성해 주세요")
		frm.title.focus();
		return false;
	}
	
	//내용을 작성하지 않은 경우 폼제출할 수 없음.
	if(!/^(.|\n)+$/.test(frm.content.value)){
		alert("내용을 입력하세요.");
		frm.content.focus();
		return false;
	}

	return true;
}
</script>
