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
		<c:if test="${empty chatroomList }">
			<div class="chat-room">
				<h3 class="title">참여 중인 채팅이 없습니다</h3>
			</div>
		</c:if>
		<c:if test="${not empty chatroomList }">
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
		</c:if>
	</div>
</div>
<script>
	let loginMember = '${loginMember.memberId}'
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
	function fn_viewChat(e){
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
		$(".chatRoom-container .chat-room-inner").append(msgBx);
		$(".chat-msgform").css("display","flex");
	}
	
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
	function fn_checkRoomId(roomId){
		if(fn_checkNull(roomId) == ""){
			$(".chat-room-inner").text("");
			$(".chatRoom-container .chat-header").text("");
			$(".chat-room-inner").append($("<h2>").text("선택된 채팅이 없습니다."));
			console.log(roomId);
		}
	}
	// 페이지 로딩 되면서 채팅목록 가져오기 -> promise / then 에 익숙하지 않아서 페이지를 로딩할 때 같이 Model에서 목록을 가져오는 방식으로 변경했다.
	/* $(document).ready(function(){
		$.ajax({
			url:"${path}/chat/",
			type:"post",
			success:data=>{
				fn_viewChatList(data);
			},fail:data=>{
				chatroomDiv.append($("<h5>").text("참여 중인 채팅이 없습니다."));
			}
		})
	}); */
	
	$(".chat-room").click(e=>{
		if($(e.target)==$(".chat-room")){
			//roomId = $(e.target).find($('input[type="hidden"]')).val();
			console.log($(e.target));
		}else {
			roomId = $(e.target).parent().find($('input[type="hidden"]')).val();
		}
		
		$.ajax({
			url:"${path}/chat/chatroom",
			type:"post",
			data: {
				chatroomId : roomId
			},
			success:data=>{
				console.log(data);
				data.forEach(e=>{
					console.log(e)
					var chat = (e.chat);
					chat.forEach(c=>{
						if(e.memberId==loginMember) {
							var chatMsg = $("<div>").attr("class","chat-msg chat-send");
							
						}else{
							var chatMsg = $("<div>").attr("class","chat-msg chat-send");
							chatMsg.append($("<h5>").text(e.memberName));
							
						}
							chatMsg.append($("<span>").attr("class","chat-date").text(c.chatDate));
							chatMsg.append($("<span>").attr("class","chat-msgbx").text(c.chatContent));
							$(".chatRoom-container .chat-room-inner").append(chatMsg);
							chatMsg.append($("<input>").attr("type","hidden").attr("value",e.chatroomId));
					})
				})
			}
		});
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
	
	function fn_exitCreateChat(){
		$(".modalNewChat").css("display","none");
	}
	
	// 채팅 목록에서 버튼 눌러서 채팅창 삭제 
	$(".deleteChatRoom").click(e =>{
		// 버튼 누르면 해당 채팅방 번호 가지고 와서 삭제하기 
		let chatroomId = $(e.target).siblings()[3].value;
		console.log(chatroomId);
		swal('채팅방 나가기', "한 번 나간 채팅방의 내용은 복구되지 않습니다", 'warning')
			.then(function(){
				location.href="${path}/chat/delete?chatroomId="+chatroomId;
			});
	})
	let deptName;
	let chatCode;
	let insertForm = $("<form class='insertChatroom'>");
	let chatDept = $("<div class='chat-dept'>");
	let chatmemberContainer;
	// 채팅 목록에서 채팅 추가 아이콘 클릭
	/* $(".addChatIcon").click(e => {
		$(".modal-add-chatContainer").css('display','block');
	})
	// 채팅 목록에서 채팅방 추가 닫기
	$(".modal-close").click(e =>{
		$(".modal-add-chatContainer").css('display','none');
	}) */
	// 1:1 채팅 만들기 선택 
	//$(".chatRoomPersonal").click(e =>{
	$(".addChatIcon").click(e => {
		let modalNewChatDiv = $(".modalNewChat");
		modalNewChatDiv.css("display","block");
		$("document").css("overflow","hidden");
		const header = $("<h3>").text("채팅 생성");
		const exit = $("<button onclick='fn_exitCreateChat()'>").text("X");
		modalNewChatDiv.append(header);
		modalNewChatDiv.append(exit);
		chatCode = 'P';
			
			// 부서 출력 
			const deptDiv = $("<form class='chat-DeptContainer'>");
			deptDiv.attr("method","post");
			deptDiv.attr("action","${path}/chat/insertChat");
			deptDiv.append($("<label>").attr("for","chatroomTitle").text("채팅 방 제목"));
			deptDiv.append($("<input type='text' name='chatroomTitle'>"));
			let deptArr = ['운영팀','취업팀','인사팀','경영팀','홍보팀','행정팀'];
			deptArr.forEach(e=>{
				chatDept = $("<div class='chat-dept'>")
				chatDept.append($("<h4 class='title'>").append($("<a class='chatDept'>").text(e)));
				deptDiv.append(chatDept);
				modalNewChatDiv.append(deptDiv);
			});
			
			// 부서명 누르면 해당 직원 출력
			$(".chat-dept").click(e => {
				deptName = $(e.target).text();
				let target = $(e.target);
				//console.log($(e.target));
				$.ajax({
					url:"${path}/chat/dept",
					type:"post",
					success:data=>{
						//console.log(data);
						var memberDiv = $("<div class='chat-memberByDept'>");
						data.forEach(e=>{
							var name = (e.dept.deptName);
							//console.log(code);
							if(name == deptName){
								console.log(deptName);
								console.log(e)
								if(e.memberId!=loginMember){
									memberDiv.append($("<label>").attr("for",e.memberId).text(e.memberName+ " "+e.job.jobName));
									memberDiv.append($("<input type='checkbox' name='memberId'>").attr("value",e.memberId));
									target.append(memberDiv);
								}
							}
						})
					}
				});
			})
			deptDiv.append($("<input type='submit' value='생성'>"));
		})
	/* $(".addChatIcon").click(e => {
		$(".chatRoom-container .chat-header").text("");
		$(".chatRoom-container .chat-room-inner").text("");
		const header = $("<h3>").text("채팅 생성");
		const exit = $("<button onclick='fn_exitCreateChat()'>").text("X");
		$(".chatRoom-container .chat-header").append(header);
		$(".chatRoom-container .chat-header").append(exit);
		chatCode = 'P';
		
		// 부서 출력 
		const deptDiv = $("<form class='chat-DeptContainer'>");
		deptDiv.attr("method","post");
		deptDiv.attr("action","${path}/chat/insertChat");
		deptDiv.append($("<label>").attr("for","chatroomTitle").text("채팅 방 제목"));
		deptDiv.append($("<input type='text' name='chatroomTitle'>"));
		let deptArr = ['운영팀','취업팀','인사팀','경영팀','홍보팀','행정팀'];
		deptArr.forEach(e=>{
			chatDept = $("<div class='chat-dept'>")
			chatDept.append($("<h4 class='title'>").append($("<a class='chatDept'>").text(e)));
			deptDiv.append(chatDept);
			$(".chatRoom-container .chat-room-inner").append(deptDiv);
		});
		
		// 부서명 누르면 해당 직원 출력
		$(".chat-dept").click(e => {
			deptName = $(e.target).text();
			let target = $(e.target);
			//console.log($(e.target));
			$.ajax({
				url:"${path}/chat/dept",
				type:"post",
				success:data=>{
					//console.log(data);
					var memberDiv = $("<div class='chat-memberByDept'>");
					data.forEach(e=>{
						var name = (e.dept.deptName);
						//console.log(code);
						if(name == deptName){
							console.log(deptName);
							console.log(e)
							if(e.memberId!=loginMember){
								memberDiv.append($("<label>").attr("for",e.memberId).text(e.memberName+ " "+e.job.jobName));
								memberDiv.append($("<input type='checkbox' name='memberId'>").attr("value",e.memberId));
								target.append(memberDiv);
							}
						}
					})
				}
			});
		})
		deptDiv.append($("<input type='submit' value='생성'>"));
	}) */
	
</script>
</body>
</html>






