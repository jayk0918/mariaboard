<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://egovframework.gov/ctl/ui" prefix="ui" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<title>게시판</title>
</head>

<body>
	<div id="wrap">
		<div id="container" class="clearfix">
			<div id="content">
				<h1>게시판</h1>
				<p>안녕하세요 ${authUser.userName}님</p>
				<a href = "${pageContext.request.contextPath}/logout.do">로그아웃</a>
				<div id="board">
					<div id="list">
						<form id = "search" name = "search" method = "get" action = "list.do">
							<select id = "searchCategory" name = 'searchCategory'>
								<option value='0'>선택하세요</option>
								<option value='1'>제목</option>
								<option value='2'>글쓴이</option>
								<option value='3'>내용</option>
							</select>
							<input id = "searchKeyword" type= "text" name = "searchKeyword">
							<button type = "submit">검색</button>
						</form>
						
						<input id = "searchedCategory" name = "searchedCategory" type = "hidden" value = "${searchVO.searchedCategory}">
						<input id = "searchedKeyword" name = "searchedKeyword" type = "hidden" value = "${searchVO.searchedKeyword}">

						<p>게시물 수 : ${totCnt}</p>
						
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
				
				<div id="paging">
	        		<ui:pagination paginationInfo = "${paginationInfo}" type="image" jsFunction="fn_egov_link_page" />
	        		<form:hidden path="pageIndex" />
	        	</div>
				
				<a id="btn_add" href="${pageContext.request.contextPath}/writeForm.do">등록</a>
				
			</div>
			<!-- //content  -->
		</div>
		<!-- //container  -->
	</div>
	<!-- //wrap -->
</body>

<script type = "text/javascript">

function fn_egov_link_page(pageNo){
	location.href = "<c:url value='/list.do'/>?pageIndex=" + pageNo + "&searchCategory=" + $("#searchedCategory").val() + "&searchKeyword=" + $("#searchedKeyword").val();
	// "?searchCategory=" + $("#searchCategory").val() + "?searchKeyword=" + $("#searchKeyword").val();
}
</script>

</html>