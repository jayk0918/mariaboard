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
									<input id = "editIdentify" name = "editIdentify" type = "hidden" value = "-1">
								</c:when>
								<c:otherwise>
									<button id = "editFile"  type = "button">수정</button>
									<button id = "cancelEdit"  type = "button">취소</button>
									<input id = "file" type = "hidden" name = "file">
									<span id = "orgFile">${content.saveName}</span>
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
$(document).ready(function(){
	$("#cancelEdit").hide();
});

$("#editFile").on("click", function(){
	$("#file").prop("type","file");
	$("#editFile").hide();
	$("#orgFile").hide();
	$("#cancelEdit").show();
	$("#editIdentify").val(1);
});

$("#cancelEdit").on("click",function(){
	$("#file").prop("type","hidden");
	$("#editFile").show();
	$("#orgFile").show();
	$("#cancelEdit").hide();
	$("#editIdentify").val(0);
});


</script>

</html>