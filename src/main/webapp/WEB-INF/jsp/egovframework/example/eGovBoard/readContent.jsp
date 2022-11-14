<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

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
						
						<c:if test = "${content.saveName != null}">
							<div class="imgView" >
								<img class="imgItem" src = "${pageContext.request.contextPath}/upload/${content.saveName}">
							</div>
						</c:if>
						
						<br>
						
						<div id = "replyArea">
							<input id = "reply" type = "text" name = "reply" placeholder = "댓글 입력하기">
							<button id = "replySubmit" type = "submit">댓글 쓰기</button>
						</div>
						
						<div id = "buttons">
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
	fetchList();
});

$("#deletion").on("click",function(){
	console.log("삭제버튼 클릭");
	var contentNo = ${content.contentNo}
	console.log(contentNo);
	
	var selectDel = confirm("삭제하시겠습니까?");
	
	if(selectDel == true){
		$.ajax({
			url : "${pageContext.request.contextPath}/api/delete.do",
			type : "post",
			data : JSON.stringify(contentNo),
			contentType : "application/json",
			dataType : "html", //"text",
			success : function(result){
				alert("삭제 성공");
				window.location.href = "${pageContext.request.contextPath}/list.do";
			},
			error : function(XHR, status, error) {
				console.log(status + ' : ' + error);
			}
		})
	}else{
		alert("취소하였습니다.");
	}
	
});

$("#replySubmit").on("click",function(){
	var contentNo = ${content.contentNo};
	console.log("댓글쓰기");
});

function fetchList(){
	var contentNo = ${content.contentNo};
	
	$.ajax({
		url : "${pageContext.request.contextPath}/api/list.do",
		type : "post",
		contentType : "application/json; charset=utf-8",
		data : JSON.stringify(contentNo),
		dataType : "json",
		success : function(boardVOList){
			console.log(boardVOList);
			
			for(var i=0; i<boardVOList.length; i++){
				render(boardVOList[i], 'down');
			}
		},
		error : function(XHR, status, error) {
			console.log(status + ' : ' + error);
		}
	});
}

function render(boardVO, opt){
	console.log('render()');
	var str = '';
	
	str += '<table id="t'+boardVO.replyNo+'" class="replyRead" border = 1>';
	str += '    <colgroup>' ;
	str += '        <col style="width: 10%;">' ;
	str += '        <col style="width: 40%;">' ;
	str += '        <col style="width: 40%;">' ;
	str += '        <col style="width: 10%;">' ;
	str += '    </colgroup>' ;
	str += '    <tr>' ;
	str += '        <td>'+boardVO.replyNo+'</td>' ;
	str += '        <td>'+boardVO.userName+'</td>' ;
	str += '        <td>'+boardVO.date+'</td>' ;
	str += '        <td><button class = "btnDelete" type = "button" data-no = '+boardVO.replyNo+'>삭제</button></td>' ;
	str += '    </tr>' ;
	str += '    <tr>' ;
	str += '        <td colspan=5 class="text-left">'+boardVO.content+'</td>' ;
	str += '    </tr>' ;
	str += '</table>' ;
	
	if(opt == 'down'){
		$('#replyArea').append(str);
	}else if(opt == 'up'){
		$('#replyArea').prepend(str);
	}else{
		console.log('opt error');
	}
};

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