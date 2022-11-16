<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>

<title>수정 양식</title>

</head>

<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/assets/bootstrap/js/bootstrap.js"></script>

<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/bootstrap/css/bootstrap.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/egovframework/board.css">

<body>
	<div id="wrap">
		<div id="container" class="clearfix">
			<div id="content">
				<h1>게시글 조회</h1>
				<div id="board">
					<div id="writeForm">
						<form action="edit.do" method="post" enctype = "multipart/form-data">
							<input type = "hidden" name = "contentNo" value = "${content.contentNo}">
							<!-- 제목 -->
							<div class="form-group">
								<label class="form-text" for="txt-title">제목</label>
								<input type="text" id="txt-title" name="title" value="${content.title}">
							</div>
						
							<!-- 내용 -->
							<div class="form-group">
								<textarea id="txt-content" name = "content">${content.content}</textarea>
							</div>
							
							<a id="btn_cancel" href="${pageContext.request.contextPath}/list.do">취소</a>
							<button id="btn_add" type="submit">등록</button>
							
							<c:choose>
								<c:when test = "${content.saveName == null}">
									<input id="file" type="file" name="file">
									
									<!-- 첨부파일 존재여부 구분 태그 -->
									<input id = "editIdentify" name = "editIdentify" type = "hidden" value = "-1">
								</c:when>
								<c:otherwise>
									<button id = "editFile"  type = "button">수정</button>
									<button id = "cancelEdit"  type = "button">취소</button>
									<input id = "file" type = "hidden" name = "file">
									<span id = "orgFile">${content.saveName}</span>
									
									<!-- 첨부파일 존재여부 구분 태그 -->
									<input id = "editIdentify" name = "editIdentify" type = "hidden" value = "0">
								</c:otherwise>
							</c:choose>
							<input type = "hidden" name = "saveName" value = "${content.saveName}">
							<input type = "hidden" name = "filesNo" value = "${content.filesNo}">
						</form>
						<!-- //form -->
					</div>
					<!-- //writeForm -->
				</div>
				<!-- //board -->
			</div>
			<!-- //content  -->
		</div>
		<!-- //container  -->
	</div>
	<!-- //wrap -->
</body>

<script type = "text/javascript">

/*** 수정화면 호출 시 수정 취소 버튼을 숨김 ***/ 
$(document).ready(function(){
	$("#cancelEdit").hide();
});

/*** 수정 버튼을 누르면 input file태그가 보여지고 수정 버튼은 숨김 ***/
/*** 이때, 첨부파일 판별용 코드인 editIdentify의 값을 1로 설정하여 update예정인 파일이 있음을 의사표시 ***/
$("#editFile").on("click", function(){
	$("#file").prop("type","file");
	$("#editFile").hide();
	$("#orgFile").hide();
	$("#cancelEdit").show();
	$("#editIdentify").val(1);
});

/*** 수정 취소 버튼을 누를 경우 기존의 파일명이 다시 보이고 input file태그를 hidden 처리 ***/
/*** 수정 버튼을 눌렀을 당시 1로 변경된 editIdentify의 값을 0으로 회귀시켜 수정할 첨부파일이 없음을 의사표시 ***/
$("#cancelEdit").on("click",function(){
	$("#file").prop("type","hidden");
	$("#editFile").show();
	$("#orgFile").show();
	$("#cancelEdit").hide();
	$("#editIdentify").val(0);
});


</script>

</html>