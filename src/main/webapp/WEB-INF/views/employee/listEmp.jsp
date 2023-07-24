<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<section class="max1920px">
	<jsp:include page="/WEB-INF/views/common/side_nav.jsp"/>
	<div class="main-section section-shadow card">
		<div class="right-container">
			<h2>사원 등록</h2>
			<select name="ent-flag">
				<option selected disable>퇴사 여부</option>
				<option value="N">재직</option>
				<option value="Y">퇴사</option>
			</select>
			<select name="search-keyword">
				<option selected disable>검색 카테고리</option>
				<option value="member-no">사번</option>
				<option value="member-name">이름</option>
				<option value="dept">부서</option>
				<option value="job">직책</option>
			</select>
			<table>
				<tr>
					<th>사번</th>
					<th>이름</th>
					<th>부서</th>
					<th>직책</th>
					<th>연봉</th>
					<th>주소</th>
					<th>입사일</th>
					<th>퇴사일</th>
				</tr>
				<!-- 반복문 처리될 구간 -->
				<tr>
					<td>사번</td>
					<td>이름</td>
					<td>부서</td>
					<td>직책</td>
					<td>연봉</td>
					<td>주소</td>
					<td>입사일</td>
					<td>퇴사일</td>
				</tr>
			</table>
			<div>pageBar</div>
		</div><!-- right-container -->
	</div>
</section>
</body>
</html>