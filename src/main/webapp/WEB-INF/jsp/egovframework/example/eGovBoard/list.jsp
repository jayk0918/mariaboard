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
				<p>안녕하세요 ${authUser.userName} 님</p>
				<a href = "${pageContext.request.contextPath}/logout.do">로그아웃</a>
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
								</tr>
							</thead>
							<tbody>
								<c:forEach items = "${list}" var = "list">
									<tr>
										<td>${list.contentNo}</td>
										<td><a href="${pageContext.request.contextPath}/readContent.do?contentNo=${list.contentNo}">${list.title}</a></td>
										<td>${list.userName}</td>
										<td>${list.hit}</td>
										<td>${list.date}</td>
									</tr>
								</c:forEach>
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