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
	 <section class="login-container">
        <div class="login-div">
        <form action="" method="post">
            <img src="">
            <!-- logo -->
            <h2 class="page-title">초기 이메일 인증 및 비밀번호 변경</h2>
            <span>이메일</span>
            <div class="input-container">
                <input type="email" name="email">
                <button onclick="">인증 요청</button>
            </div>
            <span>인증 번호</span>
            <div class="input-container">
                <input type="text" name="check-number">
                <button onclick="">인증</button>
            </div>
            <span>비밀번호</span>
            <div class="input-container">
                <input type="password" name="password" id="pwd">
            </div>
            <span>비밀번호 확인</span>
            <div class="input-container">
                <input type="password" id="pwd-check">
            </div>
            <div class="pwd-msg"></div>
            <p class="info-msg">* 이메일 인증과 비밀번호 변경을 완료하셔야 로그인 가능합니다.</p>
            <div class="success-btn">
                <button onclick="fn_checkInfo();">완료</button>
            </div>
        </form>
    </div>
    </section>
    <style>
        @font-face {
            font-family: "NEXON Lv2 Gothic";
            src:
                url("https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_20-04@2.1/NEXON Lv2 Gothic.woff")
                format("woff");
            font-style: normal;
            font-weight: normal;
        }
        *{
            padding: 0px;
            margin: 0px;
	        list-style: none;
            font-family: "NEXON Lv2 Gothic";
        }
        .login-container{
            width: 100%;
            height: 100%;
            background-color: lightsteelblue;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }
        .login-div{
            width:480px;
            height: 600px;
            border: 1px solid red;
            border-radius: 10px;
            background-color: white;
        }
        .page-title{
            margin: 20px 0px 50px 20px;
        }
        .login-div div{
            margin: 0px 0px 30px 20px;
        }
        .input-container>*{
            margin: 10px 10px;
        }
        .info-msg{
            margin-left: 20px;
        }
        form>span{
            margin-left: 30px;
        }
        .success-btn{
            width: 440px;
            height: 100px;
            border: 1px solid red;
            position: relative;
        }
        .success-btn>button{
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
        }
    </style>
</body>
</html>