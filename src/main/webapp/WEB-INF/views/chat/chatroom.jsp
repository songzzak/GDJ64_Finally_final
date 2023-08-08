<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>                            
 <c:set var="path" value="${pageContext.request.contextPath }"/>     
<link rel="stylesheet" href="${path}/resources/css/chat/chat.css">
<div class="chatRoom-container section-shadow">
	<c:if test="${empty chatroom && empty chatroomId }">
		<div class="chat-header"></div>
		<div class="chat-room-inner">
			<div class="modalNewChat section-shadow" style="display:none"></div>
			<img src="${path}/resources/images/common/workit.svg">
			<h2>선택한 채팅 창이 없습니다</h2>
		</div>
	</c:if>
	<c:if test="${not empty chatroom || not empty chatroomId }">
	<div class="chat-header">
		<h3></h3>
		<div class="chat-icon-container">
			<img src="${path}/resources/images/common/search.svg" alt="chat-search" class="searchChatIcon">
			<img src="${path}/resources/images/common/attach.svg" alt="chat-attach" class="attachChatIcon">
			<%-- <img src="${path}/resources/images/common/close.svg" alt="chat-close" class="closeIcon"> --%>
			<!-- 그룹 채팅일때만 아이콘 노출 -->
			<img src="${path}/resources/images/chat/addPerson.svg" alt="chat-addPerson" class="addPersonIcon">
		</div>
	</div>
		<div class="chat-room-inner">
		<div class="modal-searchRoomContainer" style="display: none">
			<input type="search" name="searchChatRoomList" placeholder="검색">
			<img src="${path}/resources/images/common/search.svg" alt="chat-search" class="searchChatRoomIcon">
			<span class="search-close">X</span>
		</div>
			<c:forEach var="chat" items="${chatroom}">
				<c:forEach var="c" items="${chat.chat}">
					<c:if test="${c.memberId != loginMember.memberId }">
						<div class="chat-msg">
							<h5><c:out value="${c.memberId}"/></h5>
							<span class="chat-msgbx"><c:out value="${c.chatContent}"/></span>
							<span class="chat-date"><c:out value="${c.chatDate}"/></span>
						</div>
					</c:if>
					<c:if test="${c.memberId == loginMember.memberId }">
						<div class="chat-msg chat-send">
							<span class="chat-date"><c:out value="${c.chatDate}"/></span>
							<span class="chat-msgbx"><c:out value="${c.chatContent}"/></span>
						</div>
					</c:if>
				</c:forEach>
				<input type="hidden" class="curChatroomId" value="${chat.chatroomId}">
			</c:forEach>
			<%-- <form action="${path}/chat/attatch" method="post" class="chat-msgform" enctype="multipart/form-data"> --%>
			<input type="text" name="chat-msg" class="chat-msg-input">
			<button class="sendChat">send</button>
			<form action="" class="chat-fileform">
				<input type="file" name="uploadFile" multiple style="display: none">
				<button type="submit" name="chat-attatch" class="chat-addAttatch">+</button>
			</form>
		</div>
	</c:if>
</div>
</body>
</html>
