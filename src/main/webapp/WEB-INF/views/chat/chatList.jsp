<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>                            
<c:set var="path" value="${pageContext.request.contextPath }"/>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<div class="chatList-container section-shadow">
	<div class="chat-header">
		<h2 id="startChat">채팅</h2>
		<div class="chat-icon-container">
			<img src="${path}/resources/images/common/search.svg" alt="chat-search" class="searchIcon">
			<img src="${path}/resources/images/chat/addchat.svg" alt="chat-addChat" class="addChatIcon">
		</div>
	</div>
	<div class="chat-room-list chat-inner">
		<!-- 채팅 추가 아이콘 누르면 나오는 모달창 -->
		<div class="modal-chat section-shadow modal-add-chatContainer" style="display: none">
			<div class="modal-content modal-add-chat">
				<div class="modal-close">X</div>
				<h4 class="chatRoomPersonal">1:1 채팅</h4>
				<h4 class="chatRoomGroup">그룹 채팅</h4>
			</div>
		</div>
		<div class="modal-searchContainer" style="display: none">
			<input type="search" name="searchChatList" placeholder="이름, 파일명 검색">
			<img src="${path}/resources/images/common/search.svg" alt="chat-search" class="modalSearchAllIcon">
			<span class="search-close">X</span>
		</div>
		<c:if test="${empty roomNumbers}">
			<div class="chat-room">
				<h3 class="title">참여 중인 채팅이 없습니다</h3>
			</div>
		</c:if>
		<c:if test="${not empty roomNumbers}">
			<c:forEach var="r" items="${roomNumbers}">
				<div class="chat-room chat-select">
					<h5 class="chatroom-title chat-select">${r.chatroomTitle }</h5>
					<img src="${path}/resources/images/common/more.svg" alt="chat-delete" class="deleteChatRoom">
					<input type="hidden" value="${r.chatroomId}" name="chatRoomId" class="roomId">
					<c:forEach var="c" items="${chat}">
						<c:if test="${r.chatroomId == c.chatroomId}">
							<span class="chat-content chat-select">${c.chatContent}</span>
							<span class="chat-date chat-select"><fmt:formatDate value="${c.chatDate}" type="both" pattern="yyyy-MM-dd (E) hh:mm:ss"/></span>
							<input type="hidden" value="${c.chatroomId}" name="chatRoomId" class="roomId">
						</c:if>
					</c:forEach>
				</div>
			</c:forEach>
		</c:if>
	</div>
</div>
<script>
	let chatroomId= '${chatroomId}';
	let loginMember = '${loginMember.memberId}';
	console.log(loginMember);
	let chatroomContainer = $(".chat-room-list");
	let chatroomTitle;
	
	/* $(".chat-room").click(e => {
		console.log("this : ",$(this));
		fn_openChatroom();
	}); */
	/* 
	 $(".chat-select").click(e => {
		//console.log("this : ",$(this));
		if($(e.target)==$(".chat-date") || $(e.target) ==$(".chat-content") || $(e.target)==$(".chatroom-title")) {
			console.log("chatroom 이외 ",$(e.target));
			//chatroomId = $(e.target).children().last().val();
			//console.log("target ", chatroomId);
		}
		else if($(e.target) == $(".chat-room")) {
			console.log("chatroom", $(e.target));
			/* chatroomId = $(e.target).parent().find($('input[type="hidden"]')).val();
			console.log(chatroomId); 
		}
		//chatroomTitle= $(e.target).children().first().text();
		$(".chatRoom-container .chat-header").empty();
		$(".chat-msgBox-container").empty();
		//fn_openChatroom();
	}); */
	$(".chat-room").click(e => {
		if ($(e.target) == $(".chat-room")) {
			chatroomId = $(e.target).find($('input[type="hidden"]')).val();
			console.log("chatroom",$(e.target));
		} else {
			chatroomId = $(e.target).parent().find($('input[type="hidden"]')).val();
			console.log(chatroomId);
		}
		$(".chat-msgBox-container").empty();
		fn_openChatroom();
	 });
	var chatMsg;
	const fn_openChatroom=()=>{
		console.log("fn_openchatroom start");
		console.log(chatroomId);
		$.ajax({
			url: "${path}/chat/chatroom",
			//type:"post",
			type: "get",
			data: {
				chatroomId: chatroomId
			},
			success: data => {
				console.log("open chatroom success");
				console.log(data);
				fn_startChat();
				fn_viewChatMsg(data);
			},
			error : data =>{
				console.log("error");
			}
			,done : data =>{
				
			}
		});
	}
	
	let chatroomMembers;
	let chatroomFiles;
	let divPrevChat;
	
	const fn_viewChatMsg=(data)=>{
		console.log("data : ",data);
		let chatroomMember = data.chatroomMember;
		let chatroomMemberName="";
		chatroomFiles = data.chatroomFile;
		console.log("chatroomFiles : ", chatroomFiles);
		chatroomMembers= [];
		chatroomMember.forEach(cm =>{
			chatroomMembers.push(cm.member.memberId);
			chatroomMemberName += cm.member.memberName+", ";
		})
		console.log(chatroomMemberName);
		let currentChatroom = data.chatroomList;
		//$("span.chat-member").text(chatroomMemberName+" ( "+chatroomMembers.length+" )");
		console.log("ciur",currentChatroom);
		$(".chatRoom-container .chat-header .title").text(chatroomMemberName+" ( "+chatroomMembers.length+" )");
		/* if(currentChatroom=="" || currentChatroom==null){
			alert("sdgasjdlg");
		} */
		
		if(data.chatroomList=="" || data.chatroomList==null){
			$(".chatRoom-container .chat-header .chat-icon-container").css("display","flex");
			$(".chatRoom-container .chat-header .title").text(chatroomTitle);
		}
		divPrevChat = $("<div>").attr("class","prev-chat");
		currentChatroom.forEach(e => {
			if(chatroomId!=null && chatroomId==e.chatroomId){
				//$(".chatRoom-container .chat-header .title").text(e.chatroomTitle);
				$(".chatRoom-container .chat-header .chat-icon-container").css("display","flex");
				if(e.chatroomCode == 'P') {
					$(".addPersonIcon").attr("class","chatHidden");
				}
				$(".chat-input-container").css("display","flex");
				$(".chat-room-nothing").attr("class","chatHidden");
				var chat = (e.chat);
				
				chat.forEach(c => {
					const cDate = new Date(c.chatDate);
					const chatDate = cDate.toLocaleString('ko-KO');
					if (c.member.memberId == loginMember) {
						var chatMsg = $("<div>").attr("class", "chat-msg chat-send");
						chatMsg.append($("<span>").attr("class", "chat-date").text(chatDate));
						chatMsg.append($("<span>").attr("class", "chat-msgbx").text(c.chatContent));
						chatMsg.append($("<input type='hidden'>").attr("value",c.chatId).attr("class","chat-msg-Id"));

					} else {
						var chatMsg = $("<div>").attr("class", "chat-msg");
						chatMsg.append($("<h5>").append($("<a>").text(c.member.memberName).attr("class",c.member.memberId)));
						chatMsg.append($("<span>").attr("class", "chat-msgbx").text(c.chatContent));
						chatMsg.append($("<span>").attr("class", "chat-date").text(chatDate));
						chatMsg.append($("<input type='hidden'>").attr("value",c.chatId).attr("class","chat-msg-Id"));
					}
					chatMsg.append($("<input>").attr("type", "hidden").attr("value", e.chatroomId).attr("class","roomId"));
					divPrevChat.append(chatMsg);
					$(".chat-fileform input[type='hidden']").attr("value",e.chatroomId);
				})
				$(".chatRoom-container .chat-room-inner .chat-msgBox-container").append(divPrevChat);
				
			}
		}) 
		if(data.chatroomFile!=null){
			fn_viewChatroomFile(data);
		}
	}
	const fn_viewChatroomFile=(data)=>{
			chatroomFiles.forEach(f=>{
				console.log("fieleelele", f);
				let receiveFile = f.chatroomFile;
				/* var chatMsg = $("<div>").attr("class", "chat-msg");
				chatMsg.append($("<img class='fileName'>").attr("src","${path}/resources/images/common/attach.svg").css("width","16px"));
				chatMsg.append($("<span>").attr("class", "fileName chat-msgbx").text(f.chatroomFile.originalFile));
				chatMsg.append($("<span>").attr("class", "chat-date").text(chatfileDate));
				chatMsg.append($("<input type='hidden'>").attr("value",f.fileId).attr("class","chat-msg-Id")); */
				divPrevChat.append(chatMsg);
				receiveFile.forEach(ff=>{
					const fDate = new Date(ff.fileId.uploadDate);
					const chatfileDate = fDate.toLocaleString('ko-KO');
					console.log(ff);
					var chatMsg = $("<div>").attr("class", "chat-msg");
					chatMsg.append($("<img class='fileName'>").attr("src","${path}/resources/images/common/attach.svg").css("width","16px"));
					chatMsg.append($("<span>").attr("class", "fileName chat-msgbx").text(ff.fileId.originalFile));
					chatMsg.append($("<span>").attr("class", "chat-date").text(chatfileDate));
					chatMsg.append($("<input type='hidden'>").attr("value",ff.fileId).attr("class","chat-msg-Id"));
					divPrevChat.append(chatMsg);
				})
			})
	}
	
	function fn_exitCreateChat() {
		$(".modalNewChat").css("display", "none");
	}
	
	$(".addChatIcon").click(e => {
		$(".chat-room-nothing").attr("class","chatHidden");
		$(".modal-new-chat-title").css("display","block");
		$(".modal-addChatMember").css("display","block");
	})
	
	$(".modalSearchAllIcon").click(e => {
		const keyword = $(e.target).prev().val();
		console.log(keyword);
	
		$.ajax({
			url: "${path}/chat/keyword",
			type: "post",
			data: {
				keyword: keyword
			},
			success: data => {
				console.log(data);
			}
		});
	})
	
	$(".searchChatRoomIcon").click(e => {
		let keyword = $(".searchChatRoomList").val();
		$.ajax({
			url: "${path}/chat/search",
			type: "post",
			data: {
				chatroomId: roomId,
				keyword: keyword
			}
			, success: data => {
				console.log(data);
				let url = "${path}/chat/chatroom" + data;
				window.location.replace(url);
			}
		})
	})
	
	const fn_deleteChatroom=(chatroomId)=>{
		console.log(chatroomId);
		swal('채팅방 나가기', "한 번 나간 채팅방의 내용은 복구되지 않습니다", 'warning')
			.then(function() {
				$.ajax({
					url: "${path}/chat/delete",
					method: "delete",
					data: {
						chatroomId: chatroomId,
						loginMember: loginMember
					},
					success: data => {
						console.log(data);
						if (data > 0) {
							swal("삭제 완료");
							//location.href='${path}/chat/chat.jsp';
							fn_closeChatModal();
						} else {
							swal("삭제 실패")
						}
					}
				});
			});
	}
	$(".deleteChatRoom").click(e => {
		chatroomId = $(e.target).next().val();
		fn_deleteChatroom(chatroomId);
	}) 
	
	$(".fileName").click(e=>{
		alert('sdjgoiwej')
	})
	
	$(document).on("click", ".fileName", function (e) {
		let currfileId = $(e.target).next().next().val();
		console.log("selected file Id : ",currfileId);
		
		
	});

	
</script>
</body>
</html>






