<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<section class="max1920px">
	<jsp:include page="/WEB-INF/views/common/side-nav.jsp" />
	<div class="main-section section-shadow card">
		<div class="right-container">
			<h2>직책 관리</h2>
			<section>
				<h4>직책 추가</h4>
				<span>권한</span>
				<select name="job-auth" id="job-auth-id">
					<option selected disabled>필수 선택</option>
					<option value="master">대표</option>
					<option value="submaster">부대표</option>
					<option value="teammaster">팀장</option>
					<option value="emp">사원</option>
				</select>
				<div id="insert-grade">
					<span>직책명</span>
					<input type="text" name="insert-title">
					<button onclick="fn_insertAuth();">생성</button>
				</div>
			</section>
			<section>
				<h4>직책 삭제</h4>
				<div id="delete-grade">
					<span>직책명</span>
					<select name="delete-title">
						<option selected disabled>필수 선택</option>
		         		<c:if test="${jobs!=null }">
			         		<c:forEach var="j" items="${jobs }">
			         			<option value="${j.jobCode }">${j.jobName }</option>
		         			</c:forEach>
		         		</c:if>
					</select>
					<button onclick="fn_deleteAuth();">삭제</button>
				</div>
			</section>
			<section>
				<h4>직책 수정</h4>
				<div>
					<table>
						<tr>
							<th>직책</th>
							<th>총 인원</th>
							<th>변경할 직책명</th>
							<th>수정</th>
						</tr>
						<tr><td colspan="4"><hr/></td></tr>
						<c:if test="${jobs!=null }">
							<c:forEach var="j" items="${jobs }">
								<tr class="job-tr">
									<td>${j.jobName}</td>
									<td>${j.jobCount }명</td>
									<td>
										<input type="text" name="update-title" id="update-title-id">
									</td>
									<td>
										<button onclick="fn_updateAuth();">수정</button>
									</td>
								</tr>
								<tr class="job-tr"><td colspan="4"><hr/></td></tr>
							</c:forEach>
						</c:if>
					</table>
				</div>
				<div class="pageBar">${pageBar }</div>
			</section>
		</div><!-- right-container -->
	</div>
</section>
</body>
</html>