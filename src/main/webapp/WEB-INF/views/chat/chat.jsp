<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>                            
 <c:set var="path" value="${pageContext.request.contextPath }"/>     
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<link rel="stylesheet" href="${path}/resources/css/chat/chat.css">
<link rel="stylesheet" href="${path}/resources/css/chat/chat-modal.css">
<section class="max100per">
	<jsp:include page="/WEB-INF/views/common/side-nav.jsp"/>
		<div class="main-section section-shadow">
			<jsp:include page="/WEB-INF/views/chat/chatList.jsp"/>
			<div class="chatRoom-container section-shadow">
				<jsp:include page="/WEB-INF/views/chat/chatHeader.jsp"/>
				<div class="chat-room-inner">
					<div class="modalNewChat section-shadow" style="display:none"></div>
					<!-- <h2>선택한 채팅 창이 없습니다</h2> -->
					<!-- 검색 아이콘 누르면 나오는 모달창 -->
					<div class="modal-searchRoomContainer" style="display: none">
							<input type="search" name="searchChatRoomList" placeholder="검색">
							<img src="${path}/resources/images/common/search.svg" alt="chat-search" class="searchChatRoomIcon">
							<span class="search-close">X</span>
					</div>
					<jsp:include page="/WEB-INF/views/chat/chatroom.jsp"/>
				</div>
			</div>
		</div>
		
</section>
<script>
	$("#startChat").click(e=>{
		location.assign("${path}/chat/chatting")
	})
	//조직도 보기 
	$(".deptName").click(e =>{
		let deptName = $(e.target).text();
		let chatDept = $(e.target);
		console.log(deptName);
		$.ajax({
			url:"${path}/chat/member",
			type:"get",
			data : {
				deptName : deptName
			},success:data=>{
				console.log(data);
				data.forEach(e => {
					$(".deptMember").append($("<label>").attr("for",e.memberId).text(e.memberName+ " "+e.job.jobName));
					$(".deptMember").append($("<input type='checkbox' name='memberId'>").attr("value",e.memberId));
					});
				} 
		});
	})	
	
	// 파일 업로드 
	$(".chat-msgform").click(e=> {
		const formData= new FormData();
		const inputFile= $("input[name='uploadFile']");
		let files= inputFile[0].files;
		console.log(files);
		
		
	})
	// 채팅방 아래 영역 
	// 메세지 누르면 반응 
	$(".chat-msgbx").click(e =>{
		$(".chat-reaction").css('display','block');
		
	})
	
	
	// 인원 추가 누르면 추가되는 로직 
	$(".addPerson").click(e =>{
		
	})
	
</script>
</body>
</html>
