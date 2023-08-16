// 채팅방 아래 영역 
// 메세지 누르면 반응 
$(".chat-msgbx").click(e => {
	$(".chat-reaction").css('display', 'block');

})

// 채팅 목록에서 검색 아이콘 클릭 
$(".searchIcon").click(e => {
	$(".modal-searchContainer").toggle("chatHidden");
	$(".modal-result-container").toggle("chatHidden");
	$(".modalSearchInput").val("");
})

$(".searchChatroomIcon").click(e => {
	$(".modal-searchRoomContainer").toggle("chatHidden");
	$(".modal-result-container").toggle("chatHidden");
	$(".modal-searchRoomInput").val("");
})
// 채팅 목록에서 검색 닫기
$(".search-close").click(e => {
	$(".modal-searchContainer").css('display', 'none');
	
})

class Chat {
	constructor(chatroomId = "", memberId = "", chatContent = "", chatDate = "") {
		this.chatroomId = chatroomId;
		this.memberId = memberId;
		this.chatContent = chatContent;
		this.chatDate = chatDate;
	}
}

class Chatroom {
	constructor(chatroomId = "", chatroomCode = "", chatroomTitle = "", chatroomDate = "", memberId = "") {
		this.chatroomId = chatroomId;
		this.chatroomCode = chatroomCode;
		this.chatroomTitle = chatroomTitle;
		this.chatroomDate = chatroomDate;
		this.memberId = memberId;
	}
}

$(document).on("click", ".modal-view-chatMemberProfile .modal-close", function(e) {
	$(".modal-view-chatMemberProfile").css("display","none");
});
