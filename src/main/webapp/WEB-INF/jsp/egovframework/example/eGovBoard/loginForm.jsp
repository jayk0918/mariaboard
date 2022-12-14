<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
</head>

<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/assets/bootstrap/js/bootstrap.js"></script>

<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/bootstrap/css/bootstrap.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/egovframework/loginForm.css">

<body>
	<h1>Board Project</h1>
	<div id="center-content">
		<div id="loginForm">
			<!-- 유저 3명
				id : guest1, pw : 11
				id : guest2, pw : 22
				id : admin, pw : 123
			 -->
			<form method="post" action="${pageContext.request.contextPath}/login.do">
				<div id = "idInput">
		      		<label for="userId">아이디</label></td>
			      	<input id="userId" type="text" name="userId" placeholder = "아이디를 입력해주세요"></td>
	      		</div>
	      		<div id = "passwordInput">
	      			<label for = "password">패스워드</label>
	      			<input id = "password" type="password" name="password">
      			</div>
	      		<div id="btnArea">
					<button id = "btn-login" class="btn btn-primary" type="submit">로그인</button>
				</div>
			</form>
		</div>
	</div>
</body>

</html>