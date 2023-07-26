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
		<div class="modal-searchContainer chat-room" style="display: none">
			<input type="search" name="searchChatList" placeholder="이름, 파일명 검색">
			<img src="${path}/resources/images/common/search.svg" alt="chat-search" class="searchChatIcon">
			<span class="search-close">X</span>
		</div>
		<!-- select 해서 가져오기 없으면 분기처리-->
		<div class="chat-room">
			<h5>이름</h5>
			<img src="${path}/resources/images/common/more.svg" alt="chat-delete" class="deleteChatRoom">
			<span>내용</span>
			<span>날짜</span>
			<input type="hidden" value="chatRoomNo" name="chatRoomNo">
		</div>
	</div>
</div>
<script>
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
	$(".searchChatIcon").click(e =>{
		const keyword = $(e.target).prev().val();
		console.log(keyword);
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
 	function viewMemberList(){
		$.ajax({
			url : '',
			dataType: '',
		})
	}
	
	// 1:1 채팅 만들기 선택 
	$(".chatRoomPersonal").click(e =>{
		const $chatRoomArea = $(".chatRoom-container");
		$chatRoomArea.html("");
		const header = $("<h3>").text("1:1대화");
		
		$(".chatRoom-container").append(header);
		
	})
	// 그룹 채팅 만들기 선택 
	
</script>
</body>
</html>