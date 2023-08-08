<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<link rel="stylesheet" href="${path}/resources/css/employee/employee.css">
<section class="max1920px">
	<jsp:include page="/WEB-INF/views/common/side-nav.jsp" />
	<div class="main-section section-shadow card">
		<div class="right-container emp-div">
			<h2 class="title">사원 조회</h2>
			<select id="ent-flag">
				<option selected disable>퇴사 여부</option>
				<option value="N">재직</option>
				<option value="Y">퇴사</option>
			</select>
			<select id="search-keyword">
				<option selected disable>검색 카테고리</option>
				<option value="no">사번</option>
				<option value="name">이름</option>
				<option value="dept">부서</option>
				<option value="job">직책</option>
			</select>
			<table id="emp-table">
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
				<tr><td colspan="8"><hr/></td></tr>
				<!-- 반복문 처리될 구간 -->
				<c:if test="${not empty members }">
					<c:forEach var="m" items="${members }">
					<tr onclick="location.href='${path}/employee/memberId?id=${m.memberId}'">
						<td>${m.memberId }</td>
						<td>${m.memberName }</td>
						<td>${m.dept.deptName }</td>
						<td>${m.job.jobName }</td>
						<td>${m.salary }</td>
						<td>${m.address }</td>
						<td>${m.hireDate }</td>
						<td>${m.entDate!=null?m.entDate:"" }</td>
					</tr>
					<tr><td colspan="8"><hr/></td></tr>
					</c:forEach>
				</c:if>
			</table>
			<div class="pageBar">${pageBar }</div>
		</div>
		<!-- right-container -->
	</div>
</section>
</body>
</html>