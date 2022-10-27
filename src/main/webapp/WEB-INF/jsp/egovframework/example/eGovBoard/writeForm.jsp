<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글쓰기 양식</title>
</head>


<body>
	<div id="wrap">
		<div id="container" class="clearfix">
			<div id="content">
				<h1>게시판</h1>
				<div id="board">
					<div id="writeForm">
						<form action="write" method="get">
							<!-- 제목 -->
							<div class="form-group">
								<label class="form-text" for="txt-title">제목</label>
								<input type="text" id="txt-title" name="title" value="" placeholder="제목을 입력해 주세요">
							</div>
						
							<!-- 내용 -->
							<div class="form-group">
								<textarea id="txt-content" name = "content"></textarea>
							</div>
							
							<a id="btn_cancel" href="${pageContext.request.contextPath}/list.do">취소</a>
							<input type = 'hidden' name = 'no' value = "${param.no}">
							<button id="btn_add" type="submit" >등록</button>
							
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