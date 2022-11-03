<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>

<title>글 읽기</title>

</head>

<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/assets/bootstrap/js/bootstrap.js"></script>

<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/bootstrap/css/bootstrap.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/egovframework/board.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/egovframework/readContent.css">

<body>
	<div id="wrap">
		<div id="container" class="clearfix">
			<div id="content">
				<h1>게시글 조회</h1>
				<div id="board">
					<div id="read">
						<!-- 작성자 -->
						<!--  <input id = "contentNo" type = "hidden" value = "${content.contentNo}">-->
						<div class="form-group">
							<span class="form-text">작성자</span>
							<span class="form-value">${content.userName}</span>
						</div>
						
						<!-- 조회수 -->
						<div class="form-group">
							<span class="form-text">조회수</span>
							<span class="form-value">${content.hit}</span>
						</div>
						
						<!-- 작성일 -->
						<div class="form-group">
							<span class="form-text">작성일</span>
							<span class="form-value">${content.date}</span>
						</div>
						
						<!-- 제목 -->
						<div class="form-group">
							<span class="form-text">제 목</span>
							<span id = "originalTitle" class="form-value">${content.title}</span>
							<!-- <input type = "hidden" id = "editTitle">-->
						</div>
					
						<!-- 내용 -->
						<div id="txt-content">
							<span id = "originalContent" class="form-value" >
								${content.content}
							</span>
							<!--<input type = "hidden" id = "editContent">-->
						</div>
						
						<a id = "returnList" class = "btn" href="${pageContext.request.contextPath}/list.do" >목록</a>
						
						<c:if test = "${authUser.userNo == content.userNo}">
							<a id = "edit" href = "${pageContext.request.contextPath}/editForm.do?contentNo=${content.contentNo}" class = "btn">수정</a>
							<!-- 
							<button id = "edit" type = "button">수정</button>
							<button id = "editConfirm" type = "button">확인</button>
							<button id = "editCancel" type = "button"> 취소</button>
							-->
						</c:if>
						
						<c:if test="${authUser.userNo == 3 || authUser.userNo == content.userNo}">
							<button id = "deletion" class = "btn">삭제</td>
						</c:if>
						
					</div>
					<!-- //read -->
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
/*
$(document).ready(function(){
	$("#editConfirm").css('display', 'none');
	$("#editCancel").css('display', 'none');
});
*/
$("#deletion").on("click",function(){
	console.log("삭제버튼 클릭");
	var contentNo = ${content.contentNo};
	console.log(contentNo);
	
	$.ajax({
			url : "${pageContext.request.contextPath}/delete.do",
			type : "post",
			data : JSON.stringify(contentNo),
			contentType : "application/json",
			dataType : "text",
			success : function(result){
				alert("삭제 성공");
				window.location.href = "${pageContext.request.contextPath}/list.do";
			},
			error : function(XHR, status, error) {
				console.log(status + ' : ' + error);
			}
		});
	
});

/*
$("#edit").on("click",function(){
	
	var contentNo = ${content.contentNo};
	
	$("#originalTitle").hide();
	$("#originalContent").hide();
	$("#edit").hide();
	$("#deletion").hide();
	$("#editTitle").attr('type', 'text');
	$("#editContent").attr('type', 'text');
	$("#editConfirm").css('display', 'block');
	$("#editCancel").css('display', 'block');
	
});


$("#editConfirm").on("click", function(){
	var title = $("#editTitle").val();
	var content = $("#editContent").val();
	var contentNo = $("#contentNo").val();
	
	var BoardVO ={
			"title" : title,
			"content" : content,
			"contentNo" : contentNo
		};
	
	console.log(title);
	console.log(content);
	console.log(contentNo);
	console.log(BoardVO);
	
	$.ajax({
		url : "${pageContext.request.contextPath}/edit.do",
		type : "post",
		data : JSON.parse(BoardVO),
		contentType : "application/json",
		dataType : "json",
		success : function(result){
			alert("수정 성공");
			window.location.href = "${pageContext.request.contextPath}/list.do";
		},
		error : function(XHR, status, error) {
			console.log(status + ' : ' + error);
		}
	});
	
});

$("#editCancel").on("click", function(){
	$("#editConfirm").css('display', 'none');
	$("#editCancel").css('display', 'none');
	$("#editTitle").attr('type', 'hidden');
	$("#editContent").attr('type', 'hidden');
	$("#originalTitle").show();
	$("#originalContent").show();
	$("#edit").show();
	$("#deletion").show();
});
*/
</script>

</html>