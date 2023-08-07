<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>    
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<section class="max1920px">
<jsp:include page="/WEB-INF/views/common/side-nav.jsp"/>
<c:set var="path" value="${pageContext.request.contextPath }"/>
	<div class="main-section section-shadow card">
      	<div class="right-container">
			<h3>시설 예약 내역</h3>
	<!-- 전체 예약(사용 전/후 모두 포함)에 대한 내역조회 -->
	<!-- 신청자/날짜로 조회 가능 -->
			<button onclick="location.assign('${path}/booking/calendar.jsp')">캘린더</button>
			<form id="searchBookingFrm">
				<select name="type">
					<option value="" selected>날짜/예약자로 검색</option>
					<option value="bookingDate">날짜</option>
					<option value="bookingName">예약자</option>
				</select>
				<input type="date" name="bookingDate">
				<input type="text" name="bookingName">
				<button>검색</button>
			</form>
			<button type="button" onclick="location.assign('${path}/booking/addBooking.do')">예약하기</button>
 			<table id="bookingListTbl">
				<tr>
					<th>목적</th>
					<th>예약자</th>
					<th>이용날짜</th>
					<th>이용시설</th>
					<th>이용시간</th>
					<th>주관부서</th>
					<th>비고</th>
				</tr>
				<c:if test="${empty list }">
					<tr>
						<td colspan="7">예약 내역이 없습니다</td>
					</tr>
				</c:if>
				<c:forEach var="b" items="${list }">
					<tr>
						<td>${b.purpose }</td>
						<td>${b.bookingName }</td>
						<td>${b.bookingDate }</td>
						<td>${b.facNo }</td>
						<td>${b.startTime }~${b.endTime }</td>
						<td>${b.deptCode }</td>
						<td><a href="${path }/booking/bookingDetail.do?bookingNo=${b.bookingNo}">더보기</a></td>
					</tr>
				</c:forEach>
			</table>
			<div>
				<c:out value="${pageBar }" escapeXml="false"/>
			</div>			
		</div>
	</div>
</section>
<script>
/* select 바뀌는것에 따라 뒤의 인풋 종류 바뀌게] */
/*display:none으로 먼저 두고 앞의 셀렉트 타입에 맞게 선택되면 그 인풋 보이도록 */
</script>


</body>
</html>