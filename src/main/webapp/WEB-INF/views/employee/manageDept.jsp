<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<section class="max1920px">
	<jsp:include page="/WEB-INF/views/common/side-nav.jsp" />
	<div class="main-section section-shadow card">
		<div class="right-container">
			<h2>부서 관리</h2>
			<section>
				<h4>부서 추가</h4>
				<div id="insert-grade">
					<span>부서명</span>
					<input type="text" name="insert-title">
					<button onclick="fn_insertDept();">생성</button>
				</div>
			</section>
			<script>
				const fn_insertDept=()=>{
					const deptName=$("#dept-name").val();
					$.ajax({
						method:"post",
						url:"${path}/employee/dept",
						data:"deptName="+deptName,
						dataType:"text"
					}).then(funtion (response){
						console.log(response);
					}).then(function (error){
						console.log(error);
					});
				}
			</script>
			<section>
				<h4>부서 삭제</h4>
				<div id="delete-grade">
					<p>* 해당 부서에 사원이 존재하면 삭제할 수 없습니다.</p>
					<table>
						<tr>
							<th>부서</th>
							<th>총 인원</th>
							<th>삭제</th>
						</tr>
						<tr><td colspan="4"><hr/></td></tr>
						<!-- 반복문 처리될 구간 -->
						<c:if test="${depts!=null }">
							<c:forEach var="d" items="${depts }">
								<tr class="dept-tr">
									<td>${d.deptName}</td>
									<td>${d.deptCount }명</td>
									<td>
										<button onclick="fn_updateAuth();">삭제</button>
									</td>
								</tr>
								<tr class="dept-tr"><td colspan="4"><hr/></td></tr>
							</c:forEach>
						</c:if>
					</table>
					<div class="pageBar">${pageBar }</div>
				</div>
			</section>
			<section>
				<h4>부서 수정</h4>
				<div>
					<table>
						<tr>
							<th>부서</th>
							<th>총 인원</th>
							<th>변경할 부서명</th>
							<th>수정</th>
						</tr>
						<tr><td colspan="4"><hr/></td></tr>
						<!-- 반복문 처리될 구간 -->
						<c:if test="${depts!=null }">
							<c:forEach var="d" items="${depts }">
								<tr class="dept-tr">
									<td>${d.deptName}</td>
									<td>${d.deptCount }명</td>
									<td>
										<input type="text" name="update-title" id="update-title-id">
									</td>
									<td>
										<button onclick="fn_updateAuth();">수정</button>
									</td>
								</tr>
								<tr class="dept-tr"><td colspan="4"><hr/></td></tr>
							</c:forEach>
						</c:if>
					</table>
				<div class="pageBar">${pageBar }</div>
				</div>
			</section>
		</div><!-- right-container -->
	</div>
</section>

</body>
</html>