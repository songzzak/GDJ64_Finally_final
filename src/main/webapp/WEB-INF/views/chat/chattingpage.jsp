<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>                            
 <c:set var="path" value="${pageContext.request.contextPath }"/>     
<link rel="stylesheet" href="${path}/resources/css/common/common.css">
<link rel="stylesheet" href="${path}/resources/css/chat/chat.css">
<div class="modal-addChatMember chatHidden scroll chatmodal">
	<div class="modal-content section-shadow">
	<h2 class="title">채팅 멤버 선택</h2>
	<div class="modal-current-member"></div>
	<div class="chat-DeptContainer">
		<div class="modal-new-chat-title chatHidden">
			<label for="chatroomTitle">채팅 제목 : </label><input type="text" name="chatroomTitle" placeholder="채팅 제목"><br>
			<span>채팅 제목 미 설정 시 채팅 멤버 아이디, 채팅 참여 멤버 수로 설정됩니다</span>
		</div>
		<c:if test="${not empty dept && not empty members}">
		<div class="">
			<c:forEach var="dept" items="${dept}">
				<div class="dept-list-container section-shadow">
					<h4 class="dept-title"><c:out value="${dept.deptName}"/></h4>
					<form class="modal-memberList chatHidden">
						<c:forEach var="member" items="${members }">
							<c:if test="${dept.deptCode == member.dept.deptCode && member.memberId!=loginMember.memberId}">
								<label for="memberId"></label><input type="checkbox" name="memberId" value="${member.memberId }"><c:out value="${member.memberName }"/> <c:out value="${member.job.jobName }"/>
							</c:if>
						</c:forEach>
					</form>
				</div>
			</c:forEach>
		</div>
		<c:if test="${empty chatroomMembers}">
			<button class="insert-chat-btn">채팅 시작</button>
		</c:if>
		<c:if test="${not empty chatroomMembers}">
			<h4><c:out value="${chatroomMembers}"/></h4>
			<button class="update-chat">멤버 추가</button>
		</c:if>
		</c:if>
	</div>
	</div>
</div>
<div class="chatRoom-container section-shadow">
	<div class="chat-header">
		<h3 class="title"></h3>
		<div class="chat-icon-container chatHidden">
			<img src="${path}/resources/images/common/search.svg" alt="chat-search" class="searchChatIcon">
			<img src="${path}/resources/images/common/attach.svg" alt="chat-attach" class="attachChatIcon">
			<img src="${path}/resources/images/chat/addPerson.svg" alt="chat-addPerson" class="addPersonIcon">
		</div>
	</div>
	<div class="chat-room-inner">
		<div class="modalNewChat section-shadow chatHidden"></div>
		<div class="chat-room-nothing">
			<img src="${path }/resources/images/common/workit.svg">
			<h2 class="title">선택한 채팅이 없습니다</h2>
		</div>
		<div class="modal-searchRoomContainer chatHidden">
			<input type="search" name="searchChatRoomList" placeholder="검색">
			<img src="${path}/resources/images/common/search.svg" alt="chat-search" class="searchChatRoomIcon">
			<span class="search-close">X</span>
		</div>
		<div class="chat-msgBox-container scroll"></div>
	</div>
	<div class="chat-input-container chatHidden">
		<!-- <form action="" class="chat-fileform" method="post" enctype="multipart/form-data"> -->
		<form action="${path}/chat/attach" class="chat-fileform" method="post" enctype="multipart/form-data">
			<input type="file" name="uploadFile" multiple class="chat-upFile chatHidden">
			<button name="chat-attatch" class="chat-addAttatch">+</button>
			<!-- <button type="submit" name="chat-attatch" class="chat-addAttatch">+</button> -->
		</form>
		<input type="text" name="chat-msg" class="chat-msg-input">
		<button class="sendChat">send</button>
		<%-- <img src="${path}/resources/images/common/search.svg" alt="fileUpload"> --%>
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
<script>
	const fn_closeChatModal=()=>{
		$('html').click(function(e) {   
			if(!$(e.target).hasClass("modal")) {
				alert('영역 밖입니다.');
				$(".modal-addChatMember").css("display","none");
			}
		});    
	}
	$(".insert-chat-btn").click(e=>{
		var chatroomCode;
		var chatMember="";
		//var chatMemberArr=[];
		let chatroomTitle;
		let selectedMember = $(".modal-memberList input:checked");
		if($("input[name=chatroomTitle]").val()==null ||$("input[name=chatroomTitle]").val()==""){
			chatroomTitle = $("input[name=chatroomTitle]").val()+" ("+(selectedMember.length+1)+")";
		}else{
			chatroomTitle = $("input[name=chatroomTitle]").val();
		}
		var newChatroom;
		if(selectedMember.length==1){
			chatMember = selectedMember.val();
			newChatroom = new Chatroom("", 'P', chatroomTitle, "", chatMember);
		}else{
			for(let i=0;i<selectedMember.length;i++){
				console.log(i,selectedMember[i].value);
				chatMember+=selectedMember[i].value+",";
			}
			chatMember = chatMember.slice(0, -1);
			console.log(chatMember);
			newChatroom = new Chatroom("", 'G', chatroomTitle, "", chatMember);
		}
		$.ajax({
			url: "${path}/chat/insert",
			type: "post",
			data:JSON.stringify(newChatroom),
			contentType:"application/json;charset=utf-8",
			success: data => {
				console.log(data);
			},
			done:data =>{
				fn_closeChatModal();
			}
		});
	})
	$(".dept-title").click(e=>{
		console.log($(e.target));
		$(e.target).next().toggle();
	})
	$(".modal-addChatMember").click(e=>{
		//$(".modal-content").attr("class","chatHidden");
		//$(e.target).attr("class","chatHidden");
	})
	let sendDate = new Date();
	const timeElapsed = Date.now();
	const today = new Date(timeElapsed);
	console.log("date now ",today);
	console.log("chatroomMember",chatroomId);
	$(".chat-addAttatch").click(e=>{
		$(".chat-upFile").click();
	});
	$(".chat-upFile").change(e=>{
		console.log($(e.target));
		/* const filename= $(e.target);
 		const reader=new FileReader();
 		reader.onload=e=>{
 			console.log(e);
 			//e.target.result속성에 변경된 file이 나옴.
 			//$(".i-myprofile").attr({src:e.target.result});
 		}
 		reader.readAsDataURL(e.target.files[0]); */
 	});
	const fn_viewMember=()=>{
		if(chatroomMembers==null ||chatroomMembers==""){
			chatroomId="";
			$(".modal-new-chat-title").css("display","block");
			$(".chat-DeptContaine").attr("action","${path}/chat/start");
		}else{
			$(".chat-DeptContainer").attr("action","${path}/chat/");
		}
		$.ajax({
			url: "${path}/chat/member",
			type: "post",
			data: {
				chatroomId: chatroomId
			}
			,success: data => {
				console.log("chatroomMembers : "+" "+chatroomMembers);
				console.log("member add");
				console.log(data);
				var memberDiv = $("<div class='chat-memberByDept'>");
				data.forEach(e =>{
					/* if(e.memberId!=loginMember.memberId && e.memberId!=chatroomMembers){ */
					if(e.memberId!=loginMember){
					memberDiv.append($("<label>").attr("for", e.memberId).text(e.memberName + " " + e.job.jobName));
					memberDiv.append($("<input type='checkbox' name='memberId'>").attr("value", e.memberId));
					memberDiv.append($("<br>"));
					$(".chat-DeptContainer").append(memberDiv);
					}
				})
				$(".chat-DeptContainer").append($("<input type='submit' value='선택'>"));
			}
		});
	}
	$(".addPersonIcon").click(e => {
		$(".chat-room-nothing").attr("class","chatHidden");
		$(".modal-addChatMember").css("display","block");
	})

	console.log(chatroomId);
	console.log(loginMember);
	const websocket= new WebSocket("ws://localhost:8080/chatting");
	websocket.onopen=data=>{
		console.log(data);
	}
	websocket.onmessage=data=>{
		const receiveChat=JSON.parse(data.data);
		console.log(receiveChat);
		fn_printChat(receiveChat);
		$(".chat-msg-input").val("");
	}
	websocket.onclose=data=>{
		console.log(data);
	}
 	function fn_printChat(msg){
		const chatDiv = $(".chat-msgBox-container");
		const chatDate = new Date(msg.chatDate).toLocaleString('ko-KO');
		if (msg.memberId == loginMember) {
			var chatMsg = $("<div>").attr("class", "chat-msg chat-send");
			chatMsg.append($("<span>").attr("class", "chat-date").text(chatDate));
			chatMsg.append($("<span>").attr("class", "chat-msgbx").text(msg.chatContent));
			chatMsg.append($("<input type='hidden'>").attr("value",msg.chatId).attr("class","chat-msg-Id"));

		} else {
			var chatMsg = $("<div>").attr("class", "chat-msg");
			chatMsg.append($("<h5>").text(msg.memberId));
			chatMsg.append($("<span>").attr("class", "chat-msgbx").text(msg.chatContent));
			chatMsg.append($("<span>").attr("class", "chat-date").text(chatDate));
			chatMsg.append($("<input type='hidden'>").attr("value",msg.chatId).attr("class","chat-msg-Id"));
		}
		chatMsg.append($("<input>").attr("type", "hidden").attr("value", msg.chatroomId).attr("class","roomId"));
		chatDiv.append(chatMsg);
	}
	$(".sendChat").click(e=>{
		const chatContent=$(".chat-msg-input").val();
		websocket.send(JSON.stringify(new Chat(chatroomId, loginMember, chatContent, today)));
	});
	class Chat {
		constructor(chatroomId = "", memberId = "", chatContent = "", chatDate = ""){
			this.chatroomId = chatroomId;
			this.memberId = memberId;
			this.chatContent = chatContent;
			this.chatDate = chatDate;
		}
	}
	
	class Chatroom {
		constructor(chatroomId = "", chatroomCode = "", chatroomTitle = "", chatroomDate ="", memberId = ""){
			this.chatroomId = chatroomId;		
			this.chatroomCode = chatroomCode;
			this.chatroomTitle = chatroomTitle;
			this.chatroomDate = chatroomDate;
			this.memberId = memberId;
		}
	}
	
</script>
</body>
</html>