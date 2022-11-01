<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>

<title>수정 양식</title>

</head>

<body>
	<div id="wrap">
		<div id="container" class="clearfix">
			<div id="content">
				<h1>게시글 조회</h1>
				<div id="board">
					<div id="writeForm">
						<form action="edit.do" method="post">
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

</html>