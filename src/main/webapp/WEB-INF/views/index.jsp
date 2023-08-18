<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<link rel="stylesheet" href="${path}/resources/css/main/main.css">
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<section class="max100per">
	<jsp:include page="/WEB-INF/views/common/side-nav.jsp" />
	<div class="main-section section-shadow">
		<div class="right-container">

			<div id="mainFlex">
				<div id="section1" class="marginBottom">
					<p id="approveFont">미결재(${dd})</p>
					<hr id="appHr">
					<table class="table">
						<tr id="mainTh">
							<th>작성자</th>
							<th>작성일</th>
						</tr>
						<c:if test="${empty waitingApps}">
							<tr>
								<td colspan="3" id="noApp">결재할 문서가 없습니다</td>
							</tr>
						</c:if>
						<c:if test="${not empty waitingApps}">
							<c:forEach var="waitingApp" items="${waitingApps}">
								<tr id="tr"
									onclick="location.href='${path}/approve/detailApprove.do?approveNo=${waitingApp.approveNo}&approveKind=${waitingApp.approveKind }&approveState=${waitingApp.approveState}&name=결재대기문서';">
									<td>${waitingApp.approveTitle}</td>
									<td>${waitingApp.memberId.memberName}</td>
									<td>${waitingApp.currentDate }</td>
								</tr>
							</c:forEach>
						</c:if>
					</table>
				</div>
				<div id="section2" class="marginBottom">
					<div>
						<button class="none">게시판</button>
						<button class="none">공지사항</button>
						<hr id="appHr">
						<table>
							<c:if test="${empty notices}">
								<c:forEach var="notice" items="${notices}">
									<tr id="tr"
										onclick="location.href='${path}/approve/detailApprove.do?approveNo=${waitingApp.approveNo}&approveKind=${waitingApp.approveKind }&approveState=${waitingApp.approveState}&name=결재대기문서';">
										<td>내용</td>
										<td>날짜</td>
									</tr>
								</c:forEach>
							</c:if>
						</table>
						<c:if test="${empty notices}">
							<p id="noticeFont">조회할 공지사항이 없습니다</p>
						</c:if>
					</div>
				</div>
			</div>
			<div id="mainFlex">
				<div id="section1">
					<p id="toDo">To Do</p>
					<input type="text" id="toDoText"><input type="button" id="toDoButton" value="추가">
					<div id="toDoFlex">
					<input type="checkbox" id="toDoCheck"> 밥먹기 <img src="${path}/resources/images/approve/xbutton.png" id="deleteImg">
					</div>
				</div>
				<div id="section2">
						<p id="bookFont">신청한 강의실</p>
						<hr id="appHr">
						<table>
							<c:if test="${empty books}">
								<c:forEach var="book" items="${books}">
									<tr id="tr"
										onclick="location.href='${path}/approve/detailApprove.do?approveNo=${waitingApp.approveNo}&approveKind=${waitingApp.approveKind }&approveState=${waitingApp.approveState}&name=결재대기문서';">
										<td>내용</td>
										<td>날짜</td>
									</tr>
								</c:forEach>
							</c:if>
						</table>
						<c:if test="${empty books}">
							<p id="noticeFont">예약한 강의실이 없습니다</p>
						</c:if>
					
				</div>
			</div>
		</div>
	</div>
</section>


</body>
</html>
