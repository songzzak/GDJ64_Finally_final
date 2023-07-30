<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>                            
<c:set var="path" value="${pageContext.request.contextPath }"/>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<div class="chat-header">
	<%-- <img src="${path}/resources/images/common/back.svg" alt="chat-back" class="backIcon"> --%>
	<h3></h3>
	<div class="chat-icon-container" style="display:none">
		<img src="${path}/resources/images/common/search.svg" alt="chat-search" class="searchChatIcon">
		<img src="${path}/resources/images/common/attach.svg" alt="chat-attach" class="attachIcon">
		<img src="${path}/resources/images/common/close.svg" alt="chat-close" class="closeIcon">
		<!-- 그룹 채팅일때만 아이콘 노출 -->
		<c:if test="${chatroom.chatCode eq 'G'}">
			<img src="${path}/resources/images/chat/addPerson.svg" alt="chat-addPerson" class="addPersonIcon">
		</c:if>
	</div>
</div>
<script>
	//채팅방 헤더 
	// 채팅방 나가기 (삭제 x)
	$(".closeIcon").click(e=>{
		alert("sdkgs");
		roomId = "";
		console.log(roomId);
		fn_checkRoomId(roomId);
	})	
	// 채팅방 내 검색 아이콘 클릭 
	$(".searchChatIcon").click(e => {
		$(".modal-searchRoomContainer").css('display','flex');
	})
	// 채팅방 내 검색 모달 닫기 
	$(".search-close").click(e =>{
		$(".modal-searchRoomContainer").css('display','none');
	})
	
	// 채팅창 내부에서 검색했을 때  
	$(".searchChatRoomIcon").click(e =>{
		const searchKeyword = $(e.target).prev().val();
		console.log(searchKeyword);
	})
	// 파일 아이콘누르면 파일 목록 가져오기 
	$(".attatchIcon").click(e =>{
		// ajax로 파일 가져오기 
		let $file = $("<a>");
		let $img = $("<img>");
		let $name= $("<span>");
		
		// 분기처리-파일 없음 
		$file.text("해당 채팅방의 파일이 없습니다.");
		$(".chat-room-inner").append($file);
		
		// 파일 있음
		// 순회하면서 파일 보여주기 
		
		$img.attr("src","${path}/resources/images/common/attatch.svg");
		$name.text("filename");
		$file.append($img).append($name);
		
		$(".chat-room-inner").append($file);
	})
</script>
</body>
</html>






