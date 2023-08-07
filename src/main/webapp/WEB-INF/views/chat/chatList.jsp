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
					<c:forEach var="c" items="${chat}">
						<c:if test="${r.chatroomId == c.chatroomId}">
							<span>${c.chatContent}</span>
							<span>${c.chatDate}</span>
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
	let chatroomHeader = $(".chatRoom-container .chat-header .title");
	
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
	const checkId = $(".chat-msg-Id").length;
	let adsgd = document.querySelector(".chat-msg-Id");
	var chatMsg;
	const fn_openChatroom=()=>{
		$.ajax({
			url: "${path}/chat/chatroom",
			//type:"post",
			type: "get",
			data: {
				chatroomId: chatroomId
			},
			/* beforeSend: data => { // ajax 통신 시작 전
				alert("gg");
				console.log("chatroomid :" , chatroomId);
			}, */
			success: data => {
				console.log(data);
				fn_viewChatMsg(data);
			}
		});
	}
	
	const fn_viewChatMsg=(data)=>{
		data.forEach(e => {
			$(".chatRoom-container .chat-header .title").text(e.chatroomTitle)
;			let divPrevChat = $("<div>").attr("class","prev-chat");
			if(chatroomId!=null && chatroomId==e.chatroomId){
				console.log("e =", e);
				$(".chatRoom-container .chat-header .chat-icon-container").css("display","flex");
				if(e.chatroomCode =="P") {
					$(".addPersonIcon").attr("class","chatHidden");
				}
				$(".chat-input-container").css("display","flex");
				$(".chat-room-nothing").attr("class","chatHidden");
				var chat = (e.chat);
				
				chat.forEach(c => {
					
					if (c.memberId == loginMember) {
						var chatMsg = $("<div>").attr("class", "chat-msg chat-send");
						chatMsg.append($("<span>").attr("class", "chat-date").text(c.chatDate));
						chatMsg.append($("<span>").attr("class", "chat-msgbx").text(c.chatContent));
						chatMsg.append($("<input type='hidden'>").attr("value",c.chatId).attr("class","chat-msg-Id"));

					} else {
						var chatMsg = $("<div>").attr("class", "chat-msg");
						chatMsg.append($("<h5>").append($("<a>").text(c.memberId).attr("class",c.memberId)));
						chatMsg.append($("<span>").attr("class", "chat-msgbx").text(c.chatContent));
						chatMsg.append($("<span>").attr("class", "chat-date").text(c.chatDate));
						chatMsg.append($("<input type='hidden'>").attr("value",c.chatId).attr("class","chat-msg-Id"));
					}
					chatMsg.append($("<input>").attr("type", "hidden").attr("value", e.chatroomId).attr("class","roomId"));
					divPrevChat.append(chatMsg);
				})
				$(".chatRoom-container .chat-room-inner .chat-msgBox-container").append(divPrevChat);
				
			}
		}) 
	}
	$(".chat-room").click(e => {
		if ($(e.target) == $(".chat-room")) {
			//roomId = $(e.target).find($('input[type="hidden"]')).val();
			console.log($(e.target));
		} else {
			chatroomId = $(e.target).parent().find($('input[type="hidden"]')).val();
			console.log(chatroomId);
		}
		$(".chat-msgBox-container").empty();
		fn_openChatroom();
		/* $.ajax({
			url: "${path}/chat/chatroom",
			//type:"post",
			type: "get",
			data: {
				chatroomId: roomId
			}
			,success: data => {
				console.log(data);
				data.forEach(e => {
					//open("${path}/chat/chattingpage","_blank","width:400","height:500");
					//location.assign("${path}/chat/chatting?id=" + e.chatroomId);
					console.log("e =", e);
					$(".chatRoom-container .chat-header .title").text(e.chatroomTitle);
					$(".chatRoom-container .chat-header .chat-icon-container").css("display","flex");
					if(e.chatroomCode =="P") {
						$(".addPersonIcon").attr("class","chatHidden");
					}
					$(".chat-input-container").css("display","flex");
					$(".chat-room-nothing").attr("class","chatHidden");
					var chat = (e.chat);
					let divPrevChat = $("<div>").attr("class","prev-chat");
					
					chat.forEach(c => {
						if (c.memberId == loginMember) {
							var chatMsg = $("<div>").attr("class", "chat-msg chat-send");
							chatMsg.append($("<span>").attr("class", "chat-date").text(c.chatDate));
							chatMsg.append($("<span>").attr("class", "chat-msgbx").text(c.chatContent));
	
						} else {
							var chatMsg = $("<div>").attr("class", "chat-msg");
							chatMsg.append($("<h5>").text(c.memberId));
							chatMsg.append($("<span>").attr("class", "chat-msgbx").text(c.chatContent));
							chatMsg.append($("<span>").attr("class", "chat-date").text(c.chatDate));
	
						}
						chatMsg.append($("<input>").attr("type", "hidden").attr("value", e.chatroomId).attr("class","roomId"));
						divPrevChat.append(chatMsg);
					})
					$(".chatRoom-container .chat-room-inner").append(divPrevChat);
				}) 
			}
		}); */
	})
	
	
	/* $(document).on("click",".startChat",function(e){
		//alert("sgsd");
		let target = e.target;
		let id = target.previousElementSibling.previousElementSibling.lastChild.value;
		console.log(id);
		location.href="${path}/chat/chatting";
	}); */
	
	function fn_exitCreateChat() {
		$(".modalNewChat").css("display", "none");
	}
	
	// 채팅 목록에서 버튼 눌러서 채팅창 삭제 
	$(".deleteChatRoom").click(e => {
		// 버튼 누르면 해당 채팅방 번호 가지고 와서 삭제하기 
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
	
	
	let deptName;
	let chatCode;
	let insertForm = $("<form class='insertChatroom'>");
	let chatDept = $("<div class='chat-dept'>");
	let chatmemberContainer;
	
	// 채팅 추가
	$(".addChatIcon").click(e => {
		$(".chat-room-nothing").attr("class","chatHidden");
		chatroomHeader.text("채팅 생성");
		let modalNewChatDiv = $(".modalNewChat");
		//$(document).css("overflow","auto");
		//$(".chatRoom-container *").css('display','none');
		/* modalNewChatDiv.css("display", "block");
		const header = $("<h3>").text("채팅 생성");
		const exit = $("<button onclick='fn_exitCreateChat()'>").text("X");
		modalNewChatDiv.append(header);
		modalNewChatDiv.append(exit); */
		chatCode = 'P';
		
		open("${path}/chat/modalMember","_blank","width=600,height=600");
		
	
		// 부서명 누르면 해당 직원 출력
		$(".chat-dept").click(e => {
			deptName = $(e.target).text();
			let target = $(e.target);
			//console.log($(e.target));
			$.ajax({
				url: "${path}/chat/dept",
				type: "post",
				success: data => {
					//console.log(data);
					var memberDiv = $("<div class='chat-memberByDept'>");
					data.forEach(e => {
						var name = (e.dept.deptName);
						//console.log(code);
						if (name == deptName) {
							console.log(deptName);
							console.log(e)
							if (e.memberId != loginMember) {
								memberDiv.append($("<label>").attr("for", e.memberId).text(e.memberName + " " + e.job.jobName));
								memberDiv.append($("<input type='checkbox' name='memberId'>").attr("value", e.memberId));
								target.append(memberDiv);
							}
						}
					})
				}
			});
		})
		deptDiv.append($("<input type='submit' value='생성'>"));
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
				fn_viewChatList(data);
			}
		});
	})
</script>
</body>
</html>






