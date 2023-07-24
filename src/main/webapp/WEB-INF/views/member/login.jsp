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
			<p>workIT에 오신 것을 환영합니다 :)</p>
			<div>
				<span>사원 번호</span>
				<input type="text" name="member-id">
			</div>
			<div>
				<span>비밀번호</span>
				<input type="password" name="password">
			</div>
			<div>
				<input type="checkbox" value=""><span>remember me</span>
				<button onclick="fn_login();">Log in</button>
			</div>
			<a href="">forgot your password?</a>
		</form>
	</section>
</body>
</html>