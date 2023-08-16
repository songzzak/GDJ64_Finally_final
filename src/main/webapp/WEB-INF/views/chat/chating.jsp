<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>                            
 <c:set var="path" value="${pageContext.request.contextPath }"/>     
<link rel="stylesheet" href="${path}/resources/css/common/common.css">
<link rel="stylesheet" href="${path}/resources/css/chat/chat.css">
<div class="modal-addChatMember chatHidden scroll chatmodal">
	<div class="modal-content section-shadow">
		<h2 class="title">채팅 멤버 선택</h2>
		<!-- <span class="modal-close">X</span> -->
		<div class="chat-DeptContainer">
			<div class="modal-new-chat-title chatHidden">
				<label for="chatroomTitle">채팅 제목 : </label><input type="text" name="chatroomTitle" placeholder="채팅 제목"><br>
				<span>채팅 제목 미 설정 시 채팅 멤버 아이디, 채팅 참여 멤버 수로 설정됩니다</span>
			</div>
			<c:if test="${not empty dept && not empty members}">
				<c:forEach var="dept" items="${dept}">
					<div class="dept-list-container section-shadow">
						<h4 class="dept-title"><c:out value="${dept.deptName}"/></h4>
						<form class="modal-memberList chatHidden">
							<c:forEach var="member" items="${members }">
								<c:if test="${dept.deptCode == member.dept.deptCode && member.memberId!=loginMember.memberId}">
									<label for="memberId"><input type="checkbox" name="memberId" value="${member.memberId }"><span><c:out value="${member.memberName }"/></span><c:out value="${member.job.jobName }"/></label>
								</c:if>
							</c:forEach>
						</form>
					</div>
				</c:forEach>
				<button class="modal-chat-btn">채팅 시작</button>
				<button class="modal-close">닫기</button>
			</c:if>
		</div>
	</div>
</div>
<div class="modal-updateChat chatHidden scroll chatmodal">
	<div class="modal-content section-shadow">
		<span class="modal-close">X</span>
		<h2 class="title">채팅 멤버 선택</h2>
		<div class="chat-DeptContainer">
			<div class="modal-new-chat-title chatHidden">
				<label for="chatroomTitle">채팅 제목 : </label><input type="text" name="chatroomTitle" placeholder="채팅 제목"><br>
			</div>
			<div class="currentChatMember"></div>
			<c:if test="${not empty dept && not empty members}">
				<c:forEach var="dept" items="${dept}">
					<div class="dept-list-container section-shadow">
						<h4 class="dept-title"><c:out value="${dept.deptName}"/></h4>
						<form class="modal-memberList chatHidden">
							<c:forEach var="member" items="${members }">
								<c:if test="${dept.deptCode == member.dept.deptCode && member.memberId!=loginMember.memberId}">
									<label for="memberId"><input type="checkbox" name="memberId" value="${member.memberId }"><span><c:out value="${member.memberName }"/></span><c:out value="${member.job.jobName }"/></label>
								</c:if>
							</c:forEach>
						</form>
					</div>
				</c:forEach>
				<button class="modal-update-chat-btn">변경</button>
				<button class="modal-cancle-btn" onclick="fn_closeChatModal();">변경 취소</button>
			</c:if>
		</div>
	</div>
</div>
<div class="chatRoom-container section-shadow">
	<div class="chat-header">
		<div class="title-container">
			<h3 class="title"></h3>
			<span class="chat-member"></span>
		</div>
		<div class="chat-icon-container chatHidden">
			<img src="${path}/resources/images/common/search.svg" alt="chat-search" class="searchChatroomIcon">
			<img src="${path}/resources/images/common/attach.svg" alt="chat-attach" class="attachChatIcon">
			<img src="${path}/resources/images/chat/addPerson.svg" alt="chat-addPerson" class="addPersonIcon">
			<%-- <img src="${path}/resources/images/common/setting.svg" alt="chat-setting" class="settingIcon"> --%>
		</div>
	</div>
	<div class="chat-room-inner">
		<div class="modalNewChat section-shadow chatHidden"></div>
		<div class="chat-room-nothing">
			<img src="${path}/resources/images/common/workit.svg">
			<h2 class="title">선택한 채팅이 없습니다</h2>
		</div>
		<div class="modal-searchRoomContainer chatHidden">
			<input type="search" name="searchChatRoomList" class="modal-searchRoomInput" placeholder="검색">
			<img src="${path}/resources/images/common/search.svg" alt="chat-search" class="modalChatSearchIcon">
			<!-- <span class="search-close">X</span> -->
		</div>
		<div class="modal-result-container chatHidden"></div>
		<div class="chat-msgBox-container scroll"></div>
	</div>
	<div class="chat-input-container chatHidden">
		<form action="" class="chat-fileform" method="post" enctype="multipart/form-data">
			<input type="file" name="uploadFile" multiple class="chat-upFile chatHidden">
			<img src="${path}/resources/images/common/attach.svg" alt="uploadIcon" class="chat-fileIcon"/>
			<input type="hidden" name="chatroomId"/>
		</form>
		<input type="text" name="chat-msg" class="chat-msg-input">
		<button class="sendChat">send</button>
	</div>
</div>
<script>
const cPath = '${path}'; 
/* 	setTimeout(function() {
		window.scrollTo(0, $(document).height());//스크롤 맨아래로
	}, 50); */
	$(".chat-msgBox-container").scroll(function(){
		var scrollTop = $(this).scrollTop();
		console.log("scrollTop : " + scrollTop);
			
		var innerHeight = $(this).innerHeight();
		console.log("innerHeight : " + innerHeight);
		var scrollHeight = $(this).prop('scrollHeight');
		console.log("scrollHeight : " + scrollHeight);
		if(scrollTop + innerHeight < scrollHeight) {
			$(".chat-msgBox-container").scrollTop(scrollHeight);
		}
		/* if(scrollTop + innerHeight <= scrollHeight){
			//$(".chat-msgBox-container").scrollTop == scrollHeight;
			document.body.scrollTop = document.body.scrollHeight;
		} */
	});
	
/* 	function prepareScroll() {
		window.setTimeout(fn_chatScroll, 50);
	}
	
	function fn_chatScroll() {
		let chatMsgBox = $(".chat-msgBox-container");
		let msgBox = $(".prev-chat");
		//chatMsgBox.scrollTop = chatMsgBox.scrollHeight;
		msgBox.scrollTop = msgBox.scrollHeight;
	}
	
	function move_to_page(){
        setTimeout(function() {
        	//let chatMsgBox = $(".chat-msgBox-container");
        	let chatMsgBox = document.querySelector("chat-msgBox-container").offsetTop;
        	console.log(document.querySelector("chat-msgBox-container"));
        	let chatMsgBox = $(".chat-msgBox-container");
        	chatMsgBox.scrollTop = chatMsgBox.scrollHeight;
            //var PageLocation = document.querySelector(moveto).offsetTop;
          //window.scrollTo({top: PageLocation, behavior: 'smooth'});
        }, 50);
      } */
	
	$(".addPersonIcon").click(e=>{
		console.log("chatroomMemberName : ", chatroomMemberName);
		$(".modal-updateChat").css("display","block");
		$(document).attr("overflow","hidden");
		$(".modal-addChatMember").add("chatHidden");
		$(".currentChatMember").text("현재 채팅 참여 멤버 : "+chatroomMemberName);
	})
	var idx= 0;
	const fn_fileSend=()=>{
		console.log("id :",chatroomId);
		var files = document.querySelector(".chat-upFile").files;
		//var originalFile = document.querySelector(".chat-upFile").files[0].name;
		var originalFile;
		if(files!=null || files!=""){
			for(let i = 0; i<files.length; i++){
				console.log(files[i].name);
				originalFile = files[i].name;
				websocket.send(JSON.stringify(new Chat("file", loginMember, originalFile, today))); 
			}
		}
	}
	$(".chat-fileIcon").click(e=>{
		$(".chat-upFile").click();
	});
	var formData = new FormData();
	$(".chat-upFile").change(e=>{
		let files = document.querySelector(".chat-upFile").files[0];
		console.log("files ",files);
		formData.append("chatroomId",chatroomId);
		formData.append("files",files);
		
		$.ajax({
			url : "${path}/chatroom/upload",
			data : formData,
			type : "post",
			async : true,
			enctype : "multipart/form-data",
			processData : false, // false해야 form data 인식함 
			contentType : false,
			success : data =>{
				console.log(data);
				fn_fileSend();
			},
			error: function(xhr, status, error) {
		        console.error('AJAX Error:', error);
		    }
		});
	});
	
	
	const fn_closeChatModal=()=>{
		$(".modal-addChatMember").css("display","none");
		$(".modal-updateChat").css("display","none");
	};
	
	$(".modal-close").click(e=>{
		fn_closeChatModal();
	});
	
	$(".modal-update-chat-btn").click(e=>{
		let selectedMember = $(".modal-memberList input:checked");
		let chatroomTitle = selectedMember.next().text();
		
		if(selectedMember.length>0){
			chatMember = selectedMember.val();
			$.ajax({
				url: "${path}/chatroom/update",
				type: "post",
				data:{
					chatroomId : chatroomId,
					chatMember : chatMember,
					chatroomTitle : chatroomTitle
				},
				success: data => {
					console.log(data);
					if(data>0){
						alert("채팅 멤버 초대에 성공했습니다 :)");
						fn_closeChatModal();
						fn_openChatroom();
					}else{
						alert("채팅 멤버 초대에 실패했습니다 ;<");
						fn_closeChatModal();
					}
				},
				error: function(xhr, status, error) {
			        console.error('AJAX Error:', error);
			    }
			});
		}else if((chatroomTitle=="" || chatroomTitle==null || chatroomTitle=="null") && (selectedMember ==null && selectedMember=="")){
			alert("선택된 멤버가 없습니다.")
		}
	})
	
	
	var chatMember="";
	$(".modal-chat-btn").click(e=>{
		var chatroomCode;
		let chatroomTitle;
		let selectedMember = $(".modal-memberList input:checked");
		if($("input[name=chatroomTitle]").val()==null ||$("input[name=chatroomTitle]").val()==""){
			console.log("제목없음 : ",selectedMember.next().text());
			chatroomTitle = "그룹채팅 "+selectedMember.next().text()+" ("+(selectedMember.length+1)+")";
		}else{
			chatroomTitle = $("input[name=chatroomTitle]").val();
		}
		var newChatroom;
		if(selectedMember.length==1){
			chatMember = selectedMember.val();
			newChatroom = new Chatroom("", 'P', chatroomTitle, "", chatMember);
		}else{
			for(let i=0;i<selectedMember.length;i++){
				console.log(i,selectedMember[i].value);
				chatMember+=selectedMember[i].value+",";
			}
			chatMember = chatMember.slice(0, -1);
			newChatroom = new Chatroom("", 'G', chatroomTitle, "", chatMember);
		}
		if(chatMember==null || chatMember==""){
			alert("선택한 채팅 멤버가 없습니다 다시 선택해주세요");
		}else if(chatMember!=null && chatMember!=""){
			$.ajax({
				url: "${path}/chat/insert",
				type: "post",
				data:JSON.stringify(newChatroom),
				contentType:"application/json;charset=utf-8",
				success: data => {
					console.log("insert Data ",data);
					fn_closeChatModal();
					var chatroomTitle; 
					data.forEach(d=>{
						console.log("dsgd", d);
						chatroomTitle = d.chatroom.chatroomTitle;
					})
					let chatDiv = $("<div class='chat-room chat-select'>");
					chatDiv.append($("<h5 class='chatroom-title chat-select'>").text(chatroomTitle));
					chatDiv.append($("<img class='deleteChatroom'>").attr("src","${path}/resources/images/common/more.svg").attr("alt","chat-delete"));
					swal('새로운 채팅 생성', "채팅 방이 생성 되었습니다.", 'success')
					.then(function() {
						location.href = location.href;
					});
				},
				error: function(xhr, status, error) {
			        console.error('AJAX Error:', error);
			    }
			});
		}
	});
	
	$(".dept-title").click(e=>{
		console.log($(e.target));
		$(e.target).next().toggle();
	})

	let sendDate = new Date();
	const timeElapsed = Date.now();
	const today = new Date(timeElapsed);
	
	const fn_viewMember=()=>{
		if(chatroomMembers==null ||chatroomMembers==""){
			chatroomId;
			$(".modal-new-chat-title").css("display","block");
			$(".chat-DeptContaine").attr("action","${path}/chat/start");
		}else{
			$(".chat-DeptContainer").attr("action","${path}/chat/");
		}
		$.ajax({
			url: "${path}/chat/member",
			type: "post",
			data: {
				chatroomId: chatroomId
			}
			,success: data => {
				console.log("chatroomMembers : "+" "+chatroomMembers);
				console.log("member add");
				console.log(data);
				var memberDiv = $("<div class='chat-memberByDept'>");
				data.forEach(e =>{
					if(e.memberId!=loginMember){
					var inputDiv = $("<div class='dept-member-input'>");
					inputDiv.append("<label>").attr("for", e.memberId).text(e.memberName + " " + e.job.jobName);
					inputDiv.append($("<input type='checkbox' name='memberId'>").attr("value", e.memberId));
					inputDiv.append($("<br>"));
					memberDiv.append(inputDiv);
					$(".chat-DeptContainer").append(memberDiv);
					}
				})
				$(".chat-DeptContainer").append($("<input type='submit' value='선택'>"));
			},
			error: function(xhr, status, error) {
		        console.error('AJAX Error:', error);
		    }	
		});
	}
	$(".addPersonIcon").click(e => {
		$(".chat-room-nothing").attr("class","chatHidden");
		$(".modal-addChatMember").css("display","block");
		let input = $(".modal-memberList input[name=memberId]");
		let inputArr = Object.values(input);
		var cMember="";
		inputArr.forEach(a=>{
			if(chatroomMembers!=null){
				chatroomMembers.forEach(e=>{
					if((a.value)==e) {
						$(a).css("display","none");
						$(a).parent().css("display","none");
					}
				})			
			}
		})
	})

	var websocket;
	const fn_startChat=()=>{
		websocket= new WebSocket("ws://localhost:8080/chating/"+chatroomId);
		websocket.onopen=data=>{
			console.log(data);
		}
		websocket.onmessage=data=>{
			//console.log(data);
			const receiveMsg=JSON.parse(data.data);
			//console.log(receiveMsg);
			fn_printChat(receiveMsg);
			$(".chat-msg-input").val("");
		}
		websocket.onclose=data=>{
			console.log(data);
		}
	 	function fn_printChat(msg){
	 		
	 		let checkFile = msg.fileId;
			console.log(msg.fileId);
			if(checkFile!="undefined" || checkFile!="" || checkFile!=null || checkFile!="null" || checkFile!=undefined){
				const chatDiv = $(".chat-msgBox-container");
				const chatDate = new Date(msg.chatDate).toLocaleString('ko-KO');
				if (msg.memberId == loginMember) {
					var chatMsg = $("<div>").attr("class", "chat-msg chat-send");
					chatMsg.append($("<span>").attr("class", "chat-date").text(chatDate));
					chatMsg.append($("<span>").attr("class", "chat-msgbx").text(msg.chatContent));
					chatMsg.append($("<input type='hidden'>").attr("value",msg.chatId).attr("class","chat-msg-Id"));
		
				} else {
					var chatMsg = $("<div>").attr("class", "chat-msg");
					chatMsg.append($("<h5>").text(msg.memberId));
					chatMsg.append($("<span>").attr("class", "chat-msgbx").text(msg.chatContent));
					chatMsg.append($("<span>").attr("class", "chat-date").text(chatDate));
					chatMsg.append($("<input type='hidden'>").attr("value",msg.chatId).attr("class","chat-msg-Id"));
				}
				chatMsg.append($("<input>").attr("type", "hidden").attr("value", msg.chatroomId).attr("class","roomId"));
				chatDiv.append(chatMsg);
			} 
				
		}
	}
	
	$(".sendChat").click(e=>{
		const chatContent=$(".chat-msg-input").val();
		websocket.send(JSON.stringify(new Chat(chatroomId, loginMember, chatContent, today)));
	});
	
	
	$(".attachChatIcon").click(e=>{
		$(".modal-result-container").toggle("chatHidden");	
		$.ajax({
			url: "${path}/chatroom/file",
			type: "post",
			data: {
				chatroomId: chatroomId
			},
			success: data => {
				let chatfilebx;
				console.log(data);
				console.log(data[0].chatroomFile);
				if(data!=null || data!=""){
					chatfilebx = $("<div class='chatroom-file section-shadow'>");
					chatfilebx.append($("<h3>").text("현재 채팅 창 파일 목록"))
					let fileList = data[0].chatroomFile;
					fileList.forEach(e=>{
						console.log(e.fileId.originalFile);
						chatfilebx.append($("<a class='block chatroomfileId'>").text(e.fileId.originalFile));
						chatfilebx.append($("<input type='hidden'>").attr("value",e.fileId.uploadFile));
						$(".modal-result-container").append(chatfilebx);
						$(".modal-result-container").css("display","block");
					})
				}else{
					alert("해당 채팅 창에 파일이 없습니다 =]");
				}
			},
			error: function(xhr, status, error) {
		        console.error('AJAX Error:', error);
		    }
		});
	})
	$(document).on("click", ".chatroomfileId", function (e) {
		let originalFile = $(e.target).text();
		let uploadFile = $(e.target).next().val();
		$.ajax({
			url : "${path}/chatroom/download/"+ uploadFile,
			type : "get",
			xhrFields: {
	            responseType: "blob" // 응답 데이터 형식을 blob으로 설정
	        },
			success : data =>{
				var url = window.URL.createObjectURL(data);
	            var a = document.createElement("a");
	            a.style.display = "none";
	            a.href = url;
	            a.download = originalFile;
	            document.body.appendChild(a);
	            a.click();
	            window.URL.revokeObjectURL(url);
	            
			},
			error: function(xhr, status, error) {
		        console.error('AJAX Error:', error);
		    }
		})
	});
	
	$(".modalChatSearchIcon").click(e => {
		$(".modal-result-container").empty();
		let keyword = $(e.target).prev().val();
		if(keyword==null || keyword=="" || keyword=="null"){
			alert("검색어를 입력해주세요");
		}else{
			$.ajax({
					url : "${path}/chatroom/search",
					type : "post",
					data : {
						chatroomId : chatroomId,
						keyword : keyword
					},
					success : data =>{
						$(".modal-result-container").empty();
						var checkResult = fn_checkStrNull(data);
						if(checkResult!="null"){
							fn_viewSearchResult(data);
						}else {
							fn_viewSearchResult("검색 결과가 없습니다.");
						}
						
					},
					error: function(xhr, status, error) {
				        console.error('AJAX Error:', error);
				    }
				})
		}
	});  
	const fn_checkStrNull=(data)=>{
		var checkResult;
		if(data==null || data=="" || data=="null"){
			checkResult = "null";
			return checkResult;
		}else {
			checkResult = data;
			return checkResult;
		}
	}
	let myChatList;
	let mychatFileList;
	let mychatroomList;
	
	const fn_viewSearchResult=(data)=>{
		if(data!=null || data!="" || data!="null"){
			console.log(data);
			$(".modal-result-container").css("display","block");
			myChatList = data.myChatList;
			mychatFileList = data.mychatFileList;
			mychatroomList = data.mychatroomList;
			$(".modal-result-container").append($("<h3>").text("검색 결과 : "));
			if(myChatList!=null || myChatList!="" && mychatFileList!=null || mychatFileList!="" && mychatroomList!=null || mychatroomList!="" ){
				myChatList.forEach(m=>{
					console.log("m : ",m);
					$(".modal-result-container").append($("<div class='chat-msgbx'>").text(m.chatContent));
				})
				mychatFileList.forEach(f=>{
					console.log("f : ", f);
					console.log(f.fileId.originalFile);
					$(".modal-result-container").append($("<div class='chat-msgbx'>").text(f.fileId.originalFile));
				})
				mychatroomList.forEach(c=>{
					console.log("c : ",c);
					$(".modal-result-container").append($("<div class='chat-msgbx'>").text(c.chatroomTitle));
				})
			}
		}else {
			$(".modal-result-container").append($("<h3>").text(data));
		}
	}
</script>
</body>
</html>