<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>

<title>글 읽기</title>

</head>

<body>
	<div id="wrap">
		<div id="container" class="clearfix">
			<div id="content">
				<h1>게시글 조회</h1>
				<div id="board">
					<div id="read">
						<!-- 작성자 -->
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
							<input type = "hidden" id = "editTitle">
						</div>
					
						<!-- 내용 -->
						<div id="txt-content">
							<span id = "originalContent" class="form-value" >
								${content.content}
							</span>
							<input type = "hidden" id = "editContent">
						</div>
						
						<a id="btn_list" href="${pageContext.request.contextPath}/list.do">목록</a>
						
						<c:if test="${authUser.userNo == 3 || authUser.userNo == content.userNo}">
							<button id = "deletion">삭제</td>
							<c:if test = "${authUser.userNo == content.userNo}">
								<button id = "edit" type = "button">수정</button>
								<button id = "editConfirm" type = "button">확인</button>
								<button id = "editCancel" type = "button"> 취소</button>
							</c:if>
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

$(document).ready(function(){
	$("#editConfirm").css('display', 'none');
	$("#editCancel").css('display', 'none');
});

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
	var contentNo = ${content.contentNo};
	
	console.log(title);
	console.log(content);
	console.log(contentNo);
	
	var BoardVO ={
		title : title,
		content : content,
		contentNo : contentNo
	}
	
	$.ajax({
		url : "${pageContext.request.contextPath}/edit.do",
		type : "post",
		data : JSON.stringify(BoardVO),
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


</script>

</html>