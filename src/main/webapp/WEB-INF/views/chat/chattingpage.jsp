<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>                            
 <c:set var="path" value="${pageContext.request.contextPath }"/>     
<link rel="stylesheet" href="${path}/resources/css/chat/chat.css">
<div class="chatRoom-container section-shadow">
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
	</div>
	<input type="text" name="chat-msg" class="chat-msg-input"><button class="sendChat">send</button>
	<form action="" class="chat-fileform">
		<input type="file" name="uploadFile" multiple style="display: none">
		<button type="submit" name="chat-attatch" class="chat-addAttatch">+</button>
	</form>
</div>
<script>
	console.log(chatroomId);
	console.log(loginMember);
	const websocket= new WebSocket("ws://localhost:8080/chatting");
	websocket.onopen=data=>{
		console.log(data);
		//websocket.send(JSON.stringify(new Chat(chatroomId,"aa","aa")));
	}
	websocket.onmessage=data=>{
		console.log(data);
		/* const chat=JSON.parse(data.data);
	console.log(chat); */
	}
	$(".sendChat").click(e=>{
		const chatContent=$(".chat-msg-input").val();
		//console.log(chatContent);
		websocket.send(JSON.stringify(new Chat(chatroomId, loginMember, chatContent)));
	});
	class Chat {
		constructor(chatroomId = "", memberId = "", chatContent = ""){
			this.chatroomId = chatroomId;
			this.memberId = memberId;
			this.chatContent = chatContent;
		}
	}
</script>
</body>
</html>