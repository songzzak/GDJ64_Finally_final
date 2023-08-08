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
		<!-- 검색 아이콘 누르면 나오는 모달창 -->
		<div class="modal-searchContainer" style="display: none">
			<input type="search" name="searchChatList" placeholder="이름, 파일명 검색">
			<img src="${path}/resources/images/common/search.svg" alt="chat-search" class="modalSearchAllIcon">
			<span class="search-close">X</span>
		</div>
		<!-- select 해서 가져오기 없으면 분기처리-->
		<c:if test="${empty roomNumbers}">
			<div class="chat-room">
				<h3 class="title">참여 중인 채팅이 없습니다</h3>
			</div>
		</c:if>
		<c:if test="${not empty roomNumbers}">
			<c:forEach var="r" items="${roomNumbers}">
				<div class="chat-room">
					<h5>${r.chatroomTitle }</h5>
					<img src="${path}/resources/images/common/more.svg" alt="chat-delete" class="deleteChatRoom">
					<input type="hidden" value="${r.chatroomId}" name="chatRoomId" class="roomId">
					<c:forEach var="c" items="${chat}">
						<c:if test="${r.chatroomId == c.chatroomId}">
							<span class="chat-content">${c.chatContent}</span>
							<span class="chat-date"><fmt:formatDate value="${c.chatDate}" type="both" pattern="yyyy-MM-dd (E) hh:mm:ss"/></span>
							<input type="hidden" value="${c.chatroomId}" name="chatRoomId" class="roomId">
						</c:if>
					</c:forEach>
				</div>
			</c:forEach>
		</c:if>
	</div>
</div>
<style>
.modal-addChatMember {
	position: fixed;
	z-index: 100000;
	left: 0;
	top: 0;
	width: 100%;
	height: 100%;
	overflow: auto;
	background-color: rgba(0, 0, 0, 0.4);
	display: none;
	text-align:center;
}

.modal-content{
	background-color: #FFFFFF;
	margin: 15% auto;
	width: 50%;
	text-align:center;
	padding: 2rem;
	height: 500px;
	overflow-y: scroll;
}
</style>
<script>
	let chatroomId= '${chatroomId}';
	let loginMember = '${loginMember.memberId}';
	console.log(loginMember);
	let chatroomContainer = $(".chat-room-list");
	
	$(".chat-room").click(e => {
		if ($(e.target) == $(".chat-room")) {
			console.log($(e.target));
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
		$.ajax({
			url: "${path}/chat/chatroom",
			//type:"post",
			type: "get",
			data: {
				chatroomId: chatroomId
			},
			success: data => {
				fn_viewChatMsg(data);
			}
		});
	}
	
	let chatroomMembers = [];
	
	const fn_viewChatMsg=(data)=>{
		let chatroomMember = data.chatroomMember;
		chatroomMember.forEach(cm =>{
			chatroomMembers.push(cm.member.memberId);
		})
		let currentChatroom = data.chatroomList;
		
		currentChatroom.forEach(e => {
			$(".chatRoom-container .chat-header .title").text(e.chatroomTitle);
			let divPrevChat = $("<div>").attr("class","prev-chat");
			if(chatroomId!=null && chatroomId==e.chatroomId){
				$(".chatRoom-container .chat-header .chat-icon-container").css("display","flex");
				if(e.chatroomCode =="P") {
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
				})
				$(".chatRoom-container .chat-room-inner .chat-msgBox-container").append(divPrevChat);
				
			}
		}) 
	}
	
	function fn_exitCreateChat() {
		$(".modalNewChat").css("display", "none");
	}
	
	/* let deptName;
	let chatCode;
	let chatDept = $("<div class='chat-dept'>");
	let chatmemberContainer; */
	
	// 채팅 추가
	$(".addChatIcon").click(e => {
		$(".chat-room-nothing").attr("class","chatHidden");
		$(".modal-new-chat-title").css("display","block");
		$(".modal-addChatMember").css("display","block");
	})
	// 채팅 목록에서 검색 
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
	
	$(".deleteChatRoom").click(e => {
		let chatroomId = $(e.target).siblings()[3].value;
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
						} else {
							swal("삭제 실패")
						}
					}
				});
			});
	})
</script>
</body>
</html>






