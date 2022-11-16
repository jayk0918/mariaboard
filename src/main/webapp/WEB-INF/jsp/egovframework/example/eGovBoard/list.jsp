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

<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/assets/bootstrap/js/bootstrap.js"></script>

<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/bootstrap/css/bootstrap.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/egovframework/board.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/egovframework/list.css">


<body>
	<div id="wrap">
		<div id="container" class="clearfix">
			<div id="content">
				<h1>게시판</h1>
				<div id="board">
					<div id = "upperMenu">
						<div id = "userIdentity" class = "clearfix">
							<p>안녕하세요 ${authUser.userName}님  <a href = "${pageContext.request.contextPath}/logout.do">로그아웃</a></p>
						</div>
						<p id = "contentCnt" class = "clearfix">게시물 수 : ${totCnt}</p>
						
						<!------------------ 검색 form -------------------->
						<!-- 제목 / 글쓴이 / 내용 3가지 카테고리로 input의 값 검색 -->
						<form id = "search" name = "search" method = "get" action = "list.do">
							<select id = "searchCategory" name = 'searchCategory'>
								<option value='0'>선택하세요</option>
								<option value='1'>제목</option>
								<option value='2'>글쓴이</option>
								<option value='3'>내용</option>
							</select>
							<input id = "searchKeyword" type= "text" name = "searchKeyword">
							<button type = "submit" class = "btn">검색</button>
						</form>
						
					</div>
					<div id="list">
						<!-- 기존 검색된 파라미터값 저장태그 -->
						<input id = "searchedCategory" name = "searchedCategory" type = "hidden" value = "${searchVO.searchedCategory}">
						<input id = "searchedKeyword" name = "searchedKeyword" type = "hidden" value = "${searchVO.searchedKeyword}">
						
						<!-- 리스트 table -->
						<table class = "table-bordered">
							<thead>
								<tr>
									<th width = "10%">번호</th>
									<th width = "60%">제목</th>
									<th width = "10%">글쓴이</th>
									<th width = "10%">조회수</th>
									<th width = "10%">작성일</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items = "${list}" var = "list" varStatus = "status">
									<tr>
										<td>${paginationInfo.totalRecordCount - ((paginationInfo.currentPageNo-1) * paginationInfo.recordCountPerPage + status.index) }</td>
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
					<a id="btn_add" class = "btn" href="${pageContext.request.contextPath}/writeForm.do">등록</a>
					
					<!-- 초기화 버튼, 기존 검색 파라미터를 초기화하고 최초 리스트 페이지로 회귀 -->
					<div id = "initialization">
						<a class = "btn" href = "${pageContext.request.contextPath}/list.do">초기화</a>
					</div>
				</div>
				<!-- //board -->
				
				<!-- 전자정부프레임워크 페이징 -->
				<div id="paging">
	        		<ui:pagination paginationInfo = "${paginationInfo}" type="image" jsFunction="fn_egov_link_page" />
	        		<form:hidden path="pageIndex" />
	        	</div>
				
			</div>
			<!-- //content  -->
		</div>
		<!-- //container  -->
	</div>
	<!-- //wrap -->
</body>

<script type = "text/javascript">

/*** 검색 값 없을 시 form 처리 방지, 내용 입력 alert ***/
$("#search").on("submit", function(e){
	var keyword = $("#searchKeyword").val();
	if(keyword == ""){
		alert("내용을 입력해주세요");
		e.preventDefault();
	}
});

/*** 페이징 숫자******/
/* resources/egovframework/context-property에서 1개 페이지 출력 게시물 갯수 조정 가능 */
/* 해당 검색값과 페이지 index값 유지를 위해 검색값 파라미터를 계속 넘겨줌(searchedCategory, searchedKeyword의 존재 이유) */   
function fn_egov_link_page(pageNo){
	location.href = "<c:url value='/list.do'/>?pageIndex=" + pageNo + "&searchCategory=" + $("#searchedCategory").val() + "&searchKeyword=" + $("#searchedKeyword").val();
}

</script>

</html>