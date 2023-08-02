<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.workit.member.model.dto.Member"  %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%> 
         
 <%
	Member loginMember=(Member)session.getAttribute("loginMember");
  %>                  
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
			<a id="approve-menu"><img src="${path}/resources/images/common/approve.svg"><span>전자결재</span></a>
			<div id="div-approve">
				<button class="approval-request">결재신청</button>
				<button onclick="location.href='${path}/approve/waitingApprove.do?memberId=${loginMember.memberId}';">결재대기문서</button>
				<button onclick="location.href='${path}/approve/stateApprove.do';">기안문서함</button>
				<button onclick="location.href='${path}/approve/referenceApprove.do';">참조문서함</button>
				<button onclick="location.href='${path}/approve/saveApprove.do';">임시저장함</button>
			</div>
		</div>
		<div>
			<a class="side-menu" href="${path}/chat/"><img src="${path}/resources/images/common/chat.svg"><span>메신저</span></a>
		</div>
	</div>
</div>
<jsp:include page="/WEB-INF/views/approve/select-payment-form.jsp" />