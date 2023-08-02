<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>                            
 <c:set var="path" value="${pageContext.request.contextPath }"/>     
<link rel="stylesheet" href="${path}/resources/css/chat/chat.css">
<c:if test="${result}">
	<h4>결과</h4>
	<%-- <c:choose>
		<c:when test="${ chatroom.chat.memberId not eq '2023072796'}">
			<c:forEach var="c" items="${chatroom.chat}">
				<!-- 보낸 사람이 현재 로그인 한 사람이 아닐 때 -->
				<div class="chat-msg">
					<h5>
						<c:out value="${c.memberName}" />
					</h5>
					<span class="chat-msgbx"><c:out value="${c.chatContent}" /></span>
					<span class="chat-date"><c:out value="${c.chatDate}" /></span>
					<!-- <div class="chat-reaction" style="display:none">
													<label for="reaction_like" class="chatReaction"><input type="checkbox" checked="checked" value="relike" style="display:none"/>
													<span>❤</span></label>️
													<input type="checkbox" value="regreat"/>
													<label for="reaction_great" class="chatReaction"><span>👍</span></label>️
													<input type="checkbox" value="recheck"/>
													<label for="reaction_check" class="chatReaction"><span>✔</span></label>️
												</div> -->
				</div>
			</c:forEach>
		</c:when>
		<c:when
			test="${not empty chatroom && chatroom.chat.memberId eq '2023072796' }">
			<c:forEach var="c" items="${chatroom.chat }">
				<div class="chat-msg chat-send">
					<span class="chat-date"><c:out value="${c.chatDate}" /></span> <span
						class="chat-msgbx"><c:out value="${c.chatContent}" /></span>
				</div>
			</c:forEach>
		</c:when>
	</c:choose> --%>
	<form action="${path}/chat/attatch" method="post" class="chat-msgform" enctype="multipart/form-data" style="display: none">
		<input type="file" name="uploadFile" multiple style="display: none">
		<button type="submit" name="chat-attatch" class="chat-addAttatch">+</button>
		<input type="text" name="chat-msg" class="chat-msg-input">
		<input type="submit" value="전송" class="sendChat">
	</form>
</c:if>
<script>
	//채팅 
	/* const websocket= new WebSocket("ws://localhost:8080/chat/chatting");
	//const user = '${loginMember.memberId}';
	const user = '2023072796'; // 임시
	const chatroomId = '';
	websocket.onopen=data=>{
			console.log(data);
			}
		
	server.onopen=data=>{
			server.send(JSON.stringify(new Chat(user,"hi")));
		}
		server.onmessage=data=>{
			const msg=JSON.parse(data.data);
			console.log(msg);
		}
		server.onclose=data=>{
			
		}
		$(".sendChat").click(e=>{
			const msg=$(".chat-msg-input").val();
			server.send(JSON.stringify(new Chat(user, msg)));
		});
		/* function systemMessage(msg){
			$("#accessMember").html("");
			msg.split(",").forEach(e=>{
				const m=$("<h5>").text(e);
				$("#accessMember").append(m);
			})
		} */
		/* function printMessage(msg){
			const msgContainer=$("<div>");
			const content=$("<h4>").text(msg.msg).css("text-align",msg.sender==me?"right":"left");
			msgContainer.append(content);
			$("#chattingcontainer").append(msgContainer);
		} */
		/*class Chat {
			constructor(memberId = "", chatContent = ""){
				this.memberId = memberId;
				this.chatContent = chatContent;
			}
		} */
		
		/* private String chatId; seq -> 자동 입력 
		private String chatroomId; -> 해당 번호 가지고 가야함 
		private String memberId; -> 보내는 사람이라 필요 없을 것 같기도 함.. 
		private String chatContent; -> 내용 필수 
		private Date chatDate; -> sysdate */
		/* class Message{
			constructor(type="",sender="",reciever="",msg="",room=""){
				this.type=type;
				this.sender=sender;
				this.reciever=reciever;
				this.msg=msg;
				this.room=room;
			}
		} */
</script>
</body>
</html>
