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
                <h4>workIT에 오신 것을 환영합니다 :)</h4>
                <span>사원 번호</span>
                <div class="input-container">
                    <input type="text" name="member-id">
                </div>
                <span>비밀번호</span>
                <div class="input-container">
                    <input type="password" name="password">
                </div>
                <div class="btn-container">
                    <div><input type="checkbox" value=""><span>remember me</span></div>
                    <button onclick="fn_login();">Log in</button>
                </div>
            </form>
            <a href="">forgot your password?</a>
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
            text-decoration: none;
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
        .login-div h4,a{
            display: flex;
            justify-content: center;
            margin: 30px 0px;
        }
        .login-div div{
            margin: 0px 0px 30px 20px;
        }
        .input-container>*{
            margin: 10px 10px;
        }
        form>span{
            margin-left: 30px;
        }
        .btn-container{
            padding-right: 30px;
            display: flex;
            justify-content: space-between;
        }
    </style>
</body>
</html>