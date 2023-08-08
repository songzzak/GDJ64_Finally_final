<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.workit.member.model.vo.MemberVO"  %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="${path}/resources/css/common/common.css">
<script>
const path = "${pageContext.request.contextPath}";
</script>
<script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.slim.min.js"></script>
<script src="${path}/resources/js/jquery-3.7.0.min.js"></script>
<title>Work IT</title>
</head>
<body>
<%
	MemberVO loginMember=(MemberVO)session.getAttribute("loginMember");
%>
<header class="max100per">
	<div class="header-container max90per">
		<div class="header-container-logo" onclick="toMainPage();">
			<img alt="logo_header" src="${path}/resources/images/common/workit.svg">
		</div>
		<div class="header-button-container">
			<div class="header-member">
				<a href="${path }/mypage">
					<img src="${path}/resources/images/common/profile.svg" alt="member-profile-img">
					<span>${loginMember.dept.deptName }</span>
					<span>${loginMember.memberName }</span>
				</a>
			</div>
			<%-- <div class="header-search">
				<input type="search" placeholder="사원검색" class="emp_search">
				<img alt="alram_header" src="${path}/resources/images/common/icon-search.svg"> --%><%-- 검색 아이콘
			</div> --%>
			<div class="header_icon_container">
				<img alt="alram_header" src="${path}/resources/images/common/notify.svg" onclick="alramList();">
				<img alt="logout_header" src="${path}/resources/images/common/logout.svg" onclick="fn_logout();">
			</div>
		</div>
	</div>
</header>
<script>
	function fn_logout(){
		var logoutFl=confirm("로그아웃 하시겠습니까?");
		if(logoutFl){
			location.replace("${path}/logout");
		}
	}
</script>