<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>                            
<c:set var="path" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>채팅 멤버</title>
<script src="${path}/resources/js/jquery-3.7.0.min.js"></script>
</head>
<body>
	<div class="modal-addChatMember chatHidden">
		<div class="modal-content">
			<c:if test="${empty chatMemberNow }">
				<h3>채팅 생성</h3>
			</c:if>
			<c:if test="${not empty chatMemberNow }">
			<h4>현재 채팅 멤버</h4>
			<div class="curChatMembers">
				<c:forEach var="members" items="${chatMemberNow}">
					<c:forEach var="member" items="${members.myChatroom }">
						<c:if test="${member.member.memberId != loginMember.memberId }">
						<input type="checkbox" value="${member.member.memberId}"><label for="${member.member.memberId}">${member.member.memberName }</label>
						</c:if>
					</c:forEach>
				</c:forEach>
			</div>
			</c:if>
			<div class="changeChatMembers"></div>
			<!-- <button id="changeMemberBtn">추가</button> -->
			<c:if test="${not empty members}">
				<form class="chat-DeptContainer" method="post" action="${path}/chat/start">
					<label for="chatroomTitle">채팅 제목 : </label><input type="text" name="chatroomTitle" placeholder="채팅 제목"><br>
					<span>채팅 제목 미 설정 시 채팅 멤버 아이디+채팅 참여 멤버 수로 설정됩니다</span>
					<div class="chat-dept">
						<c:forEach var="dept" items="${dept}">
							<h4 class="title chat-dept-title">
								${dept.deptName}
							</h4><hr>
							<c:forEach var="member" items="${members }">
							<c:if test="${dept.deptCode == member.dept.deptCode}">
							<!-- 이미 채팅중인 멤버 분기처리하기 -->
							<!-- <div class="memberByDept chatHidden"> -->
									<input type="checkbox" value="${member.memberId}"><label for ="${member.memberId}">${member.memberName} ${member.job.jobName }</label>
							<!-- </div> -->
							</c:if>
							</c:forEach>
						</c:forEach>
					</div>
					<input type="submit" value="선택">
				</form>
			</c:if>
			<!-- <button id="changeMemberBtn">변경</button>
			<button class="h-close-modal">변경 취소</button> -->
		</div>
	</div>
<script>
	$(".chat-dept-title").click(e =>{
		
	})
</script>
</body>
</html>