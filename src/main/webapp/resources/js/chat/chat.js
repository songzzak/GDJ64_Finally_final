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

$(document).on("click", ".chatMember", function(e) {
	console.log("sgkasjdkgj;alksg" + $(e.target).text());
	console.log("sdgasdg : sdg " + $(e.target).next().val());
	
	$(".modal-chat-member").empty();
	memberId = $(e.target).next().val();
	$(".modal-view-chatMemberProfile").css("display","block");
	$.ajax({
		url : cPath+"/chatroom/profile",
		type : "POST",
		data : {
			memberId : memberId
		},
		success : data =>{
			console.log(data);
			let modalchatmemberDiv = $("<div class='modal-chat-member'>");
			modalchatmemberDiv.append($("<img>").attr("src",cPath+"/resources/upload/profile/"+data.profileImg));
			modalchatmemberDiv.append($("<h5>").text(data.dept.deptName+" "+data.memberName+" "+data.job.jobName));
			let $table = $("<table class='modal-table'>");
			$table.append($("<tr>").append($("<th>").text("phone")).append($("<td>").text(data.phone)));
			$table.append($("<tr>").append($("<th>").text("address")).append($("<td>").text(data.address)));
			$table.append($("<tr>").append($("<th>").text("email")).append($("<td>").text(data.email)));
			$table.append($("<tr>").append($("<th>").text("입사일")).append($("<td>").text(data.hireDate)));
			modalchatmemberDiv.append($table);
			$(".modal-content").append(modalchatmemberDiv);
		},
		error: function(xhr, status, error) {
			console.error('AJAX Error:', error);
		}
	})
});

$(document).on("click", ".modal-view-chatMemberProfile .modal-close", function(e) {
	$(".modal-view-chatMemberProfile").css("display","none");
});
