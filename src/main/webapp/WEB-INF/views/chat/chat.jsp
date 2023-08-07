<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>                            
 <c:set var="path" value="${pageContext.request.contextPath }"/>     
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<link rel="stylesheet" href="${path}/resources/css/chat/chat.css">
<link rel="stylesheet" href="${path}/resources/css/chat/chat-modal.css">
<section class="max100per">
	<jsp:include page="/WEB-INF/views/common/side-nav.jsp"/>
		<div class="main-section section-shadow">
			<jsp:include page="/WEB-INF/views/chat/chatList.jsp"/>
			<%-- <jsp:include page="/WEB-INF/views/chat/chatroom.jsp"/> --%>
			<jsp:include page="/WEB-INF/views/chat/chattingpage.jsp"/>
		</div>
</section>
<!-- <script>
	function fn_chatReload(){ 
		console.log("reload");
	    $(".chatRoom-container .chat-room-inner").load(window.location.href + ".chatRoom-container .chat-room-inner");
	}
	chatroomId= '${chatroomId}';
		console.log(chatroomId);
		console.log(loginMember);
		const websocket= new WebSocket("ws://localhost:8080/chatting");
		websocket.onopen=data=>{
			console.log(data);
			websocket.send(JSON.stringify(new Chat("",loginMember,"")));
		}
		websocket.onmessage=data=>{
			console.log(data);
			const chat=JSON.parse(data.data);
			console.log(chat);
			fn_chatReload();
		}
		$(".sendChat").click(e=>{
			const chatContent=$(".chat-msg-input").val();
			console.log(chatContent);
			websocket.send(JSON.stringify(new Chat(chatroomId, loginMember, chatContent)));
		});
		class Chat {
			constructor(chatroomId = "", memberId = "", chatContent = ""){
				this.chatroomId = chatroomId;
				this.memberId = memberId;
				this.chatContent = chatContent;
			}
		} 
</script> -->
<script src="${path}/resources/js/chat/chat.js"></script>
</body>
</html>
