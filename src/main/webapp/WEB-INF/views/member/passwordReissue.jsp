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
			<h2>비밀번호 재발급</h2>
			<div>
				<span>사원 번호</span>
				<input type="text" name="member-id">
			</div>
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
				<button onclick="fn_loginPage();">Log in</button>
			</div>
			<p>* 임시 비밀번호 발급 후, 로그인 해서 비밀번호를 재설정하세요.</p>
		</form>
	</section>
</body>
</html>