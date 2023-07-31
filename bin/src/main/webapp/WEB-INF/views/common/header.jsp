<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<<<<<<< HEAD
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>                            
 <c:set var="path" value="${pageContext.request.contextPath }"/> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="${path}/resources/css/yoonjin/style_header.css">
<title>Work IT</title>
</head>
<body>
	<div class="header-container max1920px">
		<div class="header-container-logo" onclick="toMainPage();">
			<img alt="logo_header" src="${path}/resources/images/yoonjin/main_icon/logo_header.svg">
		</div>
		<div class="header-container-button">
			<div>
				<input type="search" placeholder="사원검색" class="emp_search">
			</div>
			<div class="header_icon_container">
				<img alt="chat_header" src="${path}/resources/images/yoonjin/main_icon/chat_header.svg" onclick="toChattingPage();">
				<img alt="alram_header" src="${path}/resources/images/yoonjin/main_icon/alram_header.svg" onclick="alramList();">
				<img alt="logout_header" src="${path}/resources/images/yoonjin/main_icon/logout_header.svg" onclick="loggot();">
=======
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
<%-- <c:set var="path" value="${pageContext.request.contextPath }"/> --%>
<header class="min1920px">
	<div class="header-container max1920px">
		<div class="header-container-logo" onclick="toMainPage();">
			<img alt="logo_header" src="${pageContext.request.contextPath}/resource/images/yoonjin/main_icon/logo_header.svg">
		</div>
		<div class="header-container-button">
			<div>
				<input type="search" placeholder="사원검색" class="emp_search">
			</div>
			<div class="header_icon_container">
				<img alt="chat_header" src="${pageContext.request.contextPath}/resource/images/yoonjin/main_icon/chat_header.svg" onclick="toChattingPage();">
				<img alt="alram_header" src="${pageContext.request.contextPath}/resource/images/yoonjin/main_icon/alram_header.svg" onclick="alramList();">
				<img alt="logout_header" src="${pageContext.request.contextPath}/resource/images/yoonjin/main_icon/logout_header.svg" onclick="loggot();">
>>>>>>> branch 'dev' of https://github.com/songzzak/GDJ64_Finally_final.git
			</div>
		</div>
	</div>
</header>