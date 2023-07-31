<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<section class="max1920px">
	<jsp:include page="/WEB-INF/views/common/side-nav.jsp"/>
	<div class="main-section section-shadow card">
      <div class="right-container">
		<h3>시설 예약하기</h3>
	<!-- 사용 목적 선탹에 따라 아래 디테일 약간의 변경 있음 -->
	<!-- 상담은 참여자 최대 2명(기본 1명), 회의는 최소 2명, 최대 7명/ 명수만큼 이름 입력창 나올 수 있도록 -->
	<!-- 상담은 한시간, 회의는 두시간으로 설정 -->
	<!--  -->
		<form>
			<button>예약하기</button>
			<div>
				<span>예약자</span>
				<input type="text" name="memberId" value="" readonly>
			</div>
			<div>
				<span>사용목적</span>
				<input>
			</div>
			<div>
				<span>주관부서</span>
				<input>
			</div>
			<div>
				<span>이용시설</span>
				<input>
			</div>
			<div>
				<span>이용날짜</span>
				<input>
			</div>
			<div>
				<span>이용시간</span>
				<input>
			</div>
		</form>
		</div>
	</div>
	
</section>


</body>
</html>