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
<script src="${path}/resources/js/jquery-3.7.0.min.js"></script>
<title>Work IT</title>
</head>
<body>
	 <section class="login-container first">
        <div class="login-div">
        <form action="" method="post" id="first-form">
            <div class="logo-container">
                <img src="${path }/resources/images/common/workit-logo.svg">
            </div>
            <!-- logo -->
            <h2 class="page-title">초기 이메일 인증 및 비밀번호 변경</h2>
            <span>이메일</span>
            <div class="input-container">
                <input type="email" name="email" class="first-input" id="mail">
                <input type="button" onclick="fn_requestEmail();" value="전송">
                <span>5:00</span>
            </div>
            <span>인증 번호</span>
            <div class="input-container" id="check-container">
                <input type="text" id="check-number" class="first-input">
                <input type="button" onclick="fn_checkEmailNumber();" value="인증">
            </div>
            <div id="check-info"></div>
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
<script>
	val emailFl=false;
	function fn_requestEmail(){
		const email=$("#mail").val();
		if(email==''){
			alert("이메일 주소를 입력하세요.");
			$("#mail").focus();
		}else{
			$.ajax({
				method:"post",
				url:"${path}/email",
				data:"email="+email,
				dataType:"text"
			}).then(function (response){
				alert("전송되었습니다. 이메일을 확인해주세요.");
				const emailNum=$("<input>").attr({
					"type":"hidden",
					"id":"email-number"
				});
				emailNum.val(response);
				$("#first-form").append(emailNum);
			});
		}
	}
	
	function fn_checkEmailNumber(){
		$("#check-info").find("span").remove();
		const checkNum=$("#check-number").val();
		const emailNum=$("#email-number").val();
		if(checkNum==''||checkNum.length<8){
			$("#check-info").append($("<span>").text("인증 번호를 정확하게 입력하세요."));
			$("#check-number").focus();
		}else if(checkNum==emailNum){
			$("#check-info").append($("<span>").text("인증되었습니다. :)"));
			emailFl=true;
		}else{
			$("#check-info").append($("<span>").text("인증 번호가 일치하지 않습니다."));
			$("#check-number").focus();
		}
	}
</script>
</body>
</html>