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
	 <section class="login-container first">
        <div class="login-div">
        <form action="" method="post">
            <div class="logo-container">
                <img src="${path }/resources/images/common/workit-logo.svg">
            </div>
            <!-- logo -->
            <h2 class="page-title">초기 이메일 인증 및 비밀번호 변경</h2>
            <span>이메일</span>
            <div class="input-container">
                <input type="email" name="email" class="first-input">
                <button onclick="">인증 요청</button>
                <span>5:00</span>
            </div>
            <span>인증 번호</span>
            <div class="input-container">
                <input type="text" name="check-number" class="first-input">
                <button onclick="">인증</button>
            </div>
            <span>비밀번호</span>
            <div class="input-container">
                <input type="password" name="password" id="pwd" class="first-input">
            </div>
            <span>비밀번호 확인</span>
            <div class="input-container">
                <input type="password" id="pwd-check" class="first-input">
            </div>
            <div class="pwd-msg"></div>
            <p class="info-msg">* 이메일 인증과 비밀번호 변경을 완료하셔야 로그인 가능합니다.</p>
            <div class="success-btn">
                <button onclick="fn_checkInfo();">완료</button>
            </div>
        </form>
    </div>
    </section>
</body>
</html>