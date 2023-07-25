<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<section class="max1920px">
	<jsp:include page="/WEB-INF/views/common/side-nav.jsp"/>
	<div class="main-section section-shadow card">
      <div class="right-container">
         <h2>사원 등록</h2>
         <form>
         	<div>
         		<span>이름</span>
         		<input type="text" name="member-id">
         	</div>
         	<input type="hidden" value="1234" name="password">
         	<div>
         		<span>전화번호</span>
         		<input type="text" name="phone">
         		<p>* 전화번호 입력 시 하이픈(-) 제외하고 입력하세요.</p>
         	</div>
         	<div>
         		<span>주소 검색</span>
         		<input type="text" name="main-address">
         		<button onclick="fn_searchAddr();">검색</button>
         	</div>
         	<div>
         		<span>상세 주소</span>
         		<input type="text" name="detail-address">
         	</div>
         	<div>
         		<span>부서</span>
	         	<select>
	         		<option selected disabled>필수 선택</option>
	         		<option value="">부서</option>
	         	</select>
         	</div>
         	<div>
         		<span>직책</span>
	         	<select>
	         		<option selected disabled>필수 선택</option>
	         		<option value="">직책</option>
	         	</select>
         	</div>
         	<div>
         		<span>급여</span>
         		<input type="number" name="salary">
         	</div>
         	<div>
         		<span>프로필</span>
         		<input type="file" name="profile-img">
         	</div>
         	<p>* 프로필 사진이 존재하는 경우 파일 첨부해주세요. 용량 제한 50MB</p>
         	<div>
         		<span>입사일</span>
         		<input type="date" name="enroll-date">
         	</div>
         </form>
         <p>* 사원 초기 비밀번호는 1234로 생성됩니다.</p>
      </div>
   </div>
	<div><input type="reset" value="취소"><button onclick="fn_empDataCk();">생성</button></div>
</section>
<script>
	//주소 검색 메소드
	function fn_searchAddr(){
		//주소 API 사용
	}
	
	//데이터 입력 확인 후 넘기는 메소드
	function fn_empDataCk(){
		
	}
</script>
</body>
</html>