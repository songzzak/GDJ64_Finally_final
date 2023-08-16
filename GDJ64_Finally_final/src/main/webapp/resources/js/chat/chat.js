$(".searchChatIcon").click(e => {
	$(".modal-searchRoomContainer").css("display", "block");
})

// 채팅방 아래 영역 
// 메세지 누르면 반응 
$(".chat-msgbx").click(e => {
	$(".chat-reaction").css('display', 'block');

})


// 채팅 목록에서 검색 아이콘 클릭 
$(".searchIcon").click(e => {
	$(".modal-searchContainer").css('display', 'block');

})
// 채팅 목록에서 검색 닫기
$(".search-close").click(e => {
	$(".modal-searchContainer").css('display', 'none');

})



