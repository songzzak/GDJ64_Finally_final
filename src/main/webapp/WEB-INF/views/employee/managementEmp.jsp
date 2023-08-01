<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<section class="max1920px">
	<jsp:include page="/WEB-INF/views/common/side-nav.jsp" />
	<div class="main-section section-shadow card">
		<div class="right-container">
			<h2>부서 및 직책 관리</h2>
			<section>
				<h4>부서 및 직책 추가</h4>
				<div>
					<span>부서</span> <select>
						<option selected disabled>필수 선택</option>
						<option value="dept">부서</option>
						<option value="job">직책</option>
					</select> <span>부서/직책명</span> <input type="text" name="grade-title">
					<button onclick="fn_insertAuth();">생성</button>
				</div>
			</section>
			<section>
				<h4>부서 및 직책 삭제</h4>
				<div>
					<span>부서</span> <select>
						<option selected disabled>필수 선택</option>
						<option value="dept">부서</option>
						<option value="job">직책</option>
					</select> <span>부서/직책명</span> <select>
						<option selected disabled>필수 선택</option>
						<option value="">부서</option>
					</select>
					<button onclick="fn_deleteAuth();">삭제</button>
				</div>
			</section>
			<section>
				<h4>부서 및 직책 수정</h4>
				<div>
					<select>
						<option selected disabled>필수 선택</option>
						<option value="dept">부서</option>
						<option value="job">직책</option>
					</select>
					<button onclick="fn_searchAuth();">검색</button>
					<table>
						<tr>
							<th>부서</th>
							<th>총 인원</th>
							<th>변경할 부서/직책명</th>
							<th>수정</th>
						</tr>
						<!-- 반복문 처리될 구간 -->
						<tr>
							<td></td>
							<td>명</td>
							<td>
								<input type="text" name="update-auth" id="update-auth-id">
							</td>
							<td>
								<button onclick="fn_updateAuth();">수정</button>
							</td>
						</tr>
					</table>
				</div>
				<div>pageBar</div>
			</section>
		</div><!-- right-container -->
	</div>
</section>
</body>
</html>