//채팅 
const websocket= new WebSocket("ws://localhost:8080/chat/chatting");
const user = '${loginMember.memberId}';
const chatroomId = '';
websocket.onopen=data=>{
		console.log(data);
	}
	
websocket.onopen=data=>{
	websocket.send(JSON.stringify(new Chat(user,"hi")));
}
websocket.onmessage=data=>{
	const msg=JSON.parse(data.data);
	console.log(msg);
}
websocket.onclose=data=>{
		
}
$(".sendChat").click(e=>{
	const msg=$(".chat-msg-input").val();
	websocket.send(JSON.stringify(new Chat(user, msg)));
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
class Chat {
	constructor(memberId = "", chatContent = ""){
		this.memberId = memberId;
		this.chatContent = chatContent;
	}
}

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