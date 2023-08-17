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
<!-- jQuery library -->
<script src="${path}/resources/js/jquery-3.7.0.min.js"></script>
<title>Work IT</title>
</head>
<body>
	<section class="login-container">
        <div class="login-div">
            <form action="${path }/login" method="post" id="login-form">
            	<div class="logo-container" onclick="fn_loginPage();">
                	<img src="${path }/resources/images/common/workit.svg">
            	</div>
                <!-- logo -->
                <h4>workit에 오신 것을 환영합니다 :)</h4>
                <span>사원 번호</span>
                <div class="input-container">
                    <input type="text" name="memberId" class="login-input" id="id">
                </div>
                <span>비밀번호</span>
                <div class="input-container">
                    <input type="password" name="password" class="login-input" id="member-pwd">
                </div>
            </form>
			<div class="btn-container">
				<div>
					<input type="checkbox" value="Y"><span>remember me</span>
				</div>
				<button onclick="fn_login();">Log in</button>
			</div>
			<a href="${path }/login/password">forgot your password?</a>
        </div>
	</section>
<script>
	const fn_login=()=>{
		console.log($("#id").val());
		if($("#id").val()!=""&&$("#member-pwd").val()!=""){
			$("#login-form").submit();
		}
	}

	function fn_loginPage(){
		location.href="${path}/loginpage";
	}
</script>
</body>
</html>