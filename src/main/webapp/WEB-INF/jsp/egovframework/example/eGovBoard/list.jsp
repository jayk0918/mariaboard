<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판</title>
</head>

<body>
	<div id="wrap">

		<div id="container" class="clearfix">
			<div id="content">
				<h1>게시판</h1>
				<div id="board">
					<div id="list">
						<div class="form-group text-right">
							<select name = 'content'>
								<option value='' selected = 'selected'>선택하세요</option>
								<option value='title'>제목</option>
								<option value='name'>글쓴이</option>
							</select>
							<input type="text" name = "keyword">
							<button type="submit" id=btn_search>검색</button>
						</div>
					
						<table border = '1'>
							<thead>
								<tr>
									<th>번호</th>
									<th>제목</th>
									<th>글쓴이</th>
									<th>조회수</th>
									<th>작성일</th>
									<th>관리</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>1</td>
									<td><a href="${pageContext.request.contextPath}/readContent.do">제목</a></td>
									<td>작성자</td>
									<td>1</td>
									<td>2022.10.27.</td>
									<td id = "deletion">삭제</td>
								</tr>
								
							</tbody>
						</table>
					</div>
					<!-- //list -->
				</div>
				<!-- //board -->
				
				<a id="btn_add" href="${pageContext.request.contextPath}/writeForm.do">등록</a>
				
			</div>
			<!-- //content  -->

		</div>
		<!-- //container  -->

	</div>
	<!-- //wrap -->

</body>

</html>