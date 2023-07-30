<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>                            
 <c:set var="path" value="${pageContext.request.contextPath }"/>     
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<link rel="stylesheet" href="${path}/resources/css/chat/chat.css">
<section class="max100per">
	<jsp:include page="/WEB-INF/views/common/side-nav.jsp"/>
		<div class="main-section section-shadow">
			<jsp:include page="/WEB-INF/views/chat/chatList.jsp"/>
			<div class="chatRoom-container section-shadow">
				<jsp:include page="/WEB-INF/views/chat/chatHeader.jsp"/>
				<div class="chat-room-inner">
					<!-- <h2>선택한 채팅 창이 없습니다</h2> -->
					<!-- 검색 아이콘 누르면 나오는 모달창 -->
					<div class="modal-searchRoomContainer" style="display: none">
							<input type="search" name="searchChatRoomList" placeholder="검색">
							<img src="${path}/resources/images/common/search.svg" alt="chat-search" class="searchChatRoomIcon">
							<span class="search-close">X</span>
					</div>
					<%-- <c:if test="${not empty chatroom}"> --%>
						<%-- <c:choose>
							<c:when test="${ chatroom.chat.memberId not eq '2023072796'}">
								<c:forEach var="c" items="${chatroom.chat}">
									<!-- 보낸 사람이 현재 로그인 한 사람이 아닐 때 -->
										<div class="chat-msg">
											<h5><c:out value="${c.memberName}"/></h5>
											<span class="chat-msgbx"><c:out value="${c.chatContent}"/></span>
											<span class="chat-date"><c:out value="${c.chatDate}"/></span>
											<!-- <div class="chat-reaction" style="display:none">
												<label for="reaction_like" class="chatReaction"><input type="checkbox" checked="checked" value="relike" style="display:none"/>
												<span>❤</span></label>️
												<input type="checkbox" value="regreat"/>
												<label for="reaction_great" class="chatReaction"><span>👍</span></label>️
												<input type="checkbox" value="recheck"/>
												<label for="reaction_check" class="chatReaction"><span>✔</span></label>️
											</div> -->
										</div>
								</c:forEach>
							</c:when>
							<c:when test="${not empty chatroom && chatroom.chat.memberId eq '2023072796' }">
								<c:forEach var="c" items="${chatroom.chat }">
									<div class="chat-msg chat-send">
										<span class="chat-date"><c:out value="${c.chatDate}"/></span>
										<span class="chat-msgbx"><c:out value="${c.chatContent}"/></span>
									</div>
								</c:forEach>
							</c:when>
						</c:choose> --%>
						<form action="${path}/chat/attatch" method="post" class="chat-msgform" enctype="multipart/form-data" style="display:none">
								<input type="file" name="uploadFile" multiple style="display:none">
								<button type="submit" name="chat-attatch" class="chat-addAttatch">+</button>
								<input type="text" name="chat-msg" class="chat-msg-input">
								<input type="submit" value="전송">
						</form>
					<%-- </c:if> --%>
				</div><!-- js로 가져오기 -->
			</div>
		</div>
		
</section>
<script>
	
	// 1:1 채팅 선택
	$(".chatRoomPersonal").click(e=>{
		
	})
	// 파일 업로드 
	$(".chat-msgform").click(e=> {
		const formData= new FormData();
		const inputFile= $("input[name='uploadFile']");
		let files= inputFile[0].files;
		console.log(files);
		
		// ajax
		/* $.ajax({
			url : '',
		}) */
		
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
