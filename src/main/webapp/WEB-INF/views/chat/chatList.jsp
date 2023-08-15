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
		<div class="modal-chat section-shadow modal-add-chatContainer chatHidden">
			<div class="modal-content modal-add-chat">
				<div class="modal-close">X</div>
				<h4 class="chatRoomPersonal">1:1 채팅</h4>
				<h4 class="chatRoomGroup">그룹 채팅</h4>
			</div>
		</div>
		<div class="modal-searchContainer chatHidden">
			<input type="search" name="searchChatList" placeholder="이름, 파일명 검색">
			<img src="${path}/resources/images/common/search.svg" alt="chat-search" class="modalSearchAllIcon">
			<!-- <span class="search-close">X</span> -->
		</div>
		<c:if test="${empty myChatroomList}">
			<div class="chat-room">
				<h3 class="title">참여 중인 채팅이 없습니다</h3>
			</div>
		</c:if>
		<c:if test="${not empty myChatroomList}">
			<c:forEach var="r" items="${myChatroomList}">
				<!-- <div class="chat-room chat-select"> -->
				<div class="chat-room chat-select" data-Id="${r.chatroom.chatroomId}" data-no="${r.myChatroomNo}">
					<h5 class="chatroom-title chat-select">${r.chatroom.chatroomTitle }</h5>
					<img src="${path}/resources/images/common/more.svg" alt="chat-delete" class="deleteChatRoom">
					<h5>${r.myChatroomNo}</h5>
					<c:if test="${not empty unreadMap }">
						<c:forEach var="unread" items="${unreadMap}">
							 <c:if test="${r.myChatroomNo == unread.myChatroomNo && unread.readCount!=0}">
								<span class="chatroomNotifyNumber">${unread.readCount}</span>
							</c:if>
							<input type="hidden" value="${unread.myChatroomNo}" name="myChatroomNo" class="myChatroomNo">
						</c:forEach>
					</c:if>
					<input type="hidden" value="${r.chatroom.chatroomId}" name="chatRoomId" class="roomId">
					<c:forEach var="c" items="${chat}">
						<c:if test="${r.chatroom.chatroomId == c.chatroomId}">
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
<div class="searchResultContainer"></div>
<script>
	//페이지 로드 후 제일 아래로 스크롤 자동 이동
	window.onload = function() {
	    var contentContainer = document.querySelector('.chat-room-inner'); // 컨텐츠가 들어가는 컨테이너 요소
	    contentContainer.scrollTop = contentContainer.scrollHeight;
	    fn_updateChatNotify();
	};
	
	let chatroomId= '${chatroomId}';
	let loginMember = '${loginMember.memberId}';
	console.log(loginMember);
	let chatroomContainer = $(".chat-room-list");
	let chatroomTitle;
	let myChatroomNo;
	var readCount;
	$(".chat-room").click(function() {
		var clickedDiv = $(this);
		
		chatroomId = clickedDiv.data("id"); 
		myChatroomNo = clickedDiv.data("no");
		
		console.log("data roomid : " + chatroomId );
		console.log("data roomNo : " + myChatroomNo );
		$(".chat-msgBox-container").empty();
		console.log("readCount : "+ readCount);
		fn_openChatroom();
	 });
	var chatMsg;
	
	const fn_openChatroom=()=>{
		console.log("fn_openchatroom start");
		console.log(chatroomId);
		$(".prev-chat").empty();
		$.ajax({
			url: "${path}/chat/chatroom/"+chatroomId,
			type: "post",
			data: {
				chatroomId: chatroomId,
				myChatroomNo : myChatroomNo
			},
			success: data => {
				console.log("open chatroom success");
				console.log("open chat : " + data);
				fn_viewChatMsg(data);
				fn_startChat();
				fn_updateChatNotify();
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
	let chatroomMemberName="";
	
	const fn_viewChatMsg=(data)=>{
		console.log("data : ",data);
		let chatroomMember = data.chatroomMember;
		
		chatroomFiles = data.chatroomFile;
		console.log("chatroomFiles : ", chatroomFiles);
		chatroomMembers= [];
		chatroomMember.forEach(cm =>{
			chatroomMembers.push(cm.member.memberId);
			chatroomMemberName += cm.member.memberName+", ";
		})
		if(data!=null || data!="") {
			$(".chat-room-nothing").addClass("chatHidden");
			$(".chat-input-container").css("display","flex");
		}
		console.log(chatroomMemberName);
		let currentChatroom = data.chatroomList;
		$(".chatRoom-container .chat-header .title").text(data.chatroomTitle);
		if(data.chatroomList=="" || data.chatroomList==null){
			$(".chatRoom-container .chat-header .chat-icon-container").css("display","flex");
			$(".chatRoom-container .chat-header .title").text(chatroomTitle);
		}
		divPrevChat = $("<div>").attr("class","prev-chat");
		currentChatroom.forEach(e => {
			if(chatroomId!=null && chatroomId==e.chatroomId){
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
						chatMsg.append($("<span>").attr("class", "chat-msgbx").text(c.chatContent));
						chatMsg.append($("<span>").attr("class", "chat-date block").text(chatDate));
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
				$(".chat-room-nothing").addClass("chatHidden");
				fn_viewSearchResult(data);
			}
		});
	})
	
	var formData = new FormData();
	
	
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
							fn_closeChatModal();
							location.href = location.href;
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
</script>
</body>
</html>
