<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>                            
 <c:set var="path" value="${pageContext.request.contextPath }"/>     
	<div class="side-nav-container max90per section-shadow">
		<div class="side-nav">
			<h2 class="title">메뉴</h2>
		</div>
	<div class="side-menu-container">
		<div>
			<a class="side-menu" href=""><img src="${path}/resources/images/common/member.svg"><span>인사 관리</span></a>
		</div>
		<div>
			<a class="side-menu" href=""><img src="${path}/resources/images/common/work.svg"><span>근태 관리</span></a>
		</div>
		<div>
			<a class="side-menu" href=""><img src="${path}/resources/images/common/lecture.svg"><span>수업 등록</span></a>
		</div>
		<div>
			<a class="side-menu" href="${path }/booking/bookingList.do"><img src="${path}/resources/images/common/booking.svg"><span>시설 예약</span></a>
		</div>
		<div>
			<a class="side-menu" href=""><img src="${path}/resources/images/common/board.svg"><span>게시판</span></a>
		</div>
		<div>
			<a class="side-menu" href=""><img src="${path}/resources/images/common/approve.svg"><span>전자결재</span></a>
		</div>
		<div>
			<a class="side-menu" href="${path}/chat/chat"><img src="${path}/resources/images/common/chat.svg"><span>메신저</span></a>
		</div>
	</div>
</div>
<script>
	$(".side-menu").click(e =>{
	})
</script>