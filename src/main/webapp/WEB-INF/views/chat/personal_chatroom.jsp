<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>                            
 <c:set var="path" value="${pageContext.request.contextPath }"/>     
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<link rel="stylesheet" href="${path}/resources/css/chat/chat.css">	
<section class="max100per">
	<jsp:include page="/WEB-INF/views/common/side-nav.jsp"/>
		<div class="main-section section-shadow">
			<div class="chatList-container section-shadow">
				<div class="chat-header">
					<h2>채팅</h2>
					<div class="chat-icon-container">
						<img src="${path}/resources/images/common/icon-search.svg" alt="chat-search">
						<img src="${path}/resources/images/common/icon-chat.svg" alt="chat-addChat">
					</div>
				</div>
				
				<div class="chat-room-list chat-inner">
					<div class="chat-room">
						<h5>이름</h5>
						<img src="${path}/resources/images/common/icon-more.svg" alt="chat-delete">
						<h5>내용</h5>
						<h5>날짜</h5>
					</div>
					
				</div>
			</div>
			<div class="chatRoom-container section-shadow">
				<div class="chat-header">
					<h3>이름 (숫자)</h3>
					<div class="chat-icon-container">
						<img src="${path}/resources/images/common/icon-search.svg" alt="chat-search">
						<img src="${path}/resources/images/common/icon-chat.svg" alt="chat-addChat">
					</div>
				</div>
				<div class="chatRoom chat-inner">
					<h2>선택한 채팅 창이 없습니다</h2>
				</div>
			</div>
		</div>
</section>
</body>
</html>