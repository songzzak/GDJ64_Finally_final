<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>                            
 <c:set var="path" value="${pageContext.request.contextPath }"/>     
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<link rel="stylesheet" href="${path}/resources/css/chat/chat.css">
<script src="${path}/resources/js/jquery-3.7.0.min.js"></script>
<section class="max100per">
	<jsp:include page="/WEB-INF/views/common/side-nav.jsp"/>
		<div class="main-section section-shadow">
			<jsp:include page="/WEB-INF/views/chat/chatList.jsp"/>
			<div class="chatRoom-container section-shadow">
				<div class="chat-header">
					<h3>이름 (숫자)</h3>
					<div class="chat-icon-container">
						<img src="${path}/resources/images/common/search.svg" alt="chat-search" class="searchChatIcon">
						<img src="${path}/resources/images/common/attatch.svg" alt="chat-attatch" class="attatchIcon">
						<!-- 그룹 채팅일때만 아이콘 노출 -->
						<%-- <img src="${path}/resources/images/chat/addPerson.svg" alt="chat-addPerson"> --%>
					</div>
				</div>
				<div class="chat-room-inner">
					<!-- 선택한 채팅창 없으면 나오는 문구: 분기처리 -->
					<!-- <h2>선택한 채팅 창이 없습니다</h2> -->
					
					<!-- 검색 아이콘 누르면 나오는 모달창 -->
					<div class="modal-searchRoomContainer" style="display: none">
							<input type="search" name="searchChatList" placeholder="검색">
							<img src="${path}/resources/images/common/search.svg" alt="chat-search" class="searchChatRoom">
							<span class="search-close">X</span>
					</div>
					<div class="chat-msg">
						<h5>이름</h5>
						<span class="chat-msgbx">받은 내용</span>
						<!-- <span class="chat-reaction" style="display:none"></span> -->
						<span class="chat-date">날짜</span>
					</div>
					<div class="chat-msg chat-send">
						<span class="chat-date">보낸 날짜</span>
						<span class="chat-msgbx">보낸 내용</span>
					</div>
					<form action="${path}" method="post" class="chat-msgform">
						<input type="file" name="chat-attatch" style="display:none">
						<button type="submit" name="chat-attatch" class="chat-addAttatch">+</button>
						<input type="text" name="chat-msg" class="chat-msg-input">
						<input type="submit" value="전송">
					</form>
				</div><!-- js로 가져오기 -->
			</div>
		</div>
		
</section>
<script>
	// 채팅방 헤더 
	// 채팅방 내에서 검색 
	$(".searchChatIcon").click(e => {
		$(".modal-searchRoomContainer").css('display','flex');
	})
	// 채팅방 내에서 검색 닫기
	$(".search-close").click(e =>{
		$(".modal-searchRoomContainer").css('display','none');
	})
	$(".chatRoomPersonal").click(e=>{
		
	})
	
	// 파일 아이콘누르면 파일 목록 가져오기 
	$(".attatchIcon").click(e =>{
		
	})
	// 채팅방 아래 영역 
	// 메세지 누르면 반응 
	/* $(".chat-msgbx").click(e =>{
		$(".chat-reaction").css('display','flex');
	}) */
	
	
</script>
</body>
</html>






