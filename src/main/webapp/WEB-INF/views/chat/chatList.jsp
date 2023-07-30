<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>                            
<c:set var="path" value="${pageContext.request.contextPath }"/>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<div class="chatList-container section-shadow">
	<div class="chat-header">
		<h2>채팅</h2>
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
		<!-- <div class="chat-room"></div> -->
		<%-- <c:if test="${not empty chatroomList }">
			<c:forEach var="c" items="${chatroomList }">
				<div class="chat-room">
					<h5>${c.chatroomTitle }</h5>
					<img src="${path}/resources/images/common/more.svg" alt="chat-delete" class="deleteChatRoom">
					<c:forEach var="cc" items="${c.chat }">
						<span>${cc.chatContent}</span>
						<span>${cc.chatDate}</span>
					</c:forEach>
					<input type="hidden" value="${c.chatroomId}" name="chatRoomId">
				</div>
			</c:forEach>
		</c:if> --%>
	</div>
</div>
<script>
	let chatroomContainer = $(".chat-room-list");
	// null값 체크하는 함수 
	function fn_checkNull(str){
		let newStr = str;
		if(newStr == null || newStr == "" || newStr == undefined || newStr == "undefined"){
			newStr = "";
		}
		return newStr;
	}
	
	// 채팅 메세지 채팅 창에 뿌리기
	function fn_viewChat(data){
		const msgBx = $("<div class='chat-msg'>");
		let chatHeader = $(".chatRoom-container .chat-header h3");
		chatHeader.text(e.memberId);
		$(".chat-room-inner h2").text("");
		$(".chat-icon-container").css("display","flex");
		if(e.memberId == loginMember){
			msgBx.attr("class","chat-msg chat-send");
			msgBx.append($("<span>").attr("class","chat-date").text(e.chatDate));
			msgBx.append($("<span>").attr("class","chat-msgbx").text(e.chatContent));
		}else{
			msgBx.append($("<h5>").text(e.memberId));
			msgBx.append($("<span>").attr("class","chat-msgbx").text(e.chatContent));
			msgBx.append($("<span>").attr("class","chat-date").text(e.chatDate));
			
		}
		$(".chat-room-inner").append(msgBx);
		$(".chat-msgform").css("display","flex");
	}
	
	// 채팅 목록을 로딩하면서 가져와서 jsp에서 뿌리면 -> 해당 채팅창 선택하는 함수 사용 가능 / 검색한 것에 대한 분기처리를 jsp에서 해야할 것 같음 
	// ajax로 구현하면 불가능 ㅜ ... 
	// 채팅 목록에 데이터 뿌리기
	function fn_viewChatList(data){
		console.log(data);
		data.forEach(e=>{
			console.log(e);
			let chatroomDiv = $("<div>").attr("class","chat-room");
			chatroomDiv.append($("<h5>").text(e.chatroomTitle));
			var chat = (e.chat);
			chat.forEach(c=>{
				chatroomDiv.append($("<span>").text(c.chatContent));
				chatroomDiv.append($("<span>").text(c.chatDate));
			})
			chatroomDiv.append($("<input>").attr("type","hidden").attr("value",e.chatroomId));
			chatroomContainer.append(chatroomDiv);
		})
	}
	// 채팅 목록에서 채팅 선택하면 해당 채팅방 접속하기 
	let roomId="";
	let loginMember;
	loginMember = '2023072796';
	function fn_checkRoomId(roomId){
		if(fn_checkNull(roomId) == ""){
			$(".chat-room-inner").text("");
			$(".chatRoom-container .chat-header").text("");
			$(".chat-room-inner").append($("<h2>").text("선택된 채팅이 없습니다."));
			console.log(roomId);
		}
	}
	// 페이지 로딩 되면서 채팅목록 가져오기 	
	$(document).ready(function(){
		new Promise((succ, fail)=>{
			$.ajax({
				url:"${path}/chat/",
				type:"post",
				success:data=>{
					/* console.log(data); */
					fn_viewChatList(data);
				},fail:data=>{
					chatroomDiv.append($("<h5>").text("참여 중인 채팅이 없습니다."));
				}
			}).then((arg) => {
				$.ajax({
					url:"${path}/chat/chatroom",
					type:"post",
					data: {
						chatroomId : roomId
					},
					success:data=>{
						console.log(data);
						data.forEach(e=>{
							fn_viewChat(data);
						})
					}
				});	 
			})
			
		})
	});
	
	$(".chat-room").click(e=>{
		if($(e.target)==$(".chat-room")){
			//roomId = $(e.target).find($('input[type="hidden"]')).val();
			console.log($(e.target));
		}else {
			roomId = $(e.target).parent().find($('input[type="hidden"]')).val();
		}
		console.log(roomId);
		
		/* $.ajax({
			url:"${path}/chat/chatroom",
			type:"post",
			data: {
				chatroomId : roomId
			},
			success:data=>{
				console.log(data);
				data.forEach(e=>{
					fn_viewChat(data);
				})
			}
		});	 */
	})
	
	/* const websocket=new WebSocket("ws://localhost:8080/chatting");
		websocket.onopen=data=>{
			console.log(data);
	} */
	
	// 채팅 목록에서 채팅 추가 아이콘 클릭
	$(".addChatIcon").click(e => {
		$(".modal-add-chatContainer").css('display','block');
	})
	// 채팅 목록에서 채팅방 추가 닫기
	$(".modal-close").click(e =>{
		$(".modal-add-chatContainer").css('display','none');
	})
	
	// 채팅 목록에서 검색 아이콘 클릭 
	$(".searchIcon").click(e => {
		$(".modal-searchContainer").css('display','block');
		
	})
	// 채팅 목록에서 검색 닫기
	$(".search-close").click(e =>{
		$(".modal-searchContainer").css('display','none');
				
	})
	
	// 채팅 목록에서 검색 
	$(".modalSearchAllIcon").click(e =>{
		const keyword = $(e.target).prev().val();
		console.log(keyword);
		
		$.ajax({
			url:"${path}/chat/keyword",
			type:"post",
			data: {
				keyword : keyword
			},
			success:data=>{
				console.log(data);
				fn_viewChatList(data);
				/* let chatroom = $(".chat-room");
				chatroom.text("");
				data.forEach(e=>{
					chatroom.append($("<h5>").text(e.chatroomTitle));
					var chat = (e.chat)
					chat.forEach(c=>{
						chatroom.append($("<span>").text(c.chatContent));
						chatroom.append($("<span>").text(c.chatDate));
					})
					chatroom.append($("<input>").attr("type","hidden").attr("value",e.chatroomId));
				}) */
			}
		});
	})
	
	// 채팅 목록에서 버튼 눌러서 채팅창 삭제 
	$(".deleteChatRoom").click(e =>{
		// 버튼 누르면 해당 채팅방 번호 가지고 와서 삭제하기 
		let chatRoomNo = $(e.target).siblings()[3].value;
		console.log(chatRoomNo);
		swal('채팅방 나가기', "한 번 나간 채팅방의 내용은 복구되지 않습니다", 'warning')
		.then(function(){
			location.href="/";
		});
	})
	
	// 조직도 보기 
 	function fn_viewMemberList(){
		$.ajax({
			url : '',
			dataType: '',
		})
	}
	
	// 1:1 채팅 만들기 선택 
	$(".chatRoomPersonal").click(e =>{
		$(".chatRoom-container .chat-header").text("");
		$(".chatRoom-container .chat-room-inner").text("");
		const header = $("<h3>").text("1:1대화");
		$(".chatRoom-container .chat-header").append(header);
		/* $.get("${pageContext.request.contextPath}/chat/dept",data=>{
			console.log(data);
			
		}); */
		const deptArr= ['운영팀', '행정팀', '인사팀', '경영팀', '홍보팀'];
		const deptUl = $("<ul class='chatDeptAll'>");
		deptArr.forEach(e=>{
			let dept= $("<li>");
			dept.append($("<a class='chatDept'>").text(e));
			deptUl.append(dept);
		})
		$(".chatRoom-container .chat-room-inner").append(deptUl);
	})
	$(".chatDept").click(e =>{
		alert("sgkj;aksdjg");
	})
	
	
	// 그룹 채팅 만들기 선택 
	
</script>
</body>
</html>






