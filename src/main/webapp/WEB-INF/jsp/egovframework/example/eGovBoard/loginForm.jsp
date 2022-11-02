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
			<form method="post" action="${pageContext.request.contextPath}/login.do">
	      		<table>
			      	<colgroup>
						<col style="width: 100px;">
						<col style="">
					</colgroup>
		      		<tr>
		      			<td><label for="userId">아이디</label></td>
		      			<td><input id="userId" type="text" name="userId"></td>
		      		</tr>
		      		<tr>
		      			<td><label for = "password">패스워드</label> </td>
		      			<td><input id = "password" type="password" name="password"></td>   
		      		</tr>
		      		<!--
		      		<c:if test = "${param.result == 'fail'}">
			      		<tr>
			      			<td colspan="2" id="tdMsg" colspan="2">
		      					<span>아이디 또는 비밀번호를 확인해 주세요.</span>
			      			</td>
			      		</tr> 
		      		</c:if>
		      		 -->
		      	</table>
	      		<div id="btnArea">
					<button id = "btn-login" class="btn btn-primary" type="submit">로그인</button>
				</div>
			</form>
		</div>
	</div>
	
</body>

</html>