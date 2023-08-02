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
			<jsp:include page="/WEB-INF/views/chat/chatList.jsp"/>
			<div class="chatRoom-container section-shadow">
				<jsp:include page="/WEB-INF/views/chat/chatHeader.jsp"/>
				<div class="chat-room-inner">
					<!-- <h2>선택한 채팅 창이 없습니다</h2> -->
					<!-- 검색 아이콘 누르면 나오는 모달창 -->
					<div class="modal-searchRoomContainer" style="display: none">
							<input type="search" name="searchChatRoomList" placeholder="검색">
							<img src="${path}/resources/images/common/search.svg" alt="chat-search" class="searchChatRoomIcon">
							<span class="search-close">X</span>
					</div>
				</div>
			</div>
		</div>
</section>
</body>
</html>
