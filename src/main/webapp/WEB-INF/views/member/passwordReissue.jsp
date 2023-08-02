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
	<section class="section-shadow login-container">
        <div class="login-div">
            <form action="" method="post">
                <img src="">
                <!-- logo -->
                <h2 class="page-title">비밀번호 재발급</h2>
                <span>사원 번호</span>
                <div class="input-container">
                    <input type="text" name="memberId" class="first-input">
                </div>
                <span>이메일</span>
                <div class="input-container">
                    <input type="email" name="email" class="first-input">
                    <button onclick="">인증 요청</button>
                    <span>5:00</span>
                </div>
                <span>인증 번호</span>
                <div class="input-container">
                    <input type="text" name="checkNumber" class="first-input">
                    <button onclick="">인증</button>
                    <p>* 임시 비밀번호 발급 후, 로그인 해서 비밀번호를 재설정하세요.</p>
                </div>
                <div class="success-btn">
                    <button onclick="fn_loginPage();">Log in</button>
                </div>
            </form>
        </div>
	</section>
</body>
</html>