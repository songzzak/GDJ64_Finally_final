<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>                            
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/yoonjin/style_header.css">
<title>Work IT</title>
</head>
<body>
	<section>
		<form action="" method="post">
			<img src="">
			<!-- logo -->
			<h2>초기 이메일 인증 및 비밀번호 변경</h2>
			<div>
				<span>이메일</span>
				<input type="email" name="email">
				<button onclick="">인증 요청</button>
			</div>
			<div>
				<span>인증 번호</span>
				<input type="text" name="check-number">
				<button onclick="">인증</button>
			</div>
			<div>
				<span>비밀번호</span>
				<input type="password" name="password" id="pwd">
			</div>
			<div>
				<span>비밀번호 확인</span>
				<input type="password" id="pwd-check">
			</div>
			<p>* 이메일 인증과 비밀번호 변경을 완료하셔야 로그인 가능합니다.</p>
			<div>
				<button onclick="fn_checkInfo();">완료</button>
			</div>
		</form>
	</section>
</body>
</html>