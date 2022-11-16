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
						</div>
					
						<!-- 내용 -->
						<div id="txt-content">
							<span id = "originalContent" class="form-value" >
								${content.content}
							</span>
						</div>
						
						<c:if test = "${content.saveName != null}">
							<div class="imgView" >
								<img class="imgItem" src = "${pageContext.request.contextPath}/upload/${content.saveName}">
							</div>
						</c:if>
						
						<br>
						
						<div id = "replyArea">
							<input id = "reply" type = "text" name = "reply" placeholder = "댓글 입력하기">
							<button id = "replySubmit" class = "btn" type = "submit">댓글 쓰기</button>
							<div id = "replyList">
							</div>
						</div>
						
						<div id = "buttons">
							<a id = "returnList" class = "btn" href="${pageContext.request.contextPath}/list.do" >목록</a>
							
							<c:if test = "${authUser.userNo == content.userNo}">
								<a id = "edit" href = "${pageContext.request.contextPath}/editForm.do?contentNo=${content.contentNo}" class = "btn">수정</a>
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
	var contentNo = ${content.contentNo}
	var selectDel = confirm("삭제하시겠습니까?");
	
	if(selectDel == true){
		$.ajax({
			url : "${pageContext.request.contextPath}/api/delete.do",
			type : "post",
			data : JSON.stringify(contentNo),
			contentType : "application/json",
			dataType : "json",
			success : function(){
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
	var userNo = ${content.userNo};
	var reply = $("#reply").val();
	
	var BoardVO = {
		contentNo : contentNo,
		reply : reply,
		userNo : userNo
	}
	
	if(reply.length == 0){
		alert("내용을 입력해주세요");
	}else{
		$.ajax({
			url : "${pageContext.request.contextPath}/api/replyAdd.do",
			type : "post",
			data : JSON.stringify(BoardVO),
			contentType : "application/json",
			dataType : "json",
			success : function(){
				alert("등록되었습니다.");
				location.reload();
			},
			error : function(XHR, status, error) {
				console.log(status + ' : ' + error);
			}
		});
	}
});

$("#replyArea").on("click", ".btnDelete", function(){
	var $this = $(this);
	var replyNo = $this.data("no");
	var userNo = ${authUser.userNo};
	
	var BoardVO = {
		replyNo : replyNo,
		userNo : userNo
	}
	
	if(userNo == 3){
		var selectDel = confirm("삭제하시겠습니까?");
		if(selectDel == true){
			$.ajax({
				url : "${pageContext.request.contextPath}/api/replyDelete.do",
				type : "post",
				data : JSON.stringify(replyNo),
				contentType : "application/json",
				dataType : "json",
				success : function(){
					alert("삭제되었습니다.");
					location.reload();
				},
				error : function(XHR, status, error) {
					console.log(status + ' : ' + error);
				}
			});
		}else{
			alert("취소하였습니다.");
		}
	}else{
		$.ajax({
			url : "${pageContext.request.contextPath}/api/verifyUser.do",
			type : "post",
			data : JSON.stringify(BoardVO),
			contentType : "application/json",
			dataType : "json",
			success : function(result){
				var selectDel = confirm("삭제하시겠습니까?");
					if(selectDel == true){
						$.ajax({
							url : "${pageContext.request.contextPath}/api/replyDelete.do",
							type : "post",
							data : JSON.stringify(replyNo),
							contentType : "application/json",
							dataType : "json",
							success : function(){
								alert("삭제되었습니다.");
								location.reload();
							},
							error : function(XHR, status, error) {
								console.log(status + ' : ' + error);
							}
						});
					}else{
						alert("취소하였습니다.");
					}
			},
			error : function(XHR, status, error) {
				alert("권한이 없습니다.");
			}
		});
	}

});


function fetchList(){
	var contentNo = ${content.contentNo};
	
	$.ajax({
		url : "${pageContext.request.contextPath}/api/replylist.do",
		type : "post",
		contentType : "application/json",
		data : JSON.stringify(contentNo),
		dataType : "json",
		success : function(boardVOList){
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
	var str = '';
	
	str += '<table id="t'+boardVO.replyNo+'" class="replyRead">';
	str += '    <colgroup>' ;
	str += '        <col style="width: 10%;">' ;
	str += '        <col style="width: 10%;">' ;
	str += '        <col style="width: 40%;">' ;
	str += '        <col style="width: 20%;">' ;
	str += '        <col style="width: 20%;">' ;
	str += '    </colgroup>' ;
	str += '    <tr>' ;
	str += '        <td>'+boardVO.replyNo+'</td>' ;
	str += '        <td>'+boardVO.userName+'</td>' ;
	str += '        <td class="text-left">'+boardVO.reply+'</td>' ;
	str += '        <td>'+boardVO.date+'</td>' ;
	str += '        <td><button class = "btnDelete" type = "button" data-no = '+boardVO.replyNo+'>삭제</button></td>' ;
	str += '    </tr>' ;
	str += '</table>' ;
	
	if(opt == 'down'){
		$('#replyList').append(str);
	}else if(opt == 'up'){
		$('#replyList').prepend(str);
	}else{
		console.log('opt error');
	}
};



</script>

</html>