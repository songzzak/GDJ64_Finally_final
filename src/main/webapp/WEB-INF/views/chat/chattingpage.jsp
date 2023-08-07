<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>                            
 <c:set var="path" value="${pageContext.request.contextPath }"/>     
<link rel="stylesheet" href="${path}/resources/css/chat/chat.css">
<%-- <div class="chatRoom-container section-shadow">
	<div class="chat-header">
		<h3></h3>
		<div class="chat-icon-container">
			<img src="${path}/resources/images/common/search.svg" alt="chat-search" class="searchChatIcon">
			<img src="${path}/resources/images/common/attach.svg" alt="chat-attach" class="attachChatIcon">
			<img src="${path}/resources/images/common/close.svg" alt="chat-close" class="closeIcon">
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
</div> --%>
<div class="chatRoom-container section-shadow">
	<div class="chat-header">
		<h3 class="title"></h3>
		<c:if test="${not empty chatroomId }">
		<div class="chat-icon-container chatHidden">
			<img src="${path}/resources/images/common/search.svg" alt="chat-search" class="searchChatIcon">
			<img src="${path}/resources/images/common/attach.svg" alt="chat-attach" class="attachChatIcon">
			<%-- <img src="${path}/resources/images/common/close.svg" alt="chat-close" class="closeIcon"> --%>
			<!-- 그룹 채팅일때만 아이콘 노출 -->
			<img src="${path}/resources/images/chat/addPerson.svg" alt="chat-addPerson" class="addPersonIcon">
		</div>
		</c:if>
	</div>
	<div class="chat-room-inner">
		<div class="modalNewChat section-shadow" style="display:none"></div>
		<div class="chat-room-nothing">
			<img src="${path }/resources/images/common/workit.svg">
			<h2 class="title">선택한 채팅이 없습니다</h2>
		</div>
		<div class="modal-searchRoomContainer" style="display: none">
			<input type="search" name="searchChatRoomList" placeholder="검색">
			<img src="${path}/resources/images/common/search.svg" alt="chat-search" class="searchChatRoomIcon">
			<span class="search-close">X</span>
		</div>
		<div class="chat-msgBox-container"></div>
	</div>
	<div class="chat-input-container chatHidden">
		<input type="text" name="chat-msg" class="chat-msg-input">
		<button class="sendChat">send</button>
		<%-- <img src="${path}/resources/images/common/search.svg" alt="fileUpload">
		<form action="" class="chat-fileform">
			<input type="file" name="uploadFile" multiple style="display: none">
			<!-- <button type="submit" name="chat-attatch" class="chat-addAttatch">+</button> -->
		</form>
		<input type="text" name="chat-msg" class="chat-msg-input"><button class="sendChat">send</button> --%>
		<!-- <form method="post" enctype="multipart/form-data">
		    <div class="button">
		        <label for="chooseFile">
		            👉 CLICK HERE! 👈
		        </label>
		    </div>
		    <input type="file" id="chooseFile" name="chooseFile" accept="image/*" onchange="loadFile(this)">
		</form> -->
	</div>
</div>
<div class="modal-addChatMember chatHidden">
		<div class="modal-content">
			<h4>현재 채팅 멤버</h4>
			<div class="curChatMembers"></div>
			<form class="chat-DeptContainer" method="post" action="${path}/chat/start">
				
			</form>
			<div class="changeChatMembers"></div>
			<button id="changeMemberBtn">변경</button>
			<button class="h-close-modal">변경 취소</button>
		</div>
</div>
<script>
//부서 출력 
/* const deptDiv = $("<form class='chat-DeptContainer'>");
deptDiv.attr("method", "post");
deptDiv.attr("action", "${path}/chat/start");
deptDiv.append($("<label>").attr("for", "chatroomTitle").text("채팅 방 제목"));
deptDiv.append($("<input type='text' name='chatroomTitle'>"));
let deptArr = ['운영팀', '취업팀', '인사팀', '경영팀', '홍보팀', '행정팀'];
deptArr.forEach(e => {
	chatDept = $("<div class='chat-dept'>")
	chatDept.append($("<h4 class='title'>").append($("<a class='chatDept'>").text(e)));
	deptDiv.append(chatDept);
	modalNewChatDiv.append(deptDiv);
}); */

	//인원 추가 누르면 추가되는 로직 
	$(".addPersonIcon").click(e => {
		open("${path}/chat/modalMember","_blank","width=400,height=500");
		/* $(".chat-icon-container")
		$(".modal-addChatMember").css("display","block");
		$(".chatRoom-container").attr("class","chatHidden");
		console.log(chatroomId);
		$.ajax({
			url: "${path}/chat/member",
			type: "post",
			data: {
				chatroomId: chatroomId
			}
			,success: data => {
				$(".curChatMembers");
				console.log(data);
				data.forEach(e =>{
					$("<input type")
				})
			}
		}); */
	})

	function fn_chatReload(){ 
		console.log("reload");
	    $(".chatRoom-container .chat-room-inner").load(window.location.href + ".chatRoom-container .chat-room-inner");
	}
	console.log(chatroomId);
	console.log(loginMember);
	const websocket= new WebSocket("ws://localhost:8080/chatting");
	websocket.onopen=data=>{
		console.log(data);
	}
	websocket.onmessage=data=>{
		console.log(data);
		const receiveChat=JSON.parse(data.data);
		console.log(receiveChat);
		fn_printChat(receiveChat)
		/* const chat=JSON.parse(data.data);
	console.log(chat); */
	}
	websocket.onclose=data=>{
		console.log(data);
	}
 	function fn_printChat(msg){
		const chatDiv = $(".chat-msgBox-container");
		if (msg.memberId == loginMember) {
			var chatMsg = $("<div>").attr("class", "chat-msg chat-send");
			//chatMsg.append($("<span>").attr("class", "chat-date").text(msg.chatDate));
			chatMsg.append($("<span>").attr("class", "chat-msgbx").text(msg.chatContent));
			//chatMsg.append($("<input type='hidden'>").attr("value",msg.chatId).attr("class","chat-msg-Id"));

		} else {
			var chatMsg = $("<div>").attr("class", "chat-msg");
			chatMsg.append($("<h5>").text(msg.memberId));
			chatMsg.append($("<span>").attr("class", "chat-msgbx").text(msg.chatContent));
			//chatMsg.append($("<span>").attr("class", "chat-date").text(msg.chatDate));
			//chatMsg.append($("<input type='hidden'>").attr("value",msg.chatId).attr("class","chat-msg-Id"));
		}
		chatMsg.append($("<input>").attr("type", "hidden").attr("value", msg.chatroomId).attr("class","roomId"));
		chatDiv.append(chatMsg);
	}
	$(".sendChat").click(e=>{
		const chatContent=$(".chat-msg-input").val();
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