<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<section class="max1920px">
	<jsp:include page="/WEB-INF/views/common/side-nav.jsp" />
	<div class="main-section section-shadow card">
		<div class="right-container">
			<h2>부서 및 직책 관리</h2>
			<section>
				<h4>부서 및 직책 추가</h4>
				<div id="insert-grade">
					<span>부서</span>
					<select name="insert-category">
						<option selected disabled>필수 선택</option>
						<option value="dept">부서</option>
						<option value="job">직책</option>
					</select>
					<span>부서/직책명</span>
					<input type="text" name="insert-title">
					<button onclick="fn_insertAuth();">생성</button>
				</div>
			</section>
			<section>
				<h4>부서 및 직책 삭제</h4>
				<div id="delete-grade">
					<span>부서</span>
					<select name="delete-category">
						<option selected disabled>필수 선택</option>
						<option value="dept">부서</option>
						<option value="job">직책</option>
					</select>
					<span>부서/직책명</span>
					<select name="delete-title">
						<option selected disabled>필수 선택</option>
						<c:if test="${depts!=null }">
			         		<c:forEach var="d" items="${depts }">
			         			<option value="${d.deptCode }">${d.deptName }</option>
		         			</c:forEach>
		         		</c:if>
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
				<h4>부서 및 직책 수정</h4>
				<div>
					<select id="update-grade-select">
						<option value="dept" selected>부서</option>
						<option value="job">직책</option>
					</select>
					<table>
						<tr>
							<th>부서/직책</th>
							<th>총 인원</th>
							<th>변경할 부서/직책명</th>
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
<script>
	$(document).on("change","#update-grade-select",function(){
		const selectVal=$("#update-grade-select").val();
		if(selectVal=='dept'){
			$(".job-tr").attr("display","none");
		}else{
			
		}
	});
</script>
</body>
</html>