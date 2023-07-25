<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="${path}/resources/css/common/common.css">
<link rel="stylesheet" href="${path}/resources/css/member/login.css">
<title>Work IT</title>
</head>
<body>
	<section class="login-container section-shadow">
        <div class="login-div">
            <form action="" method="post">
            	<div class="logo-container">
                	<img src="${path }/resources/images/common/workit-logo.svg">
            	</div>
                <!-- logo -->
                <h4>workit에 오신 것을 환영합니다 :)</h4>
                <span>사원 번호</span>
                <div class="input-container">
                    <input type="text" name="member-id" class="login-input">
                </div>
                <span>비밀번호</span>
                <div class="input-container">
                    <input type="password" name="password" class="login-input">
                </div>
                <div class="btn-container">
                    <div><input type="checkbox" value=""><span>remember me</span></div>
                    <button onclick="fn_login();">Log in</button>
                </div>
            </form>
            <a href="">forgot your password?</a>
        </div>
	</section>
</body>
</html>